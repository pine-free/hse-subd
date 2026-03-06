BEGIN;

CREATE TABLE alembic_version (
    version_num VARCHAR(32) NOT NULL, 
    CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num)
);

-- Running upgrade  -> 118ace94455d

CREATE TABLE card (
    card_id SERIAL NOT NULL, 
    balance INTEGER, 
    PRIMARY KEY (card_id)
);

CREATE TABLE clients (
    user_id SERIAL NOT NULL, 
    name VARCHAR(20), 
    surname VARCHAR(20), 
    deposit INTEGER, 
    address VARCHAR(20), 
    credit INTEGER, 
    notes VARCHAR(20), 
    age INTEGER, 
    PRIMARY KEY (user_id)
);

CREATE TABLE drinks (
    drink_id SERIAL NOT NULL, 
    name VARCHAR(20), 
    price INTEGER, 
    volume INTEGER, 
    category VARCHAR(20), 
    PRIMARY KEY (drink_id)
);

CREATE TABLE game_types (
    type_id SERIAL NOT NULL, 
    game_type VARCHAR(20) NOT NULL, 
    is_supervised INTEGER NOT NULL, 
    PRIMARY KEY (type_id)
);

CREATE TABLE session (
    session_id SERIAL NOT NULL, 
    start_time TIMESTAMP WITHOUT TIME ZONE, 
    end_time TIMESTAMP WITHOUT TIME ZONE, 
    PRIMARY KEY (session_id)
);

CREATE TABLE staff (
    staff_id SERIAL NOT NULL, 
    name VARCHAR(20), 
    surname VARCHAR(20), 
    address VARCHAR(20), 
    age INTEGER, 
    PRIMARY KEY (staff_id)
);

CREATE TABLE bar_supplies (
    quantity INTEGER, 
    drink_id INTEGER NOT NULL, 
    PRIMARY KEY (drink_id), 
    FOREIGN KEY(drink_id) REFERENCES drinks (drink_id)
);

CREATE TABLE bartenders (
    staff_id INTEGER NOT NULL, 
    performance_rating INTEGER, 
    PRIMARY KEY (staff_id), 
    CHECK (performance_rating >= 0 AND performance_rating <= 5), 
    FOREIGN KEY(staff_id) REFERENCES staff (staff_id)
);

CREATE TABLE card_bid_within_session (
    bid_id SERIAL NOT NULL, 
    session_id INTEGER NOT NULL, 
    card_id INTEGER NOT NULL, 
    bid_amount INTEGER, 
    money_gain INTEGER, 
    PRIMARY KEY (bid_id), 
    FOREIGN KEY(card_id) REFERENCES card (card_id), 
    FOREIGN KEY(session_id) REFERENCES session (session_id)
);

CREATE TABLE cards_to_clients_dispenser (
    dispenser_id SERIAL NOT NULL, 
    user_id INTEGER NOT NULL, 
    card_id INTEGER NOT NULL, 
    entry_time TIMESTAMP WITHOUT TIME ZONE, 
    abandon_time TIMESTAMP WITHOUT TIME ZONE, 
    PRIMARY KEY (dispenser_id), 
    FOREIGN KEY(card_id) REFERENCES card (card_id), 
    FOREIGN KEY(user_id) REFERENCES clients (user_id)
);

CREATE TABLE dealers (
    staff_id INTEGER NOT NULL, 
    qualification VARCHAR(20), 
    PRIMARY KEY (staff_id), 
    FOREIGN KEY(staff_id) REFERENCES staff (staff_id)
);

CREATE TABLE security (
    staff_id INTEGER NOT NULL, 
    zone INTEGER, 
    PRIMARY KEY (staff_id), 
    FOREIGN KEY(staff_id) REFERENCES staff (staff_id)
);

CREATE TABLE tables (
    table_id SERIAL NOT NULL, 
    type_id INTEGER NOT NULL, 
    balance INTEGER, 
    openning_time TIMESTAMP WITHOUT TIME ZONE, 
    closing_time TIMESTAMP WITHOUT TIME ZONE, 
    PRIMARY KEY (table_id), 
    FOREIGN KEY(type_id) REFERENCES game_types (type_id)
);

CREATE TABLE orders (
    order_id SERIAL NOT NULL, 
    total INTEGER, 
    order_time TIMESTAMP WITHOUT TIME ZONE, 
    staff_id INTEGER NOT NULL, 
    PRIMARY KEY (order_id), 
    FOREIGN KEY(staff_id) REFERENCES bartenders (staff_id)
);

CREATE TABLE session_tables (
    session_to_table_id SERIAL NOT NULL, 
    session_id INTEGER NOT NULL, 
    table_id INTEGER NOT NULL, 
    staff_id INTEGER, 
    PRIMARY KEY (session_to_table_id), 
    FOREIGN KEY(session_id) REFERENCES session (session_id), 
    FOREIGN KEY(staff_id) REFERENCES dealers (staff_id), 
    FOREIGN KEY(table_id) REFERENCES tables (table_id)
);

CREATE TABLE split_order_by_card (
    split_order_id SERIAL NOT NULL, 
    card_id INTEGER NOT NULL, 
    order_id INTEGER NOT NULL, 
    drink_id INTEGER NOT NULL, 
    quantity INTEGER, 
    PRIMARY KEY (split_order_id), 
    FOREIGN KEY(card_id) REFERENCES card (card_id), 
    FOREIGN KEY(drink_id) REFERENCES drinks (drink_id), 
    FOREIGN KEY(order_id) REFERENCES orders (order_id)
);

INSERT INTO alembic_version (version_num) VALUES ('118ace94455d') RETURNING alembic_version.version_num;

-- Running upgrade 118ace94455d -> 7af387664104

CREATE FUNCTION "public"."ensure_dealer_correct"() RETURNS TRIGGER AS $ensure_dealer$
    DECLARE
        table_type_id integer;
        should_be_supervised integer;
        BEGIN
            IF (TG_OP = 'INSERT') THEN
                SELECT type_id INTO table_type_id FROM Tables WHERE table_id = NEW.table_id;
                SELECT is_supervised INTO should_be_supervised FROM game_types WHERE type_id = table_type_id;
                IF (should_be_supervised = 1 AND NEW.staff_id IS NULL) THEN
                    RAISE EXCEPTION 'Game type % should be supervised, missing dealer for session %',
                        table_type_id, NEW.session_id;
                ELSIF (should_be_supervised = 0 AND NEW.staff_id IS NOT NULL) THEN
                    RAISE EXCEPTION 'Game type % should not be supervised, found dealer % for session %',
                        table_type_id, NEW.staff_id, NEW.session_id;
                END IF;
                
            END IF;
            RETURN NULL;
        END;
    $ensure_dealer$ LANGUAGE plpgsql;

CREATE FUNCTION "public"."update_card_bid"() RETURNS TRIGGER AS $update_card_bid$
    DECLARE
        card_balance integer;
    BEGIN
        IF (TG_OP = 'INSERT') THEN
            SELECT balance FROM card INTO card_balance;
            IF (NEW.bid_amount > card_balance) THEN
                RAISE EXCEPTION 'Cannot bet more money than the card has';
            END IF;
            IF (NEW.money_gain = 0) THEN
                UPDATE card SET balance = balance - NEW.bid_amount WHERE card_id = NEW.card_id;
            ELSE
                UPDATE card SET balance = balance + NEW.money_gain WHERE card_id = NEW.card_id;
            END IF;
        END IF;
        RETURN NULL;
    END;
    $update_card_bid$ LANGUAGE plpgsql;

CREATE CONSTRAINT TRIGGER "ensure_dealer_trigger" AFTER INSERT ON public.session_tables FOR EACH ROW EXECUTE FUNCTION ensure_dealer_correct();

CREATE TRIGGER "update_card_bid_trigger" AFTER INSERT ON public.card_bid_within_session FOR EACH ROW EXECUTE FUNCTION update_card_bid();

UPDATE alembic_version SET version_num='7af387664104' WHERE alembic_version.version_num = '118ace94455d';

COMMIT;

