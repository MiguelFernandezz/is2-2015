--
-- PostgreSQL database dump
--

-- Dumped from database version 9.3.6
-- Dumped by pg_dump version 9.3.6
-- Started on 2015-05-01 18:03:11 PYT

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

DROP DATABASE "taguatoBD_produccion";
--
-- TOC entry 2272 (class 1262 OID 45168)
-- Name: taguatoBD; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE "taguatoBD_produccion" WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'es_PY.UTF-8' LC_CTYPE = 'es_PY.UTF-8';


ALTER DATABASE "taguatoBD_produccion" OWNER TO postgres;

\connect "taguatoBD_produccion"

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 5 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO postgres;

--
-- TOC entry 2273 (class 0 OID 0)
-- Dependencies: 5
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- TOC entry 204 (class 3079 OID 11829)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2275 (class 0 OID 0)
-- Dependencies: 204
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 194 (class 1259 OID 45357)
-- Name: Proyectos_actividad; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "Proyectos_actividad" (
    id integer NOT NULL,
    nombre character varying(20) NOT NULL,
    descripcion character varying(200) NOT NULL,
    flujo_id integer NOT NULL,
    orden integer NOT NULL
);


ALTER TABLE public."Proyectos_actividad" OWNER TO postgres;

--
-- TOC entry 193 (class 1259 OID 45355)
-- Name: Proyectos_actividad_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "Proyectos_actividad_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Proyectos_actividad_id_seq" OWNER TO postgres;

--
-- TOC entry 2276 (class 0 OID 0)
-- Dependencies: 193
-- Name: Proyectos_actividad_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "Proyectos_actividad_id_seq" OWNED BY "Proyectos_actividad".id;


--
-- TOC entry 198 (class 1259 OID 45406)
-- Name: Proyectos_comentario; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "Proyectos_comentario" (
    id integer NOT NULL,
    texto text NOT NULL,
    fecha timestamp with time zone NOT NULL,
    userstory_id integer NOT NULL,
    username character varying(50)
);


ALTER TABLE public."Proyectos_comentario" OWNER TO postgres;

--
-- TOC entry 197 (class 1259 OID 45404)
-- Name: Proyectos_comentario_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "Proyectos_comentario_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Proyectos_comentario_id_seq" OWNER TO postgres;

--
-- TOC entry 2277 (class 0 OID 0)
-- Dependencies: 197
-- Name: Proyectos_comentario_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "Proyectos_comentario_id_seq" OWNED BY "Proyectos_comentario".id;


--
-- TOC entry 192 (class 1259 OID 45336)
-- Name: Proyectos_flujo; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "Proyectos_flujo" (
    id integer NOT NULL,
    proyecto_id integer NOT NULL,
    sprint_id integer,
    nombre character varying(50) NOT NULL,
    descripcion text NOT NULL
);


ALTER TABLE public."Proyectos_flujo" OWNER TO postgres;

--
-- TOC entry 191 (class 1259 OID 45334)
-- Name: Proyectos_flujo_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "Proyectos_flujo_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Proyectos_flujo_id_seq" OWNER TO postgres;

--
-- TOC entry 2278 (class 0 OID 0)
-- Dependencies: 191
-- Name: Proyectos_flujo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "Proyectos_flujo_id_seq" OWNED BY "Proyectos_flujo".id;


--
-- TOC entry 188 (class 1259 OID 45297)
-- Name: Proyectos_proyecto; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "Proyectos_proyecto" (
    id integer NOT NULL,
    nombre character varying(50) NOT NULL,
    descripcion text NOT NULL,
    estado character varying(3) NOT NULL,
    fecha_creacion date,
    fecha_finalizacion date
);


ALTER TABLE public."Proyectos_proyecto" OWNER TO postgres;

--
-- TOC entry 186 (class 1259 OID 45282)
-- Name: Proyectos_proyecto_equipo; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "Proyectos_proyecto_equipo" (
    id integer NOT NULL,
    proyecto_id integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public."Proyectos_proyecto_equipo" OWNER TO postgres;

--
-- TOC entry 185 (class 1259 OID 45280)
-- Name: Proyectos_proyecto_equipo_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "Proyectos_proyecto_equipo_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Proyectos_proyecto_equipo_id_seq" OWNER TO postgres;

--
-- TOC entry 2279 (class 0 OID 0)
-- Dependencies: 185
-- Name: Proyectos_proyecto_equipo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "Proyectos_proyecto_equipo_id_seq" OWNED BY "Proyectos_proyecto_equipo".id;


--
-- TOC entry 187 (class 1259 OID 45295)
-- Name: Proyectos_proyecto_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "Proyectos_proyecto_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Proyectos_proyecto_id_seq" OWNER TO postgres;

--
-- TOC entry 2280 (class 0 OID 0)
-- Dependencies: 187
-- Name: Proyectos_proyecto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "Proyectos_proyecto_id_seq" OWNED BY "Proyectos_proyecto".id;


--
-- TOC entry 190 (class 1259 OID 45320)
-- Name: Proyectos_sprint; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "Proyectos_sprint" (
    id integer NOT NULL,
    "nombreSprint" character varying(50) NOT NULL,
    fecha_inicio date NOT NULL,
    fecha_fin date NOT NULL,
    descripcion text NOT NULL,
    proyecto_id integer NOT NULL
);


ALTER TABLE public."Proyectos_sprint" OWNER TO postgres;

--
-- TOC entry 189 (class 1259 OID 45318)
-- Name: Proyectos_sprint_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "Proyectos_sprint_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Proyectos_sprint_id_seq" OWNER TO postgres;

--
-- TOC entry 2281 (class 0 OID 0)
-- Dependencies: 189
-- Name: Proyectos_sprint_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "Proyectos_sprint_id_seq" OWNED BY "Proyectos_sprint".id;


--
-- TOC entry 196 (class 1259 OID 45370)
-- Name: Proyectos_userstory; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "Proyectos_userstory" (
    id integer NOT NULL,
    "nombreUS" character varying(50) NOT NULL,
    tiempo_estimado integer NOT NULL,
    tiempo_trabajado integer NOT NULL,
    descripcion text NOT NULL,
    prioridad character varying(1) NOT NULL,
    proyecto_id integer,
    usuario_id integer,
    sprint_id integer,
    flujo_id integer,
    actividad_flujo_id integer,
    estado_actividad character varying(2),
    estado_sprint character varying(1)
);


ALTER TABLE public."Proyectos_userstory" OWNER TO postgres;

--
-- TOC entry 195 (class 1259 OID 45368)
-- Name: Proyectos_userstory_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "Proyectos_userstory_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Proyectos_userstory_id_seq" OWNER TO postgres;

--
-- TOC entry 2282 (class 0 OID 0)
-- Dependencies: 195
-- Name: Proyectos_userstory_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "Proyectos_userstory_id_seq" OWNED BY "Proyectos_userstory".id;


--
-- TOC entry 177 (class 1259 OID 45207)
-- Name: auth_group; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE auth_group (
    id integer NOT NULL,
    name character varying(80) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO postgres;

--
-- TOC entry 176 (class 1259 OID 45205)
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE auth_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO postgres;

--
-- TOC entry 2283 (class 0 OID 0)
-- Dependencies: 176
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE auth_group_id_seq OWNED BY auth_group.id;


--
-- TOC entry 175 (class 1259 OID 45192)
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO postgres;

--
-- TOC entry 174 (class 1259 OID 45190)
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO postgres;

--
-- TOC entry 2284 (class 0 OID 0)
-- Dependencies: 174
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE auth_group_permissions_id_seq OWNED BY auth_group_permissions.id;


--
-- TOC entry 173 (class 1259 OID 45182)
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE auth_permission (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO postgres;

--
-- TOC entry 172 (class 1259 OID 45180)
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE auth_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO postgres;

--
-- TOC entry 2285 (class 0 OID 0)
-- Dependencies: 172
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE auth_permission_id_seq OWNED BY auth_permission.id;


--
-- TOC entry 184 (class 1259 OID 45270)
-- Name: auth_rol; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE auth_rol (
    group_ptr_id integer NOT NULL,
    proyecto_id integer NOT NULL
);


ALTER TABLE public.auth_rol OWNER TO postgres;

--
-- TOC entry 183 (class 1259 OID 45252)
-- Name: auth_user; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE auth_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone NOT NULL,
    is_superuser boolean NOT NULL,
    username character varying(30) NOT NULL,
    first_name character varying(30) NOT NULL,
    last_name character varying(30) NOT NULL,
    email character varying(75) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


ALTER TABLE public.auth_user OWNER TO postgres;

--
-- TOC entry 179 (class 1259 OID 45222)
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE auth_user_groups (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.auth_user_groups OWNER TO postgres;

--
-- TOC entry 178 (class 1259 OID 45220)
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE auth_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_groups_id_seq OWNER TO postgres;

--
-- TOC entry 2286 (class 0 OID 0)
-- Dependencies: 178
-- Name: auth_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE auth_user_groups_id_seq OWNED BY auth_user_groups.id;


--
-- TOC entry 182 (class 1259 OID 45250)
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE auth_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_id_seq OWNER TO postgres;

--
-- TOC entry 2287 (class 0 OID 0)
-- Dependencies: 182
-- Name: auth_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE auth_user_id_seq OWNED BY auth_user.id;


--
-- TOC entry 181 (class 1259 OID 45237)
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE auth_user_user_permissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_user_user_permissions OWNER TO postgres;

--
-- TOC entry 180 (class 1259 OID 45235)
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE auth_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_user_permissions_id_seq OWNER TO postgres;

--
-- TOC entry 2288 (class 0 OID 0)
-- Dependencies: 180
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE auth_user_user_permissions_id_seq OWNED BY auth_user_user_permissions.id;


--
-- TOC entry 202 (class 1259 OID 45455)
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO postgres;

--
-- TOC entry 201 (class 1259 OID 45453)
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE django_admin_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO postgres;

--
-- TOC entry 2289 (class 0 OID 0)
-- Dependencies: 201
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE django_admin_log_id_seq OWNED BY django_admin_log.id;


--
-- TOC entry 200 (class 1259 OID 45445)
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE django_content_type (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO postgres;

--
-- TOC entry 199 (class 1259 OID 45443)
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE django_content_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO postgres;

--
-- TOC entry 2290 (class 0 OID 0)
-- Dependencies: 199
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE django_content_type_id_seq OWNED BY django_content_type.id;


--
-- TOC entry 171 (class 1259 OID 45171)
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO postgres;

--
-- TOC entry 170 (class 1259 OID 45169)
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_migrations_id_seq OWNER TO postgres;

--
-- TOC entry 2291 (class 0 OID 0)
-- Dependencies: 170
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE django_migrations_id_seq OWNED BY django_migrations.id;


--
-- TOC entry 203 (class 1259 OID 45477)
-- Name: django_session; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO postgres;

--
-- TOC entry 2018 (class 2604 OID 45360)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Proyectos_actividad" ALTER COLUMN id SET DEFAULT nextval('"Proyectos_actividad_id_seq"'::regclass);


--
-- TOC entry 2020 (class 2604 OID 45409)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Proyectos_comentario" ALTER COLUMN id SET DEFAULT nextval('"Proyectos_comentario_id_seq"'::regclass);


--
-- TOC entry 2017 (class 2604 OID 45339)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Proyectos_flujo" ALTER COLUMN id SET DEFAULT nextval('"Proyectos_flujo_id_seq"'::regclass);


--
-- TOC entry 2015 (class 2604 OID 45300)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Proyectos_proyecto" ALTER COLUMN id SET DEFAULT nextval('"Proyectos_proyecto_id_seq"'::regclass);


--
-- TOC entry 2014 (class 2604 OID 45285)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Proyectos_proyecto_equipo" ALTER COLUMN id SET DEFAULT nextval('"Proyectos_proyecto_equipo_id_seq"'::regclass);


--
-- TOC entry 2016 (class 2604 OID 45323)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Proyectos_sprint" ALTER COLUMN id SET DEFAULT nextval('"Proyectos_sprint_id_seq"'::regclass);


--
-- TOC entry 2019 (class 2604 OID 45373)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Proyectos_userstory" ALTER COLUMN id SET DEFAULT nextval('"Proyectos_userstory_id_seq"'::regclass);


--
-- TOC entry 2010 (class 2604 OID 45210)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_group ALTER COLUMN id SET DEFAULT nextval('auth_group_id_seq'::regclass);


--
-- TOC entry 2009 (class 2604 OID 45195)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('auth_group_permissions_id_seq'::regclass);


--
-- TOC entry 2008 (class 2604 OID 45185)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_permission ALTER COLUMN id SET DEFAULT nextval('auth_permission_id_seq'::regclass);


--
-- TOC entry 2013 (class 2604 OID 45255)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_user ALTER COLUMN id SET DEFAULT nextval('auth_user_id_seq'::regclass);


--
-- TOC entry 2011 (class 2604 OID 45225)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_user_groups ALTER COLUMN id SET DEFAULT nextval('auth_user_groups_id_seq'::regclass);


--
-- TOC entry 2012 (class 2604 OID 45240)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('auth_user_user_permissions_id_seq'::regclass);


--
-- TOC entry 2022 (class 2604 OID 45458)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY django_admin_log ALTER COLUMN id SET DEFAULT nextval('django_admin_log_id_seq'::regclass);


--
-- TOC entry 2021 (class 2604 OID 45448)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY django_content_type ALTER COLUMN id SET DEFAULT nextval('django_content_type_id_seq'::regclass);


--
-- TOC entry 2007 (class 2604 OID 45174)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY django_migrations ALTER COLUMN id SET DEFAULT nextval('django_migrations_id_seq'::regclass);


--
-- TOC entry 2258 (class 0 OID 45357)
-- Dependencies: 194
-- Data for Name: Proyectos_actividad; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "Proyectos_actividad" (id, nombre, descripcion, flujo_id, orden) VALUES (1, 'actividad 1', 'descripcion actividad 1', 1, 1);
INSERT INTO "Proyectos_actividad" (id, nombre, descripcion, flujo_id, orden) VALUES (2, 'actividad 2', 'descripcion actividad 2', 1, 2);
INSERT INTO "Proyectos_actividad" (id, nombre, descripcion, flujo_id, orden) VALUES (3, 'actividad 3', 'descripcion actividad 3', 1, 3);
INSERT INTO "Proyectos_actividad" (id, nombre, descripcion, flujo_id, orden) VALUES (4, 'actividad 1', 'descripcion actividad 1', 2, 1);
INSERT INTO "Proyectos_actividad" (id, nombre, descripcion, flujo_id, orden) VALUES (5, 'actividad 2', 'descripcion actividad 2', 2, 2);
INSERT INTO "Proyectos_actividad" (id, nombre, descripcion, flujo_id, orden) VALUES (6, 'actividad 1', 'descripcion actividad 1', 3, 1);
INSERT INTO "Proyectos_actividad" (id, nombre, descripcion, flujo_id, orden) VALUES (7, 'actividad 2', 'descripcion actividad 2', 3, 2);
INSERT INTO "Proyectos_actividad" (id, nombre, descripcion, flujo_id, orden) VALUES (8, 'actividad 3', 'descripcion actividad 3', 3, 3);
INSERT INTO "Proyectos_actividad" (id, nombre, descripcion, flujo_id, orden) VALUES (9, 'actividad 4', 'descripcion actividad 4', 3, 4);


--
-- TOC entry 2292 (class 0 OID 0)
-- Dependencies: 193
-- Name: Proyectos_actividad_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"Proyectos_actividad_id_seq"', 9, true);


--
-- TOC entry 2262 (class 0 OID 45406)
-- Dependencies: 198
-- Data for Name: Proyectos_comentario; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "Proyectos_comentario" (id, texto, fecha, userstory_id, username) VALUES (1, 'hola que tal
', '2015-04-01 17:29:41-04', 1, 'admin');


--
-- TOC entry 2293 (class 0 OID 0)
-- Dependencies: 197
-- Name: Proyectos_comentario_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"Proyectos_comentario_id_seq"', 1, true);


--
-- TOC entry 2256 (class 0 OID 45336)
-- Dependencies: 192
-- Data for Name: Proyectos_flujo; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "Proyectos_flujo" (id, proyecto_id, sprint_id, nombre, descripcion) VALUES (2, 1, NULL, 'flujo 2', 'descripción flujo 2');
INSERT INTO "Proyectos_flujo" (id, proyecto_id, sprint_id, nombre, descripcion) VALUES (3, 1, NULL, 'flujo 3', 'descripción flujo 3');
INSERT INTO "Proyectos_flujo" (id, proyecto_id, sprint_id, nombre, descripcion) VALUES (1, 1, 1, 'flujo 1', 'descripción flujo 1');


--
-- TOC entry 2294 (class 0 OID 0)
-- Dependencies: 191
-- Name: Proyectos_flujo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"Proyectos_flujo_id_seq"', 3, true);


--
-- TOC entry 2252 (class 0 OID 45297)
-- Dependencies: 188
-- Data for Name: Proyectos_proyecto; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "Proyectos_proyecto" (id, nombre, descripcion, estado, fecha_creacion, fecha_finalizacion) VALUES (1, 'proyecto 1', 'descripción proyecto 1', 'NOI', NULL, '2015-05-01');


--
-- TOC entry 2250 (class 0 OID 45282)
-- Dependencies: 186
-- Data for Name: Proyectos_proyecto_equipo; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "Proyectos_proyecto_equipo" (id, proyecto_id, user_id) VALUES (14, 1, 1);
INSERT INTO "Proyectos_proyecto_equipo" (id, proyecto_id, user_id) VALUES (15, 1, 2);
INSERT INTO "Proyectos_proyecto_equipo" (id, proyecto_id, user_id) VALUES (16, 1, 3);
INSERT INTO "Proyectos_proyecto_equipo" (id, proyecto_id, user_id) VALUES (17, 1, 4);
INSERT INTO "Proyectos_proyecto_equipo" (id, proyecto_id, user_id) VALUES (18, 1, 5);


--
-- TOC entry 2295 (class 0 OID 0)
-- Dependencies: 185
-- Name: Proyectos_proyecto_equipo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"Proyectos_proyecto_equipo_id_seq"', 18, true);


--
-- TOC entry 2296 (class 0 OID 0)
-- Dependencies: 187
-- Name: Proyectos_proyecto_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"Proyectos_proyecto_id_seq"', 1, true);


--
-- TOC entry 2254 (class 0 OID 45320)
-- Dependencies: 190
-- Data for Name: Proyectos_sprint; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "Proyectos_sprint" (id, "nombreSprint", fecha_inicio, fecha_fin, descripcion, proyecto_id) VALUES (1, 'sprint 1', '2015-05-02', '2015-05-09', 'descripción sprint 1', 1);
INSERT INTO "Proyectos_sprint" (id, "nombreSprint", fecha_inicio, fecha_fin, descripcion, proyecto_id) VALUES (2, 'sprint 2', '2015-05-10', '2015-05-17', 'descripción sprint 2', 1);


--
-- TOC entry 2297 (class 0 OID 0)
-- Dependencies: 189
-- Name: Proyectos_sprint_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"Proyectos_sprint_id_seq"', 2, true);


--
-- TOC entry 2260 (class 0 OID 45370)
-- Dependencies: 196
-- Data for Name: Proyectos_userstory; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "Proyectos_userstory" (id, "nombreUS", tiempo_estimado, tiempo_trabajado, descripcion, prioridad, proyecto_id, usuario_id, sprint_id, flujo_id, actividad_flujo_id, estado_actividad, estado_sprint) VALUES (2, 'US2', 16, 0, 'descripción US2', 'N', 1, 3, NULL, 1, 1, 'TO', 'F');
INSERT INTO "Proyectos_userstory" (id, "nombreUS", tiempo_estimado, tiempo_trabajado, descripcion, prioridad, proyecto_id, usuario_id, sprint_id, flujo_id, actividad_flujo_id, estado_actividad, estado_sprint) VALUES (3, 'US3', 13, 0, 'descripción US3', 'N', 1, 4, NULL, 1, 1, 'TO', 'F');
INSERT INTO "Proyectos_userstory" (id, "nombreUS", tiempo_estimado, tiempo_trabajado, descripcion, prioridad, proyecto_id, usuario_id, sprint_id, flujo_id, actividad_flujo_id, estado_actividad, estado_sprint) VALUES (1, 'US1', 10, 0, 'descripción US1', 'N', 1, 2, NULL, 1, 1, 'TO', 'F');


--
-- TOC entry 2298 (class 0 OID 0)
-- Dependencies: 195
-- Name: Proyectos_userstory_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"Proyectos_userstory_id_seq"', 3, true);


--
-- TOC entry 2241 (class 0 OID 45207)
-- Dependencies: 177
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO auth_group (id, name) VALUES (1, 'admin');
INSERT INTO auth_group (id, name) VALUES (2, 'scrumMaster');
INSERT INTO auth_group (id, name) VALUES (3, 'cliente');


--
-- TOC entry 2299 (class 0 OID 0)
-- Dependencies: 176
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('auth_group_id_seq', 3, true);


--
-- TOC entry 2239 (class 0 OID 45192)
-- Dependencies: 175
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO auth_group_permissions (id, group_id, permission_id) VALUES (1, 1, 1);
INSERT INTO auth_group_permissions (id, group_id, permission_id) VALUES (2, 1, 2);
INSERT INTO auth_group_permissions (id, group_id, permission_id) VALUES (3, 1, 3);
INSERT INTO auth_group_permissions (id, group_id, permission_id) VALUES (4, 1, 4);
INSERT INTO auth_group_permissions (id, group_id, permission_id) VALUES (5, 1, 5);
INSERT INTO auth_group_permissions (id, group_id, permission_id) VALUES (6, 1, 6);
INSERT INTO auth_group_permissions (id, group_id, permission_id) VALUES (7, 1, 7);
INSERT INTO auth_group_permissions (id, group_id, permission_id) VALUES (8, 1, 8);
INSERT INTO auth_group_permissions (id, group_id, permission_id) VALUES (9, 1, 9);
INSERT INTO auth_group_permissions (id, group_id, permission_id) VALUES (10, 1, 10);
INSERT INTO auth_group_permissions (id, group_id, permission_id) VALUES (11, 1, 11);
INSERT INTO auth_group_permissions (id, group_id, permission_id) VALUES (12, 1, 12);
INSERT INTO auth_group_permissions (id, group_id, permission_id) VALUES (13, 1, 13);
INSERT INTO auth_group_permissions (id, group_id, permission_id) VALUES (14, 1, 14);
INSERT INTO auth_group_permissions (id, group_id, permission_id) VALUES (15, 1, 15);
INSERT INTO auth_group_permissions (id, group_id, permission_id) VALUES (16, 1, 16);
INSERT INTO auth_group_permissions (id, group_id, permission_id) VALUES (17, 1, 17);
INSERT INTO auth_group_permissions (id, group_id, permission_id) VALUES (18, 1, 18);
INSERT INTO auth_group_permissions (id, group_id, permission_id) VALUES (19, 1, 19);
INSERT INTO auth_group_permissions (id, group_id, permission_id) VALUES (20, 1, 20);
INSERT INTO auth_group_permissions (id, group_id, permission_id) VALUES (21, 1, 21);
INSERT INTO auth_group_permissions (id, group_id, permission_id) VALUES (22, 1, 22);
INSERT INTO auth_group_permissions (id, group_id, permission_id) VALUES (23, 1, 23);
INSERT INTO auth_group_permissions (id, group_id, permission_id) VALUES (24, 1, 24);
INSERT INTO auth_group_permissions (id, group_id, permission_id) VALUES (25, 1, 25);
INSERT INTO auth_group_permissions (id, group_id, permission_id) VALUES (26, 1, 26);
INSERT INTO auth_group_permissions (id, group_id, permission_id) VALUES (27, 1, 27);
INSERT INTO auth_group_permissions (id, group_id, permission_id) VALUES (28, 1, 28);
INSERT INTO auth_group_permissions (id, group_id, permission_id) VALUES (29, 1, 29);
INSERT INTO auth_group_permissions (id, group_id, permission_id) VALUES (30, 1, 30);
INSERT INTO auth_group_permissions (id, group_id, permission_id) VALUES (31, 1, 31);
INSERT INTO auth_group_permissions (id, group_id, permission_id) VALUES (32, 1, 32);
INSERT INTO auth_group_permissions (id, group_id, permission_id) VALUES (33, 1, 33);
INSERT INTO auth_group_permissions (id, group_id, permission_id) VALUES (34, 1, 34);
INSERT INTO auth_group_permissions (id, group_id, permission_id) VALUES (35, 1, 35);
INSERT INTO auth_group_permissions (id, group_id, permission_id) VALUES (36, 1, 36);
INSERT INTO auth_group_permissions (id, group_id, permission_id) VALUES (37, 1, 37);
INSERT INTO auth_group_permissions (id, group_id, permission_id) VALUES (38, 1, 38);
INSERT INTO auth_group_permissions (id, group_id, permission_id) VALUES (39, 1, 39);
INSERT INTO auth_group_permissions (id, group_id, permission_id) VALUES (40, 1, 40);
INSERT INTO auth_group_permissions (id, group_id, permission_id) VALUES (41, 1, 41);
INSERT INTO auth_group_permissions (id, group_id, permission_id) VALUES (42, 1, 42);
INSERT INTO auth_group_permissions (id, group_id, permission_id) VALUES (43, 1, 43);
INSERT INTO auth_group_permissions (id, group_id, permission_id) VALUES (44, 1, 44);
INSERT INTO auth_group_permissions (id, group_id, permission_id) VALUES (45, 1, 45);
INSERT INTO auth_group_permissions (id, group_id, permission_id) VALUES (46, 1, 46);
INSERT INTO auth_group_permissions (id, group_id, permission_id) VALUES (47, 1, 47);
INSERT INTO auth_group_permissions (id, group_id, permission_id) VALUES (48, 1, 48);
INSERT INTO auth_group_permissions (id, group_id, permission_id) VALUES (49, 1, 49);
INSERT INTO auth_group_permissions (id, group_id, permission_id) VALUES (50, 1, 50);
INSERT INTO auth_group_permissions (id, group_id, permission_id) VALUES (51, 1, 51);
INSERT INTO auth_group_permissions (id, group_id, permission_id) VALUES (52, 1, 52);
INSERT INTO auth_group_permissions (id, group_id, permission_id) VALUES (53, 2, 25);
INSERT INTO auth_group_permissions (id, group_id, permission_id) VALUES (54, 2, 26);
INSERT INTO auth_group_permissions (id, group_id, permission_id) VALUES (55, 2, 27);
INSERT INTO auth_group_permissions (id, group_id, permission_id) VALUES (56, 2, 28);
INSERT INTO auth_group_permissions (id, group_id, permission_id) VALUES (57, 2, 29);
INSERT INTO auth_group_permissions (id, group_id, permission_id) VALUES (58, 2, 30);
INSERT INTO auth_group_permissions (id, group_id, permission_id) VALUES (59, 2, 31);
INSERT INTO auth_group_permissions (id, group_id, permission_id) VALUES (60, 2, 32);
INSERT INTO auth_group_permissions (id, group_id, permission_id) VALUES (61, 2, 33);
INSERT INTO auth_group_permissions (id, group_id, permission_id) VALUES (62, 2, 34);
INSERT INTO auth_group_permissions (id, group_id, permission_id) VALUES (63, 2, 35);
INSERT INTO auth_group_permissions (id, group_id, permission_id) VALUES (64, 2, 36);
INSERT INTO auth_group_permissions (id, group_id, permission_id) VALUES (65, 2, 37);
INSERT INTO auth_group_permissions (id, group_id, permission_id) VALUES (66, 2, 38);
INSERT INTO auth_group_permissions (id, group_id, permission_id) VALUES (67, 2, 39);
INSERT INTO auth_group_permissions (id, group_id, permission_id) VALUES (68, 2, 40);
INSERT INTO auth_group_permissions (id, group_id, permission_id) VALUES (69, 2, 41);
INSERT INTO auth_group_permissions (id, group_id, permission_id) VALUES (70, 2, 42);
INSERT INTO auth_group_permissions (id, group_id, permission_id) VALUES (71, 2, 43);
INSERT INTO auth_group_permissions (id, group_id, permission_id) VALUES (72, 2, 44);
INSERT INTO auth_group_permissions (id, group_id, permission_id) VALUES (73, 2, 45);
INSERT INTO auth_group_permissions (id, group_id, permission_id) VALUES (74, 2, 46);
INSERT INTO auth_group_permissions (id, group_id, permission_id) VALUES (75, 2, 47);
INSERT INTO auth_group_permissions (id, group_id, permission_id) VALUES (76, 2, 48);
INSERT INTO auth_group_permissions (id, group_id, permission_id) VALUES (77, 2, 49);
INSERT INTO auth_group_permissions (id, group_id, permission_id) VALUES (78, 2, 50);
INSERT INTO auth_group_permissions (id, group_id, permission_id) VALUES (79, 2, 51);
INSERT INTO auth_group_permissions (id, group_id, permission_id) VALUES (80, 2, 52);
INSERT INTO auth_group_permissions (id, group_id, permission_id) VALUES (81, 3, 33);
INSERT INTO auth_group_permissions (id, group_id, permission_id) VALUES (82, 3, 37);
INSERT INTO auth_group_permissions (id, group_id, permission_id) VALUES (83, 3, 41);
INSERT INTO auth_group_permissions (id, group_id, permission_id) VALUES (84, 3, 45);
INSERT INTO auth_group_permissions (id, group_id, permission_id) VALUES (85, 3, 49);
INSERT INTO auth_group_permissions (id, group_id, permission_id) VALUES (86, 3, 28);
INSERT INTO auth_group_permissions (id, group_id, permission_id) VALUES (87, 3, 29);


--
-- TOC entry 2300 (class 0 OID 0)
-- Dependencies: 174
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('auth_group_permissions_id_seq', 87, true);


--
-- TOC entry 2237 (class 0 OID 45182)
-- Dependencies: 173
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO auth_permission (id, name, content_type_id, codename) VALUES (1, 'Can add log entry', 1, 'add_logentry');
INSERT INTO auth_permission (id, name, content_type_id, codename) VALUES (2, 'Can change log entry', 1, 'change_logentry');
INSERT INTO auth_permission (id, name, content_type_id, codename) VALUES (3, 'Can delete log entry', 1, 'delete_logentry');
INSERT INTO auth_permission (id, name, content_type_id, codename) VALUES (4, 'Can add permission', 2, 'add_permission');
INSERT INTO auth_permission (id, name, content_type_id, codename) VALUES (5, 'Can change permission', 2, 'change_permission');
INSERT INTO auth_permission (id, name, content_type_id, codename) VALUES (6, 'Can delete permission', 2, 'delete_permission');
INSERT INTO auth_permission (id, name, content_type_id, codename) VALUES (7, 'Can add group', 3, 'add_group');
INSERT INTO auth_permission (id, name, content_type_id, codename) VALUES (8, 'Can change group', 3, 'change_group');
INSERT INTO auth_permission (id, name, content_type_id, codename) VALUES (9, 'Can delete group', 3, 'delete_group');
INSERT INTO auth_permission (id, name, content_type_id, codename) VALUES (10, 'Can add user', 4, 'add_user');
INSERT INTO auth_permission (id, name, content_type_id, codename) VALUES (11, 'Can change user', 4, 'change_user');
INSERT INTO auth_permission (id, name, content_type_id, codename) VALUES (12, 'Can delete user', 4, 'delete_user');
INSERT INTO auth_permission (id, name, content_type_id, codename) VALUES (13, 'Can add usuario', 4, 'add_usuario');
INSERT INTO auth_permission (id, name, content_type_id, codename) VALUES (14, 'Can change usuario', 4, 'change_usuario');
INSERT INTO auth_permission (id, name, content_type_id, codename) VALUES (15, 'Can delete usuario', 4, 'delete_usuario');
INSERT INTO auth_permission (id, name, content_type_id, codename) VALUES (16, 'Can add rol', 5, 'add_rol');
INSERT INTO auth_permission (id, name, content_type_id, codename) VALUES (17, 'Can change rol', 5, 'change_rol');
INSERT INTO auth_permission (id, name, content_type_id, codename) VALUES (18, 'Can delete rol', 5, 'delete_rol');
INSERT INTO auth_permission (id, name, content_type_id, codename) VALUES (19, 'Can add content type', 7, 'add_contenttype');
INSERT INTO auth_permission (id, name, content_type_id, codename) VALUES (20, 'Can change content type', 7, 'change_contenttype');
INSERT INTO auth_permission (id, name, content_type_id, codename) VALUES (21, 'Can delete content type', 7, 'delete_contenttype');
INSERT INTO auth_permission (id, name, content_type_id, codename) VALUES (22, 'Can add session', 8, 'add_session');
INSERT INTO auth_permission (id, name, content_type_id, codename) VALUES (23, 'Can change session', 8, 'change_session');
INSERT INTO auth_permission (id, name, content_type_id, codename) VALUES (24, 'Can delete session', 8, 'delete_session');
INSERT INTO auth_permission (id, name, content_type_id, codename) VALUES (25, 'Can add proyecto', 9, 'add_proyecto');
INSERT INTO auth_permission (id, name, content_type_id, codename) VALUES (26, 'Can change proyecto', 9, 'change_proyecto');
INSERT INTO auth_permission (id, name, content_type_id, codename) VALUES (27, 'Can delete proyecto', 9, 'delete_proyecto');
INSERT INTO auth_permission (id, name, content_type_id, codename) VALUES (28, 'Can view proyecto', 9, 'view_proyecto');
INSERT INTO auth_permission (id, name, content_type_id, codename) VALUES (29, 'Can view equipo', 9, 'view_equipo');
INSERT INTO auth_permission (id, name, content_type_id, codename) VALUES (30, 'Can add sprint', 10, 'add_sprint');
INSERT INTO auth_permission (id, name, content_type_id, codename) VALUES (31, 'Can change sprint', 10, 'change_sprint');
INSERT INTO auth_permission (id, name, content_type_id, codename) VALUES (32, 'Can delete sprint', 10, 'delete_sprint');
INSERT INTO auth_permission (id, name, content_type_id, codename) VALUES (33, 'can view sprint', 10, 'view_sprint');
INSERT INTO auth_permission (id, name, content_type_id, codename) VALUES (34, 'Can add flujo', 11, 'add_flujo');
INSERT INTO auth_permission (id, name, content_type_id, codename) VALUES (35, 'Can change flujo', 11, 'change_flujo');
INSERT INTO auth_permission (id, name, content_type_id, codename) VALUES (36, 'Can delete flujo', 11, 'delete_flujo');
INSERT INTO auth_permission (id, name, content_type_id, codename) VALUES (37, 'Can view flujo', 11, 'view_flujo');
INSERT INTO auth_permission (id, name, content_type_id, codename) VALUES (38, 'Can add Actividad', 12, 'add_actividad');
INSERT INTO auth_permission (id, name, content_type_id, codename) VALUES (39, 'Can change Actividad', 12, 'change_actividad');
INSERT INTO auth_permission (id, name, content_type_id, codename) VALUES (40, 'Can delete Actividad', 12, 'delete_actividad');
INSERT INTO auth_permission (id, name, content_type_id, codename) VALUES (41, 'can view actividad', 12, 'view_actividad');
INSERT INTO auth_permission (id, name, content_type_id, codename) VALUES (42, 'Can add User Story', 13, 'add_userstory');
INSERT INTO auth_permission (id, name, content_type_id, codename) VALUES (43, 'Can change User Story', 13, 'change_userstory');
INSERT INTO auth_permission (id, name, content_type_id, codename) VALUES (44, 'Can delete User Story', 13, 'delete_userstory');
INSERT INTO auth_permission (id, name, content_type_id, codename) VALUES (45, 'Can view userstory', 13, 'view_userstory');
INSERT INTO auth_permission (id, name, content_type_id, codename) VALUES (46, 'Can add comentario', 14, 'add_comentario');
INSERT INTO auth_permission (id, name, content_type_id, codename) VALUES (47, 'Can change comentario', 14, 'change_comentario');
INSERT INTO auth_permission (id, name, content_type_id, codename) VALUES (48, 'Can delete comentario', 14, 'delete_comentario');
INSERT INTO auth_permission (id, name, content_type_id, codename) VALUES (49, 'can view comentario', 14, 'view_comentario');
INSERT INTO auth_permission (id, name, content_type_id, codename) VALUES (50, 'Can add equipo', 9, 'add_equipo');
INSERT INTO auth_permission (id, name, content_type_id, codename) VALUES (51, 'Can change equipo', 9, 'change_equipo');
INSERT INTO auth_permission (id, name, content_type_id, codename) VALUES (52, 'Can delete equipo', 9, 'delete_equipo');


--
-- TOC entry 2301 (class 0 OID 0)
-- Dependencies: 172
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('auth_permission_id_seq', 52, true);


--
-- TOC entry 2248 (class 0 OID 45270)
-- Dependencies: 184
-- Data for Name: auth_rol; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO auth_rol (group_ptr_id, proyecto_id) VALUES (1, 1);
INSERT INTO auth_rol (group_ptr_id, proyecto_id) VALUES (2, 1);
INSERT INTO auth_rol (group_ptr_id, proyecto_id) VALUES (3, 1);


--
-- TOC entry 2247 (class 0 OID 45252)
-- Dependencies: 183
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) VALUES (5, 'pbkdf2_sha256$15000$gJt4j75jhemk$8oJFdgXufHeLL8fUdgSBfHnSaGZd/QkEu9tvGobjPx4=', '2015-05-01 17:46:17-04', false, 'cliente', '', '', '', true, true, '2015-05-01 17:46:17-04');
INSERT INTO auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) VALUES (3, 'pbkdf2_sha256$15000$bgFBPn3j79pP$sVC+Nze/M7I5PLr9mHPCiJPjO1RKK0eEvBrqBAGm3T4=', '2015-05-01 17:39:31-04', false, 'juanber', 'Juan', 'Duarte', 'juanber2.0@gmail.com', true, true, '2015-05-01 17:39:31-04');
INSERT INTO auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) VALUES (4, 'pbkdf2_sha256$15000$OWNVhlMv8hBR$+/rVvrm8IXLV9BjwLuJ6fQaJwHAs9qA08N2CWmmtAFk=', '2015-05-01 17:40:50-04', false, 'javier', 'Javier', 'Florentin', 'javierflorentin90@gmail.com', true, true, '2015-05-01 17:40:50-04');
INSERT INTO auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) VALUES (1, 'pbkdf2_sha256$15000$ljp352uAiwec$Lm6WcVRK8+3jlQzQPml0w/UCK2+PS0TVyq0SVcBMwMQ=', '2015-05-01 17:29:14-04', true, 'admin', '', '', '', true, true, '2015-05-01 17:28:38-04');
INSERT INTO auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) VALUES (2, 'pbkdf2_sha256$15000$8DqeGLrq8Hmm$bCUQug17yj86etLQo3b6SnfECwnvHwnwwEw8HvO6wlg=', '2015-05-01 18:01:12.122754-04', false, 'miguel', 'Miguel', 'Fernandez', 'myguelfernandez@gmail.com', true, true, '2015-05-01 17:35:58-04');


--
-- TOC entry 2243 (class 0 OID 45222)
-- Dependencies: 179
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO auth_user_groups (id, user_id, group_id) VALUES (1, 5, 3);
INSERT INTO auth_user_groups (id, user_id, group_id) VALUES (3, 2, 2);
INSERT INTO auth_user_groups (id, user_id, group_id) VALUES (4, 3, 2);
INSERT INTO auth_user_groups (id, user_id, group_id) VALUES (5, 4, 2);


--
-- TOC entry 2302 (class 0 OID 0)
-- Dependencies: 178
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('auth_user_groups_id_seq', 5, true);


--
-- TOC entry 2303 (class 0 OID 0)
-- Dependencies: 182
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('auth_user_id_seq', 5, true);


--
-- TOC entry 2245 (class 0 OID 45237)
-- Dependencies: 181
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2304 (class 0 OID 0)
-- Dependencies: 180
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('auth_user_user_permissions_id_seq', 1, false);


--
-- TOC entry 2266 (class 0 OID 45455)
-- Dependencies: 202
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (1, '2015-05-01 17:31:58.938354-04', '1', 'proyecto 1', 1, '', 9, 1);
INSERT INTO django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (2, '2015-05-01 17:32:07.832736-04', '1', 'flujo 1', 1, '', 11, 1);
INSERT INTO django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (3, '2015-05-01 17:32:58.383668-04', '1', 'us1', 1, '', 13, 1);
INSERT INTO django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (4, '2015-05-01 17:33:29.200806-04', '1', 'proyecto 1', 2, 'Modificado/a equipo.', 9, 1);
INSERT INTO django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (5, '2015-05-01 17:33:53.950438-04', '1', 'us1', 2, 'Modificado/a proyecto.', 13, 1);
INSERT INTO django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (6, '2015-05-01 17:34:10.254837-04', '1', 'us1', 2, 'Modificado/a actividad_flujo.', 13, 1);
INSERT INTO django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (7, '2015-05-01 17:35:05.339414-04', '2', 'flujo 2', 1, '', 11, 1);
INSERT INTO django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (8, '2015-05-01 17:35:58.930746-04', '2', 'miguel', 1, '', 6, 1);
INSERT INTO django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (9, '2015-05-01 17:36:37.262598-04', '2', 'miguel', 2, 'Modificado/a first_name, last_name, email y is_staff.', 6, 1);
INSERT INTO django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (10, '2015-05-01 17:39:31.749335-04', '3', 'juanber', 1, '', 6, 1);
INSERT INTO django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (11, '2015-05-01 17:40:17.01437-04', '3', 'juanber', 2, 'Modificado/a first_name, last_name, email y is_staff.', 6, 1);
INSERT INTO django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (12, '2015-05-01 17:40:50.840204-04', '4', 'javier', 1, '', 6, 1);
INSERT INTO django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (13, '2015-05-01 17:41:23.654788-04', '4', 'javier', 2, 'Modificado/a first_name, last_name, email y is_staff.', 6, 1);
INSERT INTO django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (14, '2015-05-01 17:41:44.019605-04', '1', 'proyecto 1', 2, 'Modificado/a equipo.', 9, 1);
INSERT INTO django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (15, '2015-05-01 17:41:50.683448-04', '1', 'proyecto 1', 2, 'No ha cambiado ningún campo.', 9, 1);
INSERT INTO django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (16, '2015-05-01 17:42:27.680093-04', '1', 'proyecto 1', 2, 'No ha cambiado ningún campo.', 9, 1);
INSERT INTO django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (17, '2015-05-01 17:43:53.645865-04', '3', 'flujo 3', 1, '', 11, 1);
INSERT INTO django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (18, '2015-05-01 17:44:20.650546-04', '1', 'admin', 1, '', 5, 1);
INSERT INTO django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (19, '2015-05-01 17:44:46.925223-04', '2', 'scrumMaster', 1, '', 5, 1);
INSERT INTO django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (20, '2015-05-01 17:45:20.034991-04', '3', 'cliente', 1, '', 5, 1);
INSERT INTO django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (21, '2015-05-01 17:46:17.291365-04', '5', 'cliente', 1, '', 6, 1);
INSERT INTO django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (22, '2015-05-01 17:46:37.72101-04', '5', 'cliente', 2, 'Modificado/a is_staff y groups.', 6, 1);
INSERT INTO django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (23, '2015-05-01 17:46:53.868943-04', '1', 'admin', 2, 'Modificado/a groups.', 6, 1);
INSERT INTO django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (24, '2015-05-01 17:47:24.005939-04', '2', 'miguel', 2, 'Modificado/a groups.', 6, 1);
INSERT INTO django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (25, '2015-05-01 17:47:34.480821-04', '3', 'juanber', 2, 'Modificado/a groups.', 6, 1);
INSERT INTO django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (26, '2015-05-01 17:47:47.881289-04', '4', 'javier', 2, 'Modificado/a groups.', 6, 1);
INSERT INTO django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (27, '2015-05-01 17:48:41.40232-04', '1', 'proyecto 1', 2, 'Modificado/a equipo.', 9, 1);
INSERT INTO django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (28, '2015-05-01 17:49:39.945979-04', '1', 'sprint 1', 1, '', 10, 1);
INSERT INTO django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (29, '2015-05-01 17:50:12.346586-04', '2', 'sprint 2', 1, '', 10, 1);
INSERT INTO django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (30, '2015-05-01 17:52:50.123994-04', '1', 'admin', 2, 'Modificado/a groups.', 6, 1);
INSERT INTO django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (31, '2015-05-01 17:53:19.964202-04', '1', 'us1', 2, 'Modificado/a usuario.', 13, 1);
INSERT INTO django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (32, '2015-05-01 17:54:26.844196-04', '1', 'us1', 2, 'Modificado/a estado_sprint.', 13, 1);
INSERT INTO django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (33, '2015-05-01 17:54:40.959126-04', '1', 'us1', 2, 'Modificado/a estado_sprint.', 13, 1);
INSERT INTO django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (34, '2015-05-01 17:55:32.646693-04', '1', 'us1', 2, 'Modificado/a estado_sprint.', 13, 1);
INSERT INTO django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (35, '2015-05-01 17:55:54.244984-04', '1', 'flujo 1', 2, 'Modificado/a sprint.', 11, 1);
INSERT INTO django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (36, '2015-05-01 17:57:44.13724-04', '2', 'US2', 1, '', 13, 1);
INSERT INTO django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (37, '2015-05-01 17:58:12.89068-04', '1', 'US1', 2, 'Modificado/a nombreUS.', 13, 1);
INSERT INTO django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (38, '2015-05-01 17:59:20.693757-04', '3', 'US3', 1, '', 13, 1);
INSERT INTO django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (39, '2015-05-01 17:59:50.066379-04', '1', 'US1', 2, 'Modificado/a descripcion.', 13, 1);


--
-- TOC entry 2305 (class 0 OID 0)
-- Dependencies: 201
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('django_admin_log_id_seq', 39, true);


--
-- TOC entry 2264 (class 0 OID 45445)
-- Dependencies: 200
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO django_content_type (id, name, app_label, model) VALUES (1, 'log entry', 'admin', 'logentry');
INSERT INTO django_content_type (id, name, app_label, model) VALUES (2, 'permission', 'auth', 'permission');
INSERT INTO django_content_type (id, name, app_label, model) VALUES (3, 'group', 'auth', 'group');
INSERT INTO django_content_type (id, name, app_label, model) VALUES (4, 'user', 'auth', 'user');
INSERT INTO django_content_type (id, name, app_label, model) VALUES (5, 'rol', 'auth', 'rol');
INSERT INTO django_content_type (id, name, app_label, model) VALUES (6, 'usuario', 'auth', 'usuario');
INSERT INTO django_content_type (id, name, app_label, model) VALUES (7, 'content type', 'contenttypes', 'contenttype');
INSERT INTO django_content_type (id, name, app_label, model) VALUES (8, 'session', 'sessions', 'session');
INSERT INTO django_content_type (id, name, app_label, model) VALUES (9, 'proyecto', 'Proyectos', 'proyecto');
INSERT INTO django_content_type (id, name, app_label, model) VALUES (10, 'sprint', 'Proyectos', 'sprint');
INSERT INTO django_content_type (id, name, app_label, model) VALUES (11, 'flujo', 'Proyectos', 'flujo');
INSERT INTO django_content_type (id, name, app_label, model) VALUES (12, 'Actividad', 'Proyectos', 'actividad');
INSERT INTO django_content_type (id, name, app_label, model) VALUES (13, 'User Story', 'Proyectos', 'userstory');
INSERT INTO django_content_type (id, name, app_label, model) VALUES (14, 'comentario', 'Proyectos', 'comentario');
INSERT INTO django_content_type (id, name, app_label, model) VALUES (15, 'equipo', 'Proyectos', 'equipo');


--
-- TOC entry 2306 (class 0 OID 0)
-- Dependencies: 199
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('django_content_type_id_seq', 15, true);


--
-- TOC entry 2235 (class 0 OID 45171)
-- Dependencies: 171
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO django_migrations (id, app, name, applied) VALUES (1, 'contenttypes', '0001_initial', '2015-05-01 17:28:24.077492-04');
INSERT INTO django_migrations (id, app, name, applied) VALUES (2, 'admin', '0001_initial', '2015-05-01 17:28:24.919202-04');
INSERT INTO django_migrations (id, app, name, applied) VALUES (3, 'sessions', '0001_initial', '2015-05-01 17:28:25.808863-04');


--
-- TOC entry 2307 (class 0 OID 0)
-- Dependencies: 170
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('django_migrations_id_seq', 3, true);


--
-- TOC entry 2267 (class 0 OID 45477)
-- Dependencies: 203
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO django_session (session_key, session_data, expire_date) VALUES ('nqmfjg17168k4tv66mupfrcxsz97re87', 'ZjJmOTVmZGFmNjAyZDBkYTg3N2Q2YzMwODVhOTEzMTNlMWVhN2Q0ODp7Il9hdXRoX3VzZXJfaGFzaCI6IjNiN2QwZTk5M2MwZjUyN2E2NzFlODVkMjQ0OTg1NDc0NzcxZjdkZDIiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjJ9', '2015-05-15 18:01:12.146298-04');


--
-- TOC entry 2082 (class 2606 OID 45362)
-- Name: Proyectos_actividad_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "Proyectos_actividad"
    ADD CONSTRAINT "Proyectos_actividad_pkey" PRIMARY KEY (id);


--
-- TOC entry 2091 (class 2606 OID 45414)
-- Name: Proyectos_comentario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "Proyectos_comentario"
    ADD CONSTRAINT "Proyectos_comentario_pkey" PRIMARY KEY (id);


--
-- TOC entry 2077 (class 2606 OID 45344)
-- Name: Proyectos_flujo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "Proyectos_flujo"
    ADD CONSTRAINT "Proyectos_flujo_pkey" PRIMARY KEY (id);


--
-- TOC entry 2063 (class 2606 OID 45287)
-- Name: Proyectos_proyecto_equipo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "Proyectos_proyecto_equipo"
    ADD CONSTRAINT "Proyectos_proyecto_equipo_pkey" PRIMARY KEY (id);


--
-- TOC entry 2066 (class 2606 OID 45289)
-- Name: Proyectos_proyecto_equipo_proyecto_id_user_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "Proyectos_proyecto_equipo"
    ADD CONSTRAINT "Proyectos_proyecto_equipo_proyecto_id_user_id_key" UNIQUE (proyecto_id, user_id);


--
-- TOC entry 2069 (class 2606 OID 45307)
-- Name: Proyectos_proyecto_nombre_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "Proyectos_proyecto"
    ADD CONSTRAINT "Proyectos_proyecto_nombre_key" UNIQUE (nombre);


--
-- TOC entry 2072 (class 2606 OID 45305)
-- Name: Proyectos_proyecto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "Proyectos_proyecto"
    ADD CONSTRAINT "Proyectos_proyecto_pkey" PRIMARY KEY (id);


--
-- TOC entry 2074 (class 2606 OID 45328)
-- Name: Proyectos_sprint_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "Proyectos_sprint"
    ADD CONSTRAINT "Proyectos_sprint_pkey" PRIMARY KEY (id);


--
-- TOC entry 2086 (class 2606 OID 45378)
-- Name: Proyectos_userstory_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "Proyectos_userstory"
    ADD CONSTRAINT "Proyectos_userstory_pkey" PRIMARY KEY (id);


--
-- TOC entry 2038 (class 2606 OID 45214)
-- Name: auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- TOC entry 2033 (class 2606 OID 45199)
-- Name: auth_group_permissions_group_id_permission_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_key UNIQUE (group_id, permission_id);


--
-- TOC entry 2036 (class 2606 OID 45197)
-- Name: auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- TOC entry 2041 (class 2606 OID 45212)
-- Name: auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- TOC entry 2028 (class 2606 OID 45189)
-- Name: auth_permission_content_type_id_codename_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_key UNIQUE (content_type_id, codename);


--
-- TOC entry 2030 (class 2606 OID 45187)
-- Name: auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- TOC entry 2060 (class 2606 OID 45274)
-- Name: auth_rol_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY auth_rol
    ADD CONSTRAINT auth_rol_pkey PRIMARY KEY (group_ptr_id);


--
-- TOC entry 2044 (class 2606 OID 45227)
-- Name: auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- TOC entry 2047 (class 2606 OID 45229)
-- Name: auth_user_groups_user_id_group_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_key UNIQUE (user_id, group_id);


--
-- TOC entry 2055 (class 2606 OID 45257)
-- Name: auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- TOC entry 2050 (class 2606 OID 45242)
-- Name: auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- TOC entry 2053 (class 2606 OID 45244)
-- Name: auth_user_user_permissions_user_id_permission_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_key UNIQUE (user_id, permission_id);


--
-- TOC entry 2057 (class 2606 OID 45259)
-- Name: auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- TOC entry 2100 (class 2606 OID 45464)
-- Name: django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- TOC entry 2094 (class 2606 OID 45452)
-- Name: django_content_type_app_label_3ec8c61c_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY django_content_type
    ADD CONSTRAINT django_content_type_app_label_3ec8c61c_uniq UNIQUE (app_label, model);


--
-- TOC entry 2096 (class 2606 OID 45450)
-- Name: django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- TOC entry 2025 (class 2606 OID 45179)
-- Name: django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- TOC entry 2103 (class 2606 OID 45484)
-- Name: django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- TOC entry 2080 (class 1259 OID 45436)
-- Name: Proyectos_actividad_flujo_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "Proyectos_actividad_flujo_id" ON "Proyectos_actividad" USING btree (flujo_id);


--
-- TOC entry 2092 (class 1259 OID 45442)
-- Name: Proyectos_comentario_userstory_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "Proyectos_comentario_userstory_id" ON "Proyectos_comentario" USING btree (userstory_id);


--
-- TOC entry 2078 (class 1259 OID 45434)
-- Name: Proyectos_flujo_proyecto_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "Proyectos_flujo_proyecto_id" ON "Proyectos_flujo" USING btree (proyecto_id);


--
-- TOC entry 2079 (class 1259 OID 45435)
-- Name: Proyectos_flujo_sprint_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "Proyectos_flujo_sprint_id" ON "Proyectos_flujo" USING btree (sprint_id);


--
-- TOC entry 2064 (class 1259 OID 45430)
-- Name: Proyectos_proyecto_equipo_proyecto_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "Proyectos_proyecto_equipo_proyecto_id" ON "Proyectos_proyecto_equipo" USING btree (proyecto_id);


--
-- TOC entry 2067 (class 1259 OID 45431)
-- Name: Proyectos_proyecto_equipo_user_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "Proyectos_proyecto_equipo_user_id" ON "Proyectos_proyecto_equipo" USING btree (user_id);


--
-- TOC entry 2070 (class 1259 OID 45432)
-- Name: Proyectos_proyecto_nombre_like; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "Proyectos_proyecto_nombre_like" ON "Proyectos_proyecto" USING btree (nombre varchar_pattern_ops);


--
-- TOC entry 2075 (class 1259 OID 45433)
-- Name: Proyectos_sprint_proyecto_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "Proyectos_sprint_proyecto_id" ON "Proyectos_sprint" USING btree (proyecto_id);


--
-- TOC entry 2083 (class 1259 OID 45441)
-- Name: Proyectos_userstory_actividad_flujo_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "Proyectos_userstory_actividad_flujo_id" ON "Proyectos_userstory" USING btree (actividad_flujo_id);


--
-- TOC entry 2084 (class 1259 OID 45440)
-- Name: Proyectos_userstory_flujo_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "Proyectos_userstory_flujo_id" ON "Proyectos_userstory" USING btree (flujo_id);


--
-- TOC entry 2087 (class 1259 OID 45437)
-- Name: Proyectos_userstory_proyecto_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "Proyectos_userstory_proyecto_id" ON "Proyectos_userstory" USING btree (proyecto_id);


--
-- TOC entry 2088 (class 1259 OID 45439)
-- Name: Proyectos_userstory_sprint_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "Proyectos_userstory_sprint_id" ON "Proyectos_userstory" USING btree (sprint_id);


--
-- TOC entry 2089 (class 1259 OID 45438)
-- Name: Proyectos_userstory_usuario_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "Proyectos_userstory_usuario_id" ON "Proyectos_userstory" USING btree (usuario_id);


--
-- TOC entry 2039 (class 1259 OID 45423)
-- Name: auth_group_name_like; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX auth_group_name_like ON auth_group USING btree (name varchar_pattern_ops);


--
-- TOC entry 2031 (class 1259 OID 45421)
-- Name: auth_group_permissions_group_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX auth_group_permissions_group_id ON auth_group_permissions USING btree (group_id);


--
-- TOC entry 2034 (class 1259 OID 45422)
-- Name: auth_group_permissions_permission_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX auth_group_permissions_permission_id ON auth_group_permissions USING btree (permission_id);


--
-- TOC entry 2026 (class 1259 OID 45420)
-- Name: auth_permission_content_type_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX auth_permission_content_type_id ON auth_permission USING btree (content_type_id);


--
-- TOC entry 2061 (class 1259 OID 45429)
-- Name: auth_rol_proyecto_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX auth_rol_proyecto_id ON auth_rol USING btree (proyecto_id);


--
-- TOC entry 2042 (class 1259 OID 45425)
-- Name: auth_user_groups_group_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX auth_user_groups_group_id ON auth_user_groups USING btree (group_id);


--
-- TOC entry 2045 (class 1259 OID 45424)
-- Name: auth_user_groups_user_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX auth_user_groups_user_id ON auth_user_groups USING btree (user_id);


--
-- TOC entry 2048 (class 1259 OID 45427)
-- Name: auth_user_user_permissions_permission_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX auth_user_user_permissions_permission_id ON auth_user_user_permissions USING btree (permission_id);


--
-- TOC entry 2051 (class 1259 OID 45426)
-- Name: auth_user_user_permissions_user_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX auth_user_user_permissions_user_id ON auth_user_user_permissions USING btree (user_id);


--
-- TOC entry 2058 (class 1259 OID 45428)
-- Name: auth_user_username_like; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX auth_user_username_like ON auth_user USING btree (username varchar_pattern_ops);


--
-- TOC entry 2097 (class 1259 OID 45475)
-- Name: django_admin_log_417f1b1c; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX django_admin_log_417f1b1c ON django_admin_log USING btree (content_type_id);


--
-- TOC entry 2098 (class 1259 OID 45476)
-- Name: django_admin_log_e8701ad4; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX django_admin_log_e8701ad4 ON django_admin_log USING btree (user_id);


--
-- TOC entry 2101 (class 1259 OID 45485)
-- Name: django_session_de54fa62; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX django_session_de54fa62 ON django_session USING btree (expire_date);


--
-- TOC entry 2104 (class 1259 OID 45486)
-- Name: django_session_session_key_630ca218_like; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX django_session_session_key_630ca218_like ON django_session USING btree (session_key varchar_pattern_ops);


--
-- TOC entry 2118 (class 2606 OID 45363)
-- Name: Proyectos_actividad_flujo_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Proyectos_actividad"
    ADD CONSTRAINT "Proyectos_actividad_flujo_id_fkey" FOREIGN KEY (flujo_id) REFERENCES "Proyectos_flujo"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 2124 (class 2606 OID 45415)
-- Name: Proyectos_comentario_userstory_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Proyectos_comentario"
    ADD CONSTRAINT "Proyectos_comentario_userstory_id_fkey" FOREIGN KEY (userstory_id) REFERENCES "Proyectos_userstory"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 2116 (class 2606 OID 45345)
-- Name: Proyectos_flujo_proyecto_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Proyectos_flujo"
    ADD CONSTRAINT "Proyectos_flujo_proyecto_id_fkey" FOREIGN KEY (proyecto_id) REFERENCES "Proyectos_proyecto"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 2117 (class 2606 OID 45350)
-- Name: Proyectos_flujo_sprint_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Proyectos_flujo"
    ADD CONSTRAINT "Proyectos_flujo_sprint_id_fkey" FOREIGN KEY (sprint_id) REFERENCES "Proyectos_sprint"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 2113 (class 2606 OID 45290)
-- Name: Proyectos_proyecto_equipo_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Proyectos_proyecto_equipo"
    ADD CONSTRAINT "Proyectos_proyecto_equipo_user_id_fkey" FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 2115 (class 2606 OID 45329)
-- Name: Proyectos_sprint_proyecto_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Proyectos_sprint"
    ADD CONSTRAINT "Proyectos_sprint_proyecto_id_fkey" FOREIGN KEY (proyecto_id) REFERENCES "Proyectos_proyecto"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 2123 (class 2606 OID 45399)
-- Name: Proyectos_userstory_actividad_flujo_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Proyectos_userstory"
    ADD CONSTRAINT "Proyectos_userstory_actividad_flujo_id_fkey" FOREIGN KEY (actividad_flujo_id) REFERENCES "Proyectos_actividad"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 2122 (class 2606 OID 45394)
-- Name: Proyectos_userstory_flujo_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Proyectos_userstory"
    ADD CONSTRAINT "Proyectos_userstory_flujo_id_fkey" FOREIGN KEY (flujo_id) REFERENCES "Proyectos_flujo"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 2119 (class 2606 OID 45379)
-- Name: Proyectos_userstory_proyecto_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Proyectos_userstory"
    ADD CONSTRAINT "Proyectos_userstory_proyecto_id_fkey" FOREIGN KEY (proyecto_id) REFERENCES "Proyectos_proyecto"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 2121 (class 2606 OID 45389)
-- Name: Proyectos_userstory_sprint_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Proyectos_userstory"
    ADD CONSTRAINT "Proyectos_userstory_sprint_id_fkey" FOREIGN KEY (sprint_id) REFERENCES "Proyectos_sprint"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 2120 (class 2606 OID 45384)
-- Name: Proyectos_userstory_usuario_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Proyectos_userstory"
    ADD CONSTRAINT "Proyectos_userstory_usuario_id_fkey" FOREIGN KEY (usuario_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 2105 (class 2606 OID 45200)
-- Name: auth_group_permissions_permission_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_permission_id_fkey FOREIGN KEY (permission_id) REFERENCES auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 2111 (class 2606 OID 45275)
-- Name: auth_rol_group_ptr_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_rol
    ADD CONSTRAINT auth_rol_group_ptr_id_fkey FOREIGN KEY (group_ptr_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 2107 (class 2606 OID 45230)
-- Name: auth_user_groups_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_fkey FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 2109 (class 2606 OID 45245)
-- Name: auth_user_user_permissions_permission_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_permission_id_fkey FOREIGN KEY (permission_id) REFERENCES auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 2125 (class 2606 OID 45465)
-- Name: django_admin_content_type_id_5151027a_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_content_type_id_5151027a_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 2126 (class 2606 OID 45470)
-- Name: django_admin_log_user_id_1c5f563_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_1c5f563_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 2106 (class 2606 OID 45215)
-- Name: group_id_refs_id_f4b32aac; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT group_id_refs_id_f4b32aac FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 2114 (class 2606 OID 45313)
-- Name: proyecto_id_refs_id_5dbe1fd0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Proyectos_proyecto_equipo"
    ADD CONSTRAINT proyecto_id_refs_id_5dbe1fd0 FOREIGN KEY (proyecto_id) REFERENCES "Proyectos_proyecto"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 2112 (class 2606 OID 45308)
-- Name: proyecto_id_refs_id_b2802eb9; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_rol
    ADD CONSTRAINT proyecto_id_refs_id_b2802eb9 FOREIGN KEY (proyecto_id) REFERENCES "Proyectos_proyecto"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 2108 (class 2606 OID 45260)
-- Name: user_id_refs_id_40c41112; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT user_id_refs_id_40c41112 FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 2110 (class 2606 OID 45265)
-- Name: user_id_refs_id_4dc23c39; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT user_id_refs_id_4dc23c39 FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 2274 (class 0 OID 0)
-- Dependencies: 5
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2015-05-01 18:03:12 PYT

--
-- PostgreSQL database dump complete
--

