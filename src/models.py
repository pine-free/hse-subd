from __future__ import annotations
import datetime

from typing import Optional, ClassVar
from sqlalchemy import String, ForeignKey, CheckConstraint
from sqlalchemy.orm import DeclarativeBase, Mapped, mapped_column
from sqlalchemy_declarative_extensions import declarative_database, Roles, Grants
from sqlalchemy_declarative_extensions.dialects.postgresql import (
    Role,
    Grant,
)


@declarative_database
class Base(DeclarativeBase):
    # Read Roles
    _ROLE_STAFF: ClassVar[Role] = Role("staff", login=True, password="staff")
    _ROLE_BARTENDER: ClassVar[Role] = Role(
        "bartenders", login=True, password="bartenders", in_roles=[_ROLE_STAFF]
    )
    _ROLE_SECURITY: ClassVar[Role] = Role(
        "security", login=True, password="security", in_roles=[_ROLE_STAFF]
    )
    _ROLE_DEALERS: ClassVar[Role] = Role(
        "dealers", login=True, password="dealers", in_roles=[_ROLE_STAFF]
    )

    _ROLE_PLAYERS: ClassVar[Role] = Role("players", login=True, password="players")

    _ROLE_CARD_READER: ClassVar[Role] = Role("card_reader", password="card_reader")

    # Write Roles
    _ROLE_CARD_DISPENSER: ClassVar[Role] = Role(
        "card_dispenser", password="card_dispenser"
    )
    _ROLE_ORDER_TERMINAL: ClassVar[Role] = Role(
        "order_terminal", password="order_terminal"
    )
    _ROLE_BID_TERMINAL: ClassVar[Role] = Role("bid_terminal", password="bid_terminal")

    roles = Roles(ignore_unspecified=True).are(
        # Read Roles
        # -- Staff
        _ROLE_STAFF,
        _ROLE_BARTENDER,
        _ROLE_SECURITY,
        _ROLE_DEALERS,
        _ROLE_PLAYERS,
        _ROLE_CARD_READER,
        # Write Roles
        _ROLE_CARD_DISPENSER,
        _ROLE_ORDER_TERMINAL,
        _ROLE_BID_TERMINAL,
    )

    grants = Grants(ignore_unspecified=True).are(
        Grant.new("select", to=_ROLE_STAFF).on_tables("staff"),
        Grant.new("select", to=_ROLE_SECURITY).on_tables(
            "clients", "cards_to_clients_dispenser", "security"
        ),
        Grant.new("select", to=_ROLE_BARTENDER).on_tables(
            "bar_supplies", "drinks", "split_order_by_card", "orders", "bartenders"
        ),
        Grant.new("select", to=_ROLE_PLAYERS).on_tables(
            "card_bid_within_session",
            "session",
            "session_tables",
            "tables",
            "game_types",
        ),
        Grant.new("select", to=_ROLE_DEALERS).on_tables(
            "card_bid_within_session",
            "session",
            "session_tables",
            "tables",
            "game_types",
            "dealers",
        ),
        Grant.new("select", to=_ROLE_CARD_READER).on_tables("card"),
        Grant.new("select", to=_ROLE_CARD_DISPENSER).on_tables(
            "cards_to_clients_dispenser", "card"
        ),
        Grant.new("insert", to=_ROLE_CARD_DISPENSER).on_tables(
            "cards_to_clients_dispenser", "card"
        ),
        Grant.new("usage", to=_ROLE_CARD_DISPENSER).on_sequences(
            "card_card_id_seq", "cards_to_clients_dispenser_dispenser_id_seq"
        ),
        # Permissions according go the order update trigger
        Grant.new("select", to=_ROLE_ORDER_TERMINAL).on_tables(
            "card",
            "drinks",
            "bar_supplies",
            "bartenders",
            "split_order_by_card",
            "orders",
        ),
        Grant.new("insert", to=_ROLE_ORDER_TERMINAL).on_tables(
            "split_order_by_card", "orders"
        ),
        Grant.new("usage", to=_ROLE_ORDER_TERMINAL).on_sequences(
            "split_order_by_card_split_order_id_seq", "orders_order_id_seq"
        ),
        Grant.new("update", to=_ROLE_ORDER_TERMINAL).on_tables(
            "bar_supplies", "orders", "card"
        ),
        # Permissions according to bid update trigger
        Grant.new("select", to=_ROLE_BID_TERMINAL).on_tables("card", "session", "card_bid_within_session"),
        Grant.new("insert", to=_ROLE_BID_TERMINAL).on_tables("card_bid_within_session"),
        Grant.new("usage", to=_ROLE_BID_TERMINAL).on_sequences(
            "card_bid_within_session_bid_id_seq"
        ),
        Grant.new("update", to=_ROLE_BID_TERMINAL).on_tables("card"),
    )


class Drinks(Base):
    __tablename__ = "drinks"

    drink_id: Mapped[int] = mapped_column(primary_key=True)
    name: Mapped[str] = mapped_column(String(20))
    price: Mapped[int]
    volume: Mapped[int]
    category: Mapped[Optional[str]] = mapped_column(String(20))


class BarSupplies(Base):
    __tablename__ = "bar_supplies"

    quantity: Mapped[int]
    drink_id: Mapped[int] = mapped_column(
        ForeignKey("drinks.drink_id"), primary_key=True
    )


class Orders(Base):
    __tablename__ = "orders"

    order_id: Mapped[int] = mapped_column(primary_key=True)
    total: Mapped[int]
    order_time: Mapped[datetime.datetime]
    staff_id: Mapped[int] = mapped_column(ForeignKey("bartenders.staff_id"))


class Staff(Base):
    __tablename__ = "staff"

    staff_id: Mapped[int] = mapped_column(primary_key=True, nullable=False)
    name: Mapped[str] = mapped_column(String(20))
    surname: Mapped[str] = mapped_column(String(20))
    address: Mapped[str] = mapped_column(String(20))
    age: Mapped[int]


class Bartenders(Base):
    __tablename__ = "bartenders"
    __table_args__ = (
        CheckConstraint("performance_rating >= 0 AND performance_rating <= 5"),
    )

    staff_id: Mapped[int] = mapped_column(
        ForeignKey("staff.staff_id"), primary_key=True
    )
    performance_rating: Mapped[Optional[int]]


class Dealers(Base):
    __tablename__ = "dealers"

    staff_id: Mapped[int] = mapped_column(
        ForeignKey("staff.staff_id"), primary_key=True
    )
    qualification: Mapped[Optional[str]] = mapped_column(String(20))


class Security(Base):
    __tablename__ = "security"

    staff_id: Mapped[int] = mapped_column(
        ForeignKey("staff.staff_id"), primary_key=True
    )
    zone: Mapped[Optional[int]]


class Clients(Base):
    __tablename__ = "clients"

    user_id: Mapped[int] = mapped_column(primary_key=True)
    name: Mapped[str] = mapped_column(String(20))
    surname: Mapped[str] = mapped_column(String(20))
    deposit: Mapped[int]
    address: Mapped[str] = mapped_column(String(20))
    credit: Mapped[Optional[int]]
    notes: Mapped[Optional[str]] = mapped_column(String(20))
    age: Mapped[int]


class Card(Base):
    __tablename__ = "card"

    card_id: Mapped[int] = mapped_column(primary_key=True)
    balance: Mapped[int]


class CardsToClientsDispenser(Base):
    __tablename__ = "cards_to_clients_dispenser"

    dispenser_id: Mapped[int] = mapped_column(primary_key=True)
    user_id: Mapped[int] = mapped_column(ForeignKey("clients.user_id"))
    card_id: Mapped[int] = mapped_column(ForeignKey("card.card_id"))
    entry_time: Mapped[datetime.datetime]
    abandon_time: Mapped[datetime.datetime]


class SplitOrderByCard(Base):
    __tablename__ = "split_order_by_card"
    __table_args__ = (CheckConstraint("quantity >= 1"),)

    split_order_id: Mapped[int] = mapped_column(primary_key=True)
    card_id: Mapped[int] = mapped_column(ForeignKey("card.card_id"))
    order_id: Mapped[int] = mapped_column(ForeignKey("orders.order_id"))
    drink_id: Mapped[int] = mapped_column(ForeignKey("drinks.drink_id"))
    quantity: Mapped[int]


class Session(Base):
    __tablename__ = "session"

    session_id: Mapped[int] = mapped_column(primary_key=True)
    start_time: Mapped[datetime.datetime]
    end_time: Mapped[datetime.datetime]


class CardBidWithnSession(Base):
    __tablename__ = "card_bid_within_session"

    bid_id: Mapped[int] = mapped_column(primary_key=True)
    session_id: Mapped[int] = mapped_column(ForeignKey("session.session_id"))
    card_id: Mapped[int] = mapped_column(ForeignKey("card.card_id"))
    bid_amount: Mapped[int]
    money_gain: Mapped[int]


class GameTypes(Base):
    __tablename__ = "game_types"

    type_id: Mapped[int] = mapped_column(primary_key=True)
    game_type: Mapped[str] = mapped_column(String(20))
    is_supervised: Mapped[bool]


class Tables(Base):
    __tablename__ = "tables"

    table_id: Mapped[int] = mapped_column(primary_key=True)
    type_id: Mapped[int] = mapped_column(ForeignKey("game_types.type_id"))
    balance: Mapped[int]
    opening_time: Mapped[datetime.datetime]
    closing_time: Mapped[datetime.datetime]


class SessionTables(Base):
    __tablename__ = "session_tables"

    session_to_table_id: Mapped[int] = mapped_column(primary_key=True)
    session_id: Mapped[int] = mapped_column(ForeignKey("session.session_id"))
    table_id: Mapped[int] = mapped_column(ForeignKey("tables.table_id"))
    staff_id: Mapped[Optional[int]] = mapped_column(ForeignKey("dealers.staff_id"))
