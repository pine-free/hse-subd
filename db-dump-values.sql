--
-- PostgreSQL database dump
--

\restrict bZTkzQ49zbdqDvymLhsdXwW08MgJRzUcoQoHjKZcWMJFOazwrk7gWEyQgnA9wHb

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

--
-- Data for Name: alembic_version; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.alembic_version (version_num) FROM stdin;
4d8457546134
\.


--
-- Data for Name: drinks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.drinks (drink_id, name, price, volume, category) FROM stdin;
\.


--
-- Data for Name: bar_supplies; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.bar_supplies (quantity, drink_id) FROM stdin;
\.


--
-- Data for Name: staff; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.staff (staff_id, name, surname, address, age) FROM stdin;
1	lol	kek	cheburek	69
2	amy	dealertine	dealertown	33
3	amy	dealertine	dealerstown	33
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
1	777
2	444
3	333
\.


--
-- Data for Name: session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.session (session_id, start_time, end_time) FROM stdin;
1	2022-12-20 13:00:00	2022-12-20 14:00:00
2	2022-12-20 13:00:00	2022-12-20 14:00:00
\.


--
-- Data for Name: card_bid_within_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.card_bid_within_session (bid_id, session_id, card_id, bid_amount, money_gain) FROM stdin;
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
-- Data for Name: cards_to_clients_dispenser; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cards_to_clients_dispenser (dispenser_id, user_id, card_id, entry_time, abandon_time) FROM stdin;
1	1	1	2022-12-20 12:00:00	2022-12-20 14:00:00
2	2	2	2022-12-20 12:00:00	2022-12-20 14:00:00
3	3	3	2022-12-20 12:00:00	2022-12-20 14:00:00
\.


--
-- Data for Name: dealers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dealers (staff_id, qualification) FROM stdin;
2	\N
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
-- Data for Name: tables; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tables (table_id, type_id, balance, opening_time, closing_time) FROM stdin;
1	1	0	2022-12-20 10:00:00	2022-12-20 18:00:00
2	3	0	2022-12-20 10:00:00	2022-12-20 18:00:00
\.


--
-- Data for Name: session_tables; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.session_tables (session_to_table_id, session_id, table_id, staff_id) FROM stdin;
2	1	1	2
3	2	2	\N
\.


--
-- Data for Name: split_order_by_card; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.split_order_by_card (split_order_id, card_id, order_id, drink_id, quantity) FROM stdin;
\.


--
-- Name: card_bid_within_session_bid_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.card_bid_within_session_bid_id_seq', 1, true);


--
-- Name: card_card_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.card_card_id_seq', 3, true);


--
-- Name: cards_to_clients_dispenser_dispenser_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cards_to_clients_dispenser_dispenser_id_seq', 3, true);


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

SELECT pg_catalog.setval('public.session_session_id_seq', 2, true);


--
-- Name: session_tables_session_to_table_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.session_tables_session_to_table_id_seq', 3, true);


--
-- Name: split_order_by_card_split_order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.split_order_by_card_split_order_id_seq', 1, false);


--
-- Name: staff_staff_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.staff_staff_id_seq', 3, true);


--
-- Name: tables_table_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tables_table_id_seq', 2, true);


--
-- PostgreSQL database dump complete
--

\unrestrict bZTkzQ49zbdqDvymLhsdXwW08MgJRzUcoQoHjKZcWMJFOazwrk7gWEyQgnA9wHb

