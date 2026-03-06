import time
import pytest
import datetime
from contextlib import contextmanager

from src.models import Card, Session as GameSession, CardBidWithnSession, Base
from sqlalchemy.orm import Session, sessionmaker
from typing import Generator, Callable
from sqlalchemy import URL, Engine, create_engine, text


@pytest.fixture()
def db_engine(postgres_url: URL) -> Engine:
    e = create_engine(postgres_url)
    return e

@pytest.fixture()
def cleanup_tables(db_session: Callable[[], Session]) -> Callable[[list[Base]], None]:
    def _cleanup(types: list[Base]) -> None:
        with db_session() as session:
            session.begin()
            for t in types:
                session.execute(text(f"TRUNCATE TABLE {t.__tablename__} RESTART IDENTITY CASCADE;"))
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


def test_card_insert_bid_loss(db_session: Callable[[], Session], cleanup_tables: Callable[list[Base], None]) -> None:
    with db_session() as session:

        session.begin()
        card = Card(balance=100)
        game_session = GameSession(
            start_time=datetime.datetime(2020, 12, 1),
            end_time=datetime.datetime(2020, 12, 2),
        )
        session.add_all([card, game_session])
        session.commit()

        session.begin()
        bid = CardBidWithnSession(
            session_id=game_session.session_id,
            card_id=card.card_id,
            bid_amount=30,
            money_gain=0,
        )
        session.add(bid)
        session.commit()

        session.begin()
        assert card.balance == 70
        session.commit()
    cleanup_tables([CardBidWithnSession, Card, GameSession])

def test_card_insert_bid_win(db_session: Callable[[], Session], cleanup_tables: Callable[list[Base], None]) -> None:
    with db_session() as session:

        session.begin()
        card = Card(balance=100)
        game_session = GameSession(
            start_time=datetime.datetime(2020, 12, 1),
            end_time=datetime.datetime(2020, 12, 2),
        )
        session.add_all([card, game_session])
        session.commit()

        session.begin()
        bid = CardBidWithnSession(
            session_id=game_session.session_id,
            card_id=card.card_id,
            bid_amount=50,
            money_gain=20,
        )
        session.add(bid)
        session.commit()

        session.begin()
        assert card.balance == 120
        session.commit()
    cleanup_tables([CardBidWithnSession, Card, GameSession])
