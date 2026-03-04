from __future__ import annotations
import datetime

from typing import Optional
from sqlalchemy import String, ForeignKey, Integer, CheckConstraint
from sqlalchemy.orm import DeclarativeBase, Mapped, mapped_column

class Base(DeclarativeBase):
    pass

class Drinks(Base):
    __tablename__ = "Drinks"

    drink_ID: Mapped[int] = mapped_column(primary_key=True)
    name: Mapped[Optional[str]] = mapped_column(String(20))
    price: Mapped[Optional[int]]
    volume: Mapped[Optional[int]]
    category: Mapped[Optional[str] ]= mapped_column(String(20))

class BarSupplies(Base):
    __tablename__ = "Bar_supplies"

    quantity: Mapped[Optional[int]]
    drink_ID: Mapped[int] = mapped_column(ForeignKey("Drinks.drink_ID"), primary_key=True)

class Orders(Base):
    __tablename__ = "Orders"

    order_ID: Mapped[int] = mapped_column(primary_key=True)
    total: Mapped[Optional[int]]
    order_time: Mapped[Optional[datetime.datetime]]
    staff_ID: Mapped[int] = mapped_column(ForeignKey("Bartenders.staff_ID"))

class Staff(Base):
    __tablename__ = "Staff"

    staff_ID: Mapped[int] = mapped_column(primary_key=True, nullable=False)
    name: Mapped[Optional[str]] = mapped_column(String(20))
    surname: Mapped[Optional[str]] = mapped_column(String(20))
    address: Mapped[Optional[str]] = mapped_column(String(20))
    age: Mapped[Optional[int]]

class Bartenders(Base):
    __tablename__ = "Bartenders"
    __table_args__ = (CheckConstraint("performance_rating >= 0 AND performance_rating <= 5"),)

    staff_ID: Mapped[int] = mapped_column(ForeignKey("Staff.staff_ID"), primary_key=True)
    performance_rating: Mapped[Optional[int]]

class Dealers(Base):
    __tablename__ = "Dealers"
        
    staff_ID: Mapped[int] = mapped_column(ForeignKey("Staff.staff_ID"), primary_key=True)
    qualification: Mapped[Optional[str]] = mapped_column(String(20))

class Security(Base):
    __tablename__ = "Security"

    staff_ID: Mapped[int] = mapped_column(ForeignKey("Staff.staff_ID"), primary_key=True)
    zone: Mapped[Optional[int]]

class Clients(Base):
    __tablename__ = "Clients"

    user_ID: Mapped[int] = mapped_column(primary_key=True)
    name: Mapped[Optional[str]] = mapped_column(String(20))
    surname: Mapped[Optional[str]] = mapped_column(String(20))
    deposit: Mapped[Optional[int]]    
    address: Mapped[Optional[str]] = mapped_column(String(20))
    credit: Mapped[Optional[int]]    
    notes: Mapped[Optional[str]] = mapped_column(String(20))
    age: Mapped[Optional[int]]
    

class Card(Base):
    __tablename__ = "Card"

    card_ID: Mapped[int] = mapped_column(primary_key=True)
    user_ID: Mapped[Optional[int]]
    balance: Mapped[Optional[int]]

class CardToClientsDispenser(Base):
    __tablename__ = "CardToClientsDispenser"

    dispenser_ID: Mapped[int] = mapped_column(primary_key=True)
    user_ID: Mapped[int] = mapped_column(ForeignKey("Clients.user_ID"))
    card_ID: Mapped[int] = mapped_column(ForeignKey("Card.card_ID"))
    entry_time: Mapped[Optional[datetime.datetime]]
    abandon_time: Mapped[Optional[datetime.datetime]]


class SplitOrderByCard(Base):
    __tablename__ = "Split_Order_by_Card"

    split_order_ID: Mapped[int] = mapped_column(primary_key=True)
    card_ID: Mapped[int] = mapped_column(ForeignKey("Card.card_ID"))
    order_ID: Mapped[int] = mapped_column(ForeignKey("Orders.order_ID"))
    drink_ID: Mapped[int] = mapped_column(ForeignKey("Drinks.drink_ID"))
    quantity: Mapped[Optional[int]]

class Session(Base):
    __tablename__ = "Session"

    session_ID: Mapped[int] = mapped_column(primary_key=True)
    start_time: Mapped[Optional[datetime.datetime]]
    end_time: Mapped[Optional[datetime.datetime]]

class CardBidWithnSession(Base):
    __tablename__ = "Card_Bid_within_Session"

    bid_ID: Mapped[int] = mapped_column(primary_key=True)
    session_ID: Mapped[int] = mapped_column(ForeignKey("Session.session_ID"))
    card_ID: Mapped[int] = mapped_column(ForeignKey("Card.card_ID"))
    bid_amount: Mapped[Optional[int]]
    money_gain: Mapped[Optional[int]]

class GameTypes(Base):
    __tablename__ = "Game_types"

    type_ID: Mapped[int] = mapped_column(primary_key=True)
    game_type: Mapped[str] = mapped_column(String(20))
    isSupervised: Mapped[int]

class Tables(Base):
    __tablename__ = "Tables"

    table_ID: Mapped[int] = mapped_column(primary_key=True)
    type_ID: Mapped[int] = mapped_column(ForeignKey("Game_types.type_ID"))
    balance: Mapped[Optional[int]]
    openning_time: Mapped[Optional[datetime.datetime]]
    closing_time: Mapped[Optional[datetime.datetime]]

class SessionTables(Base):
    __tablename__ = "Session_Tables"

    session_to_table_ID: Mapped[int] = mapped_column(primary_key=True)
    session_ID: Mapped[int] = mapped_column(ForeignKey("Session.session_ID"))
    table_ID: Mapped[int] = mapped_column(ForeignKey("Tables.table_ID"))
    staff_ID: Mapped[Optional[int]] = mapped_column(ForeignKey("Dealers.staff_ID"))
