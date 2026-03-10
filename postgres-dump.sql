--
-- PostgreSQL database cluster dump
--

\restrict ewNf08EnxwtoqEkauavq8ck7OpplzXZTdS2CX7hO4FtFH7qhLgkP4aPgRu6Nzdx

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Drop databases (except postgres and template1)
--





--
-- Drop roles
--

DROP ROLE bartenders;
DROP ROLE bid_terminal;
DROP ROLE card_dispenser;
DROP ROLE card_reader;
DROP ROLE dealers;
DROP ROLE order_terminal;
DROP ROLE players;
DROP ROLE postgres;
DROP ROLE security;
DROP ROLE staff;


--
-- Roles
--

CREATE ROLE bartenders;
ALTER ROLE bartenders WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:P53qFGS8A17dzbdN8opQAQ==$DBsipVRbkq3Q7KuGitDPzjz4N0KPgNDYHsDcOcIwQqo=:AGZYaN9UNr7+oD1SdThT3APXQarQiuDMFa8GC4HGmvc=';
CREATE ROLE bid_terminal;
ALTER ROLE bid_terminal WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB NOLOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:FKbB7pHS+PrnCduvRaB5Xg==$TWHvKY/ylHQOPJaN3iJ0WbQfHeKvSuLj/r4DgC/X4VY=:l7Qhr8Fy3+a3m2cB7BwohRIIOi55odOGx7jytNiBNpo=';
CREATE ROLE card_dispenser;
ALTER ROLE card_dispenser WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB NOLOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:P7Tc4Yal//Fdsk+NEj5T0A==$4UiB5g0P2fy9dnH57B8xOEA+8w2t1nsTVj4q8zac93Y=:68sqRVbsNT72OmeagxBj56SzlLfhDqU0w+Sr3guuM0s=';
CREATE ROLE card_reader;
ALTER ROLE card_reader WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB NOLOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:ass3yNVRLxvzYtL8uqnGpw==$izOn8wzYCwaN3zRiWsjgW3sU/WXSgXjyMIXY3yMQM/Y=:+kyg1DluSQxurwut+Lk+ePkaEtCWjodXPVk/KqH/tAQ=';
CREATE ROLE dealers;
ALTER ROLE dealers WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:9do8JW0NEnjxotcKkCldrw==$VfHoSW9G4WjbSSxKaYeOJYSEzf4EoDM8hHTAArTo99I=:Xco5+m81+rFcyO5MULj8ilnsxrUFuuIGjccUFt6dA7Q=';
CREATE ROLE order_terminal;
ALTER ROLE order_terminal WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB NOLOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:vl/ES6nkHnQhkqFvCRbFvA==$TAbeJtln+zpP0BP94+XA0mKoDvWQSpxz/ZwujmmfpC8=:wKeISjFWhE9RrpER1QcAiRaeiL6HxQok6yRN2CMe4XE=';
CREATE ROLE players;
ALTER ROLE players WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:cKccyNZsQrMBnUqVGhPfhg==$cDaAQbDZM792nLfZ7845eCm1Dp1G6PavkCk5zVp/Zz8=:5PPwTfy1Rq0S4zjb6OvG+aPihaBJIdgd1RCtAbH512A=';
CREATE ROLE postgres;
ALTER ROLE postgres WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:DApCLCCQURby9KfQ/rEezw==$yg7XeRF2wL22XI7CI/I4mMl5XxDh1ufHdHyeUBDgx1U=:wA8NDq+ZvV2/+mQAQuiKiz69P+OWY3idJCDuilxrDgM=';
CREATE ROLE security;
ALTER ROLE security WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:y6k6Qvpav94YKZccoInflA==$kqhdc8gzfSsSL4WX1tLOsv+reVgAfohjRxK+HvD7gyc=:bM+3KrmEDLRlRozGLlbZDgiBYVO8eOY6X9C0aPuWAeQ=';
CREATE ROLE staff;
ALTER ROLE staff WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:D8cJ+JIipSW+9NpfQWOa6A==$I5SEzRtElvhoAHCSww9682E8bdIAgGYvsqklsflqVLI=:v/E6pAOSTrNtbh5t1dT65P9s9J2tf9TBQytmy8P+/B0=';

--
-- User Configurations
--


--
-- Role memberships
--

GRANT staff TO bartenders WITH INHERIT TRUE GRANTED BY postgres;
GRANT staff TO dealers WITH INHERIT TRUE GRANTED BY postgres;
GRANT staff TO security WITH INHERIT TRUE GRANTED BY postgres;






\unrestrict ewNf08EnxwtoqEkauavq8ck7OpplzXZTdS2CX7hO4FtFH7qhLgkP4aPgRu6Nzdx

--
-- Databases
--

--
-- Database "template1" dump
--

--
-- PostgreSQL database dump
--

\restrict GNb2GbixW5fia2BxU8CVC00dmbjI6m4YfgaSSmCRDsD12lu5TiggRewQOe5YXZy

-- Dumped from database version 16.10 (Debian 16.10-1.pgdg13+1)
-- Dumped by pg_dump version 16.13 (Ubuntu 16.13-0ubuntu0.24.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

UPDATE pg_catalog.pg_database SET datistemplate = false WHERE datname = 'template1';
DROP DATABASE template1;
--
-- Name: template1; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE template1 WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE template1 OWNER TO postgres;

\unrestrict GNb2GbixW5fia2BxU8CVC00dmbjI6m4YfgaSSmCRDsD12lu5TiggRewQOe5YXZy
\connect template1
\restrict GNb2GbixW5fia2BxU8CVC00dmbjI6m4YfgaSSmCRDsD12lu5TiggRewQOe5YXZy

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: DATABASE template1; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE template1 IS 'default template for new databases';


--
-- Name: template1; Type: DATABASE PROPERTIES; Schema: -; Owner: postgres
--

ALTER DATABASE template1 IS_TEMPLATE = true;


\unrestrict GNb2GbixW5fia2BxU8CVC00dmbjI6m4YfgaSSmCRDsD12lu5TiggRewQOe5YXZy
\connect template1
\restrict GNb2GbixW5fia2BxU8CVC00dmbjI6m4YfgaSSmCRDsD12lu5TiggRewQOe5YXZy

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: DATABASE template1; Type: ACL; Schema: -; Owner: postgres
--

REVOKE CONNECT,TEMPORARY ON DATABASE template1 FROM PUBLIC;
GRANT CONNECT ON DATABASE template1 TO PUBLIC;


--
-- PostgreSQL database dump complete
--

\unrestrict GNb2GbixW5fia2BxU8CVC00dmbjI6m4YfgaSSmCRDsD12lu5TiggRewQOe5YXZy

--
-- Database "postgres" dump
--

--
-- PostgreSQL database dump
--

\restrict aPYw1hXd5O4ye2suk5NJh1boJzUcuBW75nL5QaZNO3MJWIbLof1wghZ3zr48cHd

-- Dumped from database version 16.10 (Debian 16.10-1.pgdg13+1)
-- Dumped by pg_dump version 16.13 (Ubuntu 16.13-0ubuntu0.24.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE postgres;
--
-- Name: postgres; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE postgres OWNER TO postgres;

\unrestrict aPYw1hXd5O4ye2suk5NJh1boJzUcuBW75nL5QaZNO3MJWIbLof1wghZ3zr48cHd
\connect postgres
\restrict aPYw1hXd5O4ye2suk5NJh1boJzUcuBW75nL5QaZNO3MJWIbLof1wghZ3zr48cHd

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: DATABASE postgres; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- Name: ensure_dealer_correct(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.ensure_dealer_correct() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    DECLARE
        table_type_id integer;
        should_be_supervised boolean;
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
    $$;


ALTER FUNCTION public.ensure_dealer_correct() OWNER TO postgres;

--
-- Name: update_card_bid(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_card_bid() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    DECLARE
        card_balance integer;
    BEGIN
        IF (TG_OP = 'INSERT') THEN
            SELECT balance FROM card INTO card_balance WHERE card_id = NEW.card_id;
            IF (NEW.bid_amount > card_balance) THEN
                RAISE EXCEPTION 'Cannot bet more money than the card has';
            END IF;
            UPDATE card SET balance = balance - NEW.bid_amount + NEW.money_gain WHERE card_id = NEW.card_id;
        END IF;
        RETURN NULL;
    END;
    $$;


ALTER FUNCTION public.update_card_bid() OWNER TO postgres;

--
-- Name: update_card_order(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_card_order() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
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
    $$;


ALTER FUNCTION public.update_card_order() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: alembic_version; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.alembic_version (
    version_num character varying(32) NOT NULL
);


ALTER TABLE public.alembic_version OWNER TO postgres;

--
-- Name: bar_supplies; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bar_supplies (
    quantity integer NOT NULL,
    drink_id integer NOT NULL
);


ALTER TABLE public.bar_supplies OWNER TO postgres;

--
-- Name: bartenders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bartenders (
    staff_id integer NOT NULL,
    performance_rating integer,
    CONSTRAINT bartenders_performance_rating_check CHECK (((performance_rating >= 0) AND (performance_rating <= 5)))
);


ALTER TABLE public.bartenders OWNER TO postgres;

--
-- Name: card; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.card (
    card_id integer NOT NULL,
    balance integer NOT NULL
);


ALTER TABLE public.card OWNER TO postgres;

--
-- Name: card_bid_within_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.card_bid_within_session (
    bid_id integer NOT NULL,
    session_id integer NOT NULL,
    card_id integer NOT NULL,
    bid_amount integer NOT NULL,
    money_gain integer NOT NULL
);


ALTER TABLE public.card_bid_within_session OWNER TO postgres;

--
-- Name: card_bid_within_session_bid_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.card_bid_within_session_bid_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.card_bid_within_session_bid_id_seq OWNER TO postgres;

--
-- Name: card_bid_within_session_bid_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.card_bid_within_session_bid_id_seq OWNED BY public.card_bid_within_session.bid_id;


--
-- Name: card_card_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.card_card_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.card_card_id_seq OWNER TO postgres;

--
-- Name: card_card_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.card_card_id_seq OWNED BY public.card.card_id;


--
-- Name: cards_to_clients_dispenser; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cards_to_clients_dispenser (
    dispenser_id integer NOT NULL,
    user_id integer NOT NULL,
    card_id integer NOT NULL,
    entry_time timestamp without time zone NOT NULL,
    abandon_time timestamp without time zone NOT NULL
);


ALTER TABLE public.cards_to_clients_dispenser OWNER TO postgres;

--
-- Name: cards_to_clients_dispenser_dispenser_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cards_to_clients_dispenser_dispenser_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cards_to_clients_dispenser_dispenser_id_seq OWNER TO postgres;

--
-- Name: cards_to_clients_dispenser_dispenser_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cards_to_clients_dispenser_dispenser_id_seq OWNED BY public.cards_to_clients_dispenser.dispenser_id;


--
-- Name: clients; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.clients (
    user_id integer NOT NULL,
    name character varying(20) NOT NULL,
    surname character varying(20) NOT NULL,
    deposit integer NOT NULL,
    address character varying(20) NOT NULL,
    credit integer,
    notes character varying(20),
    age integer NOT NULL
);


ALTER TABLE public.clients OWNER TO postgres;

--
-- Name: clients_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.clients_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.clients_user_id_seq OWNER TO postgres;

--
-- Name: clients_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.clients_user_id_seq OWNED BY public.clients.user_id;


--
-- Name: dealers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dealers (
    staff_id integer NOT NULL,
    qualification character varying(20)
);


ALTER TABLE public.dealers OWNER TO postgres;

--
-- Name: drinks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.drinks (
    drink_id integer NOT NULL,
    name character varying(20) NOT NULL,
    price integer NOT NULL,
    volume integer NOT NULL,
    category character varying(20)
);


ALTER TABLE public.drinks OWNER TO postgres;

--
-- Name: drinks_drink_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.drinks_drink_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.drinks_drink_id_seq OWNER TO postgres;

--
-- Name: drinks_drink_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.drinks_drink_id_seq OWNED BY public.drinks.drink_id;


--
-- Name: game_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.game_types (
    type_id integer NOT NULL,
    game_type character varying(20) NOT NULL,
    is_supervised boolean NOT NULL
);


ALTER TABLE public.game_types OWNER TO postgres;

--
-- Name: game_types_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.game_types_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.game_types_type_id_seq OWNER TO postgres;

--
-- Name: game_types_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.game_types_type_id_seq OWNED BY public.game_types.type_id;


--
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders (
    order_id integer NOT NULL,
    total integer NOT NULL,
    order_time timestamp without time zone NOT NULL,
    staff_id integer NOT NULL
);


ALTER TABLE public.orders OWNER TO postgres;

--
-- Name: orders_order_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.orders_order_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.orders_order_id_seq OWNER TO postgres;

--
-- Name: orders_order_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.orders_order_id_seq OWNED BY public.orders.order_id;


--
-- Name: security; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.security (
    staff_id integer NOT NULL,
    zone integer
);


ALTER TABLE public.security OWNER TO postgres;

--
-- Name: session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.session (
    session_id integer NOT NULL,
    start_time timestamp without time zone NOT NULL,
    end_time timestamp without time zone NOT NULL
);


ALTER TABLE public.session OWNER TO postgres;

--
-- Name: session_session_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.session_session_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.session_session_id_seq OWNER TO postgres;

--
-- Name: session_session_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.session_session_id_seq OWNED BY public.session.session_id;


--
-- Name: session_tables; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.session_tables (
    session_to_table_id integer NOT NULL,
    session_id integer NOT NULL,
    table_id integer NOT NULL,
    staff_id integer
);


ALTER TABLE public.session_tables OWNER TO postgres;

--
-- Name: session_tables_session_to_table_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.session_tables_session_to_table_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.session_tables_session_to_table_id_seq OWNER TO postgres;

--
-- Name: session_tables_session_to_table_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.session_tables_session_to_table_id_seq OWNED BY public.session_tables.session_to_table_id;


--
-- Name: split_order_by_card; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.split_order_by_card (
    split_order_id integer NOT NULL,
    card_id integer NOT NULL,
    order_id integer NOT NULL,
    drink_id integer NOT NULL,
    quantity integer NOT NULL,
    CONSTRAINT split_order_by_card_quantity_check CHECK ((quantity >= 1))
);


ALTER TABLE public.split_order_by_card OWNER TO postgres;

--
-- Name: split_order_by_card_split_order_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.split_order_by_card_split_order_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.split_order_by_card_split_order_id_seq OWNER TO postgres;

--
-- Name: split_order_by_card_split_order_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.split_order_by_card_split_order_id_seq OWNED BY public.split_order_by_card.split_order_id;


--
-- Name: staff; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.staff (
    staff_id integer NOT NULL,
    name character varying(20) NOT NULL,
    surname character varying(20) NOT NULL,
    address character varying(20) NOT NULL,
    age integer NOT NULL
);


ALTER TABLE public.staff OWNER TO postgres;

--
-- Name: staff_staff_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.staff_staff_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.staff_staff_id_seq OWNER TO postgres;

--
-- Name: staff_staff_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.staff_staff_id_seq OWNED BY public.staff.staff_id;


--
-- Name: tables; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tables (
    table_id integer NOT NULL,
    type_id integer NOT NULL,
    balance integer NOT NULL,
    opening_time timestamp without time zone NOT NULL,
    closing_time timestamp without time zone NOT NULL
);


ALTER TABLE public.tables OWNER TO postgres;

--
-- Name: tables_table_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tables_table_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tables_table_id_seq OWNER TO postgres;

--
-- Name: tables_table_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tables_table_id_seq OWNED BY public.tables.table_id;


--
-- Name: card card_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.card ALTER COLUMN card_id SET DEFAULT nextval('public.card_card_id_seq'::regclass);


--
-- Name: card_bid_within_session bid_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.card_bid_within_session ALTER COLUMN bid_id SET DEFAULT nextval('public.card_bid_within_session_bid_id_seq'::regclass);


--
-- Name: cards_to_clients_dispenser dispenser_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cards_to_clients_dispenser ALTER COLUMN dispenser_id SET DEFAULT nextval('public.cards_to_clients_dispenser_dispenser_id_seq'::regclass);


--
-- Name: clients user_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clients ALTER COLUMN user_id SET DEFAULT nextval('public.clients_user_id_seq'::regclass);


--
-- Name: drinks drink_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.drinks ALTER COLUMN drink_id SET DEFAULT nextval('public.drinks_drink_id_seq'::regclass);


--
-- Name: game_types type_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game_types ALTER COLUMN type_id SET DEFAULT nextval('public.game_types_type_id_seq'::regclass);


--
-- Name: orders order_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders ALTER COLUMN order_id SET DEFAULT nextval('public.orders_order_id_seq'::regclass);


--
-- Name: session session_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.session ALTER COLUMN session_id SET DEFAULT nextval('public.session_session_id_seq'::regclass);


--
-- Name: session_tables session_to_table_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.session_tables ALTER COLUMN session_to_table_id SET DEFAULT nextval('public.session_tables_session_to_table_id_seq'::regclass);


--
-- Name: split_order_by_card split_order_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.split_order_by_card ALTER COLUMN split_order_id SET DEFAULT nextval('public.split_order_by_card_split_order_id_seq'::regclass);


--
-- Name: staff staff_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.staff ALTER COLUMN staff_id SET DEFAULT nextval('public.staff_staff_id_seq'::regclass);


--
-- Name: tables table_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tables ALTER COLUMN table_id SET DEFAULT nextval('public.tables_table_id_seq'::regclass);


--
-- Data for Name: alembic_version; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.alembic_version (version_num) FROM stdin;
4d8457546134
\.


--
-- Data for Name: bar_supplies; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.bar_supplies (quantity, drink_id) FROM stdin;
\.


--
-- Data for Name: bartenders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.bartenders (staff_id, performance_rating) FROM stdin;
\.


--
-- Data for Name: card; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.card (card_id, balance) FROM stdin;
\.


--
-- Data for Name: card_bid_within_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.card_bid_within_session (bid_id, session_id, card_id, bid_amount, money_gain) FROM stdin;
\.


--
-- Data for Name: cards_to_clients_dispenser; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cards_to_clients_dispenser (dispenser_id, user_id, card_id, entry_time, abandon_time) FROM stdin;
\.


--
-- Data for Name: clients; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.clients (user_id, name, surname, deposit, address, credit, notes, age) FROM stdin;
1	kira	yoshikage	777	morioh	\N	\N	33
2	yagami	light	444	tokyo	\N	\N	19
3	dexter	morgan	333	miami	\N	\N	35
\.


--
-- Data for Name: dealers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dealers (staff_id, qualification) FROM stdin;
\.


--
-- Data for Name: drinks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.drinks (drink_id, name, price, volume, category) FROM stdin;
\.


--
-- Data for Name: game_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.game_types (type_id, game_type, is_supervised) FROM stdin;
1	poker	t
2	roulette	t
3	automaton	f
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orders (order_id, total, order_time, staff_id) FROM stdin;
\.


--
-- Data for Name: security; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.security (staff_id, zone) FROM stdin;
\.


--
-- Data for Name: session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.session (session_id, start_time, end_time) FROM stdin;
\.


--
-- Data for Name: session_tables; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.session_tables (session_to_table_id, session_id, table_id, staff_id) FROM stdin;
\.


--
-- Data for Name: split_order_by_card; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.split_order_by_card (split_order_id, card_id, order_id, drink_id, quantity) FROM stdin;
\.


--
-- Data for Name: staff; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.staff (staff_id, name, surname, address, age) FROM stdin;
1	lol	kek	cheburek	69
\.


--
-- Data for Name: tables; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tables (table_id, type_id, balance, opening_time, closing_time) FROM stdin;
\.


--
-- Name: card_bid_within_session_bid_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.card_bid_within_session_bid_id_seq', 1, false);


--
-- Name: card_card_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.card_card_id_seq', 1, false);


--
-- Name: cards_to_clients_dispenser_dispenser_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cards_to_clients_dispenser_dispenser_id_seq', 1, false);


--
-- Name: clients_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.clients_user_id_seq', 3, true);


--
-- Name: drinks_drink_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.drinks_drink_id_seq', 1, false);


--
-- Name: game_types_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.game_types_type_id_seq', 3, true);


--
-- Name: orders_order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.orders_order_id_seq', 1, false);


--
-- Name: session_session_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.session_session_id_seq', 1, false);


--
-- Name: session_tables_session_to_table_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.session_tables_session_to_table_id_seq', 1, false);


--
-- Name: split_order_by_card_split_order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.split_order_by_card_split_order_id_seq', 1, false);


--
-- Name: staff_staff_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.staff_staff_id_seq', 1, true);


--
-- Name: tables_table_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tables_table_id_seq', 1, false);


--
-- Name: alembic_version alembic_version_pkc; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alembic_version
    ADD CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num);


--
-- Name: bar_supplies bar_supplies_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bar_supplies
    ADD CONSTRAINT bar_supplies_pkey PRIMARY KEY (drink_id);


--
-- Name: bartenders bartenders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bartenders
    ADD CONSTRAINT bartenders_pkey PRIMARY KEY (staff_id);


--
-- Name: card_bid_within_session card_bid_within_session_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.card_bid_within_session
    ADD CONSTRAINT card_bid_within_session_pkey PRIMARY KEY (bid_id);


--
-- Name: card card_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.card
    ADD CONSTRAINT card_pkey PRIMARY KEY (card_id);


--
-- Name: cards_to_clients_dispenser cards_to_clients_dispenser_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cards_to_clients_dispenser
    ADD CONSTRAINT cards_to_clients_dispenser_pkey PRIMARY KEY (dispenser_id);


--
-- Name: clients clients_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clients
    ADD CONSTRAINT clients_pkey PRIMARY KEY (user_id);


--
-- Name: dealers dealers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dealers
    ADD CONSTRAINT dealers_pkey PRIMARY KEY (staff_id);


--
-- Name: drinks drinks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.drinks
    ADD CONSTRAINT drinks_pkey PRIMARY KEY (drink_id);


--
-- Name: game_types game_types_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game_types
    ADD CONSTRAINT game_types_pkey PRIMARY KEY (type_id);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (order_id);


--
-- Name: security security_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.security
    ADD CONSTRAINT security_pkey PRIMARY KEY (staff_id);


--
-- Name: session session_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.session
    ADD CONSTRAINT session_pkey PRIMARY KEY (session_id);


--
-- Name: session_tables session_tables_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.session_tables
    ADD CONSTRAINT session_tables_pkey PRIMARY KEY (session_to_table_id);


--
-- Name: split_order_by_card split_order_by_card_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.split_order_by_card
    ADD CONSTRAINT split_order_by_card_pkey PRIMARY KEY (split_order_id);


--
-- Name: staff staff_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.staff
    ADD CONSTRAINT staff_pkey PRIMARY KEY (staff_id);


--
-- Name: tables tables_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tables
    ADD CONSTRAINT tables_pkey PRIMARY KEY (table_id);


--
-- Name: session_tables ensure_dealer_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE CONSTRAINT TRIGGER ensure_dealer_trigger AFTER INSERT ON public.session_tables NOT DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE FUNCTION public.ensure_dealer_correct();


--
-- Name: card_bid_within_session update_card_bid_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_card_bid_trigger AFTER INSERT ON public.card_bid_within_session FOR EACH ROW EXECUTE FUNCTION public.update_card_bid();


--
-- Name: split_order_by_card update_card_order_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_card_order_trigger AFTER INSERT ON public.split_order_by_card FOR EACH ROW EXECUTE FUNCTION public.update_card_order();


--
-- Name: bar_supplies bar_supplies_drink_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bar_supplies
    ADD CONSTRAINT bar_supplies_drink_id_fkey FOREIGN KEY (drink_id) REFERENCES public.drinks(drink_id);


--
-- Name: bartenders bartenders_staff_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bartenders
    ADD CONSTRAINT bartenders_staff_id_fkey FOREIGN KEY (staff_id) REFERENCES public.staff(staff_id);


--
-- Name: card_bid_within_session card_bid_within_session_card_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.card_bid_within_session
    ADD CONSTRAINT card_bid_within_session_card_id_fkey FOREIGN KEY (card_id) REFERENCES public.card(card_id);


--
-- Name: card_bid_within_session card_bid_within_session_session_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.card_bid_within_session
    ADD CONSTRAINT card_bid_within_session_session_id_fkey FOREIGN KEY (session_id) REFERENCES public.session(session_id);


--
-- Name: cards_to_clients_dispenser cards_to_clients_dispenser_card_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cards_to_clients_dispenser
    ADD CONSTRAINT cards_to_clients_dispenser_card_id_fkey FOREIGN KEY (card_id) REFERENCES public.card(card_id);


--
-- Name: cards_to_clients_dispenser cards_to_clients_dispenser_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cards_to_clients_dispenser
    ADD CONSTRAINT cards_to_clients_dispenser_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.clients(user_id);


--
-- Name: dealers dealers_staff_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dealers
    ADD CONSTRAINT dealers_staff_id_fkey FOREIGN KEY (staff_id) REFERENCES public.staff(staff_id);


--
-- Name: orders orders_staff_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_staff_id_fkey FOREIGN KEY (staff_id) REFERENCES public.bartenders(staff_id);


--
-- Name: security security_staff_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.security
    ADD CONSTRAINT security_staff_id_fkey FOREIGN KEY (staff_id) REFERENCES public.staff(staff_id);


--
-- Name: session_tables session_tables_session_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.session_tables
    ADD CONSTRAINT session_tables_session_id_fkey FOREIGN KEY (session_id) REFERENCES public.session(session_id);


--
-- Name: session_tables session_tables_staff_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.session_tables
    ADD CONSTRAINT session_tables_staff_id_fkey FOREIGN KEY (staff_id) REFERENCES public.dealers(staff_id);


--
-- Name: session_tables session_tables_table_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.session_tables
    ADD CONSTRAINT session_tables_table_id_fkey FOREIGN KEY (table_id) REFERENCES public.tables(table_id);


--
-- Name: split_order_by_card split_order_by_card_card_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.split_order_by_card
    ADD CONSTRAINT split_order_by_card_card_id_fkey FOREIGN KEY (card_id) REFERENCES public.card(card_id);


--
-- Name: split_order_by_card split_order_by_card_drink_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.split_order_by_card
    ADD CONSTRAINT split_order_by_card_drink_id_fkey FOREIGN KEY (drink_id) REFERENCES public.drinks(drink_id);


--
-- Name: split_order_by_card split_order_by_card_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.split_order_by_card
    ADD CONSTRAINT split_order_by_card_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(order_id);


--
-- Name: tables tables_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tables
    ADD CONSTRAINT tables_type_id_fkey FOREIGN KEY (type_id) REFERENCES public.game_types(type_id);


--
-- Name: TABLE bar_supplies; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.bar_supplies TO bartenders;
GRANT SELECT,UPDATE ON TABLE public.bar_supplies TO order_terminal;


--
-- Name: TABLE bartenders; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.bartenders TO bartenders;
GRANT SELECT ON TABLE public.bartenders TO order_terminal;


--
-- Name: TABLE card; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,UPDATE ON TABLE public.card TO bid_terminal;
GRANT SELECT,INSERT ON TABLE public.card TO card_dispenser;
GRANT SELECT ON TABLE public.card TO card_reader;
GRANT SELECT,UPDATE ON TABLE public.card TO order_terminal;


--
-- Name: TABLE card_bid_within_session; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT ON TABLE public.card_bid_within_session TO bid_terminal;
GRANT SELECT ON TABLE public.card_bid_within_session TO dealers;
GRANT SELECT ON TABLE public.card_bid_within_session TO players;


--
-- Name: SEQUENCE card_bid_within_session_bid_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT USAGE ON SEQUENCE public.card_bid_within_session_bid_id_seq TO bid_terminal;


--
-- Name: SEQUENCE card_card_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT USAGE ON SEQUENCE public.card_card_id_seq TO card_dispenser;


--
-- Name: TABLE cards_to_clients_dispenser; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT ON TABLE public.cards_to_clients_dispenser TO card_dispenser;
GRANT SELECT ON TABLE public.cards_to_clients_dispenser TO security;


--
-- Name: SEQUENCE cards_to_clients_dispenser_dispenser_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT USAGE ON SEQUENCE public.cards_to_clients_dispenser_dispenser_id_seq TO card_dispenser;


--
-- Name: TABLE clients; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.clients TO security;


--
-- Name: TABLE dealers; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.dealers TO dealers;


--
-- Name: TABLE drinks; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.drinks TO bartenders;
GRANT SELECT ON TABLE public.drinks TO order_terminal;


--
-- Name: TABLE game_types; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.game_types TO dealers;
GRANT SELECT ON TABLE public.game_types TO players;


--
-- Name: TABLE orders; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.orders TO bartenders;
GRANT SELECT,INSERT,UPDATE ON TABLE public.orders TO order_terminal;


--
-- Name: SEQUENCE orders_order_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT USAGE ON SEQUENCE public.orders_order_id_seq TO order_terminal;


--
-- Name: TABLE security; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.security TO security;


--
-- Name: TABLE session; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.session TO bid_terminal;
GRANT SELECT ON TABLE public.session TO dealers;
GRANT SELECT ON TABLE public.session TO players;


--
-- Name: TABLE session_tables; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.session_tables TO dealers;
GRANT SELECT ON TABLE public.session_tables TO players;


--
-- Name: TABLE split_order_by_card; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.split_order_by_card TO bartenders;
GRANT SELECT,INSERT ON TABLE public.split_order_by_card TO order_terminal;


--
-- Name: SEQUENCE split_order_by_card_split_order_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT USAGE ON SEQUENCE public.split_order_by_card_split_order_id_seq TO order_terminal;


--
-- Name: TABLE staff; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.staff TO staff;


--
-- Name: TABLE tables; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.tables TO dealers;
GRANT SELECT ON TABLE public.tables TO players;


--
-- PostgreSQL database dump complete
--

\unrestrict aPYw1hXd5O4ye2suk5NJh1boJzUcuBW75nL5QaZNO3MJWIbLof1wghZ3zr48cHd

--
-- PostgreSQL database cluster dump complete
--

