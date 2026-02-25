--
-- PostgreSQL database dump
--

\restrict f217Xog0AAl2XMvIJqDFma3zi6iT3smF6t5lPNzhqiAgu3vhoX1tlxWZEu9jcjO

-- Dumped from database version 18.1
-- Dumped by pg_dump version 18.1

-- Started on 2026-02-25 22:02:31

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 4 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: pg_database_owner
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO pg_database_owner;

--
-- TOC entry 5046 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 220 (class 1259 OID 24708)
-- Name: departments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.departments (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    floor integer NOT NULL
);


ALTER TABLE public.departments OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 24707)
-- Name: departments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.departments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.departments_id_seq OWNER TO postgres;

--
-- TOC entry 5047 (class 0 OID 0)
-- Dependencies: 219
-- Name: departments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.departments_id_seq OWNED BY public.departments.id;


--
-- TOC entry 222 (class 1259 OID 24718)
-- Name: employees; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.employees (
    id integer NOT NULL,
    fullname character varying(100) NOT NULL,
    departmentid integer,
    "position" character varying(50),
    hiredate date NOT NULL
);


ALTER TABLE public.employees OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 24717)
-- Name: employees_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.employees_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.employees_id_seq OWNER TO postgres;

--
-- TOC entry 5048 (class 0 OID 0)
-- Dependencies: 221
-- Name: employees_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.employees_id_seq OWNED BY public.employees.id;


--
-- TOC entry 226 (class 1259 OID 24744)
-- Name: illnessrecords; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.illnessrecords (
    id integer NOT NULL,
    employeeid integer,
    illnesstypeid integer,
    startdate date NOT NULL,
    enddate date NOT NULL,
    diagnosisnote text
);


ALTER TABLE public.illnessrecords OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 24743)
-- Name: illnessrecords_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.illnessrecords_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.illnessrecords_id_seq OWNER TO postgres;

--
-- TOC entry 5049 (class 0 OID 0)
-- Dependencies: 225
-- Name: illnessrecords_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.illnessrecords_id_seq OWNED BY public.illnessrecords.id;


--
-- TOC entry 224 (class 1259 OID 24733)
-- Name: illnesstypes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.illnesstypes (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    isinfectious boolean NOT NULL,
    quarantinedays integer NOT NULL
);


ALTER TABLE public.illnesstypes OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 24732)
-- Name: illnesstypes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.illnesstypes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.illnesstypes_id_seq OWNER TO postgres;

--
-- TOC entry 5050 (class 0 OID 0)
-- Dependencies: 223
-- Name: illnesstypes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.illnesstypes_id_seq OWNED BY public.illnesstypes.id;


--
-- TOC entry 4871 (class 2604 OID 24711)
-- Name: departments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.departments ALTER COLUMN id SET DEFAULT nextval('public.departments_id_seq'::regclass);


--
-- TOC entry 4872 (class 2604 OID 24721)
-- Name: employees id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employees ALTER COLUMN id SET DEFAULT nextval('public.employees_id_seq'::regclass);


--
-- TOC entry 4874 (class 2604 OID 24747)
-- Name: illnessrecords id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.illnessrecords ALTER COLUMN id SET DEFAULT nextval('public.illnessrecords_id_seq'::regclass);


--
-- TOC entry 4873 (class 2604 OID 24736)
-- Name: illnesstypes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.illnesstypes ALTER COLUMN id SET DEFAULT nextval('public.illnesstypes_id_seq'::regclass);


--
-- TOC entry 5034 (class 0 OID 24708)
-- Dependencies: 220
-- Data for Name: departments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.departments (id, name, floor) FROM stdin;
1	Бухгалтерия	2
2	IT-отдел	3
3	Отдел кадров	1
\.


--
-- TOC entry 5036 (class 0 OID 24718)
-- Dependencies: 222
-- Data for Name: employees; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.employees (id, fullname, departmentid, "position", hiredate) FROM stdin;
1	Иванов Иван Иванович	1	Главбух	2020-01-15
2	Петров Петр Петрович	2	Программист	2021-03-10
3	Сидорова Анна	3	HR	2022-05-20
\.


--
-- TOC entry 5040 (class 0 OID 24744)
-- Dependencies: 226
-- Data for Name: illnessrecords; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.illnessrecords (id, employeeid, illnesstypeid, startdate, enddate, diagnosisnote) FROM stdin;
3	3	3	2023-12-01	2023-12-15	Обострение
\.


--
-- TOC entry 5038 (class 0 OID 24733)
-- Dependencies: 224
-- Data for Name: illnesstypes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.illnesstypes (id, name, isinfectious, quarantinedays) FROM stdin;
1	Грипп	t	7
2	ОРВИ	t	5
3	Остеохондроз	f	0
\.


--
-- TOC entry 5051 (class 0 OID 0)
-- Dependencies: 219
-- Name: departments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.departments_id_seq', 3, true);


--
-- TOC entry 5052 (class 0 OID 0)
-- Dependencies: 221
-- Name: employees_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.employees_id_seq', 3, true);


--
-- TOC entry 5053 (class 0 OID 0)
-- Dependencies: 225
-- Name: illnessrecords_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.illnessrecords_id_seq', 3, true);


--
-- TOC entry 5054 (class 0 OID 0)
-- Dependencies: 223
-- Name: illnesstypes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.illnesstypes_id_seq', 3, true);


--
-- TOC entry 4876 (class 2606 OID 24716)
-- Name: departments departments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.departments
    ADD CONSTRAINT departments_pkey PRIMARY KEY (id);


--
-- TOC entry 4878 (class 2606 OID 24726)
-- Name: employees employees_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_pkey PRIMARY KEY (id);


--
-- TOC entry 4882 (class 2606 OID 24754)
-- Name: illnessrecords illnessrecords_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.illnessrecords
    ADD CONSTRAINT illnessrecords_pkey PRIMARY KEY (id);


--
-- TOC entry 4880 (class 2606 OID 24742)
-- Name: illnesstypes illnesstypes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.illnesstypes
    ADD CONSTRAINT illnesstypes_pkey PRIMARY KEY (id);


--
-- TOC entry 4883 (class 2606 OID 24727)
-- Name: employees employees_departmentid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_departmentid_fkey FOREIGN KEY (departmentid) REFERENCES public.departments(id) ON DELETE SET NULL;


--
-- TOC entry 4884 (class 2606 OID 24755)
-- Name: illnessrecords illnessrecords_employeeid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.illnessrecords
    ADD CONSTRAINT illnessrecords_employeeid_fkey FOREIGN KEY (employeeid) REFERENCES public.employees(id) ON DELETE CASCADE;


--
-- TOC entry 4885 (class 2606 OID 24760)
-- Name: illnessrecords illnessrecords_illnesstypeid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.illnessrecords
    ADD CONSTRAINT illnessrecords_illnesstypeid_fkey FOREIGN KEY (illnesstypeid) REFERENCES public.illnesstypes(id) ON DELETE RESTRICT;


-- Completed on 2026-02-25 22:02:31

--
-- PostgreSQL database dump complete
--

\unrestrict f217Xog0AAl2XMvIJqDFma3zi6iT3smF6t5lPNzhqiAgu3vhoX1tlxWZEu9jcjO

