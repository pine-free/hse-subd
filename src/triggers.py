from alembic_utils.pg_trigger import PGTrigger
from alembic_utils.pg_function import PGFunction

# == Dealer check ==
ensure_dealer_correct = PGFunction(
    schema='public',
    signature='ensure_dealer_correct()',
    definition='''
    RETURNS TRIGGER AS $ensure_dealer$
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
    '''
)

ensure_dealer_trigger = PGTrigger(
    schema="public",
    signature = "ensure_dealer_trigger",
    definition="""
        AFTER INSERT ON public.session_tables DEFERRABLE INITIALLY DEFERRED
        FOR EACH ROW EXECUTE FUNCTION ensure_dealer_correct();
    """,
    on_entity='public.session_tables',
    is_constraint=True
)

# == Update cards on bid ==

update_card_bid = PGFunction(
    schema='public',
    signature='update_card_bid()',
    definition='''
    RETURNS TRIGGER AS $update_card_bid$
    DECLARE
        card_balance integer;
    BEGIN
        IF (TG_OP = 'INSERT') THEN
            SELECT balance FROM card INTO card_balance;
            IF (NEW.bid_amount > card_balance) THEN
                RAISE EXCEPTION 'Cannot bet more money than the card has';
            END IF;
            IF (NEW.money_gain = 0) THEN
                UPDATE card SET balance = balance - NEW.bid_amount WHERE card_ID = NEW.card_ID;
            ELSE
                UPDATE card SET balance = balance + NEW.money_gain WHERE card_ID = NEW.card_ID;
            END IF;
        END IF;
    END;
    $update_card_bid$ LANGUAGE plpgsql
    '''
)

ensure_dealer_trigger = PGTrigger(
    schema="public",
    signature = "update_card_bid_trigger",
    definition="""
        BEFORE INSERT ON public.card_bid_within_session
        FOR EACH ROW EXECUTE FUNCTION update_card_bid();
    """,
    on_entity='public.card_bid_within_session',
)
