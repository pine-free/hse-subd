BEGIN;

CREATE TABLE alembic_version (
    version_num VARCHAR(32) NOT NULL, 
    CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num)
);

-- Running upgrade  -> e8313f0fd0ec

CREATE TABLE "Card" (
    "card_ID" SERIAL NOT NULL, 
    "user_ID" INTEGER, 
    balance INTEGER, 
    PRIMARY KEY ("card_ID")
);

CREATE TABLE "Clients" (
    "user_ID" SERIAL NOT NULL, 
    name VARCHAR(20), 
    surname VARCHAR(20), 
    deposit INTEGER, 
    address VARCHAR(20), 
    credit INTEGER, 
    notes VARCHAR(20), 
    age INTEGER, 
    PRIMARY KEY ("user_ID")
);

CREATE TABLE "Drinks" (
    "drink_ID" SERIAL NOT NULL, 
    name VARCHAR(20), 
    price INTEGER, 
    volume INTEGER, 
    category VARCHAR(20), 
    PRIMARY KEY ("drink_ID")
);

CREATE TABLE "Game_types" (
    "type_ID" SERIAL NOT NULL, 
    game_type VARCHAR(20) NOT NULL, 
    "isSupervised" INTEGER NOT NULL, 
    PRIMARY KEY ("type_ID")
);

CREATE TABLE "Session" (
    "session_ID" SERIAL NOT NULL, 
    start_time TIMESTAMP WITHOUT TIME ZONE, 
    end_time TIMESTAMP WITHOUT TIME ZONE, 
    PRIMARY KEY ("session_ID")
);

CREATE TABLE "Staff" (
    "staff_ID" SERIAL NOT NULL, 
    name VARCHAR(20), 
    surname VARCHAR(20), 
    address VARCHAR(20), 
    age INTEGER, 
    PRIMARY KEY ("staff_ID")
);

CREATE TABLE "Bar_supplies" (
    quantity INTEGER, 
    "drink_ID" INTEGER NOT NULL, 
    PRIMARY KEY ("drink_ID"), 
    FOREIGN KEY("drink_ID") REFERENCES "Drinks" ("drink_ID")
);

CREATE TABLE "Bartenders" (
    "staff_ID" INTEGER NOT NULL, 
    performance_rating INTEGER, 
    PRIMARY KEY ("staff_ID"), 
    CHECK (performance_rating >= 0 AND performance_rating <= 5), 
    FOREIGN KEY("staff_ID") REFERENCES "Staff" ("staff_ID")
);

CREATE TABLE "CardToClientsDispenser" (
    "dispenser_ID" SERIAL NOT NULL, 
    "user_ID" INTEGER NOT NULL, 
    "card_ID" INTEGER NOT NULL, 
    entry_time TIMESTAMP WITHOUT TIME ZONE, 
    abandon_time TIMESTAMP WITHOUT TIME ZONE, 
    PRIMARY KEY ("dispenser_ID"), 
    FOREIGN KEY("card_ID") REFERENCES "Card" ("card_ID"), 
    FOREIGN KEY("user_ID") REFERENCES "Clients" ("user_ID")
);

CREATE TABLE "Card_Bid_within_Session" (
    "bid_ID" SERIAL NOT NULL, 
    "session_ID" INTEGER NOT NULL, 
    "card_ID" INTEGER NOT NULL, 
    bid_amount INTEGER, 
    money_gain INTEGER, 
    PRIMARY KEY ("bid_ID"), 
    FOREIGN KEY("card_ID") REFERENCES "Card" ("card_ID"), 
    FOREIGN KEY("session_ID") REFERENCES "Session" ("session_ID")
);

CREATE TABLE "Dealers" (
    "staff_ID" INTEGER NOT NULL, 
    qualification VARCHAR(20), 
    PRIMARY KEY ("staff_ID"), 
    FOREIGN KEY("staff_ID") REFERENCES "Staff" ("staff_ID")
);

CREATE TABLE "Security" (
    "staff_ID" INTEGER NOT NULL, 
    zone INTEGER, 
    PRIMARY KEY ("staff_ID"), 
    FOREIGN KEY("staff_ID") REFERENCES "Staff" ("staff_ID")
);

CREATE TABLE "Tables" (
    "table_ID" SERIAL NOT NULL, 
    "type_ID" INTEGER NOT NULL, 
    balance INTEGER, 
    openning_time TIMESTAMP WITHOUT TIME ZONE, 
    closing_time TIMESTAMP WITHOUT TIME ZONE, 
    PRIMARY KEY ("table_ID"), 
    FOREIGN KEY("type_ID") REFERENCES "Game_types" ("type_ID")
);

CREATE TABLE "Orders" (
    "order_ID" SERIAL NOT NULL, 
    total INTEGER, 
    order_time TIMESTAMP WITHOUT TIME ZONE, 
    "staff_ID" INTEGER NOT NULL, 
    PRIMARY KEY ("order_ID"), 
    FOREIGN KEY("staff_ID") REFERENCES "Bartenders" ("staff_ID")
);

CREATE TABLE session_tables (
    "session_to_table_ID" SERIAL NOT NULL, 
    "session_ID" INTEGER NOT NULL, 
    "table_ID" INTEGER NOT NULL, 
    "staff_ID" INTEGER, 
    PRIMARY KEY ("session_to_table_ID"), 
    FOREIGN KEY("session_ID") REFERENCES "Session" ("session_ID"), 
    FOREIGN KEY("staff_ID") REFERENCES "Dealers" ("staff_ID"), 
    FOREIGN KEY("table_ID") REFERENCES "Tables" ("table_ID")
);

CREATE TABLE "Split_Order_by_Card" (
    "split_order_ID" SERIAL NOT NULL, 
    "card_ID" INTEGER NOT NULL, 
    "order_ID" INTEGER NOT NULL, 
    "drink_ID" INTEGER NOT NULL, 
    quantity INTEGER, 
    PRIMARY KEY ("split_order_ID"), 
    FOREIGN KEY("card_ID") REFERENCES "Card" ("card_ID"), 
    FOREIGN KEY("drink_ID") REFERENCES "Drinks" ("drink_ID"), 
    FOREIGN KEY("order_ID") REFERENCES "Orders" ("order_ID")
);

INSERT INTO alembic_version (version_num) VALUES ('e8313f0fd0ec') RETURNING alembic_version.version_num;

-- Running upgrade e8313f0fd0ec -> 6611b8d45bf5

CREATE FUNCTION "public"."ensure_dealer_correct"() RETURNS TRIGGER AS $ensure_dealer$
    DECLARE
        table_type_ID integer;
        should_be_supervised integer;
        BEGIN
            IF (TG_OP = 'INSERT') THEN
                SELECT type_ID INTO table_type_ID FROM Tables WHERE table_ID = NEW.table_ID;
                SELECT isSupervised INTO should_be_supervised FROM Game_types WHERE type_ID = table_type_ID;
                IF (should_be_supervised = 1 AND NEW.staff_ID IS NULL) THEN
                    RAISE EXCEPTION 'Game type % should be supervised, missing dealer for session %',
                        table_type_ID, NEW.session_ID;
                ELSIF (should_be_supervised = 0 AND NEW.staff_ID IS NOT NULL) THEN
                    RAISE EXCEPTION 'Game type % should not be supervised, found dealer % for session %',
                        table_type_ID, NEW.staff_ID, NEW.session_ID;
                END IF;
                
            END IF;
        END;
    $ensure_dealer$ LANGUAGE plpgsql;

CREATE CONSTRAINT TRIGGER "ensure_dealer_trigger" AFTER INSERT ON public.session_tables DEFERRABLE INITIALLY DEFERRED
        FOR EACH ROW EXECUTE FUNCTION ensure_dealer_correct();

UPDATE alembic_version SET version_num='6611b8d45bf5' WHERE alembic_version.version_num = 'e8313f0fd0ec';

COMMIT;

