from alembic_utils.pg_trigger import PGTrigger
from alembic_utils.pg_function import PGFunction

# == Dealer check ==
ensure_dealer_correct = PGFunction(
    schema="public",
    signature="ensure_dealer_correct()",
    definition="""
    RETURNS TRIGGER AS $ensure_dealer$
    DECLARE
        table_type_id integer;
        should_be_supervised boolean;
        BEGIN
            IF (TG_OP = 'INSERT') THEN
                SELECT type_id INTO table_type_id FROM Tables WHERE table_id = NEW.table_id;
                SELECT is_supervised INTO should_be_supervised FROM game_types WHERE type_id = table_type_id;
                IF (should_be_supervised = true AND NEW.staff_id IS NULL) THEN
                    RAISE EXCEPTION 'Game type % should be supervised, missing dealer for session %',
                        table_type_id, NEW.session_id;
                ELSIF (should_be_supervised = false AND NEW.staff_id IS NOT NULL) THEN
                    RAISE EXCEPTION 'Game type % should not be supervised, found dealer % for session %',
                        table_type_id, NEW.staff_id, NEW.session_id;
                END IF;
                
            END IF;
            RETURN NULL;
        END;
    $ensure_dealer$ LANGUAGE plpgsql;
    """,
)

ensure_dealer_trigger = PGTrigger(
    schema="public",
    signature="ensure_dealer_trigger",
    definition="""
        AFTER INSERT ON public.session_tables
        FOR EACH ROW EXECUTE FUNCTION ensure_dealer_correct();
    """,
    on_entity="public.session_tables",
    is_constraint=True,
)

# == Update cards on bid ==

update_card_bid = PGFunction(
    schema="public",
    signature="update_card_bid()",
    definition="""
    RETURNS TRIGGER AS $update_card_bid$
    DECLARE
        card_balance integer;
        money_delta integer;
    BEGIN
        IF (TG_OP = 'INSERT') THEN
            SELECT balance FROM card INTO card_balance WHERE card_id = NEW.card_id;
            money_delta := NEW.bid_amount - NEW.money_gain;
            IF (NEW.bid_amount > card_balance) THEN
                RAISE EXCEPTION 'Cannot bet more money than the card has';
            END IF;
            UPDATE card SET balance = balance - money_delta WHERE card_id = NEW.card_id;
            UPDATE tables SET balance = balance + money_delta WHERE table_id = (SELECT table_id FROM session_tables WHERE session_id = NEW.session_id);
        END IF;
        RETURN NULL;
    END;
    $update_card_bid$ LANGUAGE plpgsql
    """,
)

update_card_bid_trigger = PGTrigger(
    schema="public",
    signature="update_card_bid_trigger",
    definition="""
        AFTER INSERT ON public.card_bid_within_session
        FOR EACH ROW EXECUTE FUNCTION update_card_bid();
    """,
    on_entity="public.card_bid_within_session",
)

update_card_order = PGFunction(
    schema="public",
    signature="update_card_order()",
    definition="""
    RETURNS TRIGGER AS $update_card_order$
    DECLARE
        card_balance integer;
        order_total integer;
        remaining_quantity integer;
    BEGIN
        IF (TG_OP = 'INSERT') THEN
            SELECT balance FROM card INTO card_balance WHERE card_id = NEW.card_id;
            SELECT price * NEW.quantity FROM drinks INTO order_total WHERE drink_id = NEW.drink_id;

            IF (order_total > card_balance) THEN
                RAISE EXCEPTION 'Cannot place an order with more total than the card has';
            END IF;

            SELECT quantity FROM bar_supplies INTO remaining_quantity WHERE drink_id = NEW.drink_id;

            IF (NEW.quantity > remaining_quantity) THEN
                RAISE EXCEPTION 'Cannot place an order for more items than there are in supplies';
            END IF;

            UPDATE orders SET total = total + order_total WHERE order_id = NEW.order_id;
            UPDATE card SET balance = balance - order_total WHERE card_id = NEW.card_id;
            UPDATE bar_supplies SET quantity = quantity - NEW.quantity WHERE drink_id = NEW.drink_id;
        END IF;
        RETURN NULL;
    END;
    $update_card_order$ LANGUAGE plpgsql
    """,
)

update_card_order_trigger = PGTrigger(
    schema="public",
    signature="update_card_order_trigger",
    definition="""
        AFTER INSERT ON public.split_order_by_card
        FOR EACH ROW EXECUTE FUNCTION update_card_order();
    """,
    on_entity="public.split_order_by_card",
)
