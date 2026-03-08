import sqlalchemy
import sqlalchemy.exc
import pytest
import datetime
from contextlib import contextmanager

from src.models import (
    Base,
    Card,
    Session as GameSession,
    CardBidWithnSession,
    GameTypes,
    SessionTables,
    Tables,
    Staff,
    Bartenders,
    Dealers,
    Orders,
    Drinks,
    SplitOrderByCard,
    BarSupplies,
)
from sqlalchemy.orm import Session, sessionmaker
from typing import Generator, Callable
from sqlalchemy import URL, Engine, create_engine, text


@pytest.fixture()
def db_engine(postgres_url: URL) -> Engine:
    e = create_engine(postgres_url)
    return e


def switch_role(session: Session, role: str) -> None:
    session.execute(text(f"SET ROLE {role};"))


@pytest.fixture()
def cleanup_tables(db_session: Callable[[], Session]) -> Callable[[list[Base]], None]:
    def _cleanup(types: list[Base]) -> None:
        with db_session() as session:
            session.begin()
            switch_role(session, "postgres")
            for t in types:
                session.execute(
                    text(f"TRUNCATE TABLE {t.__tablename__} RESTART IDENTITY CASCADE;")
                )
            session.commit()

    return _cleanup


@pytest.fixture()
def db_session(db_engine: Engine) -> Callable[[], Generator[Session]]:
    smaker = sessionmaker(bind=db_engine, autocommit=False)

    @contextmanager
    def _get_session() -> Generator[Session]:
        session = smaker(autobegin=False)

        try:
            yield session
        except Exception as e:
            session.rollback()
            raise e
        finally:
            session.close()

    return _get_session

class DbObjectsFactory:
    def __init__(self) -> None:
        pass

    @staticmethod
    def get_game_session(
        start_time: datetime.datetime = datetime.datetime(2020, 12, 1),
        end_time: datetime.datetime = datetime.datetime(2020, 12, 2),
    ) -> GameSession:
        return GameSession(start_time=start_time, end_time=end_time)

    @staticmethod
    def get_table(
        type: GameTypes,
        balance: int = 0,
        opening_time: datetime.datetime = datetime.datetime(2020, 12, 1),
        closing_time: datetime.datetime = datetime.datetime(2020, 12, 2),
    ) -> Tables:
        return Tables(
            type_id=type.type_id,
            balance=balance,
            opening_time=opening_time,
            closing_time=closing_time,
        )

    @staticmethod
    def get_staff(
        name: str = "maria",
        surname: str = "sklodowskaya-curie",
        address: str = "nowhere",
        age: int = 23,
    ) -> Staff:
        return Staff(name=name, surname=surname, address=address, age=age)

    @staticmethod
    def get_order(
        bartender: Bartenders,
        total: int,
        order_time: datetime.datetime = datetime.datetime(2020, 12, 1),
    ) -> Orders:
        return Orders(staff_id=bartender.staff_id, total=total, order_time=order_time)

    @staticmethod
    def get_drink(
        price: int,
        name: str = "margarita",
        category: str = "alcoholic",
        volume: int = 1,
    ) -> Drinks:
        return Drinks(price=price, name=name, category=category, volume=volume)


def test_card_insert_bid_invalid(
    db_session: Callable[[], Session], cleanup_tables: Callable[list[Base], None]
) -> None:
    with db_session() as session:
        session.begin()
        card = Card(balance=100)
        game_session = DbObjectsFactory.get_game_session()
        session.add_all([card, game_session])
        session.commit()

        session.begin()
        switch_role(session, Base._ROLE_BID_TERMINAL.name)
        bid = CardBidWithnSession(
            session_id=game_session.session_id,
            card_id=card.card_id,
            bid_amount=120,
            money_gain=0,
        )
        session.add(bid)
        with pytest.raises(sqlalchemy.exc.ProgrammingError):
            session.commit()
    cleanup_tables([CardBidWithnSession, Card, GameSession])


def test_card_insert_bid_win(
    db_session: Callable[[], Session], cleanup_tables: Callable[list[Base], None]
) -> None:
    with db_session() as session:
        session.begin()
        card = Card(balance=100)
        game_session = DbObjectsFactory.get_game_session()
        session.add_all([card, game_session])
        session.commit()

        session.begin()
        switch_role(session, Base._ROLE_BID_TERMINAL.name)
        bid = CardBidWithnSession(
            session_id=game_session.session_id,
            card_id=card.card_id,
            bid_amount=50,
            money_gain=20,
        )
        session.add(bid)
        session.commit()

        session.begin()
        assert card.balance == 70
        session.commit()
    cleanup_tables([CardBidWithnSession, Card, GameSession])


def test_game_unsupervised_wrong(
    db_session: Callable[[], Session], cleanup_tables: Callable[list[Base], None]
) -> None:
    with db_session() as session:
        session.begin()
        game_type = GameTypes(game_type="poker", is_supervised=True)
        game_session = DbObjectsFactory.get_game_session()
        session.add_all([game_type, game_session])
        session.commit()

        session.begin()
        table = DbObjectsFactory.get_table(game_type)
        session.add(table)
        session.commit()

        session.begin()
        session_table = SessionTables(
            session_id=game_session.session_id, table_id=table.table_id
        )
        session.add(session_table)
        with pytest.raises(sqlalchemy.exc.ProgrammingError):
            session.commit()
    cleanup_tables([GameTypes, GameSession])


def test_game_supervised_wrong(
    db_session: Callable[[], Session], cleanup_tables: Callable[list[Base], None]
) -> None:
    with db_session() as session:
        session.begin()
        game_type = GameTypes(game_type="gambling_roll", is_supervised=False)
        game_session = DbObjectsFactory.get_game_session()
        staff = DbObjectsFactory.get_staff()
        session.add_all([game_type, game_session, staff])
        session.commit()

        session.begin()

        table = DbObjectsFactory.get_table(game_type)
        bartender = Dealers(staff_id=staff.staff_id, qualification="yes")
        session.add_all([table, bartender])
        session.commit()

        session.begin()
        session_table = SessionTables(
            session_id=game_session.session_id,
            table_id=table.table_id,
            staff_id=bartender.staff_id,
        )
        session.add(session_table)
        with pytest.raises(sqlalchemy.exc.ProgrammingError):
            session.commit()
    cleanup_tables([GameTypes, GameSession])


def test_card_order_ok(
    db_session: Callable[[], Session], cleanup_tables: Callable[list[Base], None]
) -> None:
    with db_session() as session:
        session.begin()
        card = Card(balance=120)
        staff = DbObjectsFactory.get_staff()
        drink1 = DbObjectsFactory.get_drink(10)
        drink2 = DbObjectsFactory.get_drink(30)
        session.add_all([card, staff, drink1, drink2])
        session.commit()

        session.begin()
        bartender = Bartenders(staff_id=staff.staff_id, performance_rating=4)
        supply1 = BarSupplies(drink_id=drink1.drink_id, quantity=2)
        supply2 = BarSupplies(drink_id=drink2.drink_id, quantity=3)
        session.add_all([bartender, supply1, supply2])
        session.commit()

        session.begin()
        switch_role(session, Base._ROLE_ORDER_TERMINAL.name)
        order = DbObjectsFactory.get_order(bartender, 0)
        session.add(order)
        session.commit()

        session.begin()
        switch_role(session, Base._ROLE_ORDER_TERMINAL.name)
        split1 = SplitOrderByCard(
            card_id=card.card_id,
            order_id=order.order_id,
            drink_id=drink1.drink_id,
            quantity=2,
        )
        split2 = SplitOrderByCard(
            card_id=card.card_id,
            order_id=order.order_id,
            drink_id=drink2.drink_id,
            quantity=1,
        )
        session.add_all([split1, split2])
        session.commit()

        session.begin()
        assert order.total == 50
        assert card.balance == 70
        assert supply1.quantity == 0
        assert supply2.quantity == 2
        session.commit()


def test_card_order_err(
    db_session: Callable[[], Session], cleanup_tables: Callable[list[Base], None]
) -> None:
    with db_session() as session:
        session.begin()
        card = Card(balance=60)
        staff = DbObjectsFactory.get_staff()
        drink_low_supply = DbObjectsFactory.get_drink(10)
        drink_high_cost = DbObjectsFactory.get_drink(30)
        session.add_all([card, staff, drink_low_supply, drink_high_cost])
        session.commit()

        session.begin()
        bartender = Bartenders(staff_id=staff.staff_id, performance_rating=4)
        supply_low = BarSupplies(drink_id=drink_low_supply.drink_id, quantity=2)
        supply_high_cost = BarSupplies(drink_id=drink_high_cost.drink_id, quantity=3)
        session.add_all([bartender, supply_low, supply_high_cost])
        session.commit()

        session.begin()
        switch_role(session, Base._ROLE_ORDER_TERMINAL.name)
        order = DbObjectsFactory.get_order(bartender, 0)
        session.add(order)
        session.commit()

        session.begin()
        switch_role(session, Base._ROLE_ORDER_TERMINAL.name)
        split_low_supply = SplitOrderByCard(
            card_id=card.card_id,
            order_id=order.order_id,
            drink_id=drink_low_supply.drink_id,
            quantity=3,
        )
        session.add_all([split_low_supply])

        with pytest.raises(sqlalchemy.exc.ProgrammingError):
            session.commit()
        session.rollback()

        session.begin()
        split_high_cost = SplitOrderByCard(
            card_id=card.card_id,
            order_id=order.order_id,
            drink_id=drink_high_cost.drink_id,
            quantity=3,
        )
        session.add(split_high_cost)

        with pytest.raises(sqlalchemy.exc.ProgrammingError):
            session.commit()
        session.rollback()

        session.begin()
        assert card.balance == 60
        assert supply_low.quantity == 2
        assert supply_high_cost.quantity == 3
        session.commit()
