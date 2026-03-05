from __future__ import annotations
import datetime

from typing import Optional
from sqlalchemy import String, ForeignKey, Integer, CheckConstraint
from sqlalchemy.orm import DeclarativeBase, Mapped, mapped_column

class Base(DeclarativeBase):
    pass

class Drinks(Base):
    __tablename__ = "drinks"

    drink_ID: Mapped[int] = mapped_column(primary_key=True)
    name: Mapped[Optional[str]] = mapped_column(String(20))
    price: Mapped[Optional[int]]
    volume: Mapped[Optional[int]]
    category: Mapped[Optional[str] ]= mapped_column(String(20))

class BarSupplies(Base):
    __tablename__ = "bar_supplies"

    quantity: Mapped[Optional[int]]
    drink_ID: Mapped[int] = mapped_column(ForeignKey("drinks.drink_ID"), primary_key=True)

class Orders(Base):
    __tablename__ = "orders"

    order_ID: Mapped[int] = mapped_column(primary_key=True)
    total: Mapped[Optional[int]]
    order_time: Mapped[Optional[datetime.datetime]]
    staff_ID: Mapped[int] = mapped_column(ForeignKey("bartenders.staff_ID"))

class Staff(Base):
    __tablename__ = "staff"

    staff_ID: Mapped[int] = mapped_column(primary_key=True, nullable=False)
    name: Mapped[Optional[str]] = mapped_column(String(20))
    surname: Mapped[Optional[str]] = mapped_column(String(20))
    address: Mapped[Optional[str]] = mapped_column(String(20))
    age: Mapped[Optional[int]]

class Bartenders(Base):
    __tablename__ = "bartenders"
    __table_args__ = (CheckConstraint("performance_rating >= 0 AND performance_rating <= 5"),)

    staff_ID: Mapped[int] = mapped_column(ForeignKey("staff.staff_ID"), primary_key=True)
    performance_rating: Mapped[Optional[int]]

class Dealers(Base):
    __tablename__ = "dealers"
        
    staff_ID: Mapped[int] = mapped_column(ForeignKey("staff.staff_ID"), primary_key=True)
    qualification: Mapped[Optional[str]] = mapped_column(String(20))

class Security(Base):
    __tablename__ = "security"

    staff_ID: Mapped[int] = mapped_column(ForeignKey("staff.staff_ID"), primary_key=True)
    zone: Mapped[Optional[int]]

class Clients(Base):
    __tablename__ = "clients"

    user_ID: Mapped[int] = mapped_column(primary_key=True)
    name: Mapped[Optional[str]] = mapped_column(String(20))
    surname: Mapped[Optional[str]] = mapped_column(String(20))
    deposit: Mapped[Optional[int]]    
    address: Mapped[Optional[str]] = mapped_column(String(20))
    credit: Mapped[Optional[int]]    
    notes: Mapped[Optional[str]] = mapped_column(String(20))
    age: Mapped[Optional[int]]
    

class Card(Base):
    __tablename__ = "card"

    card_ID: Mapped[int] = mapped_column(primary_key=True)
    user_ID: Mapped[Optional[int]]
    balance: Mapped[Optional[int]]

class CardsToClientsDispenser(Base):
    __tablename__ = "cards_to_clients_dispenser"

    dispenser_ID: Mapped[int] = mapped_column(primary_key=True)
    user_ID: Mapped[int] = mapped_column(ForeignKey("clients.user_ID"))
    card_ID: Mapped[int] = mapped_column(ForeignKey("card.card_ID"))
    entry_time: Mapped[Optional[datetime.datetime]]
    abandon_time: Mapped[Optional[datetime.datetime]]


class SplitOrderByCard(Base):
    __tablename__ = "split_order_by_card"

    split_order_ID: Mapped[int] = mapped_column(primary_key=True)
    card_ID: Mapped[int] = mapped_column(ForeignKey("card.card_ID"))
    order_ID: Mapped[int] = mapped_column(ForeignKey("orders.order_ID"))
    drink_ID: Mapped[int] = mapped_column(ForeignKey("drinks.drink_ID"))
    quantity: Mapped[Optional[int]]

class Session(Base):
    __tablename__ = "session"

    session_ID: Mapped[int] = mapped_column(primary_key=True)
    start_time: Mapped[Optional[datetime.datetime]]
    end_time: Mapped[Optional[datetime.datetime]]

class CardBidWithnSession(Base):
    __tablename__ = "card_bid_within_session"

    bid_ID: Mapped[int] = mapped_column(primary_key=True)
    session_ID: Mapped[int] = mapped_column(ForeignKey("session.session_ID"))
    card_ID: Mapped[int] = mapped_column(ForeignKey("card.card_ID"))
    bid_amount: Mapped[Optional[int]]
    money_gain: Mapped[Optional[int]]

class GameTypes(Base):
    __tablename__ = "game_types"

    type_ID: Mapped[int] = mapped_column(primary_key=True)
    game_type: Mapped[str] = mapped_column(String(20))
    isSupervised: Mapped[int]

class Tables(Base):
    __tablename__ = "tables"

    table_ID: Mapped[int] = mapped_column(primary_key=True)
    type_ID: Mapped[int] = mapped_column(ForeignKey("game_types.type_ID"))
    balance: Mapped[Optional[int]]
    openning_time: Mapped[Optional[datetime.datetime]]
    closing_time: Mapped[Optional[datetime.datetime]]

class SessionTables(Base):
    __tablename__ = "session_tables"

    session_to_table_ID: Mapped[int] = mapped_column(primary_key=True)
    session_ID: Mapped[int] = mapped_column(ForeignKey("session.session_ID"))
    table_ID: Mapped[int] = mapped_column(ForeignKey("tables.table_ID"))
    staff_ID: Mapped[Optional[int]] = mapped_column(ForeignKey("dealers.staff_ID"))
