--
-- PostgreSQL database dump
--

-- Dumped from database version 9.3.8
-- Dumped by pg_dump version 9.3.8
-- Started on 2015-06-19 21:20:16 PYT

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

DROP DATABASE "taguatoBD";
--
-- TOC entry 2328 (class 1262 OID 18501)
-- Name: taguatoBD; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE "taguatoBD" WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'es_PY.UTF-8' LC_CTYPE = 'es_PY.UTF-8';


ALTER DATABASE "taguatoBD" OWNER TO postgres;

\connect "taguatoBD"

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
-- TOC entry 2329 (class 0 OID 0)
-- Dependencies: 5
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- TOC entry 212 (class 3079 OID 11829)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2331 (class 0 OID 0)
-- Dependencies: 212
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 192 (class 1259 OID 18669)
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
-- TOC entry 191 (class 1259 OID 18667)
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
-- TOC entry 2332 (class 0 OID 0)
-- Dependencies: 191
-- Name: Proyectos_actividad_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "Proyectos_actividad_id_seq" OWNED BY "Proyectos_actividad".id;


--
-- TOC entry 200 (class 1259 OID 18755)
-- Name: Proyectos_archivoadjunto; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "Proyectos_archivoadjunto" (
    id integer NOT NULL,
    userstory_id integer NOT NULL,
    archivo character varying(100) NOT NULL
);


ALTER TABLE public."Proyectos_archivoadjunto" OWNER TO postgres;

--
-- TOC entry 199 (class 1259 OID 18753)
-- Name: Proyectos_archivoadjunto_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "Proyectos_archivoadjunto_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Proyectos_archivoadjunto_id_seq" OWNER TO postgres;

--
-- TOC entry 2333 (class 0 OID 0)
-- Dependencies: 199
-- Name: Proyectos_archivoadjunto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "Proyectos_archivoadjunto_id_seq" OWNED BY "Proyectos_archivoadjunto".id;


--
-- TOC entry 198 (class 1259 OID 18739)
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
-- TOC entry 197 (class 1259 OID 18737)
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
-- TOC entry 2334 (class 0 OID 0)
-- Dependencies: 197
-- Name: Proyectos_comentario_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "Proyectos_comentario_id_seq" OWNED BY "Proyectos_comentario".id;


--
-- TOC entry 194 (class 1259 OID 18677)
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
-- TOC entry 193 (class 1259 OID 18675)
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
-- TOC entry 2335 (class 0 OID 0)
-- Dependencies: 193
-- Name: Proyectos_flujo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "Proyectos_flujo_id_seq" OWNED BY "Proyectos_flujo".id;


--
-- TOC entry 188 (class 1259 OID 18630)
-- Name: Proyectos_proyecto; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "Proyectos_proyecto" (
    id integer NOT NULL,
    nombre character varying(50) NOT NULL,
    descripcion text NOT NULL,
    estado character varying(3) NOT NULL,
    fecha_creacion date,
    fecha_inicio date,
    fecha_finalizacion date
);


ALTER TABLE public."Proyectos_proyecto" OWNER TO postgres;

--
-- TOC entry 186 (class 1259 OID 18615)
-- Name: Proyectos_proyecto_equipo; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "Proyectos_proyecto_equipo" (
    id integer NOT NULL,
    proyecto_id integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public."Proyectos_proyecto_equipo" OWNER TO postgres;

--
-- TOC entry 185 (class 1259 OID 18613)
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
-- TOC entry 2336 (class 0 OID 0)
-- Dependencies: 185
-- Name: Proyectos_proyecto_equipo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "Proyectos_proyecto_equipo_id_seq" OWNED BY "Proyectos_proyecto_equipo".id;


--
-- TOC entry 187 (class 1259 OID 18628)
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
-- TOC entry 2337 (class 0 OID 0)
-- Dependencies: 187
-- Name: Proyectos_proyecto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "Proyectos_proyecto_id_seq" OWNED BY "Proyectos_proyecto".id;


--
-- TOC entry 204 (class 1259 OID 18796)
-- Name: Proyectos_release; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "Proyectos_release" (
    id integer NOT NULL,
    proyecto_id integer NOT NULL,
    fecha timestamp with time zone NOT NULL
);


ALTER TABLE public."Proyectos_release" OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 18794)
-- Name: Proyectos_release_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "Proyectos_release_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Proyectos_release_id_seq" OWNER TO postgres;

--
-- TOC entry 2338 (class 0 OID 0)
-- Dependencies: 203
-- Name: Proyectos_release_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "Proyectos_release_id_seq" OWNED BY "Proyectos_release".id;


--
-- TOC entry 202 (class 1259 OID 18781)
-- Name: Proyectos_release_userstories; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "Proyectos_release_userstories" (
    id integer NOT NULL,
    release_id integer NOT NULL,
    userstory_id integer NOT NULL
);


ALTER TABLE public."Proyectos_release_userstories" OWNER TO postgres;

--
-- TOC entry 201 (class 1259 OID 18779)
-- Name: Proyectos_release_userstories_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "Proyectos_release_userstories_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Proyectos_release_userstories_id_seq" OWNER TO postgres;

--
-- TOC entry 2339 (class 0 OID 0)
-- Dependencies: 201
-- Name: Proyectos_release_userstories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "Proyectos_release_userstories_id_seq" OWNED BY "Proyectos_release_userstories".id;


--
-- TOC entry 190 (class 1259 OID 18653)
-- Name: Proyectos_sprint; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "Proyectos_sprint" (
    id integer NOT NULL,
    "nombreSprint" character varying(50) NOT NULL,
    fecha_inicio date NOT NULL,
    fecha_fin date NOT NULL,
    descripcion text NOT NULL,
    proyecto_id integer NOT NULL,
    finalizado boolean NOT NULL
);


ALTER TABLE public."Proyectos_sprint" OWNER TO postgres;

--
-- TOC entry 189 (class 1259 OID 18651)
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
-- TOC entry 2340 (class 0 OID 0)
-- Dependencies: 189
-- Name: Proyectos_sprint_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "Proyectos_sprint_id_seq" OWNED BY "Proyectos_sprint".id;


--
-- TOC entry 211 (class 1259 OID 18917)
-- Name: Proyectos_timeline; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "Proyectos_timeline" (
    id integer NOT NULL,
    userstory_id integer NOT NULL,
    horas integer NOT NULL,
    fecha date NOT NULL,
    horas_restantes_sprint integer NOT NULL,
    horas_restantes_proyecto integer NOT NULL
);


ALTER TABLE public."Proyectos_timeline" OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 18915)
-- Name: Proyectos_timeline_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "Proyectos_timeline_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Proyectos_timeline_id_seq" OWNER TO postgres;

--
-- TOC entry 2341 (class 0 OID 0)
-- Dependencies: 210
-- Name: Proyectos_timeline_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "Proyectos_timeline_id_seq" OWNED BY "Proyectos_timeline".id;


--
-- TOC entry 196 (class 1259 OID 18703)
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
    estado_sprint character varying(1),
    backlog boolean NOT NULL
);


ALTER TABLE public."Proyectos_userstory" OWNER TO postgres;

--
-- TOC entry 195 (class 1259 OID 18701)
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
-- TOC entry 2342 (class 0 OID 0)
-- Dependencies: 195
-- Name: Proyectos_userstory_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "Proyectos_userstory_id_seq" OWNED BY "Proyectos_userstory".id;


--
-- TOC entry 177 (class 1259 OID 18540)
-- Name: auth_group; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE auth_group (
    id integer NOT NULL,
    name character varying(80) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO postgres;

--
-- TOC entry 176 (class 1259 OID 18538)
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
-- TOC entry 2343 (class 0 OID 0)
-- Dependencies: 176
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE auth_group_id_seq OWNED BY auth_group.id;


--
-- TOC entry 175 (class 1259 OID 18525)
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO postgres;

--
-- TOC entry 174 (class 1259 OID 18523)
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
-- TOC entry 2344 (class 0 OID 0)
-- Dependencies: 174
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE auth_group_permissions_id_seq OWNED BY auth_group_permissions.id;


--
-- TOC entry 173 (class 1259 OID 18515)
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
-- TOC entry 172 (class 1259 OID 18513)
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
-- TOC entry 2345 (class 0 OID 0)
-- Dependencies: 172
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE auth_permission_id_seq OWNED BY auth_permission.id;


--
-- TOC entry 184 (class 1259 OID 18603)
-- Name: auth_rol; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE auth_rol (
    group_ptr_id integer NOT NULL,
    proyecto_id integer NOT NULL
);


ALTER TABLE public.auth_rol OWNER TO postgres;

--
-- TOC entry 183 (class 1259 OID 18585)
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
-- TOC entry 179 (class 1259 OID 18555)
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE auth_user_groups (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.auth_user_groups OWNER TO postgres;

--
-- TOC entry 178 (class 1259 OID 18553)
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
-- TOC entry 2346 (class 0 OID 0)
-- Dependencies: 178
-- Name: auth_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE auth_user_groups_id_seq OWNED BY auth_user_groups.id;


--
-- TOC entry 182 (class 1259 OID 18583)
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
-- TOC entry 2347 (class 0 OID 0)
-- Dependencies: 182
-- Name: auth_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE auth_user_id_seq OWNED BY auth_user.id;


--
-- TOC entry 181 (class 1259 OID 18570)
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE auth_user_user_permissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_user_user_permissions OWNER TO postgres;

--
-- TOC entry 180 (class 1259 OID 18568)
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
-- TOC entry 2348 (class 0 OID 0)
-- Dependencies: 180
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE auth_user_user_permissions_id_seq OWNED BY auth_user_user_permissions.id;


--
-- TOC entry 208 (class 1259 OID 18852)
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
-- TOC entry 207 (class 1259 OID 18850)
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
-- TOC entry 2349 (class 0 OID 0)
-- Dependencies: 207
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE django_admin_log_id_seq OWNED BY django_admin_log.id;


--
-- TOC entry 206 (class 1259 OID 18842)
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
-- TOC entry 205 (class 1259 OID 18840)
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
-- TOC entry 2350 (class 0 OID 0)
-- Dependencies: 205
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE django_content_type_id_seq OWNED BY django_content_type.id;


--
-- TOC entry 171 (class 1259 OID 18504)
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
-- TOC entry 170 (class 1259 OID 18502)
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
-- TOC entry 2351 (class 0 OID 0)
-- Dependencies: 170
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE django_migrations_id_seq OWNED BY django_migrations.id;


--
-- TOC entry 209 (class 1259 OID 18874)
-- Name: django_session; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO postgres;

--
-- TOC entry 2041 (class 2604 OID 18672)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Proyectos_actividad" ALTER COLUMN id SET DEFAULT nextval('"Proyectos_actividad_id_seq"'::regclass);


--
-- TOC entry 2045 (class 2604 OID 18758)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Proyectos_archivoadjunto" ALTER COLUMN id SET DEFAULT nextval('"Proyectos_archivoadjunto_id_seq"'::regclass);


--
-- TOC entry 2044 (class 2604 OID 18742)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Proyectos_comentario" ALTER COLUMN id SET DEFAULT nextval('"Proyectos_comentario_id_seq"'::regclass);


--
-- TOC entry 2042 (class 2604 OID 18680)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Proyectos_flujo" ALTER COLUMN id SET DEFAULT nextval('"Proyectos_flujo_id_seq"'::regclass);


--
-- TOC entry 2039 (class 2604 OID 18633)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Proyectos_proyecto" ALTER COLUMN id SET DEFAULT nextval('"Proyectos_proyecto_id_seq"'::regclass);


--
-- TOC entry 2038 (class 2604 OID 18618)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Proyectos_proyecto_equipo" ALTER COLUMN id SET DEFAULT nextval('"Proyectos_proyecto_equipo_id_seq"'::regclass);


--
-- TOC entry 2047 (class 2604 OID 18799)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Proyectos_release" ALTER COLUMN id SET DEFAULT nextval('"Proyectos_release_id_seq"'::regclass);


--
-- TOC entry 2046 (class 2604 OID 18784)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Proyectos_release_userstories" ALTER COLUMN id SET DEFAULT nextval('"Proyectos_release_userstories_id_seq"'::regclass);


--
-- TOC entry 2040 (class 2604 OID 18656)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Proyectos_sprint" ALTER COLUMN id SET DEFAULT nextval('"Proyectos_sprint_id_seq"'::regclass);


--
-- TOC entry 2051 (class 2604 OID 18920)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Proyectos_timeline" ALTER COLUMN id SET DEFAULT nextval('"Proyectos_timeline_id_seq"'::regclass);


--
-- TOC entry 2043 (class 2604 OID 18706)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Proyectos_userstory" ALTER COLUMN id SET DEFAULT nextval('"Proyectos_userstory_id_seq"'::regclass);


--
-- TOC entry 2034 (class 2604 OID 18543)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_group ALTER COLUMN id SET DEFAULT nextval('auth_group_id_seq'::regclass);


--
-- TOC entry 2033 (class 2604 OID 18528)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('auth_group_permissions_id_seq'::regclass);


--
-- TOC entry 2032 (class 2604 OID 18518)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_permission ALTER COLUMN id SET DEFAULT nextval('auth_permission_id_seq'::regclass);


--
-- TOC entry 2037 (class 2604 OID 18588)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_user ALTER COLUMN id SET DEFAULT nextval('auth_user_id_seq'::regclass);


--
-- TOC entry 2035 (class 2604 OID 18558)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_user_groups ALTER COLUMN id SET DEFAULT nextval('auth_user_groups_id_seq'::regclass);


--
-- TOC entry 2036 (class 2604 OID 18573)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('auth_user_user_permissions_id_seq'::regclass);


--
-- TOC entry 2049 (class 2604 OID 18855)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY django_admin_log ALTER COLUMN id SET DEFAULT nextval('django_admin_log_id_seq'::regclass);


--
-- TOC entry 2048 (class 2604 OID 18845)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY django_content_type ALTER COLUMN id SET DEFAULT nextval('django_content_type_id_seq'::regclass);


--
-- TOC entry 2031 (class 2604 OID 18507)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY django_migrations ALTER COLUMN id SET DEFAULT nextval('django_migrations_id_seq'::regclass);


--
-- TOC entry 2304 (class 0 OID 18669)
-- Dependencies: 192
-- Data for Name: Proyectos_actividad; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "Proyectos_actividad" (id, nombre, descripcion, flujo_id, orden) VALUES (1, 'actividad 1', 'descripción actividad 1', 1, 1);
INSERT INTO "Proyectos_actividad" (id, nombre, descripcion, flujo_id, orden) VALUES (2, 'actividad 2', 'descripción actividad 2', 1, 2);
INSERT INTO "Proyectos_actividad" (id, nombre, descripcion, flujo_id, orden) VALUES (3, 'actividad 1', 'descripción actividad 1', 2, 1);
INSERT INTO "Proyectos_actividad" (id, nombre, descripcion, flujo_id, orden) VALUES (4, 'actividad 2', 'descripción actividad 2', 2, 2);
INSERT INTO "Proyectos_actividad" (id, nombre, descripcion, flujo_id, orden) VALUES (5, 'actividad 3', 'descripción actividad 3', 2, 3);


--
-- TOC entry 2352 (class 0 OID 0)
-- Dependencies: 191
-- Name: Proyectos_actividad_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"Proyectos_actividad_id_seq"', 5, true);


--
-- TOC entry 2312 (class 0 OID 18755)
-- Dependencies: 200
-- Data for Name: Proyectos_archivoadjunto; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "Proyectos_archivoadjunto" (id, userstory_id, archivo) VALUES (1, 7, './dragon_ball___kid_goku_14___dragon_box_by_superjmanplay2-d4p09wr.png');


--
-- TOC entry 2353 (class 0 OID 0)
-- Dependencies: 199
-- Name: Proyectos_archivoadjunto_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"Proyectos_archivoadjunto_id_seq"', 1, true);


--
-- TOC entry 2310 (class 0 OID 18739)
-- Dependencies: 198
-- Data for Name: Proyectos_comentario; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "Proyectos_comentario" (id, texto, fecha, userstory_id, username) VALUES (1, 'adfadfad', '2015-05-11 10:44:46-04', 7, 'miguel');


--
-- TOC entry 2354 (class 0 OID 0)
-- Dependencies: 197
-- Name: Proyectos_comentario_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"Proyectos_comentario_id_seq"', 1, true);


--
-- TOC entry 2306 (class 0 OID 18677)
-- Dependencies: 194
-- Data for Name: Proyectos_flujo; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "Proyectos_flujo" (id, proyecto_id, sprint_id, nombre, descripcion) VALUES (1, 1, 1, 'Flujo 1', 'Descripción Flujo 1');
INSERT INTO "Proyectos_flujo" (id, proyecto_id, sprint_id, nombre, descripcion) VALUES (2, 1, 1, 'Flujo 2', 'Descripción Flujo 2');


--
-- TOC entry 2355 (class 0 OID 0)
-- Dependencies: 193
-- Name: Proyectos_flujo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"Proyectos_flujo_id_seq"', 2, true);


--
-- TOC entry 2300 (class 0 OID 18630)
-- Dependencies: 188
-- Data for Name: Proyectos_proyecto; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "Proyectos_proyecto" (id, nombre, descripcion, estado, fecha_creacion, fecha_inicio, fecha_finalizacion) VALUES (1, 'Proyecto 1', 'Descripción Proyecto 1', 'NOI', '2015-06-11', '2015-06-05', '2015-06-30');
INSERT INTO "Proyectos_proyecto" (id, nombre, descripcion, estado, fecha_creacion, fecha_inicio, fecha_finalizacion) VALUES (2, 'Proyecto 2', 'Descripción Proyecto 2', 'NOI', '2015-06-19', '2015-06-19', '2015-06-20');


--
-- TOC entry 2298 (class 0 OID 18615)
-- Dependencies: 186
-- Data for Name: Proyectos_proyecto_equipo; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "Proyectos_proyecto_equipo" (id, proyecto_id, user_id) VALUES (2, 1, 2);


--
-- TOC entry 2356 (class 0 OID 0)
-- Dependencies: 185
-- Name: Proyectos_proyecto_equipo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"Proyectos_proyecto_equipo_id_seq"', 2, true);


--
-- TOC entry 2357 (class 0 OID 0)
-- Dependencies: 187
-- Name: Proyectos_proyecto_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"Proyectos_proyecto_id_seq"', 2, true);


--
-- TOC entry 2316 (class 0 OID 18796)
-- Dependencies: 204
-- Data for Name: Proyectos_release; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2358 (class 0 OID 0)
-- Dependencies: 203
-- Name: Proyectos_release_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"Proyectos_release_id_seq"', 1, false);


--
-- TOC entry 2314 (class 0 OID 18781)
-- Dependencies: 202
-- Data for Name: Proyectos_release_userstories; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2359 (class 0 OID 0)
-- Dependencies: 201
-- Name: Proyectos_release_userstories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"Proyectos_release_userstories_id_seq"', 1, false);


--
-- TOC entry 2302 (class 0 OID 18653)
-- Dependencies: 190
-- Data for Name: Proyectos_sprint; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "Proyectos_sprint" (id, "nombreSprint", fecha_inicio, fecha_fin, descripcion, proyecto_id, finalizado) VALUES (1, 'Sprint 1', '2015-06-05', '2015-06-10', 'Descripción Sprint 1', 1, true);
INSERT INTO "Proyectos_sprint" (id, "nombreSprint", fecha_inicio, fecha_fin, descripcion, proyecto_id, finalizado) VALUES (2, 'Sprint 2', '2015-06-10', '2015-06-10', 'Descripción Sprint 2', 1, true);


--
-- TOC entry 2360 (class 0 OID 0)
-- Dependencies: 189
-- Name: Proyectos_sprint_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"Proyectos_sprint_id_seq"', 2, true);


--
-- TOC entry 2323 (class 0 OID 18917)
-- Dependencies: 211
-- Data for Name: Proyectos_timeline; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "Proyectos_timeline" (id, userstory_id, horas, fecha, horas_restantes_sprint, horas_restantes_proyecto) VALUES (1, 1, 10, '2015-06-06', 50, 65);
INSERT INTO "Proyectos_timeline" (id, userstory_id, horas, fecha, horas_restantes_sprint, horas_restantes_proyecto) VALUES (2, 2, 11, '2015-06-06', 39, 54);
INSERT INTO "Proyectos_timeline" (id, userstory_id, horas, fecha, horas_restantes_sprint, horas_restantes_proyecto) VALUES (3, 3, 12, '2015-06-07', 27, 42);
INSERT INTO "Proyectos_timeline" (id, userstory_id, horas, fecha, horas_restantes_sprint, horas_restantes_proyecto) VALUES (4, 4, 13, '2015-06-08', 14, 29);
INSERT INTO "Proyectos_timeline" (id, userstory_id, horas, fecha, horas_restantes_sprint, horas_restantes_proyecto) VALUES (5, 5, 14, '2015-06-09', 0, 15);
INSERT INTO "Proyectos_timeline" (id, userstory_id, horas, fecha, horas_restantes_sprint, horas_restantes_proyecto) VALUES (6, 6, 10, '2015-06-10', 5, 5);


--
-- TOC entry 2361 (class 0 OID 0)
-- Dependencies: 210
-- Name: Proyectos_timeline_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"Proyectos_timeline_id_seq"', 6, true);


--
-- TOC entry 2308 (class 0 OID 18703)
-- Dependencies: 196
-- Data for Name: Proyectos_userstory; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "Proyectos_userstory" (id, "nombreUS", tiempo_estimado, tiempo_trabajado, descripcion, prioridad, proyecto_id, usuario_id, sprint_id, flujo_id, actividad_flujo_id, estado_actividad, estado_sprint, backlog) VALUES (8, 'backlog US', 10, 0, 'adfadsf', 'N', 1, NULL, NULL, NULL, NULL, 'TO', 'N', true);
INSERT INTO "Proyectos_userstory" (id, "nombreUS", tiempo_estimado, tiempo_trabajado, descripcion, prioridad, proyecto_id, usuario_id, sprint_id, flujo_id, actividad_flujo_id, estado_actividad, estado_sprint, backlog) VALUES (6, 'US6', 15, 10, 'Descripción US6', 'N', 1, 1, 2, 2, 3, 'DG', 'F', false);
INSERT INTO "Proyectos_userstory" (id, "nombreUS", tiempo_estimado, tiempo_trabajado, descripcion, prioridad, proyecto_id, usuario_id, sprint_id, flujo_id, actividad_flujo_id, estado_actividad, estado_sprint, backlog) VALUES (7, 'US de Miguel', 20, 0, 'Descripción US de Miguel', 'N', 1, 2, 2, NULL, NULL, 'TO', 'B', false);
INSERT INTO "Proyectos_userstory" (id, "nombreUS", tiempo_estimado, tiempo_trabajado, descripcion, prioridad, proyecto_id, usuario_id, sprint_id, flujo_id, actividad_flujo_id, estado_actividad, estado_sprint, backlog) VALUES (2, 'US2', 11, 11, 'Descripción US2', 'N', 1, 1, 2, 1, 1, 'DG', 'F', false);
INSERT INTO "Proyectos_userstory" (id, "nombreUS", tiempo_estimado, tiempo_trabajado, descripcion, prioridad, proyecto_id, usuario_id, sprint_id, flujo_id, actividad_flujo_id, estado_actividad, estado_sprint, backlog) VALUES (3, 'US3', 12, 12, 'Descripción US3', 'N', 1, 1, 2, 1, 1, 'DG', 'F', false);
INSERT INTO "Proyectos_userstory" (id, "nombreUS", tiempo_estimado, tiempo_trabajado, descripcion, prioridad, proyecto_id, usuario_id, sprint_id, flujo_id, actividad_flujo_id, estado_actividad, estado_sprint, backlog) VALUES (4, 'US4', 13, 13, 'Descripción US4', 'N', 1, 1, 2, 1, 1, 'DG', 'F', false);
INSERT INTO "Proyectos_userstory" (id, "nombreUS", tiempo_estimado, tiempo_trabajado, descripcion, prioridad, proyecto_id, usuario_id, sprint_id, flujo_id, actividad_flujo_id, estado_actividad, estado_sprint, backlog) VALUES (5, 'US5', 14, 14, 'Descripción US5', 'N', 1, 1, 2, 1, 1, 'DG', 'F', false);
INSERT INTO "Proyectos_userstory" (id, "nombreUS", tiempo_estimado, tiempo_trabajado, descripcion, prioridad, proyecto_id, usuario_id, sprint_id, flujo_id, actividad_flujo_id, estado_actividad, estado_sprint, backlog) VALUES (1, 'US1', 10, 10, 'Descripción US1', 'N', 1, 1, 2, 1, 2, 'TO', 'F', false);


--
-- TOC entry 2362 (class 0 OID 0)
-- Dependencies: 195
-- Name: Proyectos_userstory_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"Proyectos_userstory_id_seq"', 8, true);


--
-- TOC entry 2289 (class 0 OID 18540)
-- Dependencies: 177
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO auth_group (id, name) VALUES (1, 'admin');


--
-- TOC entry 2363 (class 0 OID 0)
-- Dependencies: 176
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('auth_group_id_seq', 1, true);


--
-- TOC entry 2287 (class 0 OID 18525)
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
INSERT INTO auth_group_permissions (id, group_id, permission_id) VALUES (53, 1, 53);
INSERT INTO auth_group_permissions (id, group_id, permission_id) VALUES (54, 1, 54);
INSERT INTO auth_group_permissions (id, group_id, permission_id) VALUES (55, 1, 55);
INSERT INTO auth_group_permissions (id, group_id, permission_id) VALUES (56, 1, 56);
INSERT INTO auth_group_permissions (id, group_id, permission_id) VALUES (57, 1, 57);
INSERT INTO auth_group_permissions (id, group_id, permission_id) VALUES (58, 1, 58);
INSERT INTO auth_group_permissions (id, group_id, permission_id) VALUES (59, 1, 59);
INSERT INTO auth_group_permissions (id, group_id, permission_id) VALUES (60, 1, 60);
INSERT INTO auth_group_permissions (id, group_id, permission_id) VALUES (61, 1, 61);
INSERT INTO auth_group_permissions (id, group_id, permission_id) VALUES (62, 1, 62);
INSERT INTO auth_group_permissions (id, group_id, permission_id) VALUES (63, 1, 63);
INSERT INTO auth_group_permissions (id, group_id, permission_id) VALUES (64, 1, 64);
INSERT INTO auth_group_permissions (id, group_id, permission_id) VALUES (65, 1, 65);


--
-- TOC entry 2364 (class 0 OID 0)
-- Dependencies: 174
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('auth_group_permissions_id_seq', 65, true);


--
-- TOC entry 2285 (class 0 OID 18515)
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
INSERT INTO auth_permission (id, name, content_type_id, codename) VALUES (34, 'Can add Actividad', 11, 'add_actividad');
INSERT INTO auth_permission (id, name, content_type_id, codename) VALUES (35, 'Can change Actividad', 11, 'change_actividad');
INSERT INTO auth_permission (id, name, content_type_id, codename) VALUES (36, 'Can delete Actividad', 11, 'delete_actividad');
INSERT INTO auth_permission (id, name, content_type_id, codename) VALUES (37, 'can view actividad', 11, 'view_actividad');
INSERT INTO auth_permission (id, name, content_type_id, codename) VALUES (38, 'Can add flujo', 12, 'add_flujo');
INSERT INTO auth_permission (id, name, content_type_id, codename) VALUES (39, 'Can change flujo', 12, 'change_flujo');
INSERT INTO auth_permission (id, name, content_type_id, codename) VALUES (40, 'Can delete flujo', 12, 'delete_flujo');
INSERT INTO auth_permission (id, name, content_type_id, codename) VALUES (41, 'Can view flujo', 12, 'view_flujo');
INSERT INTO auth_permission (id, name, content_type_id, codename) VALUES (42, 'Can add User Story', 13, 'add_userstory');
INSERT INTO auth_permission (id, name, content_type_id, codename) VALUES (43, 'Can change User Story', 13, 'change_userstory');
INSERT INTO auth_permission (id, name, content_type_id, codename) VALUES (44, 'Can delete User Story', 13, 'delete_userstory');
INSERT INTO auth_permission (id, name, content_type_id, codename) VALUES (45, 'Can view userstory', 13, 'view_userstory');
INSERT INTO auth_permission (id, name, content_type_id, codename) VALUES (46, 'Can add comentario', 14, 'add_comentario');
INSERT INTO auth_permission (id, name, content_type_id, codename) VALUES (47, 'Can change comentario', 14, 'change_comentario');
INSERT INTO auth_permission (id, name, content_type_id, codename) VALUES (48, 'Can delete comentario', 14, 'delete_comentario');
INSERT INTO auth_permission (id, name, content_type_id, codename) VALUES (49, 'can view comentario', 14, 'view_comentario');
INSERT INTO auth_permission (id, name, content_type_id, codename) VALUES (50, 'Can add Archivo Adjunto', 15, 'add_archivoadjunto');
INSERT INTO auth_permission (id, name, content_type_id, codename) VALUES (51, 'Can change Archivo Adjunto', 15, 'change_archivoadjunto');
INSERT INTO auth_permission (id, name, content_type_id, codename) VALUES (52, 'Can delete Archivo Adjunto', 15, 'delete_archivoadjunto');
INSERT INTO auth_permission (id, name, content_type_id, codename) VALUES (53, 'can view archivoadjunto', 15, 'view_archivoadjunto');
INSERT INTO auth_permission (id, name, content_type_id, codename) VALUES (54, 'Can add equipo', 9, 'add_equipo');
INSERT INTO auth_permission (id, name, content_type_id, codename) VALUES (55, 'Can change equipo', 9, 'change_equipo');
INSERT INTO auth_permission (id, name, content_type_id, codename) VALUES (56, 'Can delete equipo', 9, 'delete_equipo');
INSERT INTO auth_permission (id, name, content_type_id, codename) VALUES (57, 'Can add time line', 16, 'add_timeline');
INSERT INTO auth_permission (id, name, content_type_id, codename) VALUES (58, 'Can change time line', 16, 'change_timeline');
INSERT INTO auth_permission (id, name, content_type_id, codename) VALUES (59, 'Can delete time line', 16, 'delete_timeline');
INSERT INTO auth_permission (id, name, content_type_id, codename) VALUES (60, 'Can add Backlog', 13, 'add_backlog');
INSERT INTO auth_permission (id, name, content_type_id, codename) VALUES (61, 'Can change Backlog', 13, 'change_backlog');
INSERT INTO auth_permission (id, name, content_type_id, codename) VALUES (62, 'Can delete Backlog', 13, 'delete_backlog');
INSERT INTO auth_permission (id, name, content_type_id, codename) VALUES (63, 'Can add release', 17, 'add_release');
INSERT INTO auth_permission (id, name, content_type_id, codename) VALUES (64, 'Can change release', 17, 'change_release');
INSERT INTO auth_permission (id, name, content_type_id, codename) VALUES (65, 'Can delete release', 17, 'delete_release');


--
-- TOC entry 2365 (class 0 OID 0)
-- Dependencies: 172
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('auth_permission_id_seq', 65, true);


--
-- TOC entry 2296 (class 0 OID 18603)
-- Dependencies: 184
-- Data for Name: auth_rol; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO auth_rol (group_ptr_id, proyecto_id) VALUES (1, 1);


--
-- TOC entry 2295 (class 0 OID 18585)
-- Dependencies: 183
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) VALUES (2, 'pbkdf2_sha256$15000$DDTKIWHUNbv8$Df9Q24e19SxgMXqOd8aXBsjwck2SckhAAwumtp1ZV5g=', '2015-06-11 10:12:02.777943-04', false, 'miguel', 'Miguel', 'Fernández', '', true, true, '2015-06-11 10:10:17-04');
INSERT INTO auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) VALUES (1, 'pbkdf2_sha256$15000$f0cO8zk7kRM7$UTvS+Vqpny0QxVLwc7eXgOtANmHksb4Ky2uzLuNkUh0=', '2015-06-13 16:08:28.0147-04', true, 'admin', '', '', '', true, true, '2015-06-11 08:39:59.512911-04');


--
-- TOC entry 2291 (class 0 OID 18555)
-- Dependencies: 179
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO auth_user_groups (id, user_id, group_id) VALUES (1, 2, 1);


--
-- TOC entry 2366 (class 0 OID 0)
-- Dependencies: 178
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('auth_user_groups_id_seq', 1, true);


--
-- TOC entry 2367 (class 0 OID 0)
-- Dependencies: 182
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('auth_user_id_seq', 2, true);


--
-- TOC entry 2293 (class 0 OID 18570)
-- Dependencies: 181
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2368 (class 0 OID 0)
-- Dependencies: 180
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('auth_user_user_permissions_id_seq', 1, false);


--
-- TOC entry 2320 (class 0 OID 18852)
-- Dependencies: 208
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (1, '2015-06-11 08:42:00.078821-04', '1', 'Proyecto 1', 1, '', 9, 1);
INSERT INTO django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (2, '2015-06-11 08:44:05.153778-04', '1', 'Sprint 1', 1, '', 10, 1);
INSERT INTO django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (3, '2015-06-11 08:44:49.548811-04', '1', 'Flujo 1', 1, '', 12, 1);
INSERT INTO django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (4, '2015-06-11 08:45:51.794151-04', '2', 'Flujo 2', 1, '', 12, 1);
INSERT INTO django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (5, '2015-06-11 08:46:27.497291-04', '1', 'US1', 1, '', 19, 1);
INSERT INTO django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (6, '2015-06-11 08:46:51.652793-04', '2', 'US2', 1, '', 19, 1);
INSERT INTO django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (7, '2015-06-11 08:47:17.349288-04', '3', 'US3', 1, '', 19, 1);
INSERT INTO django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (8, '2015-06-11 08:47:40.954999-04', '4', 'US4', 1, '', 19, 1);
INSERT INTO django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (9, '2015-06-11 08:48:07.553961-04', '5', 'US5', 1, '', 19, 1);
INSERT INTO django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (10, '2015-06-11 08:48:26.887269-04', '6', 'US6', 1, '', 19, 1);
INSERT INTO django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (11, '2015-06-04 08:50:08.313817-04', '1', 'US1', 2, 'Modificado/a usuario, sprint y flujo.', 13, 1);
INSERT INTO django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (12, '2015-06-04 08:50:26.377357-04', '2', 'US2', 2, 'Modificado/a usuario, sprint y flujo.', 13, 1);
INSERT INTO django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (13, '2015-06-04 08:50:44.536785-04', '3', 'US3', 2, 'Modificado/a usuario, sprint y flujo.', 13, 1);
INSERT INTO django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (14, '2015-06-04 08:51:21.771879-04', '4', 'US4', 2, 'Modificado/a usuario, sprint y flujo.', 13, 1);
INSERT INTO django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (15, '2015-06-04 08:51:34.838987-04', '5', 'US5', 2, 'Modificado/a usuario, sprint y flujo.', 13, 1);
INSERT INTO django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (16, '2015-06-04 08:52:16.671419-04', '2', 'Sprint 2', 1, '', 10, 1);
INSERT INTO django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (17, '2015-06-04 08:52:31.682806-04', '6', 'US6', 2, 'Modificado/a usuario y sprint.', 13, 1);
INSERT INTO django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (18, '2015-06-06 08:55:16.260343-04', '1', 'US1', 2, 'Modificado/a tiempo_trabajado.', 13, 1);
INSERT INTO django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (19, '2015-06-06 09:01:35.37063-04', '1', 'US1', 2, 'Modificado/a tiempo_trabajado y estado_actividad.', 13, 1);
INSERT INTO django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (20, '2015-06-06 09:02:12.847777-04', '2', 'US2', 2, 'Modificado/a tiempo_trabajado.', 13, 1);
INSERT INTO django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (21, '2015-06-07 09:02:32.814803-04', '3', 'US3', 2, 'Modificado/a tiempo_trabajado.', 13, 1);
INSERT INTO django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (22, '2015-06-08 09:02:42.176137-04', '4', 'US4', 2, 'Modificado/a tiempo_trabajado.', 13, 1);
INSERT INTO django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (23, '2015-06-09 09:03:02.300294-04', '5', 'US5', 2, 'Modificado/a tiempo_trabajado.', 13, 1);
INSERT INTO django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (24, '2015-06-09 09:03:18.012854-04', '6', 'US6', 2, 'Modificado/a tiempo_trabajado y flujo.', 13, 1);
INSERT INTO django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (25, '2015-06-11 10:10:17.275711-04', '2', 'miguel', 1, '', 6, 1);
INSERT INTO django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (26, '2015-06-11 10:10:35.726874-04', '2', 'miguel', 2, 'Modificado/a is_staff.', 6, 1);
INSERT INTO django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (27, '2015-06-11 10:10:51.695576-04', '1', 'admin', 1, '', 5, 1);
INSERT INTO django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (28, '2015-06-11 10:11:40.669307-04', '2', 'miguel', 2, 'Modificado/a first_name y last_name.', 6, 1);
INSERT INTO django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (29, '2015-06-11 10:11:52.96498-04', '2', 'miguel', 2, 'Modificado/a last_name y groups.', 6, 1);
INSERT INTO django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (30, '2015-06-11 10:12:57.621434-04', '7', 'US de Miguel', 1, '', 13, 2);
INSERT INTO django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (31, '2015-06-11 10:31:26.153303-04', '7', 'US de Miguel', 2, 'Añadido/a "ArchivoAdjunto object" Archivo Adjunto.', 13, 2);
INSERT INTO django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (32, '2015-06-11 10:44:54.281399-04', '7', 'US de Miguel', 2, 'Añadido/a "2015-05-11 10:44:46-04:00" comentario.', 13, 2);
INSERT INTO django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (33, '2015-06-13 16:09:05.367378-04', '1', 'US1', 2, 'Modificado/a estado_actividad.', 13, 1);
INSERT INTO django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (34, '2015-06-13 16:09:59.436365-04', '1', 'Proyecto 1', 2, 'Modificado/a equipo.', 9, 1);
INSERT INTO django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (35, '2015-06-19 13:11:15.688286-04', '8', 'backlog US', 1, '', 19, 1);
INSERT INTO django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (36, '2015-06-19 15:19:48.875288-04', '1', 'Proyecto 1', 2, 'Modificado/a equipo.', 9, 1);
INSERT INTO django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (37, '2015-06-19 15:20:01.354521-04', '1', 'Proyecto 1', 2, 'Modificado/a equipo.', 9, 1);
INSERT INTO django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (38, '2015-06-19 16:01:46.914541-04', '2', 'Proyecto 2', 1, '', 9, 1);


--
-- TOC entry 2369 (class 0 OID 0)
-- Dependencies: 207
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('django_admin_log_id_seq', 38, true);


--
-- TOC entry 2318 (class 0 OID 18842)
-- Dependencies: 206
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
INSERT INTO django_content_type (id, name, app_label, model) VALUES (11, 'Actividad', 'Proyectos', 'actividad');
INSERT INTO django_content_type (id, name, app_label, model) VALUES (12, 'flujo', 'Proyectos', 'flujo');
INSERT INTO django_content_type (id, name, app_label, model) VALUES (13, 'User Story', 'Proyectos', 'userstory');
INSERT INTO django_content_type (id, name, app_label, model) VALUES (14, 'comentario', 'Proyectos', 'comentario');
INSERT INTO django_content_type (id, name, app_label, model) VALUES (15, 'Archivo Adjunto', 'Proyectos', 'archivoadjunto');
INSERT INTO django_content_type (id, name, app_label, model) VALUES (16, 'time line', 'Proyectos', 'timeline');
INSERT INTO django_content_type (id, name, app_label, model) VALUES (17, 'release', 'Proyectos', 'release');
INSERT INTO django_content_type (id, name, app_label, model) VALUES (18, 'equipo', 'Proyectos', 'equipo');
INSERT INTO django_content_type (id, name, app_label, model) VALUES (19, 'Backlog', 'Proyectos', 'backlog');


--
-- TOC entry 2370 (class 0 OID 0)
-- Dependencies: 205
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('django_content_type_id_seq', 19, true);


--
-- TOC entry 2283 (class 0 OID 18504)
-- Dependencies: 171
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO django_migrations (id, app, name, applied) VALUES (1, 'contenttypes', '0001_initial', '2015-06-11 08:39:48.18989-04');
INSERT INTO django_migrations (id, app, name, applied) VALUES (2, 'admin', '0001_initial', '2015-06-11 08:39:48.480829-04');
INSERT INTO django_migrations (id, app, name, applied) VALUES (3, 'sessions', '0001_initial', '2015-06-11 08:39:48.759516-04');


--
-- TOC entry 2371 (class 0 OID 0)
-- Dependencies: 170
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('django_migrations_id_seq', 3, true);


--
-- TOC entry 2321 (class 0 OID 18874)
-- Dependencies: 209
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO django_session (session_key, session_data, expire_date) VALUES ('4i09jtxybzzc83eqf6yjvqonutl71lm2', 'NGIwNjA0MzBkM2MwYjgxYjFlNGZjOWM0OGEzMDAyZTI2MjNlOTU4NTp7Il9hdXRoX3VzZXJfaGFzaCI6IjI4OTNjMzAwNDA0MWNjOGVmM2I1MGU5Y2ZiZjc0ZmFjYWEwZWFkMGQiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjF9', '2015-06-27 16:08:28.070744-04');


--
-- TOC entry 2106 (class 2606 OID 18674)
-- Name: Proyectos_actividad_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "Proyectos_actividad"
    ADD CONSTRAINT "Proyectos_actividad_pkey" PRIMARY KEY (id);


--
-- TOC entry 2122 (class 2606 OID 18760)
-- Name: Proyectos_archivoadjunto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "Proyectos_archivoadjunto"
    ADD CONSTRAINT "Proyectos_archivoadjunto_pkey" PRIMARY KEY (id);


--
-- TOC entry 2119 (class 2606 OID 18747)
-- Name: Proyectos_comentario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "Proyectos_comentario"
    ADD CONSTRAINT "Proyectos_comentario_pkey" PRIMARY KEY (id);


--
-- TOC entry 2108 (class 2606 OID 18685)
-- Name: Proyectos_flujo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "Proyectos_flujo"
    ADD CONSTRAINT "Proyectos_flujo_pkey" PRIMARY KEY (id);


--
-- TOC entry 2091 (class 2606 OID 18620)
-- Name: Proyectos_proyecto_equipo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "Proyectos_proyecto_equipo"
    ADD CONSTRAINT "Proyectos_proyecto_equipo_pkey" PRIMARY KEY (id);


--
-- TOC entry 2094 (class 2606 OID 18622)
-- Name: Proyectos_proyecto_equipo_proyecto_id_user_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "Proyectos_proyecto_equipo"
    ADD CONSTRAINT "Proyectos_proyecto_equipo_proyecto_id_user_id_key" UNIQUE (proyecto_id, user_id);


--
-- TOC entry 2097 (class 2606 OID 18640)
-- Name: Proyectos_proyecto_nombre_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "Proyectos_proyecto"
    ADD CONSTRAINT "Proyectos_proyecto_nombre_key" UNIQUE (nombre);


--
-- TOC entry 2100 (class 2606 OID 18638)
-- Name: Proyectos_proyecto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "Proyectos_proyecto"
    ADD CONSTRAINT "Proyectos_proyecto_pkey" PRIMARY KEY (id);


--
-- TOC entry 2131 (class 2606 OID 18801)
-- Name: Proyectos_release_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "Proyectos_release"
    ADD CONSTRAINT "Proyectos_release_pkey" PRIMARY KEY (id);


--
-- TOC entry 2125 (class 2606 OID 18786)
-- Name: Proyectos_release_userstories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "Proyectos_release_userstories"
    ADD CONSTRAINT "Proyectos_release_userstories_pkey" PRIMARY KEY (id);


--
-- TOC entry 2128 (class 2606 OID 18788)
-- Name: Proyectos_release_userstories_release_id_userstory_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "Proyectos_release_userstories"
    ADD CONSTRAINT "Proyectos_release_userstories_release_id_userstory_id_key" UNIQUE (release_id, userstory_id);


--
-- TOC entry 2102 (class 2606 OID 18661)
-- Name: Proyectos_sprint_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "Proyectos_sprint"
    ADD CONSTRAINT "Proyectos_sprint_pkey" PRIMARY KEY (id);


--
-- TOC entry 2146 (class 2606 OID 18922)
-- Name: Proyectos_timeline_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "Proyectos_timeline"
    ADD CONSTRAINT "Proyectos_timeline_pkey" PRIMARY KEY (id);


--
-- TOC entry 2114 (class 2606 OID 18711)
-- Name: Proyectos_userstory_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "Proyectos_userstory"
    ADD CONSTRAINT "Proyectos_userstory_pkey" PRIMARY KEY (id);


--
-- TOC entry 2066 (class 2606 OID 18547)
-- Name: auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- TOC entry 2061 (class 2606 OID 18532)
-- Name: auth_group_permissions_group_id_permission_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_key UNIQUE (group_id, permission_id);


--
-- TOC entry 2064 (class 2606 OID 18530)
-- Name: auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- TOC entry 2069 (class 2606 OID 18545)
-- Name: auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- TOC entry 2056 (class 2606 OID 18522)
-- Name: auth_permission_content_type_id_codename_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_key UNIQUE (content_type_id, codename);


--
-- TOC entry 2058 (class 2606 OID 18520)
-- Name: auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- TOC entry 2088 (class 2606 OID 18607)
-- Name: auth_rol_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY auth_rol
    ADD CONSTRAINT auth_rol_pkey PRIMARY KEY (group_ptr_id);


--
-- TOC entry 2072 (class 2606 OID 18560)
-- Name: auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- TOC entry 2075 (class 2606 OID 18562)
-- Name: auth_user_groups_user_id_group_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_key UNIQUE (user_id, group_id);


--
-- TOC entry 2083 (class 2606 OID 18590)
-- Name: auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- TOC entry 2078 (class 2606 OID 18575)
-- Name: auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- TOC entry 2081 (class 2606 OID 18577)
-- Name: auth_user_user_permissions_user_id_permission_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_key UNIQUE (user_id, permission_id);


--
-- TOC entry 2085 (class 2606 OID 18592)
-- Name: auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- TOC entry 2140 (class 2606 OID 18861)
-- Name: django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- TOC entry 2134 (class 2606 OID 18849)
-- Name: django_content_type_app_label_3ec8c61c_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY django_content_type
    ADD CONSTRAINT django_content_type_app_label_3ec8c61c_uniq UNIQUE (app_label, model);


--
-- TOC entry 2136 (class 2606 OID 18847)
-- Name: django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- TOC entry 2053 (class 2606 OID 18512)
-- Name: django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- TOC entry 2143 (class 2606 OID 18881)
-- Name: django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- TOC entry 2104 (class 1259 OID 18826)
-- Name: Proyectos_actividad_flujo_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "Proyectos_actividad_flujo_id" ON "Proyectos_actividad" USING btree (flujo_id);


--
-- TOC entry 2123 (class 1259 OID 18835)
-- Name: Proyectos_archivoadjunto_userstory_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "Proyectos_archivoadjunto_userstory_id" ON "Proyectos_archivoadjunto" USING btree (userstory_id);


--
-- TOC entry 2120 (class 1259 OID 18834)
-- Name: Proyectos_comentario_userstory_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "Proyectos_comentario_userstory_id" ON "Proyectos_comentario" USING btree (userstory_id);


--
-- TOC entry 2109 (class 1259 OID 18827)
-- Name: Proyectos_flujo_proyecto_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "Proyectos_flujo_proyecto_id" ON "Proyectos_flujo" USING btree (proyecto_id);


--
-- TOC entry 2110 (class 1259 OID 18828)
-- Name: Proyectos_flujo_sprint_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "Proyectos_flujo_sprint_id" ON "Proyectos_flujo" USING btree (sprint_id);


--
-- TOC entry 2092 (class 1259 OID 18822)
-- Name: Proyectos_proyecto_equipo_proyecto_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "Proyectos_proyecto_equipo_proyecto_id" ON "Proyectos_proyecto_equipo" USING btree (proyecto_id);


--
-- TOC entry 2095 (class 1259 OID 18823)
-- Name: Proyectos_proyecto_equipo_user_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "Proyectos_proyecto_equipo_user_id" ON "Proyectos_proyecto_equipo" USING btree (user_id);


--
-- TOC entry 2098 (class 1259 OID 18824)
-- Name: Proyectos_proyecto_nombre_like; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "Proyectos_proyecto_nombre_like" ON "Proyectos_proyecto" USING btree (nombre varchar_pattern_ops);


--
-- TOC entry 2132 (class 1259 OID 18839)
-- Name: Proyectos_release_proyecto_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "Proyectos_release_proyecto_id" ON "Proyectos_release" USING btree (proyecto_id);


--
-- TOC entry 2126 (class 1259 OID 18837)
-- Name: Proyectos_release_userstories_release_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "Proyectos_release_userstories_release_id" ON "Proyectos_release_userstories" USING btree (release_id);


--
-- TOC entry 2129 (class 1259 OID 18838)
-- Name: Proyectos_release_userstories_userstory_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "Proyectos_release_userstories_userstory_id" ON "Proyectos_release_userstories" USING btree (userstory_id);


--
-- TOC entry 2103 (class 1259 OID 18825)
-- Name: Proyectos_sprint_proyecto_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "Proyectos_sprint_proyecto_id" ON "Proyectos_sprint" USING btree (proyecto_id);


--
-- TOC entry 2147 (class 1259 OID 18928)
-- Name: Proyectos_timeline_userstory_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "Proyectos_timeline_userstory_id" ON "Proyectos_timeline" USING btree (userstory_id);


--
-- TOC entry 2111 (class 1259 OID 18833)
-- Name: Proyectos_userstory_actividad_flujo_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "Proyectos_userstory_actividad_flujo_id" ON "Proyectos_userstory" USING btree (actividad_flujo_id);


--
-- TOC entry 2112 (class 1259 OID 18832)
-- Name: Proyectos_userstory_flujo_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "Proyectos_userstory_flujo_id" ON "Proyectos_userstory" USING btree (flujo_id);


--
-- TOC entry 2115 (class 1259 OID 18829)
-- Name: Proyectos_userstory_proyecto_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "Proyectos_userstory_proyecto_id" ON "Proyectos_userstory" USING btree (proyecto_id);


--
-- TOC entry 2116 (class 1259 OID 18831)
-- Name: Proyectos_userstory_sprint_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "Proyectos_userstory_sprint_id" ON "Proyectos_userstory" USING btree (sprint_id);


--
-- TOC entry 2117 (class 1259 OID 18830)
-- Name: Proyectos_userstory_usuario_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "Proyectos_userstory_usuario_id" ON "Proyectos_userstory" USING btree (usuario_id);


--
-- TOC entry 2067 (class 1259 OID 18815)
-- Name: auth_group_name_like; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX auth_group_name_like ON auth_group USING btree (name varchar_pattern_ops);


--
-- TOC entry 2059 (class 1259 OID 18813)
-- Name: auth_group_permissions_group_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX auth_group_permissions_group_id ON auth_group_permissions USING btree (group_id);


--
-- TOC entry 2062 (class 1259 OID 18814)
-- Name: auth_group_permissions_permission_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX auth_group_permissions_permission_id ON auth_group_permissions USING btree (permission_id);


--
-- TOC entry 2054 (class 1259 OID 18812)
-- Name: auth_permission_content_type_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX auth_permission_content_type_id ON auth_permission USING btree (content_type_id);


--
-- TOC entry 2089 (class 1259 OID 18821)
-- Name: auth_rol_proyecto_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX auth_rol_proyecto_id ON auth_rol USING btree (proyecto_id);


--
-- TOC entry 2070 (class 1259 OID 18817)
-- Name: auth_user_groups_group_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX auth_user_groups_group_id ON auth_user_groups USING btree (group_id);


--
-- TOC entry 2073 (class 1259 OID 18816)
-- Name: auth_user_groups_user_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX auth_user_groups_user_id ON auth_user_groups USING btree (user_id);


--
-- TOC entry 2076 (class 1259 OID 18819)
-- Name: auth_user_user_permissions_permission_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX auth_user_user_permissions_permission_id ON auth_user_user_permissions USING btree (permission_id);


--
-- TOC entry 2079 (class 1259 OID 18818)
-- Name: auth_user_user_permissions_user_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX auth_user_user_permissions_user_id ON auth_user_user_permissions USING btree (user_id);


--
-- TOC entry 2086 (class 1259 OID 18820)
-- Name: auth_user_username_like; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX auth_user_username_like ON auth_user USING btree (username varchar_pattern_ops);


--
-- TOC entry 2137 (class 1259 OID 18872)
-- Name: django_admin_log_417f1b1c; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX django_admin_log_417f1b1c ON django_admin_log USING btree (content_type_id);


--
-- TOC entry 2138 (class 1259 OID 18873)
-- Name: django_admin_log_e8701ad4; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX django_admin_log_e8701ad4 ON django_admin_log USING btree (user_id);


--
-- TOC entry 2141 (class 1259 OID 18882)
-- Name: django_session_de54fa62; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX django_session_de54fa62 ON django_session USING btree (expire_date);


--
-- TOC entry 2144 (class 1259 OID 18883)
-- Name: django_session_session_key_630ca218_like; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX django_session_session_key_630ca218_like ON django_session USING btree (session_key varchar_pattern_ops);


--
-- TOC entry 2168 (class 2606 OID 18761)
-- Name: Proyectos_archivoadjunto_userstory_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Proyectos_archivoadjunto"
    ADD CONSTRAINT "Proyectos_archivoadjunto_userstory_id_fkey" FOREIGN KEY (userstory_id) REFERENCES "Proyectos_userstory"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 2167 (class 2606 OID 18748)
-- Name: Proyectos_comentario_userstory_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Proyectos_comentario"
    ADD CONSTRAINT "Proyectos_comentario_userstory_id_fkey" FOREIGN KEY (userstory_id) REFERENCES "Proyectos_userstory"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 2160 (class 2606 OID 18686)
-- Name: Proyectos_flujo_proyecto_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Proyectos_flujo"
    ADD CONSTRAINT "Proyectos_flujo_proyecto_id_fkey" FOREIGN KEY (proyecto_id) REFERENCES "Proyectos_proyecto"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 2161 (class 2606 OID 18691)
-- Name: Proyectos_flujo_sprint_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Proyectos_flujo"
    ADD CONSTRAINT "Proyectos_flujo_sprint_id_fkey" FOREIGN KEY (sprint_id) REFERENCES "Proyectos_sprint"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 2156 (class 2606 OID 18623)
-- Name: Proyectos_proyecto_equipo_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Proyectos_proyecto_equipo"
    ADD CONSTRAINT "Proyectos_proyecto_equipo_user_id_fkey" FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 2171 (class 2606 OID 18802)
-- Name: Proyectos_release_proyecto_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Proyectos_release"
    ADD CONSTRAINT "Proyectos_release_proyecto_id_fkey" FOREIGN KEY (proyecto_id) REFERENCES "Proyectos_proyecto"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 2169 (class 2606 OID 18789)
-- Name: Proyectos_release_userstories_userstory_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Proyectos_release_userstories"
    ADD CONSTRAINT "Proyectos_release_userstories_userstory_id_fkey" FOREIGN KEY (userstory_id) REFERENCES "Proyectos_userstory"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 2158 (class 2606 OID 18662)
-- Name: Proyectos_sprint_proyecto_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Proyectos_sprint"
    ADD CONSTRAINT "Proyectos_sprint_proyecto_id_fkey" FOREIGN KEY (proyecto_id) REFERENCES "Proyectos_proyecto"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 2174 (class 2606 OID 18923)
-- Name: Proyectos_timeline_userstory_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Proyectos_timeline"
    ADD CONSTRAINT "Proyectos_timeline_userstory_id_fkey" FOREIGN KEY (userstory_id) REFERENCES "Proyectos_userstory"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 2166 (class 2606 OID 18732)
-- Name: Proyectos_userstory_actividad_flujo_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Proyectos_userstory"
    ADD CONSTRAINT "Proyectos_userstory_actividad_flujo_id_fkey" FOREIGN KEY (actividad_flujo_id) REFERENCES "Proyectos_actividad"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 2165 (class 2606 OID 18727)
-- Name: Proyectos_userstory_flujo_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Proyectos_userstory"
    ADD CONSTRAINT "Proyectos_userstory_flujo_id_fkey" FOREIGN KEY (flujo_id) REFERENCES "Proyectos_flujo"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 2162 (class 2606 OID 18712)
-- Name: Proyectos_userstory_proyecto_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Proyectos_userstory"
    ADD CONSTRAINT "Proyectos_userstory_proyecto_id_fkey" FOREIGN KEY (proyecto_id) REFERENCES "Proyectos_proyecto"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 2164 (class 2606 OID 18722)
-- Name: Proyectos_userstory_sprint_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Proyectos_userstory"
    ADD CONSTRAINT "Proyectos_userstory_sprint_id_fkey" FOREIGN KEY (sprint_id) REFERENCES "Proyectos_sprint"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 2163 (class 2606 OID 18717)
-- Name: Proyectos_userstory_usuario_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Proyectos_userstory"
    ADD CONSTRAINT "Proyectos_userstory_usuario_id_fkey" FOREIGN KEY (usuario_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 2148 (class 2606 OID 18533)
-- Name: auth_group_permissions_permission_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_permission_id_fkey FOREIGN KEY (permission_id) REFERENCES auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 2154 (class 2606 OID 18608)
-- Name: auth_rol_group_ptr_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_rol
    ADD CONSTRAINT auth_rol_group_ptr_id_fkey FOREIGN KEY (group_ptr_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 2150 (class 2606 OID 18563)
-- Name: auth_user_groups_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_fkey FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 2152 (class 2606 OID 18578)
-- Name: auth_user_user_permissions_permission_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_permission_id_fkey FOREIGN KEY (permission_id) REFERENCES auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 2172 (class 2606 OID 18862)
-- Name: django_admin_content_type_id_5151027a_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_content_type_id_5151027a_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 2173 (class 2606 OID 18867)
-- Name: django_admin_log_user_id_1c5f563_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_1c5f563_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 2159 (class 2606 OID 18696)
-- Name: flujo_id_refs_id_efee1327; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Proyectos_actividad"
    ADD CONSTRAINT flujo_id_refs_id_efee1327 FOREIGN KEY (flujo_id) REFERENCES "Proyectos_flujo"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 2149 (class 2606 OID 18548)
-- Name: group_id_refs_id_f4b32aac; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT group_id_refs_id_f4b32aac FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 2157 (class 2606 OID 18646)
-- Name: proyecto_id_refs_id_5dbe1fd0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Proyectos_proyecto_equipo"
    ADD CONSTRAINT proyecto_id_refs_id_5dbe1fd0 FOREIGN KEY (proyecto_id) REFERENCES "Proyectos_proyecto"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 2155 (class 2606 OID 18641)
-- Name: proyecto_id_refs_id_b2802eb9; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_rol
    ADD CONSTRAINT proyecto_id_refs_id_b2802eb9 FOREIGN KEY (proyecto_id) REFERENCES "Proyectos_proyecto"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 2170 (class 2606 OID 18807)
-- Name: release_id_refs_id_583bd14c; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Proyectos_release_userstories"
    ADD CONSTRAINT release_id_refs_id_583bd14c FOREIGN KEY (release_id) REFERENCES "Proyectos_release"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 2151 (class 2606 OID 18593)
-- Name: user_id_refs_id_40c41112; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT user_id_refs_id_40c41112 FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 2153 (class 2606 OID 18598)
-- Name: user_id_refs_id_4dc23c39; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT user_id_refs_id_4dc23c39 FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 2330 (class 0 OID 0)
-- Dependencies: 5
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2015-06-19 21:20:18 PYT

--
-- PostgreSQL database dump complete
--

