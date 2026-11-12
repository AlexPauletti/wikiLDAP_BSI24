--
-- PostgreSQL database dump
--

\restrict EUFD6V7BkXm6vb9K7KcOibaedzVctfs6yReyRIdb4JKOA50H27ApBmenbMHzKOC

-- Dumped from database version 15.19
-- Dumped by pg_dump version 15.19

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: analytics; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public.analytics (
    key character varying(255) NOT NULL,
    "isEnabled" boolean DEFAULT false NOT NULL,
    config json NOT NULL
);


ALTER TABLE public.analytics OWNER TO wikijs;

--
-- Name: apiKeys; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public."apiKeys" (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    key text NOT NULL,
    expiration character varying(255) NOT NULL,
    "isRevoked" boolean DEFAULT false NOT NULL,
    "createdAt" character varying(255) NOT NULL,
    "updatedAt" character varying(255) NOT NULL
);


ALTER TABLE public."apiKeys" OWNER TO wikijs;

--
-- Name: apiKeys_id_seq; Type: SEQUENCE; Schema: public; Owner: wikijs
--

CREATE SEQUENCE public."apiKeys_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."apiKeys_id_seq" OWNER TO wikijs;

--
-- Name: apiKeys_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wikijs
--

ALTER SEQUENCE public."apiKeys_id_seq" OWNED BY public."apiKeys".id;


--
-- Name: assetData; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public."assetData" (
    id integer NOT NULL,
    data bytea NOT NULL
);


ALTER TABLE public."assetData" OWNER TO wikijs;

--
-- Name: assetFolders; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public."assetFolders" (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    slug character varying(255) NOT NULL,
    "parentId" integer
);


ALTER TABLE public."assetFolders" OWNER TO wikijs;

--
-- Name: assetFolders_id_seq; Type: SEQUENCE; Schema: public; Owner: wikijs
--

CREATE SEQUENCE public."assetFolders_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."assetFolders_id_seq" OWNER TO wikijs;

--
-- Name: assetFolders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wikijs
--

ALTER SEQUENCE public."assetFolders_id_seq" OWNED BY public."assetFolders".id;


--
-- Name: assets; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public.assets (
    id integer NOT NULL,
    filename character varying(255) NOT NULL,
    hash character varying(255) NOT NULL,
    ext character varying(255) NOT NULL,
    kind text DEFAULT 'binary'::text NOT NULL,
    mime character varying(255) DEFAULT 'application/octet-stream'::character varying NOT NULL,
    "fileSize" integer,
    metadata json,
    "createdAt" character varying(255) NOT NULL,
    "updatedAt" character varying(255) NOT NULL,
    "folderId" integer,
    "authorId" integer,
    CONSTRAINT assets_kind_check CHECK ((kind = ANY (ARRAY['binary'::text, 'image'::text])))
);


ALTER TABLE public.assets OWNER TO wikijs;

--
-- Name: COLUMN assets."fileSize"; Type: COMMENT; Schema: public; Owner: wikijs
--

COMMENT ON COLUMN public.assets."fileSize" IS 'In kilobytes';


--
-- Name: assets_id_seq; Type: SEQUENCE; Schema: public; Owner: wikijs
--

CREATE SEQUENCE public.assets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.assets_id_seq OWNER TO wikijs;

--
-- Name: assets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wikijs
--

ALTER SEQUENCE public.assets_id_seq OWNED BY public.assets.id;


--
-- Name: authentication; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public.authentication (
    key character varying(255) NOT NULL,
    "isEnabled" boolean DEFAULT false NOT NULL,
    config json NOT NULL,
    "selfRegistration" boolean DEFAULT false NOT NULL,
    "domainWhitelist" json NOT NULL,
    "autoEnrollGroups" json NOT NULL,
    "order" integer DEFAULT 0 NOT NULL,
    "strategyKey" character varying(255) DEFAULT ''::character varying NOT NULL,
    "displayName" character varying(255) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.authentication OWNER TO wikijs;

--
-- Name: brute; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public.brute (
    key character varying(255),
    "firstRequest" bigint,
    "lastRequest" bigint,
    lifetime bigint,
    count integer
);


ALTER TABLE public.brute OWNER TO wikijs;

--
-- Name: commentProviders; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public."commentProviders" (
    key character varying(255) NOT NULL,
    "isEnabled" boolean DEFAULT false NOT NULL,
    config json NOT NULL
);


ALTER TABLE public."commentProviders" OWNER TO wikijs;

--
-- Name: comments; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public.comments (
    id integer NOT NULL,
    content text NOT NULL,
    "createdAt" character varying(255) NOT NULL,
    "updatedAt" character varying(255) NOT NULL,
    "pageId" integer,
    "authorId" integer,
    render text DEFAULT ''::text NOT NULL,
    name character varying(255) DEFAULT ''::character varying NOT NULL,
    email character varying(255) DEFAULT ''::character varying NOT NULL,
    ip character varying(255) DEFAULT ''::character varying NOT NULL,
    "replyTo" integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.comments OWNER TO wikijs;

--
-- Name: comments_id_seq; Type: SEQUENCE; Schema: public; Owner: wikijs
--

CREATE SEQUENCE public.comments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.comments_id_seq OWNER TO wikijs;

--
-- Name: comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wikijs
--

ALTER SEQUENCE public.comments_id_seq OWNED BY public.comments.id;


--
-- Name: editors; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public.editors (
    key character varying(255) NOT NULL,
    "isEnabled" boolean DEFAULT false NOT NULL,
    config json NOT NULL
);


ALTER TABLE public.editors OWNER TO wikijs;

--
-- Name: groups; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public.groups (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    permissions json NOT NULL,
    "pageRules" json NOT NULL,
    "isSystem" boolean DEFAULT false NOT NULL,
    "createdAt" character varying(255) NOT NULL,
    "updatedAt" character varying(255) NOT NULL,
    "redirectOnLogin" character varying(255) DEFAULT '/'::character varying NOT NULL
);


ALTER TABLE public.groups OWNER TO wikijs;

--
-- Name: groups_id_seq; Type: SEQUENCE; Schema: public; Owner: wikijs
--

CREATE SEQUENCE public.groups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.groups_id_seq OWNER TO wikijs;

--
-- Name: groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wikijs
--

ALTER SEQUENCE public.groups_id_seq OWNED BY public.groups.id;


--
-- Name: locales; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public.locales (
    code character varying(5) NOT NULL,
    strings json,
    "isRTL" boolean DEFAULT false NOT NULL,
    name character varying(255) NOT NULL,
    "nativeName" character varying(255) NOT NULL,
    availability integer DEFAULT 0 NOT NULL,
    "createdAt" character varying(255) NOT NULL,
    "updatedAt" character varying(255) NOT NULL
);


ALTER TABLE public.locales OWNER TO wikijs;

--
-- Name: loggers; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public.loggers (
    key character varying(255) NOT NULL,
    "isEnabled" boolean DEFAULT false NOT NULL,
    level character varying(255) DEFAULT 'warn'::character varying NOT NULL,
    config json
);


ALTER TABLE public.loggers OWNER TO wikijs;

--
-- Name: migrations; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public.migrations (
    id integer NOT NULL,
    name character varying(255),
    batch integer,
    migration_time timestamp with time zone
);


ALTER TABLE public.migrations OWNER TO wikijs;

--
-- Name: migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: wikijs
--

CREATE SEQUENCE public.migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.migrations_id_seq OWNER TO wikijs;

--
-- Name: migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wikijs
--

ALTER SEQUENCE public.migrations_id_seq OWNED BY public.migrations.id;


--
-- Name: migrations_lock; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public.migrations_lock (
    index integer NOT NULL,
    is_locked integer
);


ALTER TABLE public.migrations_lock OWNER TO wikijs;

--
-- Name: migrations_lock_index_seq; Type: SEQUENCE; Schema: public; Owner: wikijs
--

CREATE SEQUENCE public.migrations_lock_index_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.migrations_lock_index_seq OWNER TO wikijs;

--
-- Name: migrations_lock_index_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wikijs
--

ALTER SEQUENCE public.migrations_lock_index_seq OWNED BY public.migrations_lock.index;


--
-- Name: navigation; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public.navigation (
    key character varying(255) NOT NULL,
    config json
);


ALTER TABLE public.navigation OWNER TO wikijs;

--
-- Name: pageHistory; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public."pageHistory" (
    id integer NOT NULL,
    path character varying(255) NOT NULL,
    hash character varying(255) NOT NULL,
    title character varying(255) NOT NULL,
    description character varying(255),
    "isPrivate" boolean DEFAULT false NOT NULL,
    "isPublished" boolean DEFAULT false NOT NULL,
    "publishStartDate" character varying(255),
    "publishEndDate" character varying(255),
    action character varying(255) DEFAULT 'updated'::character varying,
    "pageId" integer,
    content text,
    "contentType" character varying(255) NOT NULL,
    "createdAt" character varying(255) NOT NULL,
    "editorKey" character varying(255),
    "localeCode" character varying(5),
    "authorId" integer,
    "versionDate" character varying(255) DEFAULT ''::character varying NOT NULL,
    extra json DEFAULT '{}'::json NOT NULL
);


ALTER TABLE public."pageHistory" OWNER TO wikijs;

--
-- Name: pageHistoryTags; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public."pageHistoryTags" (
    id integer NOT NULL,
    "pageId" integer,
    "tagId" integer
);


ALTER TABLE public."pageHistoryTags" OWNER TO wikijs;

--
-- Name: pageHistoryTags_id_seq; Type: SEQUENCE; Schema: public; Owner: wikijs
--

CREATE SEQUENCE public."pageHistoryTags_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."pageHistoryTags_id_seq" OWNER TO wikijs;

--
-- Name: pageHistoryTags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wikijs
--

ALTER SEQUENCE public."pageHistoryTags_id_seq" OWNED BY public."pageHistoryTags".id;


--
-- Name: pageHistory_id_seq; Type: SEQUENCE; Schema: public; Owner: wikijs
--

CREATE SEQUENCE public."pageHistory_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."pageHistory_id_seq" OWNER TO wikijs;

--
-- Name: pageHistory_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wikijs
--

ALTER SEQUENCE public."pageHistory_id_seq" OWNED BY public."pageHistory".id;


--
-- Name: pageLinks; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public."pageLinks" (
    id integer NOT NULL,
    path character varying(255) NOT NULL,
    "localeCode" character varying(5) NOT NULL,
    "pageId" integer
);


ALTER TABLE public."pageLinks" OWNER TO wikijs;

--
-- Name: pageLinks_id_seq; Type: SEQUENCE; Schema: public; Owner: wikijs
--

CREATE SEQUENCE public."pageLinks_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."pageLinks_id_seq" OWNER TO wikijs;

--
-- Name: pageLinks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wikijs
--

ALTER SEQUENCE public."pageLinks_id_seq" OWNED BY public."pageLinks".id;


--
-- Name: pageTags; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public."pageTags" (
    id integer NOT NULL,
    "pageId" integer,
    "tagId" integer
);


ALTER TABLE public."pageTags" OWNER TO wikijs;

--
-- Name: pageTags_id_seq; Type: SEQUENCE; Schema: public; Owner: wikijs
--

CREATE SEQUENCE public."pageTags_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."pageTags_id_seq" OWNER TO wikijs;

--
-- Name: pageTags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wikijs
--

ALTER SEQUENCE public."pageTags_id_seq" OWNED BY public."pageTags".id;


--
-- Name: pageTree; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public."pageTree" (
    id integer NOT NULL,
    path character varying(255) NOT NULL,
    depth integer NOT NULL,
    title character varying(255) NOT NULL,
    "isPrivate" boolean DEFAULT false NOT NULL,
    "isFolder" boolean DEFAULT false NOT NULL,
    "privateNS" character varying(255),
    parent integer,
    "pageId" integer,
    "localeCode" character varying(5),
    ancestors json
);


ALTER TABLE public."pageTree" OWNER TO wikijs;

--
-- Name: pages; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public.pages (
    id integer NOT NULL,
    path character varying(255) NOT NULL,
    hash character varying(255) NOT NULL,
    title character varying(255) NOT NULL,
    description character varying(255),
    "isPrivate" boolean DEFAULT false NOT NULL,
    "isPublished" boolean DEFAULT false NOT NULL,
    "privateNS" character varying(255),
    "publishStartDate" character varying(255),
    "publishEndDate" character varying(255),
    content text,
    render text,
    toc json,
    "contentType" character varying(255) NOT NULL,
    "createdAt" character varying(255) NOT NULL,
    "updatedAt" character varying(255) NOT NULL,
    "editorKey" character varying(255),
    "localeCode" character varying(5),
    "authorId" integer,
    "creatorId" integer,
    extra json DEFAULT '{}'::json NOT NULL
);


ALTER TABLE public.pages OWNER TO wikijs;

--
-- Name: pages_id_seq; Type: SEQUENCE; Schema: public; Owner: wikijs
--

CREATE SEQUENCE public.pages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pages_id_seq OWNER TO wikijs;

--
-- Name: pages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wikijs
--

ALTER SEQUENCE public.pages_id_seq OWNED BY public.pages.id;


--
-- Name: renderers; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public.renderers (
    key character varying(255) NOT NULL,
    "isEnabled" boolean DEFAULT false NOT NULL,
    config json
);


ALTER TABLE public.renderers OWNER TO wikijs;

--
-- Name: searchEngines; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public."searchEngines" (
    key character varying(255) NOT NULL,
    "isEnabled" boolean DEFAULT false NOT NULL,
    config json
);


ALTER TABLE public."searchEngines" OWNER TO wikijs;

--
-- Name: sessions; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public.sessions (
    sid character varying(255) NOT NULL,
    sess json NOT NULL,
    expired timestamp with time zone NOT NULL
);


ALTER TABLE public.sessions OWNER TO wikijs;

--
-- Name: settings; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public.settings (
    key character varying(255) NOT NULL,
    value json,
    "updatedAt" character varying(255) NOT NULL
);


ALTER TABLE public.settings OWNER TO wikijs;

--
-- Name: storage; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public.storage (
    key character varying(255) NOT NULL,
    "isEnabled" boolean DEFAULT false NOT NULL,
    mode character varying(255) DEFAULT 'push'::character varying NOT NULL,
    config json,
    "syncInterval" character varying(255),
    state json
);


ALTER TABLE public.storage OWNER TO wikijs;

--
-- Name: tags; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public.tags (
    id integer NOT NULL,
    tag character varying(255) NOT NULL,
    title character varying(255),
    "createdAt" character varying(255) NOT NULL,
    "updatedAt" character varying(255) NOT NULL
);


ALTER TABLE public.tags OWNER TO wikijs;

--
-- Name: tags_id_seq; Type: SEQUENCE; Schema: public; Owner: wikijs
--

CREATE SEQUENCE public.tags_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tags_id_seq OWNER TO wikijs;

--
-- Name: tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wikijs
--

ALTER SEQUENCE public.tags_id_seq OWNED BY public.tags.id;


--
-- Name: userAvatars; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public."userAvatars" (
    id integer NOT NULL,
    data bytea NOT NULL
);


ALTER TABLE public."userAvatars" OWNER TO wikijs;

--
-- Name: userGroups; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public."userGroups" (
    id integer NOT NULL,
    "userId" integer,
    "groupId" integer
);


ALTER TABLE public."userGroups" OWNER TO wikijs;

--
-- Name: userGroups_id_seq; Type: SEQUENCE; Schema: public; Owner: wikijs
--

CREATE SEQUENCE public."userGroups_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."userGroups_id_seq" OWNER TO wikijs;

--
-- Name: userGroups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wikijs
--

ALTER SEQUENCE public."userGroups_id_seq" OWNED BY public."userGroups".id;


--
-- Name: userKeys; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public."userKeys" (
    id integer NOT NULL,
    kind character varying(255) NOT NULL,
    token character varying(255) NOT NULL,
    "createdAt" character varying(255) NOT NULL,
    "validUntil" character varying(255) NOT NULL,
    "userId" integer
);


ALTER TABLE public."userKeys" OWNER TO wikijs;

--
-- Name: userKeys_id_seq; Type: SEQUENCE; Schema: public; Owner: wikijs
--

CREATE SEQUENCE public."userKeys_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."userKeys_id_seq" OWNER TO wikijs;

--
-- Name: userKeys_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wikijs
--

ALTER SEQUENCE public."userKeys_id_seq" OWNED BY public."userKeys".id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public.users (
    id integer NOT NULL,
    email character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    "providerId" character varying(255),
    password character varying(255),
    "tfaIsActive" boolean DEFAULT false NOT NULL,
    "tfaSecret" character varying(255),
    "jobTitle" character varying(255) DEFAULT ''::character varying,
    location character varying(255) DEFAULT ''::character varying,
    "pictureUrl" character varying(255),
    timezone character varying(255) DEFAULT 'America/New_York'::character varying NOT NULL,
    "isSystem" boolean DEFAULT false NOT NULL,
    "isActive" boolean DEFAULT false NOT NULL,
    "isVerified" boolean DEFAULT false NOT NULL,
    "mustChangePwd" boolean DEFAULT false NOT NULL,
    "createdAt" character varying(255) NOT NULL,
    "updatedAt" character varying(255) NOT NULL,
    "providerKey" character varying(255) DEFAULT 'local'::character varying NOT NULL,
    "localeCode" character varying(5) DEFAULT 'en'::character varying NOT NULL,
    "defaultEditor" character varying(255) DEFAULT 'markdown'::character varying NOT NULL,
    "lastLoginAt" character varying(255),
    "dateFormat" character varying(255) DEFAULT ''::character varying NOT NULL,
    appearance character varying(255) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.users OWNER TO wikijs;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: wikijs
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO wikijs;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wikijs
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: apiKeys id; Type: DEFAULT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."apiKeys" ALTER COLUMN id SET DEFAULT nextval('public."apiKeys_id_seq"'::regclass);


--
-- Name: assetFolders id; Type: DEFAULT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."assetFolders" ALTER COLUMN id SET DEFAULT nextval('public."assetFolders_id_seq"'::regclass);


--
-- Name: assets id; Type: DEFAULT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.assets ALTER COLUMN id SET DEFAULT nextval('public.assets_id_seq'::regclass);


--
-- Name: comments id; Type: DEFAULT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.comments ALTER COLUMN id SET DEFAULT nextval('public.comments_id_seq'::regclass);


--
-- Name: groups id; Type: DEFAULT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.groups ALTER COLUMN id SET DEFAULT nextval('public.groups_id_seq'::regclass);


--
-- Name: migrations id; Type: DEFAULT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.migrations ALTER COLUMN id SET DEFAULT nextval('public.migrations_id_seq'::regclass);


--
-- Name: migrations_lock index; Type: DEFAULT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.migrations_lock ALTER COLUMN index SET DEFAULT nextval('public.migrations_lock_index_seq'::regclass);


--
-- Name: pageHistory id; Type: DEFAULT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."pageHistory" ALTER COLUMN id SET DEFAULT nextval('public."pageHistory_id_seq"'::regclass);


--
-- Name: pageHistoryTags id; Type: DEFAULT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."pageHistoryTags" ALTER COLUMN id SET DEFAULT nextval('public."pageHistoryTags_id_seq"'::regclass);


--
-- Name: pageLinks id; Type: DEFAULT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."pageLinks" ALTER COLUMN id SET DEFAULT nextval('public."pageLinks_id_seq"'::regclass);


--
-- Name: pageTags id; Type: DEFAULT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."pageTags" ALTER COLUMN id SET DEFAULT nextval('public."pageTags_id_seq"'::regclass);


--
-- Name: pages id; Type: DEFAULT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.pages ALTER COLUMN id SET DEFAULT nextval('public.pages_id_seq'::regclass);


--
-- Name: tags id; Type: DEFAULT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.tags ALTER COLUMN id SET DEFAULT nextval('public.tags_id_seq'::regclass);


--
-- Name: userGroups id; Type: DEFAULT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."userGroups" ALTER COLUMN id SET DEFAULT nextval('public."userGroups_id_seq"'::regclass);


--
-- Name: userKeys id; Type: DEFAULT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."userKeys" ALTER COLUMN id SET DEFAULT nextval('public."userKeys_id_seq"'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: analytics; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public.analytics (key, "isEnabled", config) FROM stdin;
azureinsights	f	{"instrumentationKey":""}
baidutongji	f	{"propertyTrackingId":""}
countly	f	{"appKey":"","serverUrl":""}
elasticapm	f	{"serverUrl":"http://apm.example.com:8200","serviceName":"wiki-js","environment":""}
fathom	f	{"host":"","siteId":""}
fullstory	f	{"org":""}
google	f	{"propertyTrackingId":""}
gtm	f	{"containerTrackingId":""}
hotjar	f	{"siteId":""}
matomo	f	{"siteId":1,"serverHost":"https://example.matomo.cloud"}
newrelic	f	{"licenseKey":"","appId":"","beacon":"bam.nr-data.net","errorBeacon":"bam.nr-data.net"}
plausible	f	{"domain":"","plausibleJsSrc":"https://plausible.io/js/plausible.js"}
statcounter	f	{"projectId":"","securityToken":""}
umami	f	{"websiteID":"","url":""}
umami2	f	{"websiteID":"","url":""}
yandex	f	{"tagNumber":""}
\.


--
-- Data for Name: apiKeys; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public."apiKeys" (id, name, key, expiration, "isRevoked", "createdAt", "updatedAt") FROM stdin;
1	teste	eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJhcGkiOjEsImdycCI6MSwiaWF0IjoxNzkzNTY0ODAzLCJleHAiOjE4MjUxMjI0MDMsImF1ZCI6InVybjp3aWtpLmpzIiwiaXNzIjoidXJuOndpa2kuanMifQ.JkrnbYqqPk6QaaTvO5jgJs6V-irNLqH06dgtvW1YW_QakMxUY8O5sDs7aKnkmWt4aavfSqvwrFRc2wTLj7jD5vjlMg8HG6iab1T_3EmozZeDc-OqRZ4L4JhsToo9OFdb4lbTX8wg2XMaINCD6zS2lxscb7hp1rfqkrxV-ErauJB855_U8Ou3zWSuCKddMo3m33lL_fCPMNeDen0WRdhMHHZKU5oOM5UNdiNBWRNDLtTqA6vw-ZexQ2Omb-l3k2PyaoN0aXsG7FkspQFPO8TfqDZwXv1GmeypHgnEX-gopH37UYssi4XSF7_r56gPb3ctmPYsm32_SPIXUALeTElgMw	2027-11-02T02:26:43.898Z	t	2026-11-01T20:26:43.901Z	2026-11-01T20:28:42.804Z
2	SD	eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJhcGkiOjIsImdycCI6MSwiaWF0IjoxNzkzNTY0OTMyLCJleHAiOjE4MjUxMjI1MzIsImF1ZCI6InVybjp3aWtpLmpzIiwiaXNzIjoidXJuOndpa2kuanMifQ.QjXgOGxqCE2vOduT5ras3wLMR_LJ4jjucDNqDP1Xq6FsRMVPXc1WBUzRVnXsStB96qxTV2TrpnrocpKATZSLg-z1QYaLWwVpGPZH-wdQi_ElUs6CrzUF6qYgQxzi6vTVMTEF8xoI3qg7UuBuF3tpelNLXwKrTEfjP4QyMnvumUMVcDKawAsExRDWNQcJ5tdpBuWi6ZFWbWc_Tw-luZ6tqiQ51schviFQEooRLQlBnHURZ2RCfhPF-DrgnZ3wdTeIAUgcYBI3lThR_WeuZBz3PvXIgx7zeKEE3xGet6YJYbFh_4AiXqArAmVROBx0hrgaSKK99-4VYclXtdXEmUaNxg	2027-11-02T02:28:52.115Z	f	2026-11-01T20:28:52.115Z	2026-11-01T20:28:52.120Z
\.


--
-- Data for Name: assetData; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public."assetData" (id, data) FROM stdin;
\.


--
-- Data for Name: assetFolders; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public."assetFolders" (id, name, slug, "parentId") FROM stdin;
\.


--
-- Data for Name: assets; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public.assets (id, filename, hash, ext, kind, mime, "fileSize", metadata, "createdAt", "updatedAt", "folderId", "authorId") FROM stdin;
\.


--
-- Data for Name: authentication; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public.authentication (key, "isEnabled", config, "selfRegistration", "domainWhitelist", "autoEnrollGroups", "order", "strategyKey", "displayName") FROM stdin;
local	t	{}	f	{"v":[]}	{"v":[]}	0	local	Local
decd4a0b-d6eb-4b30-9094-582389bd3dfd	t	{"url":"ldap://ldap:389","bindDn":"uid=svc-wiki,ou=DITI - Divisao de Tecnologia da Informacao,ou=SEGOV - Secretaria Municipal de Governo Inovacao e Orcamento,ou=PMBC - Prefeitura Municipal de Balneario Camboriu,dc=pmbc,dc=local","bindCredentials":"Teste@123","searchBase":"dc=pmbc,dc=local","searchFilter":"(uid={{username}})","tlsEnabled":false,"verifyTLSCertificate":true,"tlsCertPath":"","mappingUID":"uid","mappingEmail":"mail","mappingDisplayName":"cn","mappingPicture":"jpegPhoto","mapGroups":true,"groupSearchBase":"OU=groups,dc=pmbc,dc=local","groupSearchFilter":"(member={{dn}})","groupSearchScope":"sub","groupDnProperty":"dn","groupNameField":"cn"}	t	{"v":[]}	{"v":[3]}	1	ldap	PMBC
\.


--
-- Data for Name: brute; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public.brute (key, "firstRequest", "lastRequest", lifetime, count) FROM stdin;
\.


--
-- Data for Name: commentProviders; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public."commentProviders" (key, "isEnabled", config) FROM stdin;
artalk	f	{"server":"","siteName":""}
commento	f	{"instanceUrl":"https://cdn.commento.io"}
default	t	{"akismet":"","minDelay":30}
disqus	f	{"accountName":""}
\.


--
-- Data for Name: comments; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public.comments (id, content, "createdAt", "updatedAt", "pageId", "authorId", render, name, email, ip, "replyTo") FROM stdin;
\.


--
-- Data for Name: editors; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public.editors (key, "isEnabled", config) FROM stdin;
api	f	{}
asciidoc	f	{}
ckeditor	f	{}
code	f	{}
markdown	t	{}
redirect	f	{}
wysiwyg	f	{}
\.


--
-- Data for Name: groups; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public.groups (id, name, permissions, "pageRules", "isSystem", "createdAt", "updatedAt", "redirectOnLogin") FROM stdin;
1	Administrators	["manage:system"]	[]	t	2026-10-24T19:52:26.113Z	2026-10-24T19:52:26.113Z	/
11	diti-leitor	["read:pages","read:assets","read:comments","write:comments"]	[{"id":"default","deny":false,"match":"START","roles":["read:pages","read:assets","read:comments","write:comments"],"path":"pmbc/segov/diti","locales":[]},{"id":"70940b737d","deny":false,"match":"EXACT","roles":["read:pages","read:assets","read:comments","write:comments"],"path":"pmbc/segov","locales":[]},{"id":"a378ba7b94","deny":false,"match":"EXACT","roles":["read:pages","read:assets","read:comments","write:comments"],"path":"pmbc","locales":[]}]	f	2026-11-01T19:09:15.038Z	2026-11-03T23:39:34.714Z	/pmbc/segov/diti
3	Pendentes	[]	[]	f	2026-11-01T18:22:38.885Z	2026-11-01T18:55:44.186Z	/
5	decc-leitor	["read:pages","read:assets","read:comments","write:comments"]	[{"id":"default","deny":false,"match":"START","roles":["read:pages","read:assets","read:comments","write:comments"],"path":"pmbc/searp/decc","locales":[]},{"id":"002af343d7","deny":false,"match":"EXACT","roles":["read:pages","read:assets","read:comments","write:comments"],"path":"pmbc/searp","locales":[]},{"id":"19ac0c6909","deny":false,"match":"EXACT","roles":["read:pages","read:assets","read:comments","write:comments"],"path":"pmbc","locales":[]}]	f	2026-11-01T19:08:36.900Z	2026-11-03T23:40:12.811Z	/pmbc/searp/decc
2	Guests	[]	[]	t	2026-10-24T19:52:26.122Z	2026-11-03T23:34:42.453Z	/
8	pio-leitor	["read:pages","read:assets","read:comments","write:comments"]	[{"id":"default","deny":false,"match":"START","roles":["read:pages","read:assets","read:comments","write:comments"],"path":"pmbc/seduc/nei/pio","locales":[]},{"id":"92269153bf","deny":false,"match":"EXACT","roles":["read:pages","read:assets","write:comments","read:comments"],"path":"pmbc/seduc/nei","locales":[]},{"id":"7e7e0072d4","deny":false,"match":"EXACT","roles":["read:pages","read:assets","read:comments","write:comments"],"path":"pmbc/seduc","locales":[]},{"id":"7ca9c67370","deny":false,"match":"EXACT","roles":["read:pages","read:assets","read:comments","write:comments"],"path":"pmbc","locales":[]}]	f	2026-11-01T19:08:59.012Z	2026-11-03T23:40:30.318Z	/pmbc/seduc/nei/pio
6	pal-leitor	["read:pages","read:assets","read:comments","write:comments"]	[{"id":"default","deny":false,"match":"START","roles":["read:pages","read:assets","read:comments","write:comments"],"path":"pmbc/seduc/cem/pal","locales":[]},{"id":"e218cf62dc","deny":false,"match":"EXACT","roles":["read:pages","read:assets","read:comments","write:comments"],"path":"pmbc/seduc","locales":[]},{"id":"5b7e1436f4","deny":false,"match":"EXACT","roles":["read:pages","read:assets","read:comments","write:comments"],"path":"pmbc/seduc/cem","locales":[]},{"id":"08634e02da","deny":false,"match":"EXACT","roles":["read:pages","read:assets","read:comments","write:comments"],"path":"pmbc","locales":[]}]	f	2026-11-01T19:08:43.764Z	2026-11-03T23:41:01.056Z	/pmbc/seduc/cem/pal
9	pio-admin	["read:pages","read:assets","read:comments","write:comments","write:pages","manage:pages","read:history","manage:assets","write:assets"]	[{"id":"default","deny":false,"match":"START","roles":["read:pages","read:assets","read:comments","write:comments","write:pages","manage:pages","read:history","write:assets","manage:assets"],"path":"pmbc/seduc/nei/pio","locales":[]},{"id":"d5ea0eb135","deny":false,"match":"EXACT","roles":["read:pages","read:assets","read:comments","write:comments"],"path":"pmbc/seduc/nei","locales":[]},{"id":"a273e60277","deny":false,"match":"EXACT","roles":["read:pages","read:assets","read:comments","write:comments"],"path":"pmbc/seduc","locales":[]},{"id":"c44373f7ff","deny":false,"match":"EXACT","roles":["read:pages","read:assets","read:comments","write:comments"],"path":"pmbc","locales":[]}]	f	2026-11-01T19:09:04.005Z	2026-11-03T23:41:18.014Z	/pmbc/seduc/nei/pio
10	diti-admin	["read:pages","read:assets","read:comments","write:comments","write:pages","manage:pages","read:history","write:assets","manage:assets"]	[{"id":"default","deny":false,"match":"START","roles":["read:pages","read:assets","read:comments","write:comments","write:pages","manage:pages","read:history","write:assets","manage:assets"],"path":"pmbc/segov/diti","locales":[]},{"id":"1e0f15d7d4","deny":false,"match":"EXACT","roles":["read:pages","read:assets","read:comments","write:comments"],"path":"pmbc/segov","locales":[]},{"id":"73e4c474cb","deny":false,"match":"EXACT","roles":["read:pages","read:assets","read:comments","write:comments"],"path":"pmbc","locales":[]}]	f	2026-11-01T19:09:10.214Z	2026-11-03T23:41:32.367Z	/pmbc/segov/diti
4	decc-admin	["read:pages","read:assets","read:comments","write:comments","write:pages","manage:pages","read:history","write:assets","manage:comments","manage:assets"]	[{"id":"default","deny":false,"match":"START","roles":["read:pages","read:assets","read:comments","write:comments","write:pages","manage:pages","read:history","write:assets","manage:assets"],"path":"pmbc/searp/decc","locales":[]},{"id":"02d18dcd37","deny":false,"match":"EXACT","roles":["read:pages","read:assets"],"path":"pmbc/searp","locales":[]},{"id":"32d98f2749","deny":false,"match":"EXACT","roles":["read:pages","read:assets"],"path":"pmbc","locales":[]}]	f	2026-11-01T19:08:31.980Z	2026-11-03T23:41:45.758Z	/pmbc/searp/decc
7	pal-admin	["read:pages","read:assets","read:comments","write:comments","write:pages","manage:pages","read:history","write:assets","manage:assets"]	[{"id":"default","deny":false,"match":"START","roles":["read:pages","read:assets","read:comments","write:comments","write:pages","manage:pages","read:history","write:assets","manage:assets"],"path":"pmbc/seduc/cem/pal","locales":[]},{"id":"302c12b6a6","deny":false,"match":"EXACT","roles":["read:pages","read:assets","write:comments","read:comments"],"path":"pmbc/seduc/cem","locales":[]},{"id":"6f15c6ae35","deny":false,"match":"EXACT","roles":["read:pages","read:assets","read:comments","write:comments"],"path":"pmbc/seduc","locales":[]},{"id":"71591fe2d3","deny":false,"match":"EXACT","roles":["read:pages","read:assets","read:comments","write:comments"],"path":"pmbc","locales":[]}]	f	2026-11-01T19:08:49.917Z	2026-11-03T23:39:57.952Z	/pmbc/seduc/cem/pal
\.


--
-- Data for Name: locales; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public.locales (code, strings, "isRTL", name, "nativeName", availability, "createdAt", "updatedAt") FROM stdin;
pt-br	{"common":{"footer":{"poweredBy":"Distribuído por","copyright":"© {{year}} {{company}}. Todos os direitos reservados.","license":"O conteúdo está disponível sob a licença {{license}}, por {{company}}."},"actions":{"save":"Salvar","cancel":"Cancelar","download":"Baixar","upload":"Carregar","discard":"Descartar","clear":"Limpar","create":"Criar","edit":"Editar","delete":"Excluir","refresh":"Atualizar","saveChanges":"Salvar alterações","proceed":"Prosseguir","ok":"OK","add":"Adicionar","apply":"Aplicar","browse":"Navegar…","close":"Fechar","page":"Página","discardChanges":"Descartar alterações","move":"Mover","rename":"Renomear","optimize":"Otimizar","preview":"Pré-visualização","properties":"Propriedades","insert":"Inserir","fetch":"Buscar","generate":"Gerar","confirm":"Confirmar","copy":"Copiar","returnToTop":"Retornar ao topo","exit":"Sair","select":"Selecionar","convert":"Converter"},"newpage":{"title":"Esta página ainda não existe.","subtitle":"Você deseja criá-la agora?","create":"Criar página","goback":"Voltar"},"unauthorized":{"title":"Não autorizado","action":{"view":"Você não pode visualizar essa página.","source":"Você não pode ver o código fonte da página.","history":"Você não pode ver o histórico da página.","edit":"Você não pode editar a página.","create":"Você não pode criar a página.","download":"Você não pode baixar o conteúdo da página.","downloadVersion":"Você não pode baixar o conteúdo desta versão da página.","sourceVersion":"Você não pode ver o código fonte desta versão da página."},"goback":"Voltar","login":"Entrar como…"},"notfound":{"gohome":"Página inicial","title":"Não encontrado","subtitle":"Esta página não existe."},"welcome":{"title":"Bem-vindo à sua wiki!","subtitle":"Vamos começar a criar a sua página inicial.","createhome":"Criar página inicial","goadmin":"Administração"},"header":{"home":"Página inicial","newPage":"Nova página","currentPage":"Página atual","view":"Ver","edit":"Editar","history":"Histórico","viewSource":"Ver código fonte","move":"Mover/renomear","delete":"Excluir","assets":"Recursos","imagesFiles":"Imagens e arquivos","search":"Pesquisar…","admin":"Administração","account":"Conta","myWiki":"Minha wiki","profile":"Perfil","logout":"Sair","login":"Login","searchHint":"Digite pelo menos 2 caracteres para iniciar a pesquisa…","searchLoading":"Procurando…","searchNoResult":"Nenhuma página corresponde à sua pesquisa.","searchResultsCount":"{{total}} resultados encontrados","searchDidYouMean":"Você quis dizer…","searchClose":"Fechar","searchCopyLink":"Copiar link de pesquisa","language":"Idioma","browseTags":"Procurar por palavras-chave","siteMap":"Mapa do site","pageActions":"Ações da página","duplicate":"Duplicar","convert":"Converter"},"page":{"lastEditedBy":"Editado pela última vez por","unpublished":"Não publicado","editPage":"Editar página","toc":"Índice","bookmark":"Favoritos","share":"Compartilhar","printFormat":"Formato de impressão","delete":"Excluir página","deleteTitle":"Você deseja mesmo excluir a página {{title}}?","deleteSubtitle":"A página pode ser restaurada a partir da área de administração.","viewingSource":"Exibindo o código fonte da página {{path}}","returnNormalView":"Retornar para a visualização normal","id":"ID {{id}}","published":"Publicada","private":"Privada","global":"Global","loading":"Carregando página…","viewingSourceVersion":"Exibindo o código fonte da página {{path}} em {{date}}","versionId":"ID da versão: {{id}}","unpublishedWarning":"Esta página não está publicada.","tags":"Palavras-chave","tagsMatching":"Páginas correspondentes às palavras-chave","convert":"Converter Página","convertTitle":"Selecione o editor que deseja usar a partir de agora para a página {{title}}","convertSubtitle":"O conteúdo da página será convertido no formato do editor recém-selecionado. Observe que parte da formatação ou do conteúdo não renderizado pode ser perdido como resultado da conversão. Um snapshot será adicionado ao histórico da página e pode ser restaurado a qualquer momento.","editExternal":"Editar usando {{name}}"},"error":{"unexpected":"Ocorreu um erro inesperado."},"password":{"veryWeak":"Muito fraca","weak":"Fraca","average":"Média","strong":"Forte","veryStrong":"Muito forte"},"user":{"search":"Pesquisar usuário","searchPlaceholder":"Pesquisar usuários…"},"duration":{"every":"A cada","minutes":"Minuto(s)","hours":"Hora(s)","days":"Dia(s)","months":"Mês(es)","years":"Ano(s)"},"outdatedBrowserWarning":"Seu navegador está desatualizado. Atualize para um {{modernBrowser}}.","modernBrowser":"navegador compatível","license":{"none":"Nenhuma","ccby":"Creative Commons Attribution","ccbysa":"Creative Commons Attribution-ShareAlike","ccbynd":"Creative Commons Attribution-NoDerivs","ccbync":"Creative Commons Attribution-NonCommercial","ccbyncsa":"Creative Commons Attribution-NonCommercial-ShareAlike","ccbyncnd":"Creative Commons Attribution-NonCommercial-NoDerivs","cc0":"Domínio público","alr":"Todos os direitos reservados"},"sidebar":{"browse":"Navegar","mainMenu":"Menu principal","currentDirectory":"Diretório atual","root":"(raiz)"},"comments":{"title":"Comentários","newPlaceholder":"Escreva um novo comentário…","fieldName":"Seu nome","fieldEmail":"Seu endereço de e-mail","markdownFormat":"Formato Markdown","postComment":"Publicar comentário","loading":"Carregando comentários…","postingAs":"Postagem como {{name}}","beFirst":"Seja o primeiro a comentar.","none":"Ainda não há comentários.","updateComment":"Atualizar comentário","deleteConfirmTitle":"Confirmar exclusão","deleteWarn":"Deseja mesmo excluir este comentário permanentemente?","deletePermanentWarn":"Esta ação não pode ser desfeita!","modified":"modificado {{reldate}}","postSuccess":"Novo comentário publicado com êxito.","contentMissingError":"O comentário está vazio ou é muito curto!","updateSuccess":"O comentário foi atualizado com êxito.","deleteSuccess":"O comentário foi excluído com êxito.","viewDiscussion":"Ver discussão","newComment":"Novo comentário","fieldContent":"Conteúdo do comentário","sdTitle":"Comentários"},"pageSelector":{"createTitle":"Selecione o Local da Nova Página","moveTitle":"Mover/Renomear Local da Página","selectTitle":"Selecione uma Página","virtualFolders":"Pastas Virtuais","pages":"Páginas","folderEmptyWarning":"Esta pasta está vazia."}},"auth":{"loginRequired":"Login necessário","fields":{"emailUser":"E-mail/Usuário","password":"Senha","email":"Endereço de e-mail","verifyPassword":"Verificar senha","name":"Nome","username":"Nome de usuário"},"actions":{"login":"Entrar","register":"Cadastrar"},"errors":{"invalidLogin":"Login Inválido","invalidLoginMsg":"O e-mail ou senha é inválido.","invalidUserEmail":"E-mail de usuário inválido","loginError":"Erro de login","notYetAuthorized":"Você ainda não foi autorizado a fazer login neste site.","tooManyAttempts":"Muitas tentativas!","tooManyAttemptsMsg":"Você falhou em muitas tentativas num curto período. Tente novamente em {{time}}.","userNotFound":"Usuário não encontrado"},"providers":{"local":"Local","windowslive":"Conta Microsoft","azure":"Azure Active Directory","google":"Google ID","facebook":"Facebook","github":"GitHub","slack":"Slack","ldap":"LDAP/Active Directory"},"tfa":{"title":"Autenticação de dois fatores","subtitle":"Código de segurança obrigatório:","placeholder":"XXXXXX","verifyToken":"Verificar"},"registerTitle":"Criar uma conta","switchToLogin":{"text":"Já possui uma conta? {{link}}","link":"Fazer login em vez disso"},"loginUsingStrategy":"Entrar usando {{strategy}}","forgotPasswordLink":"Esqueceu sua senha?","orLoginUsingStrategy":"ou entre usando…","switchToRegister":{"text":"Ainda não tem uma conta? {{link}}","link":"Crie uma conta"},"invalidEmailUsername":"Digite um e-mail/nome de usuário válido.","invalidPassword":"Digite uma senha válida.","loginSuccess":"Login feito com sucesso! Redirecionando…","signingIn":"Entrando…","genericError":"A autenticação não está disponível.","registerSubTitle":"Preencha o formulário abaixo para criar a sua conta.","pleaseWait":"Só um instante…","registerSuccess":"Conta criada com sucesso!","registering":"Criando conta…","missingEmail":"Está faltando o endereço de e-mail.","invalidEmail":"O endereço de e-mail é inválido.","missingPassword":"Está faltando a senha.","passwordTooShort":"A senha é muito pequena.","passwordNotMatch":"As senhas não correspondem.","missingName":"Está faltando o nome.","nameTooShort":"O nome é muito pequeno.","nameTooLong":"O nome é muito grande.","forgotPasswordCancel":"Cancelar","sendResetPassword":"Redefinir senha","forgotPasswordSubtitle":"Digite o seu endereço de e-mail para receber as instruções para redefinir a sua senha.","registerCheckEmail":"Verifique o seu e-mail para ativar a sua conta.","changePwd":{"subtitle":"Insira uma nova senha","instructions":"Você deve escolher uma nova senha:","newPasswordPlaceholder":"Nova senha","newPasswordVerifyPlaceholder":"Verificar Nova Senha","proceed":"Alterar Senha","loading":"Alterando a senha…"},"forgotPasswordLoading":"Solicitando redefinição de senha…","forgotPasswordSuccess":"Verifique seus e-mails para obter instruções de redefinição de senha!","selectAuthProvider":"Selecione o provedor de autenticação","enterCredentials":"Insira as suas credenciais","forgotPasswordTitle":"Esqueceu sua senha?","tfaFormTitle":"Digite o código de segurança gerado pelo seu dispositivo de confiança:","tfaSetupTitle":"Seu administrador determinou que a autenticação de dois fatores (2FA) seja ativada na sua conta.","tfaSetupInstrFirst":"1) Escaneie o código QR abaixo a partir de seu aplicativo móvel de autenticação de dois fatores:","tfaSetupInstrSecond":"2) Digite o código de segurança gerado pelo seu dispositivo de confiança:"},"admin":{"dashboard":{"title":"Visão geral","subtitle":"Wiki.js","pages":"Páginas","users":"Usuários","groups":"Grupos","versionLatest":"Você está usando a versão mais recente.","versionNew":"Uma nova versão está disponível {{version}}","contributeSubtitle":"O Wiki.js é um projeto de código aberto e gratuito. Existem várias maneiras de contribuir para o projeto.","contributeHelp":"Precisamos da sua ajuda!","contributeLearnMore":"Saiba mais","recentPages":"Páginas recentes","mostPopularPages":"Páginas populares","lastLogins":"Últimos logins"},"general":{"title":"Geral","subtitle":"Principais configurações da sua wiki","siteInfo":"Informações do site","siteBranding":"Marca do site","general":"Geral","siteUrl":"URL do site","siteUrlHint":"URL completa da sua wiki, sem a barra final. (Por exemplo: https://wiki.exemplo.com)","siteTitle":"Título do site","siteTitleHint":"Exibido na barra superior e adicionado aos metadados de todas as páginas.","logo":"Logo","uploadLogo":"Enviar logo","uploadClear":"Limpar","uploadSizeHint":"Uma imagem de {{size}} pixels é recomendada para melhores resultados.","uploadTypesHint":"Somente arquivos {{typeList}} ou {{lastType}}","footerCopyright":"Direitos autorais no rodapé","companyName":"Nome da empresa/organização","companyNameHint":"Nome a ser usado ao exibir o aviso de direitos autorais no rodapé. Deixe vazio para esconder.","siteDescription":"Descrição do site","siteDescriptionHint":"Descrição padrão quando nenhuma é inserida em uma página.","metaRobots":"Meta Robots","metaRobotsHint":"Padrão: Index, Follow. Também pode ser definido individualmente por página.","logoUrl":"URL do logo","logoUrlHint":"Escolha uma imagem para usar como logo. Imagens em SVG, PNG e JPG são aceitas, em proporção quadrada, com no mínimo 34 × 34 pixels. Clique no botão à direita para enviar uma nova imagem.","contentLicense":"Licença do conteúdo","contentLicenseHint":"Licença exibida no rodapé de todas as páginas de conteúdo.","siteTitleInvalidChars":"O título do site contém caracteres inválidos.","saveSuccess":"As configurações do site foram salvas com êxito.","pageExtensions":"Extensões de página","pageExtensionsHint":"Uma lista separada por vírgulas de extensões de URL que serão tratadas como páginas. Por exemplo, adicionar md tratará /foobar.md da mesma forma que /foobar.","editMenuExternalName":"Título do Botão","editMenuExternalNameHint":"Nome do site externo a ser mostrado no botão de editar. Não inclua o prefixo \\"Editar usando\\".","editMenuExternalIcon":"Ícone do Botão","editMenuExternalIconHint":"O ícone a ser mostrado no botão de editar. Por exemplo, mdi-github para mostrar o íncone do GitHub.","editMenuExternalUrl":"URL do Botão","editMenuExternalUrlHint":"URL para a página em um repositório externo. O texto {filename} pode ser usado como um placeholder para o nome do arquivo. (ex.: https://github.com/foo/bar/blob/main/{filename})","editShortcuts":"Editar Atalhos","editFab":"Editar Barra de Menu","editFabHint":"Exibir o botão de edição flutuante (FAB, floating action button) com um menu dinâmico no canto inferior direito","editMenuBar":"Editar Barra de Menu","displayEditMenuBar":"Exibir o menu de edição","displayEditMenuBarHint":"Mostrar a barra de menu de edição no cabeçalho da página.","displayEditMenuBtn":"Mostrar Botão de Editar","displayEditMenuBtnHint":"Mostrar um botão para editar a página atual.","displayEditMenuExternalBtn":"Mostrar Botão Externo de Editar","displayEditMenuExternalBtnHint":"Mostrar um botão com link a um repositório externo (ex.: GitHub) onde usuários podem editar ou enviar um PR para a página atual.","footerOverride":"Substituição do Texto do Rodapé","footerOverrideHint":"Opcionalmente, substitua o texto do rodapé por uma mensagem personalizada. Útil se nenhuma das licenças acima for apropriada."},"locale":{"title":"Idioma","subtitle":"Defina opções de localização para sua wiki","settings":"Configurações de idioma","namespacing":"Namespace multilíngue","downloadTitle":"Baixar idioma","base":{"labelWithNS":"Idioma principal","hint":"All UI text elements will be displayed in selected language.","label":"Idioma do site"},"autoUpdate":{"label":"Atualizar Automaticamente","hintWithNS":"Baixar atualizações automaticamente para todos os idiomas com namespaces ativados abaixo.","hint":"Baixar atualizações automaticamente para esse idioma à medida que elas se tornem disponíveis."},"namespaces":{"label":"Namespaces Multilíngues","hint":"Habilita várias versões de idioma da mesma página."},"activeNamespaces":{"label":"Namespaces Ativos","hint":"Lista de idiomas ativos para separação de artigos por idioma. O idioma principal definido acima sempre será incluído, independentemente desta seleção."},"namespacingPrefixWarning":{"title":"O código de idioma será prefixado a todos os caminhos. (por exemplo: /{{langCode}}/nome-da-pagina)","subtitle":"Caminhos sem um código de idioma serão automaticamente redirecionados para o idioma principal definido acima."},"sideload":"Carregar pacote de idioma","sideloadHelp":"Se não estiver conectado à internet ou não puder fazer o download dos arquivos de idioma usando o método acima, você pode carregar os arquivos manualmente fazendo o upload deles abaixo.","code":"Código","name":"Nome","nativeName":"Nome nativo","rtl":"Direita para a esquerda (RTL)","availability":"Disponibilidade","download":"Download"},"stats":{"title":"Estatísticas"},"theme":{"title":"Tema","subtitle":"Modifique a aparência da sua wiki","siteTheme":"Tema do site","siteThemeHint":"Os temas afetarão como as páginas de conteúdo serão exibidas. Outras seções do site (como o editor ou a área administrativa) não serão afetadas.","darkMode":"Modo Escuro","darkModeHint":"Não recomendado para acessibilidade. Pode não ser suportado por todos os temas.","codeInjection":"Injeção de Código","cssOverride":"Substituição de CSS","cssOverrideHint":"Código CSS a ser injetado após o CSS padrão do sistema. Considere usar temas personalizados se você tiver uma grande quantidade de código CSS. Injetar código CSS demais resultará em um desempenho reduzido no carregamento das páginas! O CSS será automaticamente minificado.","headHtmlInjection":"Injeção de HTML no Head","headHtmlInjectionHint":"Código HTML a ser injetado logo antes de fechar a tag head. Geralmente para tags script.","bodyHtmlInjection":"Injeção de HTML no body","bodyHtmlInjectionHint":"Código HTML a ser injetado logo antes do fechamento da tag body.","downloadThemes":"Baixar temas","iconset":"Ícones do Tema","iconsetHint":"Conjunto de ícones para usar na navegação da barra lateral.","downloadName":"Nome","downloadAuthor":"Autor","downloadDownload":"Download","cssOverrideWarning":"{{caution}} Ao adicionar estilos ao conteúdo da página, você deve aplicá-los à classe {{cssClass}}. Omitir isso poderá causar erros ao layout do editor!","cssOverrideWarningCaution":"Cuidado:","options":"Opções do tema","tocHeadingLevels":"Níveis de título de Índice padrão","tocHeadingLevelsHint":"O índice mostrará os títulos de e até os níveis selecionados por padrão."},"groups":{"title":"Grupos"},"users":{"title":"Usuários","active":"Ativo","inactive":"Inativo","verified":"Verificado","unverified":"Não verificado","edit":"Editar usuário","id":"ID {{id}}","basicInfo":"Informações básicas","email":"E-mail","displayName":"Nome de exibição","authentication":"Autenticação","authProvider":"Provedor","password":"Senha","changePassword":"Alterar senha","newPassword":"Nova senha","tfa":"Verificação em duas etapas","toggle2FA":"Ativar/desativar verificação em duas etapas","authProviderId":"ID do provedor","groups":"Grupos de usuários","noGroupAssigned":"Este usuário ainda não está atribuído a nenhum grupo ainda. Você deve atribuir pelo menos um grupo a um usuário.","selectGroup":"Selecionar grupo…","groupAssign":"Atribuir","extendedMetadata":"Metadados adicionais","location":"Localização","jobTitle":"Cargo","timezone":"Fuso horário","userUpdateSuccess":"Usuário atualizado com sucesso.","userAlreadyAssignedToGroup":"O usuário já está atribuído a este grupo!","deleteConfirmTitle":"Excluir o usuário?","deleteConfirmText":"Você deseja mesmo excluir o usuário {{username}}?","updateUser":"Atualizar usuário","groupAssignNotice":"Você não pode adicionar usuários para os grupos Administradores e Convidados a partir deste painel.","deleteConfirmForeignNotice":"Você não pode apagar um usuário que possui conteúdo criado por ele. Você deve desativar o usuário ou excluir todos os conteúdos criados por ele.","userVerifySuccess":"O usuário foi verificado com sucesso.","userActivateSuccess":"Usuário ativado com sucesso.","userDeactivateSuccess":"Usuário desativado com sucesso.","deleteConfirmReplaceWarn":"Todo o conteúdo criado por este usuário (páginas, uploads, comentários, etc.) será reatribuído ao usuário selecionado abaixo. Recomendamos criar um usuário de destino fictício (por exemplo: “Usuário excluído”) se você não quiser que o conteúdo seja reatribuído a algum usuário atualmente ativo.","userTFADisableSuccess":"Autenticação de dois fatores desativada com êxito.","userTFAEnableSuccess":"Autenticação de dois fatores ativada com êxito."},"auth":{"title":"Autenticação","subtitle":"Configure as definições de autenticação da sua wiki","strategies":"Estratégias","globalAdvSettings":"Configurações Avançadas Globais","jwtAudience":"Público JWT","jwtAudienceHint":"URN do público usado no JWT emitido no login. Geralmente seu nome de domínio. (por exemplo: urn:seu.dominio.com)","tokenExpiration":"Expiração do Token","tokenExpirationHint":"O período de expiração de um token até que ele deva ser renovado. (padrão: 30m)","tokenRenewalPeriod":"Período de renovação do token","tokenRenewalPeriodHint":"O período máximo em que um token pode ser renovado quando expirado. (padrão: 14d)","strategyState":"Esta estratégia está {{state}} {{locked}}","strategyStateActive":"ativa","strategyStateInactive":"inativa","strategyStateLocked":"e não pode ser desativada.","strategyConfiguration":"Configurações da estratégia","strategyNoConfiguration":"Esta estratégia não possui configurações que possam ser modificadas.","registration":"Cadastro","selfRegistration":"Permitir autorregistro","selfRegistrationHint":"Permitir que qualquer usuário autorizado pela estratégia com êxito acesse a wiki.","domainsWhitelist":"Limitar para domínios de e-mail específicos","domainsWhitelistHint":"Uma lista de domínios autorizados que podem se registrar. O domínio do endereço de e-mail do usuário deve corresponder a um destes para obter acesso.","autoEnrollGroups":"Atribuir ao grupo","autoEnrollGroupsHint":"Atribuir automaticamente novos usuários a esses grupos.","security":"Segurança","force2fa":"Forçar todos os usuários a usar a verificação em duas etapas","force2faHint":"Os usuários precisarão configurar a verificação em duas etapas no primeiro login e isto não poderá ser desativado pelo usuário.","configReference":"Referência de Configuração","configReferenceSubtitle":"Algumas estratégias podem exigir que algumas configurações sejam definidas no seu provedor. Estas são providas apenas para referência e podem não ser necessárias pela estratégia atual.","siteUrlNotSetup":"Você deve definir uma {{siteUrl}} válida primeiro! Clique em {{general}} na barra lateral esquerda.","allowedWebOrigins":"Origens da web permitidas","callbackUrl":"URL de callback/URI de redirecionamento","loginUrl":"URL de login","logoutUrl":"URL de logout","tokenEndpointAuthMethod":"Método de Autenticação de Endpoint de Token","refreshSuccess":"A lista de estratégias foi atualizada.","saveSuccess":"Configuração de autenticação salva com sucesso.","activeStrategies":"Estratégias ativas","addStrategy":"Adicionar estratégia","strategyIsEnabled":"Ativo","strategyIsEnabledHint":"Os usuários podem fazer login usando esta estratégia?","displayName":"Nome de exibição","displayNameHint":"O título mostrado ao usuário final para esta estratégia de autenticação."},"editor":{"title":"Editor"},"logging":{"title":"Logging"},"rendering":{"title":"Renderização","subtitle":"Configure o pipeline de renderização das páginas"},"search":{"title":"Mecanismo de busca","subtitle":"Configure as capacidades de pesquisa da sua wiki","rebuildIndex":"Reconstruir índice","searchEngine":"Mecanismo de busca","engineConfig":"Configuração do mecanismo","engineNoConfig":"Este mecanismo não possui configurações que possam ser modificadas.","listRefreshSuccess":"A lista de mecanismos de pesquisa foi atualizada.","configSaveSuccess":"Configurações de mecanismo de pesquisa salva com sucesso.","indexRebuildSuccess":"Índice reconstruído com sucesso."},"storage":{"title":"Armazenamento","subtitle":"Defina os destinos de backup e sincronização do seu conteúdo","targets":"Destinos","status":"Status","lastSync":"Última sincronização: {{time}}","lastSyncAttempt":"A última tentativa foi {{time}}","errorMsg":"Mensagem de erro","noTarget":"Você não possui nenhum local de armazenamento ativo.","targetConfig":"Configurações do local de armazenamento","noConfigOption":"Este local de armazenamento não possui configurações que possam ser modificadas.","syncDirection":"Direção da sincronização","syncDirectionSubtitle":"Defina como a sincronização de conteúdo é tratada para este local de armazenamento.","syncDirBi":"Bidirecional","syncDirPush":"Enviar para o destino","syncDirPull":"Baixar do destino","unsupported":"Não suportado","syncDirBiHint":"No modo bidirecional, o conteúdo é inicialmente baixado do armazenamento remoto. Qualquer conteúdo novo sobrescreverá o conteúdo local. O conteúdo novo desde a última sincronização é então enviado para o armazenamento remoto, sobrescrevendo qualquer conteúdo no destino (caso existente).","syncDirPushHint":"O conteúdo é sempre enviado para o armazenamento remoto, sobrescrevendo qualquer conteúdo nele. Esta é a escolha mais segura para situações de backup.","syncDirPullHint":"O conteúdo é sempre baixado do armazenamento remoto, sobrescrevendo qualquer conteúdo local que já exista. Essa opção é geralmente utilizada para importações de uso único. Cuidado com esta opção, pois qualquer conteúdo local será sempre sobrescrito!","syncSchedule":"Agenda de sincronização","syncScheduleHint":"Por motivos de desempenho, este local de armazenamento sincroniza alterações com base em intervalos de tempo, ao invés de a cada alteração. Defina o intervalo no qual a sincronização deve ocorrer.","syncScheduleCurrent":"Atualmente definido para a cada {{schedule}}","syncScheduleDefault":"O padrão é a cada {{schedule}}","actions":"Ações","actionRun":"Executar","targetState":"Este destino de armazenamento está {{state}}","targetStateActive":"ativo","targetStateInactive":"inativo","actionsInactiveWarn":"Você deve ativar este destino de armazenamento e aplicar as mudanças antes de poder executar a ação."},"api":{"title":"Acesso à API","subtitle":"Gerencie chaves de acesso à API","enabled":"API ativada","disabled":"API desativada","enableButton":"Ativar API","disableButton":"Desativar API","newKeyButton":"Nova chave de API","headerName":"Nome","headerKeyEnding":"Final da chave","headerExpiration":"Expiração","headerCreated":"Criada","headerLastUpdated":"Última alteração","headerRevoke":"Revogar","noKeyInfo":"Nenhuma chave de API foi gerada ainda.","revokeConfirm":"Revogar chave de API?","revokeConfirmText":"Você deseja mesmo revogar a chave {{name}}? Esta ação não poderá ser desfeita!","revoke":"Revogar","refreshSuccess":"A lista de chaves de API foi atualizada.","revokeSuccess":"A chave foi revogada com êxito.","newKeyTitle":"Nova chave de API","newKeySuccess":"Chave de API criada com êxito.","newKeyNameError":"O nome é inválido ou está faltando.","newKeyGroupError":"Você deve escolher um grupo.","newKeyGuestGroupError":"O grupo de convidados não pode ser usado para chaves de API.","newKeyNameHint":"Propósito desta chave","newKeyName":"Nome","newKeyExpiration":"Validade","newKeyExpirationHint":"Você ainda pode revogar uma chave a qualquer momento, independentemente da validade.","newKeyPermissionScopes":"Escopos de permissão","newKeyFullAccess":"Acesso total","newKeyGroupPermissions":"ou use permissões de grupo…","newKeyGroup":"Grupo","newKeyGroupHint":"A chave de API terá as mesmas permissões que o grupo selecionado.","expiration30d":"30 dias","expiration90d":"90 dias","expiration180d":"180 dias","expiration1y":"1 ano","expiration3y":"3 anos","newKeyCopyWarn":"Copie a chave mostrada abaixo, pois {{bold}}","newKeyCopyWarnBold":"ela NÃO será mostrada novamente","toggleStateEnabledSuccess":"API ativada com êxito.","toggleStateDisabledSuccess":"API desativada com êxito."},"system":{"title":"Informações do Sistema","subtitle":"Informações sobre o seu sistema","hostInfo":"Informações do host","currentVersion":"Versão Atual","latestVersion":"Versão mais recente","published":"Publicado","os":"Sistema Operacional","hostname":"Hostname","cpuCores":"Núcleos da CPU","totalRAM":"RAM total","workingDirectory":"Diretório de trabalho","configFile":"Arquivo de configuração","ramUsage":"Uso de RAM: {{used}}/{{total}}","dbPartialSupport":"A versão do seu banco de dados não é totalmente suportada. Algumas funcionalidades podem ser limitadas ou não funcionar conforme o esperado.","refreshSuccess":"As informações do sistema foram atualizadas."},"utilities":{"title":"Utilidades","subtitle":"Ferramentas de manutenção e diversas","tools":"Ferramentas","authTitle":"Autenticação","authSubtitle":"Várias ferramentas para autenticação/usuários","cacheTitle":"Limpar cache","cacheSubtitle":"Limpa o cache de vários componentes","graphEndpointTitle":"Endpoint do GraphQL","graphEndpointSubtitle":"Alterar o endpoint do GraphQL para a Wiki.js","importv1Title":"Importar do Wiki.js 1.x","importv1Subtitle":"Migrar dados de uma instalação versão 1.x anterior","telemetryTitle":"Telemetria","telemetrySubtitle":"Ativar/desativar a telemetria ou redefinir o ID do cliente","contentTitle":"Conteúdo","contentSubtitle":"Ferramentas diversas para páginas","exportTitle":"Exportar para Disco","exportSubtitle":"Salvar conteúdo para tarball para backup / migração"},"dev":{"title":"Ferramentas de Desenvolvedor","flags":{"title":"Flags"},"graphiql":{"title":"GraphiQL"},"voyager":{"title":"Voyager"}},"contribute":{"title":"Contribua para o Wiki.js","subtitle":"Apoie o desenvolvimento e as operações do Wiki.js","fundOurWork":"Financie o nosso trabalho","spreadTheWord":"Espalhe a palavra","talkToFriends":"Fale com seus colegas e amigos sobre como o Wiki.js é incrível!","followUsOnTwitter":"Siga-nos no {{0}}.","submitAnIdea":"Envie uma ideia ou vote em uma proposta no {{0}}.","submitAnIdeaLink":"quadro de solicitações de funcionalidades","foundABug":"Encontrou uma falha? Envie uma issue no {{0}}","helpTranslate":"Ajude a traduzir o Wiki.js para o seu idioma. Avise-nos no {{0}}.","makeADonation":"Faça uma doação","contribute":"Contribuir","openCollective":"Wiki.js também faz parte da iniciativa Open Collective, um fundo transparente que vai para recursos da comunidade. Você pode contribuir financeiramente fazendo uma doação mensal ou única:","needYourHelp":"Precisamos da sua ajuda para continuarmos melhorando o software e operando os vários serviços associados (hospedagem e rede, por exemplo).","openSource":"Wiki.js é um software gratuito e de código aberto trazido para você com {{0}} pela {{1}} e {{2}}","openSourceContributors":"contribuidores","tshirts":"Você também pode comprar camisetas do Wiki.js para apoiar financeiramente o projeto:","shop":"Loja Wiki.js","becomeAPatron":"Ajude pelo Patreon","patreon":"Torne-se um apoiador ou patrocinador via Patreon (ajuda diretamente o desenvolvedor chefe Nicolas Giard no seu objetivo de trabalhar em tempo integral no Wiki.js)","paypal":"Faça uma doação única ou recorrente via Paypal:","ethereum":"Aceitamos doações usando o Ethereum:","github":"Torne-se um patrocinador via GitHub Sponsors (vai ajudar diretamente o desenvolvedor chefe Nicolas Giard no objetivo de trabalhar em tempo integral no Wiki.js)","becomeASponsor":"Seja um patrocinador"},"nav":{"site":"Site","users":"Usuários","modules":"Módulos","system":"Sistema"},"pages":{"title":"Páginas"},"navigation":{"title":"Navegação","subtitle":"Gerencie a navegação do site","link":"Link","divider":"Divisor","header":"Cabeçalho","label":"Rótulo","icon":"Ícone","targetType":"Tipo de destino","target":"Destino","noSelectionText":"Selecione um item de navegação à esquerda.","untitled":"{{kind}} sem título","navType":{"external":"Link externo","home":"Página inicial","page":"Página","searchQuery":"Consulta de pesquisa","externalblank":"Link externo (nova janela)"},"edit":"Editar {{kind}}","delete":"Excluir {{kind}}","saveSuccess":"Navegação salva com sucesso.","noItemsText":"Clique no botão Adicionar para incluir seu primeiro item de navegação.","emptyList":"A navegação está vazia","visibilityMode":{"all":"Visível para todos","restricted":"Visível para os grupos selecionados…"},"selectPageButton":"Selecionar página…","mode":"Modo de navegação","modeSiteTree":{"title":"Mapa do site","description":"Modo clássico do mapa de navegação"},"modeCustom":{"title":"Navegação personalizada","description":"Menu de navegação estática + botão do mapa do site"},"modeNone":{"title":"Nenhum","description":"Desativar barra lateral de navegação"},"copyFromLocale":"Copiar de outro idioma…","sourceLocale":"Idioma de origem","sourceLocaleHint":"O idioma do qual os itens de navegação serão copiados.","copyFromLocaleInfoText":"Selecione o idioma do qual os itens serão copiados. Os itens serão acrescentados à lista atual de itens do idioma ativo.","modeStatic":{"title":"Navegação estática","description":"Apenas menu de navegação estático"}},"mail":{"title":"E-mail","subtitle":"Configurar definições de e-mail","configuration":"Configuração","dkim":"DKIM (opcional)","test":"Enviar um e-mail de teste","testRecipient":"E-mail do destinatário","testSend":"Enviar e-mail","sender":"Remetente","senderName":"Nome do remetente","senderEmail":"E-mail do remetente","smtp":"Configurações de SMTP","smtpHost":"Host","smtpPort":"Porta","smtpPortHint":"Geralmente a 465 (recomendada), 587 ou 25.","smtpTLS":"Seguro (TLS)","smtpTLSHint":"Deve ser ativado ao usar a porta 465, caso contrário, desativado (587 ou 25)","smtpUser":"Usuário","smtpPwd":"Senha","dkimHint":"O DKIM (DomainKeys Identified Mail) fornece uma camada de segurança em todos os e-mails enviados pelo Wiki.js ao prover os meios para que os destinatários validem o nome de domínio e garantam a autenticidade da mensagem.","dkimUse":"Usar DKIM","dkimDomainName":"Nome do domínio","dkimKeySelector":"Seletor de chaves","dkimPrivateKey":"Chave privada","dkimPrivateKeyHint":"Chave privada para o seletor no formato PEM","testHint":"Envie um e-mail de teste para garantir que suas configurações de SMTP estejam funcionando.","saveSuccess":"Configuração salva com sucesso.","sendTestSuccess":"Um e-mail de teste foi enviado com sucesso.","smtpVerifySSL":"Verificar certificado SSL","smtpVerifySSLHint":"Alguns servidores de hospedagem exigem que a verificação de certificado SSL esteja desativada. Deixe ativada para obter a segurança adequada.","smtpName":"Nome do host de identificação do cliente","smtpNameHint":"Um nome opcional para enviar ao servidor SMTP para identificar seu remetente. Deixe em branco para usar o nome do host do servidor. Para clientes do Google Workspace, esse deve ser seu nome de domínio principal."},"webhooks":{"title":"Webhooks","subtitle":"Gerenciar webhooks para serviços externos"},"adminArea":"Área administrativa","analytics":{"title":"Analytics","subtitle":"Adicione ferramentas de analytics e rastreamento à sua Wiki","providers":"Provedores","providerConfiguration":"Configurações do provedor","providerNoConfiguration":"Este provedor não possui opções de configuração que você possa modificar.","refreshSuccess":"Lista de provedores atualizada com sucesso.","saveSuccess":"Configurações de analytics salvas com sucesso"},"comments":{"title":"Comentários","provider":"Provedor","subtitle":"Adicione fóruns de discussão às suas páginas wiki","providerConfig":"Configurações do provedor","providerNoConfig":"Este provedor não possui opções de configuração que você possa modificar.","configSaveSuccess":"Configuração salva com sucesso."},"tags":{"title":"Palavras-chave","subtitle":"Gerenciar as palavras-chave das páginas","emptyList":"Nenhuma palavra-chave para exibir.","edit":"Editar palavra-chave","tag":"Palavra-chave","label":"Rótulo","date":"Criado em {{created}} e atualizado pela última vez {{updated}}.","delete":"Excluir esta palavra-chave","noSelectionText":"Selecione uma palavra-chave na lista à esquerda.","noItemsText":"Adicione uma palavra-chave a uma página para começar.","refreshSuccess":"As palavras-chave foram atualizadas.","deleteSuccess":"Palavra-chave excluída com sucesso.","saveSuccess":"Palavra-chave salva com sucesso.","filter":"Filtro…","viewLinkedPages":"Ver páginas vinculadas","deleteConfirm":"Excluir palavra-chave?","deleteConfirmText":"Você deseja mesmo excluir a palavra-chave {{tag}}? Ela também será removida de todas as páginas vinculadas."},"ssl":{"title":"SSL","subtitle":"Gerenciar configurações de SSL","provider":"Provedor","providerHint":"Selecione “Certificado personalizado” se você já possui o seu próprio certificado.","domain":"Domínio","domainHint":"Digite o domínio totalmente qualificado que aponta para a sua wiki (exemplo: wiki.exemplo.com).","providerOptions":"Opções do provedor","providerDisabled":"Desativado","providerLetsEncrypt":"Let's Encrypt","providerCustomCertificate":"Certificado personalizado","ports":"Portas","httpPort":"Porta HTTP","httpPortHint":"Porta não-SSL que o servidor escutará para solicitações HTTP. Geralmente é a 80 ou a 3000.","httpsPort":"Porta HTTPS","httpsPortHint":"Porta SSL que o servidor escutará para solicitações HTTPS. Geralmente é a 443.","httpPortRedirect":"Redirecionar solicitações HTTP para HTTPS","httpPortRedirectHint":"Redirecionará automaticamente todas as solicitações na porta HTTP para a HTTPS.","writableConfigFileWarning":"Observe que seu arquivo de configuração deve ser gravável para manter salva a configuração das portas.","renewCertificate":"Renovar certificado","status":"Status do certificado","expiration":"Expiração do certificado","subscriberEmail":"E-mail do assinante","currentState":"Estado atual","httpPortRedirectTurnOn":"Ativar","httpPortRedirectTurnOff":"Desativar","renewCertificateLoadingTitle":"Renovando certificado...","renewCertificateLoadingSubtitle":"Não saia desta página.","renewCertificateSuccess":"Certificado renovado com êxito.","httpPortRedirectSaveSuccess":"Redirecionamento HTTP alterado com êxito."},"security":{"title":"Segurança","maxUploadSize":"Tamanho máximo de envio","maxUploadBatch":"Máximo de arquivos por envio","maxUploadBatchHint":"Quantos arquivos no máximo podem ser enviados de uma única vez?","maxUploadSizeHint":"O tamanho máximo para um único arquivo.","maxUploadSizeSuffix":"bytes","maxUploadBatchSuffix":"arquivos","uploads":"Uploads","uploadsInfo":"Estas configurações afetam apenas o Wiki.js. Se estiver usando um proxy reverso (ex.: nginx, Apache, Cloudflare), você também deverá alterar as configurações dele para corresponder com as definidas aqui.","subtitle":"Configure ajustes de segurança","login":"Login","loginScreen":"Tela de login","jwt":"Configurações do JWT","bypassLogin":"Ignorar tela de login","bypassLoginHint":"Define se o usuário será automaticamente redirecionado ao primeiro provedor de autenticação.","loginBgUrl":"URL da imagem de fundo da tela de login","loginBgUrlHint":"Especifica uma imagem para usar como plano de fundo da tela de login. PNG e JPG são suportados, 1920x1080 recomendado. Deixe em branco para usar o padrão. Clique no botão à direita para fazer upload de uma nova imagem. Observe que o grupo Convidados deve ter acesso de leitura à imagem selecionada!","hideLocalLogin":"Ocultar provedor de autenticação local","hideLocalLoginHint":"Não exibe o provedor de autenticação local na tela de login. Adicione ?all ao final do URL para usá-lo temporariamente.","loginSecurity":"Segurança","enforce2fa":"Forçar verificação em duas etapas","enforce2faHint":"Obriga todos os usuários a usar a verificação em duas etapas ao usar um provedor de autenticação com um formulário de usuário/senha."},"extensions":{"title":"Extensões","subtitle":"Instale extensões para obter funcionalidades extras"}},"editor":{"page":"Página","save":{"processing":"Renderizando","pleaseWait":"Só um instante…","createSuccess":"Página criada com sucesso.","error":"Ocorreu um erro ao criar a página","updateSuccess":"Página atualizada com sucesso.","saved":"Salvo"},"props":{"pageProperties":"Propriedades da página","pageInfo":"Informações da página","title":"Título","shortDescription":"Descrição curta","shortDescriptionHint":"Exibida abaixo do título","pathCategorization":"Caminho & categorização","locale":"Idioma","path":"Caminho","pathHint":"Não inclua nenhuma barra no início ou no fim.","tags":"Palavras-chave","tagsHint":"Use palavras-chave para categorizar suas páginas e torná-las mais fáceis de encontrar.","publishState":"Estado da publicação","publishToggle":"Publicada","publishToggleHint":"Páginas não publicadas ainda podem ser vistas por usuários com permissões de escrita nesta página.","publishStart":"A publicação inicia em…","publishStartHint":"Deixe vazio para publicar imediatamente","publishEnd":"A publicação expira em…","publishEndHint":"Deixe vazio para ficar sem data final","info":"Informações","scheduling":"Agendamento","social":"Social","categorization":"Categorização","socialFeatures":"Recursos sociais","allowComments":"Permitir comentários","allowCommentsHint":"Ativa a capacidade de comentar nesta página.","allowRatings":"Permitir avaliações","displayAuthor":"Exibir informações do autor","displaySharingBar":"Exibir a barra de ferramentas de compartilhamento","displaySharingBarHint":"Mostra uma barra de ferramentas com botões para compartilhar e imprimir esta página","displayAuthorHint":"Mostra o autor da página e o horário da última edição.","allowRatingsHint":"Ativa os recursos de classificação nesta página.","scripts":"Scripts","css":"CSS","cssHint":"O CSS será minificado automaticamente após salvar. Não inclua tags <style>, apenas o código CSS.","styles":"Estilo","html":"HTML","htmlHint":"Você precisa envolver o seu código JavaScript com tags <script>.","toc":"Índice","tocTitle":"Índice","tocUseDefault":"Usar padrões do site","tocHeadingLevels":"Níveis de Título de Índice","tocHeadingLevelsHint":"O índice mostrará os títulos de e até os níveis selecionados."},"unsaved":{"title":"Descartar alterações ainda não salvas?","body":"Você possui alterações não salvas. Deseja mesmo sair do editor e descartar as alterações feitas desde o último salvamento?"},"select":{"title":"Qual editor você deseja usar para esta página?","cannotChange":"Isto não poderá ser alterado após a página ser criada.","customView":"ou crie uma exibição personalizada"},"assets":{"title":"Mídia","newFolder":"Nova pasta","folderName":"Nome da pasta","folderNameNamingRules":"Você precisa seguir as {{namingRules}} da pasta de mídia.","folderNameNamingRulesLink":"regras de nomenclatura","folderEmpty":"Esta pasta de mídia está vazia.","fileCount":"{{count}} arquivos","headerId":"ID","headerFilename":"Nome do arquivo","headerType":"Tipo","headerFileSize":"Tamanho do arquivo","headerAdded":"Adicionada","headerActions":"Ações","uploadAssets":"Enviar mídia","uploadAssetsDropZone":"Navegue ou solte arquivos aqui…","fetchImage":"Obter imagem remota","imageAlign":"Alinhamento da imagem","renameAsset":"Renomear mídia","renameAssetSubtitle":"Digite o novo nome para esta mídia:","deleteAsset":"Excluir mídia","deleteAssetConfirm":"Você deseja mesmo excluir o arquivo","deleteAssetWarn":"Esta ação não pode ser desfeita!","refreshSuccess":"Lista de mídias atualizada com sucesso.","uploadFailed":"O upload do arquivo falhou.","folderCreateSuccess":"Pasta de mídia criada com sucesso.","renameSuccess":"Mídia renomeada com sucesso.","deleteSuccess":"Mídia excluída com sucesso.","noUploadError":"Você deve escolher um arquivo para fazer upload primeiro!"},"backToEditor":"Voltar ao editor","markup":{"bold":"Negrito","italic":"Itálico","strikethrough":"Tachado","heading":"Título {{level}}","subscript":"Subscrito","superscript":"Sobrescrito","blockquote":"Bloco","blockquoteInfo":"Bloco de informação","blockquoteSuccess":"Bloco de sucesso","blockquoteWarning":"Bloco de aviso","blockquoteError":"Bloco de erro","unorderedList":"Lista não ordenada","orderedList":"Lista ordenada","inlineCode":"Código inline","keyboardKey":"Tecla do teclado","horizontalBar":"Barra horizontal","togglePreviewPane":"Ocultar/exibir painel de pré-visualização","insertLink":"Inserir link","insertAssets":"Inserir mídia","insertBlock":"Inserir bloco","insertCodeBlock":"Inserir bloco de código","insertVideoAudio":"Inserir vídeo/áudio","insertDiagram":"Inserir diagrama","insertMathExpression":"Inserir expressão matemática","tableHelper":"Ajuda de tabelas","distractionFreeMode":"Modo sem distrações","markdownFormattingHelp":"Ajuda de formatação do Markdown","noSelectionError":"O texto precisa estar selecionado antes!","toggleSpellcheck":"Alternar verificação ortográfica"},"ckeditor":{"stats":"{{chars}} caracteres, {{words}} palavras"},"conflict":{"title":"Resolver conflito e salvar","useLocal":"Usar versão local","useRemote":"Usar versão remota","useRemoteHint":"Descartar alterações locais e usar a versão mais recente","useLocalHint":"Usar o conteúdo no painel esquerdo","viewLatestVersion":"Ver versão mais recente","infoGeneric":"Uma versão mais recente desta página foi salva por {{authorName}}, {{date}}","whatToDo":"O que deseja fazer?","whatToDoLocal":"Usar sua versão local atual e ignorar as alterações mais recentes.","whatToDoRemote":"Usar a versão remota (mais recente) e descartar as suas alterações.","overwrite":{"title":"Substituir com versão remota?","description":"Você deseja mesmo substituir a sua versão atual pelo conteúdo remoto mais recente? {{refEditsLost}}","editsLost":"Suas alterações atuais serão perdidas."},"localVersion":"Versão local {{refEditable}}","editable":"(editável)","readonly":"(somente leitura)","remoteVersion":"Versão remota {{refReadOnly}}","leftPanelInfo":"Sua edição atual, com base na versão de página de {{date}}","rightPanelInfo":"Última edição por {{authorName}}, {{date}}","pageTitle":"Título:","pageDescription":"Descrição:","warning":"Erro ao salvar! Outro usuário já modificou esta página."},"unsavedWarning":"Você possui alterações não salvas. Deseja mesmo sair do editor?"},"tags":{"currentSelection":"Seleção atual","clearSelection":"Limpar seleção","selectOneMoreTags":"Selecione uma ou mais palavras-chave","searchWithinResultsPlaceholder":"Pesquisar nos resultados…","locale":"Idioma","orderBy":"Ordenar por","selectOneMoreTagsHint":"Selecione uma ou mais palavras-chave à esquerda.","retrievingResultsLoading":"Buscando resultados da página…","noResults":"Não foi possível encontrar nenhuma página com as etiquetas selecionadas.","noResultsWithFilter":"Não foi possível encontrar nenhuma página que corresponda às opções de filtragem atuais.","pageLastUpdated":"Última modificação em {{date}}","orderByField":{"creationDate":"Data de criação","ID":"ID","lastModified":"Última modificação","path":"Caminho","title":"Título"},"localeAny":"Qualquer"},"history":{"restore":{"confirmTitle":"Restaurar versão da página?","confirmText":"Você deseja mesmo restaurar o conteúdo desta página para como estava em {{date}}? Esta versão será copiada para o topo do histórico atual. Dessa forma, as versões mais recentes ainda serão preservadas.","confirmButton":"Restaurar","success":"Versão restaurada com êxito!"}},"profile":{"displayName":"Nome para exibição","location":"Localização","jobTitle":"Cargo","timezone":"Fuso horário","title":"Perfil","subtitle":"Minhas informações pessoais","myInfo":"Minhas informações","viewPublicProfile":"Ver perfil público","auth":{"title":"Autenticação","provider":"Provedor","changePassword":"Alterar senha","currentPassword":"Senha Atual","newPassword":"Nova Senha","verifyPassword":"Confirmar Nova Senha","changePassSuccess":"Senha alterada com sucesso."},"groups":{"title":"Grupos"},"activity":{"title":"Atividade","joinedOn":"Ingressou em","lastUpdatedOn":"Última atualização do perfil em","lastLoginOn":"Último login em","pagesCreated":"Páginas criadas","commentsPosted":"Comentários publicados"},"save":{"success":"Perfil salvo com sucesso."},"pages":{"title":"Páginas","subtitle":"Lista de páginas que criei ou modifiquei pela última vez","emptyList":"Sem páginas para exibir.","refreshSuccess":"A lista de páginas foi atualizada.","headerTitle":"Título","headerPath":"Caminho","headerCreatedAt":"Criado","headerUpdatedAt":"Última alteração"},"comments":{"title":"Comentários"},"preferences":"Preferências","dateFormat":"Formato de data","localeDefault":"Padrão do idioma/região","appearance":"Aparência","appearanceDefault":"Padrão do site","appearanceLight":"Claro","appearanceDark":"Escuro"}}	f	Portuguese (Brazil)	português	100	2026-11-01T19:16:02.043Z	2026-11-01T19:16:02.043Z
en	{"common":{"footer":{"poweredBy":"Powered by","copyright":"© {{year}} {{company}}. All rights reserved.","license":"Content is available under the {{license}}, by {{company}}."},"actions":{"save":"Save","cancel":"Cancel","download":"Download","upload":"Upload","discard":"Discard","clear":"Clear","create":"Create","edit":"Edit","delete":"Delete","refresh":"Refresh","saveChanges":"Save Changes","proceed":"Proceed","ok":"OK","add":"Add","apply":"Apply","browse":"Browse...","close":"Close","page":"Page","discardChanges":"Discard Changes","move":"Move","rename":"Rename","optimize":"Optimize","preview":"Preview","properties":"Properties","insert":"Insert","fetch":"Fetch","generate":"Generate","confirm":"Confirm","copy":"Copy","returnToTop":"Return to top","exit":"Exit","select":"Select","convert":"Convert"},"newpage":{"title":"This page does not exist yet.","subtitle":"Would you like to create it now?","create":"Create Page","goback":"Go back"},"unauthorized":{"title":"Unauthorized","action":{"view":"You cannot view this page.","source":"You cannot view the page source.","history":"You cannot view the page history.","edit":"You cannot edit the page.","create":"You cannot create the page.","download":"You cannot download the page content.","downloadVersion":"You cannot download the content for this page version.","sourceVersion":"You cannot view the source of this version of the page."},"goback":"Go Back","login":"Login As..."},"notfound":{"gohome":"Home","title":"Not Found","subtitle":"This page does not exist."},"welcome":{"title":"Welcome to your wiki!","subtitle":"Let's get started and create the home page.","createhome":"Create Home Page","goadmin":"Administration"},"header":{"home":"Home","newPage":"New Page","currentPage":"Current Page","view":"View","edit":"Edit","history":"History","viewSource":"View Source","move":"Move / Rename","delete":"Delete","assets":"Assets","imagesFiles":"Images & Files","search":"Search...","admin":"Administration","account":"Account","myWiki":"My Wiki","profile":"Profile","logout":"Logout","login":"Login","searchHint":"Type at least 2 characters to start searching...","searchLoading":"Searching...","searchNoResult":"No pages matching your query.","searchResultsCount":"Found {{total}} results","searchDidYouMean":"Did you mean...","searchClose":"Close","searchCopyLink":"Copy Search Link","language":"Language","browseTags":"Browse by Tags","siteMap":"Site Map","pageActions":"Page Actions","duplicate":"Duplicate","convert":"Convert"},"page":{"lastEditedBy":"Last edited by","unpublished":"Unpublished","editPage":"Edit Page","toc":"Page Contents","bookmark":"Bookmark","share":"Share","printFormat":"Print Format","delete":"Delete Page","deleteTitle":"Are you sure you want to delete page {{title}}?","deleteSubtitle":"The page can be restored from the administration area.","viewingSource":"Viewing source of page {{path}}","returnNormalView":"Return to Normal View","id":"ID {{id}}","published":"Published","private":"Private","global":"Global","loading":"Loading Page...","viewingSourceVersion":"Viewing source as of {{date}} of page {{path}}","versionId":"Version ID {{id}}","unpublishedWarning":"This page is not published.","tags":"Tags","tagsMatching":"Pages matching tags","convert":"Convert Page","convertTitle":"Select the editor you want to use going forward for the page {{title}}:","convertSubtitle":"The page content will be converted into the format of the newly selected editor. Note that some formatting or non-rendered content may be lost as a result of the conversion. A snapshot will be added to the page history and can be restored at any time.","editExternal":"Edit on {{name}}"},"error":{"unexpected":"An unexpected error occurred."},"password":{"veryWeak":"Very Weak","weak":"Weak","average":"Average","strong":"Strong","veryStrong":"Very Strong"},"user":{"search":"Search User","searchPlaceholder":"Search Users..."},"duration":{"every":"Every","minutes":"Minute(s)","hours":"Hour(s)","days":"Day(s)","months":"Month(s)","years":"Year(s)"},"outdatedBrowserWarning":"Your browser is outdated. Upgrade to a {{modernBrowser}}.","modernBrowser":"modern browser","license":{"none":"None","ccby":" Creative Commons Attribution License","ccbysa":"Creative Commons Attribution-ShareAlike License","ccbynd":"Creative Commons Attribution-NoDerivs License","ccbync":"Creative Commons Attribution-NonCommercial License","ccbyncsa":"Creative Commons Attribution-NonCommercial-ShareAlike License","ccbyncnd":"Creative Commons Attribution-NonCommercial-NoDerivs License","cc0":"Public Domain","alr":"All Rights Reserved"},"sidebar":{"browse":"Browse","mainMenu":"Main Menu","currentDirectory":"Current Directory","root":"(root)"},"comments":{"title":"Comments","newPlaceholder":"Write a new comment...","fieldName":"Your Name","fieldEmail":"Your Email Address","markdownFormat":"Markdown Format","postComment":"Post Comment","loading":"Loading comments...","postingAs":"Posting as {{name}}","beFirst":"Be the first to comment.","none":"No comments yet.","updateComment":"Update Comment","deleteConfirmTitle":"Confirm Delete","deleteWarn":"Are you sure you want to permanently delete this comment?","deletePermanentWarn":"This action cannot be undone!","modified":"modified {{reldate}}","postSuccess":"New comment posted successfully.","contentMissingError":"Comment is empty or too short!","updateSuccess":"Comment was updated successfully.","deleteSuccess":"Comment was deleted successfully.","viewDiscussion":"View Discussion","newComment":"New Comment","fieldContent":"Comment Content","sdTitle":"Talk"},"pageSelector":{"createTitle":"Select New Page Location","moveTitle":"Move / Rename Page Location","selectTitle":"Select a Page","virtualFolders":"Virtual Folders","pages":"Pages","folderEmptyWarning":"This folder is empty."}},"auth":{"loginRequired":"Login required","fields":{"emailUser":"Email / Username","password":"Password","email":"Email Address","verifyPassword":"Verify Password","name":"Name","username":"Username"},"actions":{"login":"Log In","register":"Register"},"errors":{"invalidLogin":"Invalid Login","invalidLoginMsg":"The email or password is invalid.","invalidUserEmail":"Invalid User Email","loginError":"Login error","notYetAuthorized":"You have not been authorized to login to this site yet.","tooManyAttempts":"Too many attempts!","tooManyAttemptsMsg":"You've made too many failed attempts in a short period of time, please try again {{time}}.","userNotFound":"User not found"},"providers":{"local":"Local","windowslive":"Microsoft Account","azure":"Azure Active Directory","google":"Google ID","facebook":"Facebook","github":"GitHub","slack":"Slack","ldap":"LDAP / Active Directory"},"tfa":{"title":"Two Factor Authentication","subtitle":"Security code required:","placeholder":"XXXXXX","verifyToken":"Verify"},"registerTitle":"Create an account","switchToLogin":{"text":"Already have an account? {{link}}","link":"Login instead"},"loginUsingStrategy":"Login using {{strategy}}","forgotPasswordLink":"Forgot your password?","orLoginUsingStrategy":"or login using...","switchToRegister":{"text":"Don't have an account yet? {{link}}","link":"Create an account"},"invalidEmailUsername":"Enter a valid email / username.","invalidPassword":"Enter a valid password.","loginSuccess":"Login Successful! Redirecting...","signingIn":"Signing In...","genericError":"Authentication is unavailable.","registerSubTitle":"Fill-in the form below to create your account.","pleaseWait":"Please wait","registerSuccess":"Account created successfully!","registering":"Creating account...","missingEmail":"Missing email address.","invalidEmail":"Email address is invalid.","missingPassword":"Missing password.","passwordTooShort":"Password is too short.","passwordNotMatch":"Both passwords do not match.","missingName":"Name is missing.","nameTooShort":"Name is too short.","nameTooLong":"Name is too long.","forgotPasswordCancel":"Cancel","sendResetPassword":"Reset Password","forgotPasswordSubtitle":"Enter your email address to receive the instructions to reset your password:","registerCheckEmail":"Check your emails to activate your account.","changePwd":{"subtitle":"Choose a new password","instructions":"You must choose a new password:","newPasswordPlaceholder":"New Password","newPasswordVerifyPlaceholder":"Verify New Password","proceed":"Change Password","loading":"Changing password..."},"forgotPasswordLoading":"Requesting password reset...","forgotPasswordSuccess":"Check your emails for password reset instructions!","selectAuthProvider":"Select Authentication Provider","enterCredentials":"Enter your credentials","forgotPasswordTitle":"Forgot your password","tfaFormTitle":"Enter the security code generated from your trusted device:","tfaSetupTitle":"Your administrator has required Two-Factor Authentication (2FA) to be enabled on your account.","tfaSetupInstrFirst":"1) Scan the QR code below from your mobile 2FA application:","tfaSetupInstrSecond":"2) Enter the security code generated from your trusted device:"},"admin":{"dashboard":{"title":"Dashboard","subtitle":"Wiki.js","pages":"Pages","users":"Users","groups":"Groups","versionLatest":"You are running the latest version.","versionNew":"A new version is available: {{version}}","contributeSubtitle":"Wiki.js is a free and open source project. There are several ways you can contribute to the project.","contributeHelp":"We need your help!","contributeLearnMore":"Learn More","recentPages":"Recent Pages","mostPopularPages":"Most Popular Pages","lastLogins":"Last Logins"},"general":{"title":"General","subtitle":"Main settings of your wiki","siteInfo":"Site Info","siteBranding":"Site Branding","general":"General","siteUrl":"Site URL","siteUrlHint":"Full URL to your wiki, without the trailing slash. (e.g. https://wiki.example.com)","siteTitle":"Site Title","siteTitleHint":"Displayed in the top bar and appended to all pages meta title.","logo":"Logo","uploadLogo":"Upload Logo","uploadClear":"Clear","uploadSizeHint":"An image of {{size}} pixels is recommended for best results.","uploadTypesHint":"{{typeList}} or {{lastType}} files only","footerCopyright":"Footer Copyright","companyName":"Company / Organization Name","companyNameHint":"Name to use when displaying copyright notice in the footer. Leave empty to hide.","siteDescription":"Site Description","siteDescriptionHint":"Default description when none is provided for a page.","metaRobots":"Meta Robots","metaRobotsHint":"Default: Index, Follow. Can also be set on a per-page basis.","logoUrl":"Logo URL","logoUrlHint":"Specify an image to use as the logo. SVG, PNG, JPG are supported, in a square ratio, 34x34 pixels or larger. Click the button on the right to upload a new image.","contentLicense":"Content License","contentLicenseHint":"License shown in the footer of all content pages.","siteTitleInvalidChars":"Site Title contains invalid characters.","saveSuccess":"Site configuration saved successfully.","pageExtensions":"Page Extensions","pageExtensionsHint":"A comma-separated list of URL extensions that will be treated as pages. For example, adding md will treat /foobar.md the same as /foobar.","editMenuExternalName":"Button Site Name","editMenuExternalNameHint":"The name of the external site to display on the edit button. Do not include the \\"Edit on\\" prefix.","editMenuExternalIcon":"Button Icon","editMenuExternalIconHint":"The icon to display on the edit button. For example, mdi-github to display the GitHub icon.","editMenuExternalUrl":"Button URL","editMenuExternalUrlHint":"Url to the page on the external repository. Use the {filename} placeholder where the filename should be included. (e.g. https://github.com/foo/bar/blob/main/{filename} )","editShortcuts":"Edit Shortcuts","editFab":"FAB Quick Edit Menu","editFabHint":"Display the edit floating action button (FAB) with a speed-dial menu in the bottom right corner of the screen.","editMenuBar":"Edit Menu Bar","displayEditMenuBar":"Display Edit Menu Bar","displayEditMenuBarHint":"Display the edit menu bar in the page header.","displayEditMenuBtn":"Display Edit Button","displayEditMenuBtnHint":"Display a button to edit the current page.","displayEditMenuExternalBtn":"Display External Edit Button","displayEditMenuExternalBtnHint":"Display a button linking to an external repository (e.g. GitHub) where users can edit or submit a PR for the current page.","footerOverride":"Footer Text Override","footerOverrideHint":"Optionally override the footer text with a custom message. Useful if none of the above licenses are appropriate."},"locale":{"title":"Locale","subtitle":"Set localization options for your wiki","settings":"Locale Settings","namespacing":"Multilingual Namespacing","downloadTitle":"Download Locale","base":{"labelWithNS":"Base Locale","hint":"All UI text elements will be displayed in selected language.","label":"Site Locale"},"autoUpdate":{"label":"Update Automatically","hintWithNS":"Automatically download updates to all namespaced locales enabled below.","hint":"Automatically download updates to this locale as they become available."},"namespaces":{"label":"Multilingual Namespaces","hint":"Enables multiple language versions of the same page."},"activeNamespaces":{"label":"Active Namespaces","hint":"List of locales enabled for multilingual namespacing. The base locale defined above will always be included regardless of this selection."},"namespacingPrefixWarning":{"title":"The locale code will be prefixed to all paths. (e.g. /{{langCode}}/page-name)","subtitle":"Paths without a locale code will be automatically redirected to the base locale defined above."},"sideload":"Sideload Locale Package","sideloadHelp":"If you are not connected to the internet or cannot download locale files using the method above, you can instead sideload packages manually by uploading them below.","code":"Code","name":"Name","nativeName":"Native Name","rtl":"RTL","availability":"Availability","download":"Download"},"stats":{"title":"Statistics"},"theme":{"title":"Theme","subtitle":"Modify the look & feel of your wiki","siteTheme":"Site Theme","siteThemeHint":"Themes affect how content pages are displayed. Other site sections (such as the editor or admin area) are not affected.","darkMode":"Dark Mode","darkModeHint":"Not recommended for accessibility. May not be supported by all themes.","codeInjection":"Code Injection","cssOverride":"CSS Override","cssOverrideHint":"CSS code to inject after system default CSS. Consider using custom themes if you have a large amount of css code. Injecting too much CSS code will result in poor page load performance! CSS will automatically be minified.","headHtmlInjection":"Head HTML Injection","headHtmlInjectionHint":"HTML code to be injected just before the closing head tag. Usually for script tags.","bodyHtmlInjection":"Body HTML Injection","bodyHtmlInjectionHint":"HTML code to be injected just before the closing body tag.","downloadThemes":"Download Themes","iconset":"Icon Set","iconsetHint":"Set of icons to use for the sidebar navigation.","downloadName":"Name","downloadAuthor":"Author","downloadDownload":"Download","cssOverrideWarning":"{{caution}} When adding styles for page content, you must scope them to the {{cssClass}} class. Omitting this could break the layout of the editor!","cssOverrideWarningCaution":"CAUTION:","options":"Theme Options","tocHeadingLevels":"Default TOC Heading Levels","tocHeadingLevelsHint":"The table of contents will show headings from and up to the selected levels by default."},"groups":{"title":"Groups"},"users":{"title":"Users","active":"Active","inactive":"Inactive","verified":"Verified","unverified":"Unverified","edit":"Edit User","id":"ID {{id}}","basicInfo":"Basic Info","email":"Email","displayName":"Display Name","authentication":"Authentication","authProvider":"Provider","password":"Password","changePassword":"Change Password","newPassword":"New Password","tfa":"Two Factor Authentication (2FA)","toggle2FA":"Toggle 2FA","authProviderId":"Provider Id","groups":"User Groups","noGroupAssigned":"This user is not assigned to any group yet. You must assign at least 1 group to a user.","selectGroup":"Select Group...","groupAssign":"Assign","extendedMetadata":"Extended Metadata","location":"Location","jobTitle":"Job Title","timezone":"Timezone","userUpdateSuccess":"User updated successfully.","userAlreadyAssignedToGroup":"User is already assigned to this group!","deleteConfirmTitle":"Delete User?","deleteConfirmText":"Are you sure you want to delete user {{username}}?","updateUser":"Update User","groupAssignNotice":"Note that you cannot assign users to the Administrators or Guests groups from this panel.","deleteConfirmForeignNotice":"Note that you cannot delete a user that already created content. You must instead either deactivate the user or delete all content that was created by that user.","userVerifySuccess":"User has been verified successfully.","userActivateSuccess":"User has been activated successfully.","userDeactivateSuccess":"User deactivated successfully.","deleteConfirmReplaceWarn":"Any content (pages, uploads, comments, etc.) that was created by this user will be reassigned to the user selected below. It is recommended to create a dummy target user (e.g. Deleted User) if you don't want the content to be reassigned to any current active user.","userTFADisableSuccess":"2FA was disabled successfully.","userTFAEnableSuccess":"2FA was enabled successfully."},"auth":{"title":"Authentication","subtitle":"Configure the authentication settings of your wiki","strategies":"Strategies","globalAdvSettings":"Global Advanced Settings","jwtAudience":"JWT Audience","jwtAudienceHint":"Audience URN used in JWT issued upon login. Usually your domain name. (e.g. urn:your.domain.com)","tokenExpiration":"Token Expiration","tokenExpirationHint":"The expiration period of a token until it must be renewed. (default: 30m)","tokenRenewalPeriod":"Token Renewal Period","tokenRenewalPeriodHint":"The maximum period a token can be renewed when expired. (default: 14d)","strategyState":"This strategy is {{state}} {{locked}}","strategyStateActive":"active","strategyStateInactive":"not active","strategyStateLocked":"and cannot be disabled.","strategyConfiguration":"Strategy Configuration","strategyNoConfiguration":"This strategy has no configuration options you can modify.","registration":"Registration","selfRegistration":"Allow self-registration","selfRegistrationHint":"Allow any user successfully authorized by the strategy to access the wiki.","domainsWhitelist":"Limit to specific email domains","domainsWhitelistHint":"A list of domains authorized to register. The user email address domain must match one of these to gain access.","autoEnrollGroups":"Assign to group","autoEnrollGroupsHint":"Automatically assign new users to these groups.","security":"Security","force2fa":"Force all users to use Two-Factor Authentication (2FA)","force2faHint":"Users will be required to setup 2FA the first time they login and cannot be disabled by the user.","configReference":"Configuration Reference","configReferenceSubtitle":"Some strategies may require some configuration values to be set on your provider. These are provided for reference only and may not be needed by the current strategy.","siteUrlNotSetup":"You must set a valid {{siteUrl}} first! Click on {{general}} in the left sidebar.","allowedWebOrigins":"Allowed Web Origins","callbackUrl":"Callback URL / Redirect URI","loginUrl":"Login URL","logoutUrl":"Logout URL","tokenEndpointAuthMethod":"Token Endpoint Authentication Method","refreshSuccess":"List of strategies has been refreshed.","saveSuccess":"Authentication configuration saved successfully.","activeStrategies":"Active Strategies","addStrategy":"Add Strategy","strategyIsEnabled":"Active","strategyIsEnabledHint":"Are users able to login using this strategy?","displayName":"Display Name","displayNameHint":"The title shown to the end user for this authentication strategy."},"editor":{"title":"Editor"},"logging":{"title":"Logging"},"rendering":{"title":"Rendering","subtitle":"Configure the page rendering pipeline"},"search":{"title":"Search Engine","subtitle":"Configure the search capabilities of your wiki","rebuildIndex":"Rebuild Index","searchEngine":"Search Engine","engineConfig":"Engine Configuration","engineNoConfig":"This engine has no configuration options you can modify.","listRefreshSuccess":"List of search engines has been refreshed.","configSaveSuccess":"Search engine configuration saved successfully.","indexRebuildSuccess":"Index rebuilt successfully."},"storage":{"title":"Storage","subtitle":"Set backup and sync targets for your content","targets":"Targets","status":"Status","lastSync":"Last synchronization {{time}}","lastSyncAttempt":"Last attempt was {{time}}","errorMsg":"Error Message","noTarget":"You don't have any active storage target.","targetConfig":"Target Configuration","noConfigOption":"This storage target has no configuration options you can modify.","syncDirection":"Sync Direction","syncDirectionSubtitle":"Choose how content synchronization is handled for this storage target.","syncDirBi":"Bi-directional","syncDirPush":"Push to target","syncDirPull":"Pull from target","unsupported":"Unsupported","syncDirBiHint":"In bi-directional mode, content is first pulled from the storage target. Any newer content overwrites local content. New content since last sync is then pushed to the storage target, overwriting any content on target if present.","syncDirPushHint":"Content is always pushed to the storage target, overwriting any existing content. This is safest choice for backup scenarios.","syncDirPullHint":"Content is always pulled from the storage target, overwriting any local content which already exists. This choice is usually reserved for single-use content import. Caution with this option as any local content will always be overwritten!","syncSchedule":"Sync Schedule","syncScheduleHint":"For performance reasons, this storage target synchronize changes on an interval-based schedule, instead of on every change. Define at which interval should the synchronization occur.","syncScheduleCurrent":"Currently set to every {{schedule}}.","syncScheduleDefault":"The default is every {{schedule}}.","actions":"Actions","actionRun":"Run","targetState":"This storage target is {{state}}","targetStateActive":"active","targetStateInactive":"inactive","actionsInactiveWarn":"You must enable this storage target and apply changes before you can run actions."},"api":{"title":"API Access","subtitle":"Manage keys to access the API","enabled":"API Enabled","disabled":"API Disabled","enableButton":"Enable API","disableButton":"Disable API","newKeyButton":"New API Key","headerName":"Name","headerKeyEnding":"Key Ending","headerExpiration":"Expiration","headerCreated":"Created","headerLastUpdated":"Last Updated","headerRevoke":"Revoke","noKeyInfo":"No API keys have been generated yet.","revokeConfirm":"Revoke API Key?","revokeConfirmText":"Are you sure you want to revoke key {{name}}? This action cannot be undone!","revoke":"Revoke","refreshSuccess":"List of API keys has been refreshed.","revokeSuccess":"The key has been revoked successfully.","newKeyTitle":"New API Key","newKeySuccess":"API key created successfully.","newKeyNameError":"Name is missing or invalid.","newKeyGroupError":"You must select a group.","newKeyGuestGroupError":"The guests group cannot be used for API keys.","newKeyNameHint":"Purpose of this key","newKeyName":"Name","newKeyExpiration":"Expiration","newKeyExpirationHint":"You can still revoke a key anytime regardless of the expiration.","newKeyPermissionScopes":"Permission Scopes","newKeyFullAccess":"Full Access","newKeyGroupPermissions":"or use group permissions...","newKeyGroup":"Group","newKeyGroupHint":"The API key will have the same permissions as the selected group.","expiration30d":"30 days","expiration90d":"90 days","expiration180d":"180 days","expiration1y":"1 year","expiration3y":"3 years","newKeyCopyWarn":"Copy the key shown below as {{bold}}","newKeyCopyWarnBold":"it will NOT be shown again","toggleStateEnabledSuccess":"API has been enabled successfully.","toggleStateDisabledSuccess":"API has been disabled successfully."},"system":{"title":"System Info","subtitle":"Information about your system","hostInfo":"Host Information","currentVersion":"Current Version","latestVersion":"Latest Version","published":"Published","os":"Operating System","hostname":"Hostname","cpuCores":"CPU Cores","totalRAM":"Total RAM","workingDirectory":"Working Directory","configFile":"Configuration File","ramUsage":"RAM Usage: {{used}} / {{total}}","dbPartialSupport":"Your database version is not fully supported. Some functionality may be limited or not work as expected.","refreshSuccess":"System Info has been refreshed."},"utilities":{"title":"Utilities","subtitle":"Maintenance and miscellaneous tools","tools":"Tools","authTitle":"Authentication","authSubtitle":"Various tools for authentication / users","cacheTitle":"Flush Cache","cacheSubtitle":"Flush cache of various components","graphEndpointTitle":"GraphQL Endpoint","graphEndpointSubtitle":"Change the GraphQL endpoint for Wiki.js","importv1Title":"Import from Wiki.js 1.x","importv1Subtitle":"Migrate data from a previous 1.x installation","telemetryTitle":"Telemetry","telemetrySubtitle":"Enable/Disable telemetry or reset the client ID","contentTitle":"Content","contentSubtitle":"Various tools for pages","exportTitle":"Export to Disk","exportSubtitle":"Save content to tarball for backup / migration"},"dev":{"title":"Developer Tools","flags":{"title":"Flags"},"graphiql":{"title":"GraphiQL"},"voyager":{"title":"Voyager"}},"contribute":{"title":"Contribute to Wiki.js","subtitle":"Help support Wiki.js development and operations","fundOurWork":"Fund our work","spreadTheWord":"Spread the word","talkToFriends":"Talk to your friends and colleagues about how awesome Wiki.js is!","followUsOnTwitter":"Follow us on {{0}}.","submitAnIdea":"Submit an idea or vote on a proposed one on the {{0}}.","submitAnIdeaLink":"feature requests board","foundABug":"Found a bug? Submit an issue on {{0}}.","helpTranslate":"Help translate Wiki.js in your language. Let us know on {{0}}.","makeADonation":"Make a donation","contribute":"Contribute","openCollective":"Wiki.js is also part of the Open Collective initiative, a transparent fund that goes toward community resources. You can contribute financially by making a monthly or one-time donation:","needYourHelp":"We need your help to keep improving the software and run the various associated services (e.g. hosting and networking).","openSource":"Wiki.js is a free and open-source software brought to you with {{0}} by {{1}} and {{2}}.","openSourceContributors":"contributors","tshirts":"You can also buy Wiki.js t-shirts to support the project financially:","shop":"Wiki.js Shop","becomeAPatron":"Become a Patron","patreon":"Become a backer or sponsor via Patreon (goes directly into supporting lead developer Nicolas Giard's goal of working full-time on Wiki.js)","paypal":"Make a one-time or recurring donation via Paypal:","ethereum":"We accept donations using Ethereum:","github":"Become a sponsor via GitHub Sponsors (goes directly into supporting lead developer Nicolas Giard's goal of working full-time on Wiki.js)","becomeASponsor":"Become a Sponsor"},"nav":{"site":"Site","users":"Users","modules":"Modules","system":"System"},"pages":{"title":"Pages"},"navigation":{"title":"Navigation","subtitle":"Manage the site navigation","link":"Link","divider":"Divider","header":"Header","label":"Label","icon":"Icon","targetType":"Target Type","target":"Target","noSelectionText":"Select a navigation item on the left.","untitled":"Untitled {{kind}}","navType":{"external":"External Link","home":"Home","page":"Page","searchQuery":"Search Query","externalblank":"External Link (New Window)"},"edit":"Edit {{kind}}","delete":"Delete {{kind}}","saveSuccess":"Navigation saved successfully.","noItemsText":"Click the Add button to add your first navigation item.","emptyList":"Navigation is empty","visibilityMode":{"all":"Visible to everyone","restricted":"Visible to select groups..."},"selectPageButton":"Select Page...","mode":"Navigation Mode","modeSiteTree":{"title":"Site Tree","description":"Classic Tree-based Navigation"},"modeCustom":{"title":"Custom Navigation","description":"Static Navigation Menu + Site Tree Button"},"modeNone":{"title":"None","description":"Disable Site Navigation"},"copyFromLocale":"Copy from locale...","sourceLocale":"Source Locale","sourceLocaleHint":"The locale from which navigation items will be copied from.","copyFromLocaleInfoText":"Select the locale from which items will be copied from. Items will be appended to the current list of items in the active locale.","modeStatic":{"title":"Static Navigation","description":"Static Navigation Menu Only"}},"mail":{"title":"Mail","subtitle":"Configure mail settings","configuration":"Configuration","dkim":"DKIM (optional)","test":"Send a test email","testRecipient":"Recipient Email Address","testSend":"Send Email","sender":"Sender","senderName":"Sender Name","senderEmail":"Sender Email","smtp":"SMTP Settings","smtpHost":"Host","smtpPort":"Port","smtpPortHint":"Usually 465 (recommended), 587 or 25.","smtpTLS":"Secure (TLS)","smtpTLSHint":"Should be enabled when using port 465, otherwise turned off (587 or 25).","smtpUser":"Username","smtpPwd":"Password","dkimHint":"DKIM (DomainKeys Identified Mail) provides a layer of security on all emails sent from Wiki.js by providing the means for recipients to validate the domain name and ensure the message authenticity.","dkimUse":"Use DKIM","dkimDomainName":"Domain Name","dkimKeySelector":"Key Selector","dkimPrivateKey":"Private Key","dkimPrivateKeyHint":"Private key for the selector in PEM format","testHint":"Send a test email to ensure your SMTP configuration is working.","saveSuccess":"Configuration saved successfully.","sendTestSuccess":"A test email was sent successfully.","smtpVerifySSL":"Verify SSL Certificate","smtpVerifySSLHint":"Some hosts requires SSL certificate checking to be disabled. Leave enabled for proper security.","smtpName":"Client Identifying Hostname","smtpNameHint":"An optional name to send to the SMTP server to identify your mailer. Leave empty to use server hostname. For Google Workspace customers, this should be your main domain name."},"webhooks":{"title":"Webhooks","subtitle":"Manage webhooks to external services"},"adminArea":"Administration Area","analytics":{"title":"Analytics","subtitle":"Add analytics and tracking tools to your wiki","providers":"Providers","providerConfiguration":"Provider Configuration","providerNoConfiguration":"This provider has no configuration options you can modify.","refreshSuccess":"List of providers refreshed successfully.","saveSuccess":"Analytics configuration saved successfully"},"comments":{"title":"Comments","provider":"Provider","subtitle":"Add discussions to your wiki pages","providerConfig":"Provider Configuration","providerNoConfig":"This provider has no configuration options you can modify.","configSaveSuccess":"Comments configuration saved successfully."},"tags":{"title":"Tags","subtitle":"Manage page tags","emptyList":"No tags to display.","edit":"Edit Tag","tag":"Tag","label":"Label","date":"Created {{created}} and last updated {{updated}}.","delete":"Delete this tag","noSelectionText":"Select a tag from the list on the left.","noItemsText":"Add a tag to a page to get started.","refreshSuccess":"Tags have been refreshed.","deleteSuccess":"Tag deleted successfully.","saveSuccess":"Tag has been saved successfully.","filter":"Filter...","viewLinkedPages":"View Linked Pages","deleteConfirm":"Delete Tag?","deleteConfirmText":"Are you sure you want to delete tag {{tag}}? The tag will also be unlinked from all pages."},"ssl":{"title":"SSL","subtitle":"Manage SSL configuration","provider":"Provider","providerHint":"Select Custom Certificate if you have your own certificate already.","domain":"Domain","domainHint":"Enter the fully qualified domain pointing to your wiki. (e.g. wiki.example.com)","providerOptions":"Provider Options","providerDisabled":"Disabled","providerLetsEncrypt":"Let's Encrypt","providerCustomCertificate":"Custom Certificate","ports":"Ports","httpPort":"HTTP Port","httpPortHint":"Non-SSL port the server will listen to for HTTP requests. Usually 80 or 3000.","httpsPort":"HTTPS Port","httpsPortHint":"SSL port the server will listen to for HTTPS requests. Usually 443.","httpPortRedirect":"Redirect HTTP requests to HTTPS","httpPortRedirectHint":"Will automatically redirect any requests on the HTTP port to HTTPS.","writableConfigFileWarning":"Note that your config file must be writable in order to persist ports configuration.","renewCertificate":"Renew Certificate","status":"Certificate Status","expiration":"Certificate Expiration","subscriberEmail":"Subscriber Email","currentState":"Current State","httpPortRedirectTurnOn":"Turn On","httpPortRedirectTurnOff":"Turn Off","renewCertificateLoadingTitle":"Renewing Certificate...","renewCertificateLoadingSubtitle":"Do not leave this page.","renewCertificateSuccess":"Certificate renewed successfully.","httpPortRedirectSaveSuccess":"HTTP Redirection changed successfully."},"security":{"title":"Security","maxUploadSize":"Max Upload Size","maxUploadBatch":"Max Files per Upload","maxUploadBatchHint":"How many files can be uploaded in a single batch?","maxUploadSizeHint":"The maximum size for a single file.","maxUploadSizeSuffix":"bytes","maxUploadBatchSuffix":"files","uploads":"Uploads","uploadsInfo":"These settings only affect Wiki.js. If you're using a reverse-proxy (e.g. nginx, apache, Cloudflare), you must also change its settings to match.","subtitle":"Configure security settings","login":"Login","loginScreen":"Login Screen","jwt":"JWT Configuration","bypassLogin":"Bypass Login Screen","bypassLoginHint":"Should the user be redirected automatically to the first authentication provider.","loginBgUrl":"Login Background Image URL","loginBgUrlHint":"Specify an image to use as the login background. PNG and JPG are supported, 1920x1080 recommended. Leave empty for default. Click the button on the right to upload a new image. Note that the Guests group must have read-access to the selected image!","hideLocalLogin":"Hide Local Authentication Provider","hideLocalLoginHint":"Don't show the local authentication provider on the login screen. Add ?all to the URL to temporarily use it.","loginSecurity":"Security","enforce2fa":"Enforce 2FA","enforce2faHint":"Force all users to use Two-Factor Authentication when using an authentication provider with a user / password form."},"extensions":{"title":"Extensions","subtitle":"Install extensions for extra functionality"}},"editor":{"page":"Page","save":{"processing":"Rendering","pleaseWait":"Please wait...","createSuccess":"Page created successfully.","error":"An error occurred while creating the page","updateSuccess":"Page updated successfully.","saved":"Saved"},"props":{"pageProperties":"Page Properties","pageInfo":"Page Info","title":"Title","shortDescription":"Short Description","shortDescriptionHint":"Shown below the title","pathCategorization":"Path & Categorization","locale":"Locale","path":"Path","pathHint":"Do not include any leading or trailing slashes.","tags":"Tags","tagsHint":"Use tags to categorize your pages and make them easier to find.","publishState":"Publishing State","publishToggle":"Published","publishToggleHint":"Unpublished pages are still visible to users with write permissions on this page.","publishStart":"Publish starting on...","publishStartHint":"Leave empty for no start date","publishEnd":"Publish ending on...","publishEndHint":"Leave empty for no end date","info":"Info","scheduling":"Scheduling","social":"Social","categorization":"Categorization","socialFeatures":"Social Features","allowComments":"Allow Comments","allowCommentsHint":"Enable commenting abilities on this page.","allowRatings":"Allow Ratings","displayAuthor":"Display Author Info","displaySharingBar":"Display Sharing Toolbar","displaySharingBarHint":"Show a toolbar with buttons to share and print this page","displayAuthorHint":"Show the page author along with the last edition time.","allowRatingsHint":"Enable rating capabilities on this page.","scripts":"Scripts","css":"CSS","cssHint":"CSS will automatically be minified upon saving. Do not include surrounding style tags, only the actual CSS code.","styles":"Styles","html":"HTML","htmlHint":"You must surround your javascript code with HTML script tags.","toc":"TOC","tocTitle":"Table of Contents","tocUseDefault":"Use Site Defaults","tocHeadingLevels":"TOC Heading Levels","tocHeadingLevelsHint":"The table of contents will show headings from and up to the selected levels."},"unsaved":{"title":"Discard Unsaved Changes?","body":"You have unsaved changes. Are you sure you want to leave the editor and discard any modifications you made since the last save?"},"select":{"title":"Which editor do you want to use for this page?","cannotChange":"This cannot be changed once the page is created.","customView":"or create a custom view?"},"assets":{"title":"Assets","newFolder":"New Folder","folderName":"Folder Name","folderNameNamingRules":"Must follow the asset folder {{namingRules}}.","folderNameNamingRulesLink":"naming rules","folderEmpty":"This asset folder is empty.","fileCount":"{{count}} files","headerId":"ID","headerFilename":"Filename","headerType":"Type","headerFileSize":"File Size","headerAdded":"Added","headerActions":"Actions","uploadAssets":"Upload Assets","uploadAssetsDropZone":"Browse or Drop files here...","fetchImage":"Fetch Remote Image","imageAlign":"Image Alignment","renameAsset":"Rename Asset","renameAssetSubtitle":"Enter the new name for this asset:","deleteAsset":"Delete Asset","deleteAssetConfirm":"Are you sure you want to delete asset","deleteAssetWarn":"This action cannot be undone!","refreshSuccess":"List of assets refreshed successfully.","uploadFailed":"File upload failed.","folderCreateSuccess":"Asset folder created successfully.","renameSuccess":"Asset renamed successfully.","deleteSuccess":"Asset deleted successfully.","noUploadError":"You must choose a file to upload first!"},"backToEditor":"Back to Editor","markup":{"bold":"Bold","italic":"Italic","strikethrough":"Strikethrough","heading":"Heading {{level}}","subscript":"Subscript","superscript":"Superscript","blockquote":"Blockquote","blockquoteInfo":"Info Blockquote","blockquoteSuccess":"Success Blockquote","blockquoteWarning":"Warning Blockquote","blockquoteError":"Error Blockquote","unorderedList":"Unordered List","orderedList":"Ordered List","inlineCode":"Inline Code","keyboardKey":"Keyboard Key","horizontalBar":"Horizontal Bar","togglePreviewPane":"Hide / Show Preview Pane","insertLink":"Insert Link","insertAssets":"Insert Assets","insertBlock":"Insert Block","insertCodeBlock":"Insert Code Block","insertVideoAudio":"Insert Video / Audio","insertDiagram":"Insert Diagram","insertMathExpression":"Insert Math Expression","tableHelper":"Table Helper","distractionFreeMode":"Distraction Free Mode","markdownFormattingHelp":"Markdown Formatting Help","noSelectionError":"Text must be selected first!","toggleSpellcheck":"Toggle Spellcheck"},"ckeditor":{"stats":"{{chars}} chars, {{words}} words"},"conflict":{"title":"Resolve Save Conflict","useLocal":"Use Local","useRemote":"Use Remote","useRemoteHint":"Discard local changes and use latest version","useLocalHint":"Use content in the left panel","viewLatestVersion":"View Latest Version","infoGeneric":"A more recent version of this page was saved by {{authorName}}, {{date}}","whatToDo":"What do you want to do?","whatToDoLocal":"Use your current local version and ignore the latest changes.","whatToDoRemote":"Use the remote version (latest) and discard your changes.","overwrite":{"title":"Overwrite with Remote Version?","description":"Are you sure you want to replace your current version with the latest remote content? {{refEditsLost}}","editsLost":"Your current edits will be lost."},"localVersion":"Local Version {{refEditable}}","editable":"(editable)","readonly":"(read-only)","remoteVersion":"Remote Version {{refReadOnly}}","leftPanelInfo":"Your current edit, based on page version from {{date}}","rightPanelInfo":"Last edited by {{authorName}}, {{date}}","pageTitle":"Title:","pageDescription":"Description:","warning":"Save conflict! Another user has already modified this page."},"unsavedWarning":"You have unsaved edits. Are you sure you want to leave the editor?"},"tags":{"currentSelection":"Current Selection","clearSelection":"Clear Selection","selectOneMoreTags":"Select one or more tags","searchWithinResultsPlaceholder":"Search within results...","locale":"Locale","orderBy":"Order By","selectOneMoreTagsHint":"Select one or more tags on the left.","retrievingResultsLoading":"Retrieving page results...","noResults":"Couldn't find any page with the selected tags.","noResultsWithFilter":"Couldn't find any page matching the current filtering options.","pageLastUpdated":"Last Updated {{date}}","orderByField":{"creationDate":"Creation Date","ID":"ID","lastModified":"Last Modified","path":"Path","title":"Title"},"localeAny":"Any"},"history":{"restore":{"confirmTitle":"Restore page version?","confirmText":"Are you sure you want to restore this page content as it was on {{date}}? This version will be copied on top of the current history. As such, newer versions will still be preserved.","confirmButton":"Restore","success":"Page version restored succesfully!"}},"profile":{"displayName":"Display Name","location":"Location","jobTitle":"Job Title","timezone":"Timezone","title":"Profile","subtitle":"My personal info","myInfo":"My Info","viewPublicProfile":"View Public Profile","auth":{"title":"Authentication","provider":"Provider","changePassword":"Change Password","currentPassword":"Current Password","newPassword":"New Password","verifyPassword":"Confirm New Password","changePassSuccess":"Password changed successfully."},"groups":{"title":"Groups"},"activity":{"title":"Activity","joinedOn":"Joined on","lastUpdatedOn":"Profile last updated on","lastLoginOn":"Last login on","pagesCreated":"Pages created","commentsPosted":"Comments posted"},"save":{"success":"Profile saved successfully."},"pages":{"title":"Pages","subtitle":"List of pages I created or last modified","emptyList":"No pages to display.","refreshSuccess":"Page list has been refreshed.","headerTitle":"Title","headerPath":"Path","headerCreatedAt":"Created","headerUpdatedAt":"Last Updated"},"comments":{"title":"Comments"},"preferences":"Preferences","dateFormat":"Date Format","localeDefault":"Locale Default","appearance":"Appearance","appearanceDefault":"Site Default","appearanceLight":"Light","appearanceDark":"Dark"}}	f	English	English	100	2026-10-24T19:52:26.102Z	2026-11-12T13:35:32.832Z
\.


--
-- Data for Name: loggers; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public.loggers (key, "isEnabled", level, config) FROM stdin;
airbrake	f	warn	{}
bugsnag	f	warn	{"key":""}
disk	f	info	{}
eventlog	f	warn	{}
loggly	f	warn	{"token":"","subdomain":""}
logstash	f	warn	{}
newrelic	f	warn	{}
papertrail	f	warn	{"host":"","port":0}
raygun	f	warn	{}
rollbar	f	warn	{"key":""}
sentry	f	warn	{"key":""}
syslog	f	warn	{}
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public.migrations (id, name, batch, migration_time) FROM stdin;
1	2.0.0.js	1	2026-10-24 19:47:35.386+00
2	2.1.85.js	1	2026-10-24 19:47:35.387+00
3	2.2.3.js	1	2026-10-24 19:47:35.401+00
4	2.2.17.js	1	2026-10-24 19:47:35.404+00
5	2.3.10.js	1	2026-10-24 19:47:35.405+00
6	2.3.23.js	1	2026-10-24 19:47:35.406+00
7	2.4.13.js	1	2026-10-24 19:47:35.409+00
8	2.4.14.js	1	2026-10-24 19:47:35.424+00
9	2.4.36.js	1	2026-10-24 19:47:35.427+00
10	2.4.61.js	1	2026-10-24 19:47:35.428+00
11	2.5.1.js	1	2026-10-24 19:47:35.433+00
12	2.5.12.js	1	2026-10-24 19:47:35.435+00
13	2.5.108.js	1	2026-10-24 19:47:35.436+00
14	2.5.118.js	1	2026-10-24 19:47:35.437+00
15	2.5.122.js	1	2026-10-24 19:47:35.451+00
16	2.5.128.js	1	2026-10-24 19:47:35.453+00
\.


--
-- Data for Name: migrations_lock; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public.migrations_lock (index, is_locked) FROM stdin;
1	0
\.


--
-- Data for Name: navigation; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public.navigation (key, config) FROM stdin;
site	[{"locale":"en","items":[{"id":"bddb2191-7bc4-4a4e-8a18-d02a5ffb25d0","kind":"link","label":"Home","icon":"mdi-home","targetType":"home","target":"/","visibilityMode":"all","visibilityGroups":null}]}]
\.


--
-- Data for Name: pageHistory; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public."pageHistory" (id, path, hash, title, description, "isPrivate", "isPublished", "publishStartDate", "publishEndDate", action, "pageId", content, "contentType", "createdAt", "editorKey", "localeCode", "authorId", "versionDate", extra) FROM stdin;
1	pmbc/geral	90e646e6cbc5314259d58e4a0c0c67a1faad39ea	Informações gerais da Prefeitura	Informações gerais da Prefeitura	f	t			deleted	1	# Informações gerais da Prefeitura\n\nNormas e comunicados válidos para **todos os departamentos** da Prefeitura. Horário de expediente, calendário de feriados e canais oficiais de atendimento.\n\n> Conteúdo fictício, criado para testes do projeto de extensão.\n	markdown	2026-11-01T22:33:35.753Z	markdown	pt-br	1	2026-11-01T20:29:28.188Z	{}
2	pmbc/searp/geral	63b63937b3e79643e516e9f256f05ce9b27cb265	SEARP – Informações gerais	SEARP – Informações gerais	f	t			deleted	2	# SEARP – Informações gerais\n\nDocumentos comuns a todos os setores da Secretaria de Articulação Política e Relações Institucionais.\n\n> Conteúdo fictício, criado para testes do projeto de extensão.\n	markdown	2026-11-01T22:33:36.396Z	markdown	pt-br	1	2026-11-01T20:29:29.938Z	{}
3	pmbc/searp/decc/home	e02d73071f8a2138c5500c691af3ce52160b7c1e	DECC – Início	DECC – Início	f	t			deleted	3	# DECC – Início\n\nPágina inicial do Departamento da Casa dos Conselhos.\n\n> Conteúdo fictício, criado para testes do projeto de extensão.\n	markdown	2026-11-01T22:33:37.009Z	markdown	pt-br	1	2026-11-01T20:29:31.684Z	{}
4	pmbc/seduc/geral	4c827195963e065bb688d59de62e5946b9ac72d3	SEDUC – Informações gerais	SEDUC – Informações gerais	f	t			deleted	6	# SEDUC – Informações gerais\n\nDocumentos comuns a toda a Secretaria Municipal de Educação: calendário escolar e orientações pedagógicas gerais.\n\n> Conteúdo fictício, criado para testes do projeto de extensão.\n	markdown	2026-11-01T22:33:37.588Z	markdown	pt-br	1	2026-11-01T20:29:36.990Z	{}
5	pmbc/seduc/cem/geral	1b80ec05172c87372a8443079729297932540a72	CEM – Informações gerais	CEM – Informações gerais	f	t			deleted	7	# CEM – Informações gerais\n\nInformações comuns às unidades vinculadas ao Centro Educacional Municipal.\n\n> Conteúdo fictício, criado para testes do projeto de extensão.\n	markdown	2026-11-01T22:33:38.175Z	markdown	pt-br	1	2026-11-01T20:29:38.762Z	{}
6	pmbc/seduc/cem/pal/home	40a36864f4d35e0ea928d2ccc85ed7886a5aa3f2	PAL – Início	PAL – Início	f	t			deleted	8	# PAL – Início\n\nPágina inicial da unidade Professor Antonio Lucio.\n\n> Conteúdo fictício, criado para testes do projeto de extensão.\n	markdown	2026-11-01T22:33:38.758Z	markdown	pt-br	1	2026-11-01T20:29:40.501Z	{}
7	pmbc/seduc/nei/geral	e89c4683a94ed567ed0770e13d2a1ab6aaca0725	NEI – Informações gerais	NEI – Informações gerais	f	t			deleted	11	# NEI – Informações gerais\n\nInformações comuns às unidades do Núcleo de Educação da Infância.\n\n> Conteúdo fictício, criado para testes do projeto de extensão.\n	markdown	2026-11-01T22:33:39.342Z	markdown	pt-br	1	2026-11-01T20:29:45.935Z	{}
8	pmbc/seduc/nei/pio/home	d8f90f5bb192ea10c1d8c33bd6f6106cee55db13	PIO – Início	PIO – Início	f	t			deleted	12	# PIO – Início\n\nPágina inicial da unidade Pioneiros.\n\n> Conteúdo fictício, criado para testes do projeto de extensão.\n	markdown	2026-11-01T22:33:39.925Z	markdown	pt-br	1	2026-11-01T20:29:47.758Z	{}
9	pmbc/segov/geral	5cd849a47db01ea7fd1cf9abeac14e528aaee3f9	SEGOV – Informações gerais	SEGOV – Informações gerais	f	t			deleted	15	# SEGOV – Informações gerais\n\nDocumentos comuns à Secretaria Municipal de Governo, Inovação e Orçamento.\n\n> Conteúdo fictício, criado para testes do projeto de extensão.\n	markdown	2026-11-01T22:33:40.508Z	markdown	pt-br	1	2026-11-01T20:29:53.020Z	{}
10	pmbc/segov/diti/home	fc94762c34f9ae6963afaca760d01848a5b072c8	DITI – Início	DITI – Início	f	t			deleted	16	# DITI – Início\n\nPágina inicial da Divisão de Tecnologia da Informação.\n\n> Conteúdo fictício, criado para testes do projeto de extensão.\n	markdown	2026-11-01T22:33:41.109Z	markdown	pt-br	1	2026-11-01T20:29:54.794Z	{}
11	pmbc/searp/decc/agenda-conselhos	ee02a616a63b2c06e8235edc040e50516780a1dc	DECC – Agenda dos conselhos	DECC – Agenda dos conselhos	f	t			deleted	4	# DECC – Agenda dos conselhos\n\nProcedimento para **agendar reunião de conselho** na Casa dos Conselhos: solicitar a sala, confirmar a pauta e enviar a convocação.\n\n> Conteúdo fictício, criado para testes do projeto de extensão.\n	markdown	2026-11-01T22:33:41.766Z	markdown	pt-br	1	2026-11-01T20:29:33.429Z	{}
12	pmbc/searp/decc/ata-modelo	49bf73ae2db845d303c1dadeb065caf13ff02700	DECC – Modelo de ata	DECC – Modelo de ata	f	t			deleted	5	# DECC – Modelo de ata\n\nModelo padrão de **ata** de reunião de conselho, com cabeçalho, presentes, deliberações e assinaturas.\n\n> Conteúdo fictício, criado para testes do projeto de extensão.\n	markdown	2026-11-01T22:33:42.352Z	markdown	pt-br	1	2026-11-01T20:29:35.155Z	{}
13	pmbc/seduc/cem/pal/matricula	62e4a5b5921b3a615d5dbc5a7800d28fc328520b	PAL – Procedimento de matrícula	PAL – Procedimento de matrícula	f	t			deleted	9	# PAL – Procedimento de matrícula\n\nPasso a passo da **matrícula** de novos alunos: documentos exigidos, prazo e lançamento no sistema.\n\n> Conteúdo fictício, criado para testes do projeto de extensão.\n	markdown	2026-11-01T22:33:42.956Z	markdown	pt-br	1	2026-11-01T20:29:42.330Z	{}
14	pmbc/seduc/cem/pal/transporte-escolar	7930ae89b4a6fcecc725ef6b6bbb9263af0dae3d	PAL – Transporte escolar	PAL – Transporte escolar	f	t			deleted	10	# PAL – Transporte escolar\n\nComo solicitar e renovar o **transporte escolar** dos alunos da unidade.\n\n> Conteúdo fictício, criado para testes do projeto de extensão.\n	markdown	2026-11-01T22:33:43.541Z	markdown	pt-br	1	2026-11-01T20:29:44.138Z	{}
15	pmbc/seduc/nei/pio/cardapio	e9f0072aa2cec29ea8c1ccf48458c15a48767e53	PIO – Cardápio e alimentação	PIO – Cardápio e alimentação	f	t			deleted	13	# PIO – Cardápio e alimentação\n\nOrientações sobre o **cardápio** semanal e restrições alimentares das crianças.\n\n> Conteúdo fictício, criado para testes do projeto de extensão.\n	markdown	2026-11-01T22:33:44.140Z	markdown	pt-br	1	2026-11-01T20:29:49.513Z	{}
16	pmbc/seduc/nei/pio/adaptacao	995195ccdc98d679b34d162e171b846e8e4ec294	PIO – Período de adaptação	PIO – Período de adaptação	f	t			deleted	14	# PIO – Período de adaptação\n\nRoteiro do **período de adaptação** de crianças novas na unidade.\n\n> Conteúdo fictício, criado para testes do projeto de extensão.\n	markdown	2026-11-01T22:33:44.733Z	markdown	pt-br	1	2026-11-01T20:29:51.259Z	{}
17	pmbc/segov/diti/abrir-chamado	15e02f3f83d0edf25ce47eeb5fa10c9c1e86fa51	DITI – Como abrir um chamado	DITI – Como abrir um chamado	f	t			deleted	17	# DITI – Como abrir um chamado\n\nPasso a passo para **abrir um chamado** de suporte de informática: identificar o equipamento, descrever o problema e anotar o protocolo.\n\n> Conteúdo fictício, criado para testes do projeto de extensão.\n	markdown	2026-11-01T22:33:45.347Z	markdown	pt-br	1	2026-11-01T20:29:56.546Z	{}
18	pmbc/segov/diti/backup	8e2db97637a5d9902c8b0335937c59b491ecb7cf	DITI – Rotina de backup	DITI – Rotina de backup	f	t			deleted	18	# DITI – Rotina de backup\n\nDescrição da rotina de **backup** dos servidores: frequência, retenção e procedimento de restauração.\n\n> Conteúdo fictício, criado para testes do projeto de extensão.\n	markdown	2026-11-01T22:33:45.927Z	markdown	pt-br	1	2026-11-01T20:29:58.368Z	{}
\.


--
-- Data for Name: pageHistoryTags; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public."pageHistoryTags" (id, "pageId", "tagId") FROM stdin;
\.


--
-- Data for Name: pageLinks; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public."pageLinks" (id, path, "localeCode", "pageId") FROM stdin;
\.


--
-- Data for Name: pageTags; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public."pageTags" (id, "pageId", "tagId") FROM stdin;
19	19	1
20	20	1
21	21	1
22	22	1
23	23	1
24	24	1
25	25	1
26	26	1
27	27	1
28	28	1
29	29	1
30	30	1
31	31	1
32	32	1
33	33	1
34	34	1
35	35	1
36	36	1
\.


--
-- Data for Name: pageTree; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public."pageTree" (id, path, depth, title, "isPrivate", "isFolder", "privateNS", parent, "pageId", "localeCode", ancestors) FROM stdin;
1	home	1	Untitled Page	f	f	\N	\N	37	en	[]
2	pmbc	1	Informações gerais da Prefeitura	f	t	\N	\N	19	en	[]
3	pmbc/searp	2	SEARP – Informações gerais	f	t	\N	2	20	en	[2]
4	pmbc/searp/decc	3	DECC – Início	f	t	\N	3	21	en	[2,3]
5	pmbc/searp/decc/agenda-conselhos	4	DECC – Agenda dos conselhos	f	f	\N	4	22	en	[2,3,4]
6	pmbc/searp/decc/ata-modelo	4	DECC – Modelo de ata	f	f	\N	4	23	en	[2,3,4]
7	pmbc/seduc	2	SEDUC – Informações gerais	f	t	\N	2	24	en	[2]
8	pmbc/seduc/cem	3	CEM – Informações gerais	f	t	\N	7	25	en	[2,7]
9	pmbc/seduc/cem/pal	4	PAL – Início	f	t	\N	8	26	en	[2,7,8]
10	pmbc/seduc/cem/pal/matricula	5	PAL – Procedimento de matrícula	f	f	\N	9	27	en	[2,7,8,9]
11	pmbc/seduc/cem/pal/transporte-escolar	5	PAL – Transporte escolar	f	f	\N	9	28	en	[2,7,8,9]
12	pmbc/seduc/nei	3	NEI – Informações gerais	f	t	\N	7	29	en	[2,7]
13	pmbc/seduc/nei/pio	4	PIO – Início	f	t	\N	12	30	en	[2,7,12]
14	pmbc/seduc/nei/pio/adaptacao	5	PIO – Período de adaptação	f	f	\N	13	32	en	[2,7,12,13]
15	pmbc/seduc/nei/pio/cardapio	5	PIO – Cardápio e alimentação	f	f	\N	13	31	en	[2,7,12,13]
16	pmbc/segov	2	SEGOV – Informações gerais	f	t	\N	2	33	en	[2]
17	pmbc/segov/diti	3	DITI – Início	f	t	\N	16	34	en	[2,16]
18	pmbc/segov/diti/abrir-chamado	4	DITI – Como abrir um chamado	f	f	\N	17	35	en	[2,16,17]
19	pmbc/segov/diti/backup	4	DITI – Rotina de backup	f	f	\N	17	36	en	[2,16,17]
\.


--
-- Data for Name: pages; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public.pages (id, path, hash, title, description, "isPrivate", "isPublished", "privateNS", "publishStartDate", "publishEndDate", content, render, toc, "contentType", "createdAt", "updatedAt", "editorKey", "localeCode", "authorId", "creatorId", extra) FROM stdin;
19	pmbc	903517d794d149ec1dccc2c53b832422d91add3e	Informações gerais da Prefeitura	Informações gerais da Prefeitura	f	t	\N			# Informações gerais da Prefeitura\n\nNormas e comunicados válidos para **todos os departamentos** da Prefeitura. Horário de expediente, calendário de feriados e canais oficiais de atendimento.\n\n> Conteúdo fictício, criado para testes do projeto de extensão.\n	<h1 id="informações-gerais-da-prefeitura" class="toc-header"><a class="toc-anchor" href="#informações-gerais-da-prefeitura">¶</a> Informações gerais da Prefeitura</h1>\n<p>Normas e comunicados válidos para <strong>todos os departamentos</strong> da Prefeitura. Horário de expediente, calendário de feriados e canais oficiais de atendimento.</p>\n<blockquote>\n<p>Conteúdo fictício, criado para testes do projeto de extensão.</p>\n</blockquote>\n	[{"title":"Informações gerais da Prefeitura","anchor":"#informações-gerais-da-prefeitura","children":[]}]	markdown	2026-11-01T22:31:51.491Z	2026-11-01T22:31:52.735Z	markdown	en	1	1	{"js":"","css":""}
20	pmbc/searp	39703471dea26fa7ce3c37493f5befacf6e225a2	SEARP – Informações gerais	SEARP – Informações gerais	f	t	\N			# SEARP – Informações gerais\n\nDocumentos comuns a todos os setores da Secretaria de Articulação Política e Relações Institucionais.\n\n> Conteúdo fictício, criado para testes do projeto de extensão.\n	<h1 id="searp-informações-gerais" class="toc-header"><a class="toc-anchor" href="#searp-informações-gerais">¶</a> SEARP – Informações gerais</h1>\n<p>Documentos comuns a todos os setores da Secretaria de Articulação Política e Relações Institucionais.</p>\n<blockquote>\n<p>Conteúdo fictício, criado para testes do projeto de extensão.</p>\n</blockquote>\n	[{"title":"SEARP – Informações gerais","anchor":"#searp-informações-gerais","children":[]}]	markdown	2026-11-01T22:31:53.343Z	2026-11-01T22:31:54.528Z	markdown	en	1	1	{"js":"","css":""}
21	pmbc/searp/decc	f2391f55f90ee03a83eb2fe40a181e097f6693e9	DECC – Início	DECC – Início	f	t	\N			# DECC – Início\n\nPágina inicial do Departamento da Casa dos Conselhos.\n\n> Conteúdo fictício, criado para testes do projeto de extensão.\n	<h1 id="decc-início" class="toc-header"><a class="toc-anchor" href="#decc-início">¶</a> DECC – Início</h1>\n<p>Página inicial do Departamento da Casa dos Conselhos.</p>\n<blockquote>\n<p>Conteúdo fictício, criado para testes do projeto de extensão.</p>\n</blockquote>\n	[{"title":"DECC – Início","anchor":"#decc-início","children":[]}]	markdown	2026-11-01T22:31:55.129Z	2026-11-01T22:31:56.376Z	markdown	en	1	1	{"js":"","css":""}
22	pmbc/searp/decc/agenda-conselhos	aef64cf4a31fc9e584e36b1beba505bb5eb7c8ad	DECC – Agenda dos conselhos	DECC – Agenda dos conselhos	f	t	\N			# DECC – Agenda dos conselhos\n\nProcedimento para **agendar reunião de conselho** na Casa dos Conselhos: solicitar a sala, confirmar a pauta e enviar a convocação.\n\n> Conteúdo fictício, criado para testes do projeto de extensão.\n	<h1 id="decc-agenda-dos-conselhos" class="toc-header"><a class="toc-anchor" href="#decc-agenda-dos-conselhos">¶</a> DECC – Agenda dos conselhos</h1>\n<p>Procedimento para <strong>agendar reunião de conselho</strong> na Casa dos Conselhos: solicitar a sala, confirmar a pauta e enviar a convocação.</p>\n<blockquote>\n<p>Conteúdo fictício, criado para testes do projeto de extensão.</p>\n</blockquote>\n	[{"title":"DECC – Agenda dos conselhos","anchor":"#decc-agenda-dos-conselhos","children":[]}]	markdown	2026-11-01T22:31:56.991Z	2026-11-01T22:31:58.227Z	markdown	en	1	1	{"js":"","css":""}
23	pmbc/searp/decc/ata-modelo	cd58fdfed9c772682541da7eaf733c4a19feda36	DECC – Modelo de ata	DECC – Modelo de ata	f	t	\N			# DECC – Modelo de ata\n\nModelo padrão de **ata** de reunião de conselho, com cabeçalho, presentes, deliberações e assinaturas.\n\n> Conteúdo fictício, criado para testes do projeto de extensão.\n	<h1 id="decc-modelo-de-ata" class="toc-header"><a class="toc-anchor" href="#decc-modelo-de-ata">¶</a> DECC – Modelo de ata</h1>\n<p>Modelo padrão de <strong>ata</strong> de reunião de conselho, com cabeçalho, presentes, deliberações e assinaturas.</p>\n<blockquote>\n<p>Conteúdo fictício, criado para testes do projeto de extensão.</p>\n</blockquote>\n	[{"title":"DECC – Modelo de ata","anchor":"#decc-modelo-de-ata","children":[]}]	markdown	2026-11-01T22:31:58.848Z	2026-11-01T22:32:00.016Z	markdown	en	1	1	{"js":"","css":""}
24	pmbc/seduc	1886fbc722a1b09ff81fec056b2ed35094602dd0	SEDUC – Informações gerais	SEDUC – Informações gerais	f	t	\N			# SEDUC – Informações gerais\n\nDocumentos comuns a toda a Secretaria Municipal de Educação: calendário escolar e orientações pedagógicas gerais.\n\n> Conteúdo fictício, criado para testes do projeto de extensão.\n	<h1 id="seduc-informações-gerais" class="toc-header"><a class="toc-anchor" href="#seduc-informações-gerais">¶</a> SEDUC – Informações gerais</h1>\n<p>Documentos comuns a toda a Secretaria Municipal de Educação: calendário escolar e orientações pedagógicas gerais.</p>\n<blockquote>\n<p>Conteúdo fictício, criado para testes do projeto de extensão.</p>\n</blockquote>\n	[{"title":"SEDUC – Informações gerais","anchor":"#seduc-informações-gerais","children":[]}]	markdown	2026-11-01T22:32:00.621Z	2026-11-01T22:32:01.872Z	markdown	en	1	1	{"js":"","css":""}
25	pmbc/seduc/cem	09d19a748f001d437561e01e0e76b7cbd61cd5b7	CEM – Informações gerais	CEM – Informações gerais	f	t	\N			# CEM – Informações gerais\n\nInformações comuns às unidades vinculadas ao Centro Educacional Municipal.\n\n> Conteúdo fictício, criado para testes do projeto de extensão.\n	<h1 id="cem-informações-gerais" class="toc-header"><a class="toc-anchor" href="#cem-informações-gerais">¶</a> CEM – Informações gerais</h1>\n<p>Informações comuns às unidades vinculadas ao Centro Educacional Municipal.</p>\n<blockquote>\n<p>Conteúdo fictício, criado para testes do projeto de extensão.</p>\n</blockquote>\n	[{"title":"CEM – Informações gerais","anchor":"#cem-informações-gerais","children":[]}]	markdown	2026-11-01T22:32:02.470Z	2026-11-01T22:32:03.650Z	markdown	en	1	1	{"js":"","css":""}
26	pmbc/seduc/cem/pal	d6d2f6fe55ba7cad4fb9f1014332c25d0ba7be45	PAL – Início	PAL – Início	f	t	\N			# PAL – Início\n\nPágina inicial da unidade Professor Antonio Lucio.\n\n> Conteúdo fictício, criado para testes do projeto de extensão.\n	<h1 id="pal-início" class="toc-header"><a class="toc-anchor" href="#pal-início">¶</a> PAL – Início</h1>\n<p>Página inicial da unidade Professor Antonio Lucio.</p>\n<blockquote>\n<p>Conteúdo fictício, criado para testes do projeto de extensão.</p>\n</blockquote>\n	[{"title":"PAL – Início","anchor":"#pal-início","children":[]}]	markdown	2026-11-01T22:32:04.241Z	2026-11-01T22:32:05.410Z	markdown	en	1	1	{"js":"","css":""}
27	pmbc/seduc/cem/pal/matricula	f932978fa7873f59599937301f26ffa11903ff81	PAL – Procedimento de matrícula	PAL – Procedimento de matrícula	f	t	\N			# PAL – Procedimento de matrícula\n\nPasso a passo da **matrícula** de novos alunos: documentos exigidos, prazo e lançamento no sistema.\n\n> Conteúdo fictício, criado para testes do projeto de extensão.\n	<h1 id="pal-procedimento-de-matrícula" class="toc-header"><a class="toc-anchor" href="#pal-procedimento-de-matrícula">¶</a> PAL – Procedimento de matrícula</h1>\n<p>Passo a passo da <strong>matrícula</strong> de novos alunos: documentos exigidos, prazo e lançamento no sistema.</p>\n<blockquote>\n<p>Conteúdo fictício, criado para testes do projeto de extensão.</p>\n</blockquote>\n	[{"title":"PAL – Procedimento de matrícula","anchor":"#pal-procedimento-de-matrícula","children":[]}]	markdown	2026-11-01T22:32:06.027Z	2026-11-01T22:32:07.240Z	markdown	en	1	1	{"js":"","css":""}
28	pmbc/seduc/cem/pal/transporte-escolar	09c4728545ff8d78fb6733239bba7d7e290c41ad	PAL – Transporte escolar	PAL – Transporte escolar	f	t	\N			# PAL – Transporte escolar\n\nComo solicitar e renovar o **transporte escolar** dos alunos da unidade.\n\n> Conteúdo fictício, criado para testes do projeto de extensão.\n	<h1 id="pal-transporte-escolar" class="toc-header"><a class="toc-anchor" href="#pal-transporte-escolar">¶</a> PAL – Transporte escolar</h1>\n<p>Como solicitar e renovar o <strong>transporte escolar</strong> dos alunos da unidade.</p>\n<blockquote>\n<p>Conteúdo fictício, criado para testes do projeto de extensão.</p>\n</blockquote>\n	[{"title":"PAL – Transporte escolar","anchor":"#pal-transporte-escolar","children":[]}]	markdown	2026-11-01T22:32:07.828Z	2026-11-01T22:32:09.037Z	markdown	en	1	1	{"js":"","css":""}
29	pmbc/seduc/nei	15cd75cdd69ef2c8b664f1522b0c13621ce9eaea	NEI – Informações gerais	NEI – Informações gerais	f	t	\N			# NEI – Informações gerais\n\nInformações comuns às unidades do Núcleo de Educação da Infância.\n\n> Conteúdo fictício, criado para testes do projeto de extensão.\n	<h1 id="nei-informações-gerais" class="toc-header"><a class="toc-anchor" href="#nei-informações-gerais">¶</a> NEI – Informações gerais</h1>\n<p>Informações comuns às unidades do Núcleo de Educação da Infância.</p>\n<blockquote>\n<p>Conteúdo fictício, criado para testes do projeto de extensão.</p>\n</blockquote>\n	[{"title":"NEI – Informações gerais","anchor":"#nei-informações-gerais","children":[]}]	markdown	2026-11-01T22:32:09.641Z	2026-11-01T22:32:10.864Z	markdown	en	1	1	{"js":"","css":""}
30	pmbc/seduc/nei/pio	19be37cbb353f111ab5ce8f16f0e4cb369ece2f6	PIO – Início	PIO – Início	f	t	\N			# PIO – Início\n\nPágina inicial da unidade Pioneiros.\n\n> Conteúdo fictício, criado para testes do projeto de extensão.\n	<h1 id="pio-início" class="toc-header"><a class="toc-anchor" href="#pio-início">¶</a> PIO – Início</h1>\n<p>Página inicial da unidade Pioneiros.</p>\n<blockquote>\n<p>Conteúdo fictício, criado para testes do projeto de extensão.</p>\n</blockquote>\n	[{"title":"PIO – Início","anchor":"#pio-início","children":[]}]	markdown	2026-11-01T22:32:11.509Z	2026-11-01T22:32:12.653Z	markdown	en	1	1	{"js":"","css":""}
31	pmbc/seduc/nei/pio/cardapio	9229061f60a2121c861758d5639578c39f1912b6	PIO – Cardápio e alimentação	PIO – Cardápio e alimentação	f	t	\N			# PIO – Cardápio e alimentação\n\nOrientações sobre o **cardápio** semanal e restrições alimentares das crianças.\n\n> Conteúdo fictício, criado para testes do projeto de extensão.\n	<h1 id="pio-cardápio-e-alimentação" class="toc-header"><a class="toc-anchor" href="#pio-cardápio-e-alimentação">¶</a> PIO – Cardápio e alimentação</h1>\n<p>Orientações sobre o <strong>cardápio</strong> semanal e restrições alimentares das crianças.</p>\n<blockquote>\n<p>Conteúdo fictício, criado para testes do projeto de extensão.</p>\n</blockquote>\n	[{"title":"PIO – Cardápio e alimentação","anchor":"#pio-cardápio-e-alimentação","children":[]}]	markdown	2026-11-01T22:32:13.253Z	2026-11-01T22:32:14.444Z	markdown	en	1	1	{"js":"","css":""}
32	pmbc/seduc/nei/pio/adaptacao	c57ee203d34bb584ef9eff84730a50da3f40bc0d	PIO – Período de adaptação	PIO – Período de adaptação	f	t	\N			# PIO – Período de adaptação\n\nRoteiro do **período de adaptação** de crianças novas na unidade.\n\n> Conteúdo fictício, criado para testes do projeto de extensão.\n	<h1 id="pio-período-de-adaptação" class="toc-header"><a class="toc-anchor" href="#pio-período-de-adaptação">¶</a> PIO – Período de adaptação</h1>\n<p>Roteiro do <strong>período de adaptação</strong> de crianças novas na unidade.</p>\n<blockquote>\n<p>Conteúdo fictício, criado para testes do projeto de extensão.</p>\n</blockquote>\n	[{"title":"PIO – Período de adaptação","anchor":"#pio-período-de-adaptação","children":[]}]	markdown	2026-11-01T22:32:15.041Z	2026-11-01T22:32:16.276Z	markdown	en	1	1	{"js":"","css":""}
33	pmbc/segov	7a2d9238e9de68f1877e7e4d651584a1b11492bd	SEGOV – Informações gerais	SEGOV – Informações gerais	f	t	\N			# SEGOV – Informações gerais\n\nDocumentos comuns à Secretaria Municipal de Governo, Inovação e Orçamento.\n\n> Conteúdo fictício, criado para testes do projeto de extensão.\n	<h1 id="segov-informações-gerais" class="toc-header"><a class="toc-anchor" href="#segov-informações-gerais">¶</a> SEGOV – Informações gerais</h1>\n<p>Documentos comuns à Secretaria Municipal de Governo, Inovação e Orçamento.</p>\n<blockquote>\n<p>Conteúdo fictício, criado para testes do projeto de extensão.</p>\n</blockquote>\n	[{"title":"SEGOV – Informações gerais","anchor":"#segov-informações-gerais","children":[]}]	markdown	2026-11-01T22:32:16.890Z	2026-11-01T22:32:18.112Z	markdown	en	1	1	{"js":"","css":""}
34	pmbc/segov/diti	daab7ec1487555a3ccc8659c37f2dcfbfed84c92	DITI – Início	DITI – Início	f	t	\N			# DITI – Início\n\nPágina inicial da Divisão de Tecnologia da Informação.\n\n> Conteúdo fictício, criado para testes do projeto de extensão.\n	<h1 id="diti-início" class="toc-header"><a class="toc-anchor" href="#diti-início">¶</a> DITI – Início</h1>\n<p>Página inicial da Divisão de Tecnologia da Informação.</p>\n<blockquote>\n<p>Conteúdo fictício, criado para testes do projeto de extensão.</p>\n</blockquote>\n	[{"title":"DITI – Início","anchor":"#diti-início","children":[]}]	markdown	2026-11-01T22:32:18.742Z	2026-11-01T22:32:19.895Z	markdown	en	1	1	{"js":"","css":""}
35	pmbc/segov/diti/abrir-chamado	366fdf1273ae14e7aae7c8c333313c81253fb2b1	DITI – Como abrir um chamado	DITI – Como abrir um chamado	f	t	\N			# DITI – Como abrir um chamado\n\nPasso a passo para **abrir um chamado** de suporte de informática: identificar o equipamento, descrever o problema e anotar o protocolo.\n\n> Conteúdo fictício, criado para testes do projeto de extensão.\n	<h1 id="diti-como-abrir-um-chamado" class="toc-header"><a class="toc-anchor" href="#diti-como-abrir-um-chamado">¶</a> DITI – Como abrir um chamado</h1>\n<p>Passo a passo para <strong>abrir um chamado</strong> de suporte de informática: identificar o equipamento, descrever o problema e anotar o protocolo.</p>\n<blockquote>\n<p>Conteúdo fictício, criado para testes do projeto de extensão.</p>\n</blockquote>\n	[{"title":"DITI – Como abrir um chamado","anchor":"#diti-como-abrir-um-chamado","children":[]}]	markdown	2026-11-01T22:32:20.496Z	2026-11-01T22:32:21.707Z	markdown	en	1	1	{"js":"","css":""}
36	pmbc/segov/diti/backup	c0a186d1266f00d77f7c579b8725d7e7a5dc9c67	DITI – Rotina de backup	DITI – Rotina de backup	f	t	\N			# DITI – Rotina de backup\n\nDescrição da rotina de **backup** dos servidores: frequência, retenção e procedimento de restauração.\n\n> Conteúdo fictício, criado para testes do projeto de extensão.\n	<h1 id="diti-rotina-de-backup" class="toc-header"><a class="toc-anchor" href="#diti-rotina-de-backup">¶</a> DITI – Rotina de backup</h1>\n<p>Descrição da rotina de <strong>backup</strong> dos servidores: frequência, retenção e procedimento de restauração.</p>\n<blockquote>\n<p>Conteúdo fictício, criado para testes do projeto de extensão.</p>\n</blockquote>\n	[{"title":"DITI – Rotina de backup","anchor":"#diti-rotina-de-backup","children":[]}]	markdown	2026-11-01T22:32:22.321Z	2026-11-01T22:32:23.476Z	markdown	en	1	1	{"js":"","css":""}
37	home	b29b5d2ce62e55412776ab98f05631e0aa96597b	Untitled Page		f	t	\N			<p>Página home teste</p>\n	<p>Página home teste</p>\n	[]	html	2026-11-03T23:34:09.231Z	2026-11-03T23:34:10.395Z	ckeditor	en	1	1	{"js":"","css":""}
\.


--
-- Data for Name: renderers; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public.renderers (key, "isEnabled", config) FROM stdin;
asciidocCore	t	{"safeMode":"server"}
htmlAsciinema	f	{}
htmlBlockquotes	t	{}
htmlCodehighlighter	t	{}
htmlCore	t	{"absoluteLinks":false,"openExternalLinkNewTab":false,"relAttributeExternalLink":"noreferrer"}
htmlDiagram	t	{}
htmlImagePrefetch	f	{}
htmlMediaplayers	t	{}
htmlMermaid	t	{}
htmlSecurity	t	{"safeHTML":true,"allowDrawIoUnsafe":true,"allowIFrames":false}
htmlTabset	t	{}
htmlTwemoji	t	{}
markdownAbbr	t	{}
markdownCore	t	{"allowHTML":true,"linkify":true,"linebreaks":true,"underline":false,"typographer":false,"quotes":"English"}
markdownEmoji	t	{}
markdownExpandtabs	t	{"tabWidth":4}
markdownFootnotes	t	{}
markdownImsize	t	{}
markdownKatex	t	{"useInline":true,"useBlocks":true}
markdownKroki	f	{"server":"https://kroki.io","openMarker":"```kroki","closeMarker":"```"}
markdownMathjax	f	{"useInline":true,"useBlocks":true}
markdownMultiTable	f	{"multilineEnabled":true,"headerlessEnabled":true,"rowspanEnabled":true}
markdownPivotTable	f	{}
markdownPlantuml	t	{"server":"https://plantuml.requarks.io","openMarker":"```plantuml","closeMarker":"```","imageFormat":"svg"}
markdownSupsub	t	{"subEnabled":true,"supEnabled":true}
markdownTasklists	t	{}
openapiCore	t	{}
\.


--
-- Data for Name: searchEngines; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public."searchEngines" (key, "isEnabled", config) FROM stdin;
algolia	f	{"appId":"","apiKey":"","indexName":"wiki"}
aws	f	{"domain":"","endpoint":"","region":"us-east-1","accessKeyId":"","secretAccessKey":"","AnalysisSchemeLang":"en"}
azure	f	{"serviceName":"","adminKey":"","indexName":"wiki"}
db	t	{}
elasticsearch	f	{"apiVersion":"7.x","hosts":"","verifyTLSCertificate":true,"tlsCertPath":"","indexName":"wiki","analyzer":"simple","sniffOnStart":false,"sniffInterval":0}
manticore	f	{}
postgres	f	{"dictLanguage":"english"}
solr	f	{"host":"solr","port":8983,"core":"wiki","protocol":"http"}
sphinx	f	{}
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public.sessions (sid, sess, expired) FROM stdin;
\.


--
-- Data for Name: settings; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public.settings (key, value, "updatedAt") FROM stdin;
auth	{"audience":"urn:wiki.js","tokenExpiration":"30m","tokenRenewal":"14d"}	2026-10-24T19:52:25.651Z
certs	{"jwk":{"kty":"RSA","n":"xXdsq8FX-aJDR0lnoxGmLXHzXxFSaMA2Pdpi_8nPacTXqFAOFWswOwmBcMeezgJdi6nUgm7I9ZU_q8q8OWbfAwBQvJa65Ef8hl1Hi-JZcYA2YUxVicbLcDiPI-TiBbrWWQFmCYP6WhJvRLRh6I10e82YQKC4gJeiq-wccFVwoqkGgVd6tN4GOEauXAu9BkBkL6lZ4UJZOLteRrMBryIZmiuLfS2186WU5TqEdh1_LoA8ho0XgJKHm847UmCXAWfQOTGQQcUSMnSFoIQF7YTq2OZNMG6xuIEhNYStalcOxKeA3IDlo8ZxWPPkATOFJi5Ej-D28yFF6ncikBgMtfftsQ","e":"AQAB"},"public":"-----BEGIN RSA PUBLIC KEY-----\\nMIIBCgKCAQEAxXdsq8FX+aJDR0lnoxGmLXHzXxFSaMA2Pdpi/8nPacTXqFAOFWsw\\nOwmBcMeezgJdi6nUgm7I9ZU/q8q8OWbfAwBQvJa65Ef8hl1Hi+JZcYA2YUxVicbL\\ncDiPI+TiBbrWWQFmCYP6WhJvRLRh6I10e82YQKC4gJeiq+wccFVwoqkGgVd6tN4G\\nOEauXAu9BkBkL6lZ4UJZOLteRrMBryIZmiuLfS2186WU5TqEdh1/LoA8ho0XgJKH\\nm847UmCXAWfQOTGQQcUSMnSFoIQF7YTq2OZNMG6xuIEhNYStalcOxKeA3IDlo8Zx\\nWPPkATOFJi5Ej+D28yFF6ncikBgMtfftsQIDAQAB\\n-----END RSA PUBLIC KEY-----\\n","private":"-----BEGIN RSA PRIVATE KEY-----\\nProc-Type: 4,ENCRYPTED\\nDEK-Info: AES-256-CBC,2FD0D984BAE9CF853FFA3A09BC48C97A\\n\\nDzUOARkUKLdfgipzclzgEKCnh7gLNA/O2IBZ12NZroXggkZNOJyHCvQMtOGFVyba\\nDTZ2muEmyEyzsXgO9Yhqn/ApamQvfhQfBnOgKKh2NSuLHXCtpp1qtHmyp4Kx9PFQ\\nFNE67CNJGv9KypqAA34ELobsc4WyJZAx7TetHamo9Z2lBnyea798rDvHn30hQ7XV\\nnPVJhAWL30ci5MPKHrL4Lvj8LawLzGalhfcAiymRa07FBKKzX9r51LPspqgXqP2S\\nbxaWewXTyIfh96Mc4cNiaQfO77PNfPzYi2DK710Y3mfkEKvC5GFvXQK/N49res4b\\nyO9xNKMKHXQm8lLdq2uziTYA1i8nw6Zgs4bk0x45/KGIUP3IlwxLYKRa70JaUOBh\\ncbzHiZ/xkys0g0TGVeBa8PXIdTgFb/19wgyeUYZnlbnNRlMRq7Ik7Uvi1dlhyzMH\\n8PWOglSrJqFX0HLJJOdg8n1fJDH8JYzlos3hg2qTsIn6CqDqsVo92F3rTMX8BfEj\\n9hefYh9QGgADrwsHL7NHs6OUaVSahbsqAs4+YEp94ev4MaBU0bkg/iLvKWplYYwi\\n1nX23DOSl2soKaGmvzkNRDu5AUMF7yZycURmFxP/wC9Rwv+Y64VI+5fPuaGnssqE\\n6Y2+T9/Z/hdRmY91TjLQCB1AYmNeQcgTSi0K11aEvtuLP2Jfrbwn0ZI3xhZ/ikeH\\nklVTO+aPLCTGaK4cAJ4pBaJ2ODKc2krd95KJZzno+WD+hXwIcJRZoay9JZZ9lVNh\\nn4kQnMjWlszUZ+ZCYcl6Y5JXSNlbJV0ImykWK3B9q8pbkOkyPqf6Fg/2cGTOPHKp\\nQEVNbqY9cQN73gcW7+UfLR9uBRSpWNK4aXrqxsrIubAOq1c96IEQb/t3xZPlF7q7\\n7IEeS2A4dbobCTXEYRFHHUN3vPT3zDoxtZZQxcsKZZxO+65I9zTJV1yfo1Ecr+Um\\nbKm6xtPU5MElNy1tllju8IpF7Xi666qxt6Kfzo+1IjDZ8JadZiEubuD84aRFChNN\\n6Wjovn/aBNuCnfvuRD62t/7dVHD6GlRG0MTbqMMThV3dSaS+FaiZDK0zg9mRCzUy\\nf6FYmOgCcUzvwUMSYkA2D9fqaqhUUjQFyUG975+TfJpjcWsU91HzJ9VgEq9/wqAa\\nH6kOR/lZJpmL4fw8CPQP2fvoKGyLn72e7404jwhqpqikCX68qIhr3f/pfdm2Bd1U\\n0xXGjd12VtZVufy9htLJ9V+UZgndTNnrXQFhSVQnZyif41ppFHosGZhoithU7Sr+\\n5KE02NQmJfsOKFVGcO4x/mLzD5uno/Am7Dl5+Mskr001z7gw8n5J121plSSBkpqJ\\ndEPlU8FEBo9LGApdwvlX8IKJkgtWomQBnkY7TeW97upsHtudvE43twfTHrtd4tbY\\nmOIrPChRv7m0sk2mlJJD0hhK1JcBSMrNPZ2giMbOoVmY47S5STNWzAGvAgiCS+An\\n3yWjrfZnVUaILych5G7/cjhXJ7SWxKC8CQsgyAxYSw+VHBE95WDxxQHth23J09wH\\n00SD4eUL4rHMiz+1nbC973Vd9aY2+KK6pI0cQ1xSZ5z2Y6OZkpyK1TWLml5Lwshx\\n-----END RSA PRIVATE KEY-----\\n"}	2026-10-24T19:52:25.664Z
company	{"v":""}	2026-10-24T19:52:25.673Z
features	{"featurePageRatings":true,"featurePageComments":true,"featurePersonalWikis":true}	2026-10-24T19:52:25.680Z
graphEndpoint	{"v":"https://graph.requarks.io"}	2026-10-24T19:52:25.689Z
host	{"v":"https://wiki.teste.com"}	2026-10-24T19:52:25.697Z
logo	{"hasLogo":false,"logoIsSquare":false}	2026-10-24T19:52:25.713Z
mail	{"senderName":"","senderEmail":"","host":"","port":465,"name":"","secure":true,"verifySSL":true,"user":"","pass":"","useDKIM":false,"dkimDomainName":"","dkimKeySelector":"","dkimPrivateKey":""}	2026-10-24T19:52:25.720Z
seo	{"description":"","robots":["index","follow"],"analyticsService":"","analyticsId":""}	2026-10-24T19:52:25.729Z
sessionSecret	{"v":"60554eb0612e57bc1357fbeadd8444df89f5d774f941ff1314427d5544866cb8"}	2026-10-24T19:52:25.736Z
telemetry	{"isEnabled":false,"clientId":"c1ebc647-a9ef-4125-a961-13d666b2b1d2"}	2026-10-24T19:52:25.744Z
theming	{"theme":"default","darkMode":false,"iconset":"mdi","injectCSS":"","injectHead":"","injectBody":""}	2026-10-24T19:52:25.751Z
uploads	{"maxFileSize":5242880,"maxFiles":10,"scanSVG":true,"forceDownload":true}	2026-10-24T19:52:25.759Z
title	{"v":"Wiki.js"}	2026-10-24T19:52:25.767Z
lang	{"code":"en","autoUpdate":true,"namespacing":false,"namespaces":["pt-br","en"],"rtl":false}	2026-11-01T19:39:00.508Z
api	{"isEnabled":false}	2026-11-01T22:36:36.498Z
nav	{"mode":"MIXED"}	2026-11-01T22:41:43.470Z
\.


--
-- Data for Name: storage; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public.storage (key, "isEnabled", mode, config, "syncInterval", state) FROM stdin;
azure	f	push	{"accountName":"","accountKey":"","containerName":"wiki","storageTier":"Cool"}	P0D	{"status":"pending","message":"","lastAttempt":null}
box	f	push	{"clientId":"","clientSecret":"","rootFolder":""}	P0D	{"status":"pending","message":"","lastAttempt":null}
digitalocean	f	push	{"endpoint":"nyc3.digitaloceanspaces.com","bucket":"","accessKeyId":"","secretAccessKey":""}	P0D	{"status":"pending","message":"","lastAttempt":null}
disk	f	push	{"path":"","createDailyBackups":false}	P0D	{"status":"pending","message":"","lastAttempt":null}
dropbox	f	push	{"appKey":"","appSecret":""}	P0D	{"status":"pending","message":"","lastAttempt":null}
gdrive	f	push	{"clientId":"","clientSecret":""}	P0D	{"status":"pending","message":"","lastAttempt":null}
git	f	sync	{"authType":"ssh","repoUrl":"","branch":"master","sshPrivateKeyMode":"path","sshPrivateKeyPath":"","sshPrivateKeyContent":"","verifySSL":true,"basicUsername":"","basicPassword":"","defaultEmail":"name@company.com","defaultName":"John Smith","localRepoPath":"./data/repo","alwaysNamespace":false,"gitBinaryPath":""}	PT5M	{"status":"pending","message":"","lastAttempt":null}
onedrive	f	push	{"clientId":"","clientSecret":""}	P0D	{"status":"pending","message":"","lastAttempt":null}
s3	f	push	{"region":"","bucket":"","accessKeyId":"","secretAccessKey":""}	P0D	{"status":"pending","message":"","lastAttempt":null}
s3generic	f	push	{"endpoint":"https://service.region.example.com","bucket":"","accessKeyId":"","secretAccessKey":"","sslEnabled":true,"s3ForcePathStyle":false,"s3BucketEndpoint":false}	P0D	{"status":"pending","message":"","lastAttempt":null}
sftp	f	push	{"host":"","port":22,"authMode":"privateKey","username":"","privateKey":"","passphrase":"","password":"","basePath":"/root/wiki"}	P0D	{"status":"pending","message":"","lastAttempt":null}
\.


--
-- Data for Name: tags; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public.tags (id, tag, title, "createdAt", "updatedAt") FROM stdin;
1	teste	teste	2026-11-01T20:29:26.533Z	2026-11-01T20:29:26.533Z
\.


--
-- Data for Name: userAvatars; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public."userAvatars" (id, data) FROM stdin;
\.


--
-- Data for Name: userGroups; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public."userGroups" (id, "userId", "groupId") FROM stdin;
1	1	1
2	2	2
4	3	8
6	4	9
8	5	5
9	5	11
12	7	1
\.


--
-- Data for Name: userKeys; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public."userKeys" (id, kind, token, "createdAt", "validUntil", "userId") FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public.users (id, email, name, "providerId", password, "tfaIsActive", "tfaSecret", "jobTitle", location, "pictureUrl", timezone, "isSystem", "isActive", "isVerified", "mustChangePwd", "createdAt", "updatedAt", "providerKey", "localeCode", "defaultEditor", "lastLoginAt", "dateFormat", appearance) FROM stdin;
2	guest@example.com	Guest	\N		f	\N			\N	America/New_York	t	t	t	f	2026-10-24T19:52:26.541Z	2026-10-24T19:52:26.541Z	local	en	markdown	\N		
5	multi.setor@pmbc.local	Servidor MultiSetor	multi.setor	\N	f	\N				America/New_York	f	t	t	f	2026-11-11T13:38:08.995Z	2026-11-11T13:38:08.995Z	decd4a0b-d6eb-4b30-9094-582389bd3dfd	en	markdown	2026-11-11T13:38:09.020Z		
6	sem.grupo@pmbc.local	Usuario SemGrupo	sem.grupo	\N	f	\N				America/New_York	f	t	t	f	2026-11-11T13:39:08.500Z	2026-11-11T13:39:08.500Z	decd4a0b-d6eb-4b30-9094-582389bd3dfd	en	markdown	2026-11-11T13:39:08.514Z		
7	ti.admin@pmbc.local	Administrador TI	ti.admin	\N	f	\N				America/New_York	f	t	t	f	2026-11-11T13:40:04.829Z	2026-11-11T13:40:04.829Z	decd4a0b-d6eb-4b30-9094-582389bd3dfd	en	markdown	2026-11-11T13:40:04.847Z		
1	alexpauletti10@gmail.com	Administrator	\N	$2a$12$8OxmlwTI4AQkxK0X4M/xk.8A5bwuQLFInRuH86JzuSNyZbk.I7.gW	f	\N			\N	America/New_York	f	t	t	f	2026-10-24T19:52:26.284Z	2026-10-24T19:52:26.284Z	local	en	markdown	2026-11-04T01:33:45.061Z		
3	pio.leitor@pmbc.local	Estagiario PIO	pio.leitor	\N	f	\N				America/New_York	f	t	t	f	2026-11-03T23:33:26.897Z	2026-11-04T01:34:45.178Z	decd4a0b-d6eb-4b30-9094-582389bd3dfd	en	markdown	2026-11-11T13:36:47.994Z		
4	pio.admin@pmbc.local	Diretor PIO	pio.admin	\N	f	\N				America/New_York	f	t	t	f	2026-11-11T13:37:32.900Z	2026-11-11T13:37:32.900Z	decd4a0b-d6eb-4b30-9094-582389bd3dfd	en	markdown	2026-11-11T13:37:32.929Z		
\.


--
-- Name: apiKeys_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wikijs
--

SELECT pg_catalog.setval('public."apiKeys_id_seq"', 2, true);


--
-- Name: assetFolders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wikijs
--

SELECT pg_catalog.setval('public."assetFolders_id_seq"', 1, false);


--
-- Name: assets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wikijs
--

SELECT pg_catalog.setval('public.assets_id_seq', 1, false);


--
-- Name: comments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wikijs
--

SELECT pg_catalog.setval('public.comments_id_seq', 1, false);


--
-- Name: groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wikijs
--

SELECT pg_catalog.setval('public.groups_id_seq', 11, true);


--
-- Name: migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wikijs
--

SELECT pg_catalog.setval('public.migrations_id_seq', 16, true);


--
-- Name: migrations_lock_index_seq; Type: SEQUENCE SET; Schema: public; Owner: wikijs
--

SELECT pg_catalog.setval('public.migrations_lock_index_seq', 1, true);


--
-- Name: pageHistoryTags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wikijs
--

SELECT pg_catalog.setval('public."pageHistoryTags_id_seq"', 1, false);


--
-- Name: pageHistory_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wikijs
--

SELECT pg_catalog.setval('public."pageHistory_id_seq"', 18, true);


--
-- Name: pageLinks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wikijs
--

SELECT pg_catalog.setval('public."pageLinks_id_seq"', 1, false);


--
-- Name: pageTags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wikijs
--

SELECT pg_catalog.setval('public."pageTags_id_seq"', 36, true);


--
-- Name: pages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wikijs
--

SELECT pg_catalog.setval('public.pages_id_seq', 37, true);


--
-- Name: tags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wikijs
--

SELECT pg_catalog.setval('public.tags_id_seq', 1, true);


--
-- Name: userGroups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wikijs
--

SELECT pg_catalog.setval('public."userGroups_id_seq"', 12, true);


--
-- Name: userKeys_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wikijs
--

SELECT pg_catalog.setval('public."userKeys_id_seq"', 1, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wikijs
--

SELECT pg_catalog.setval('public.users_id_seq', 7, true);


--
-- Name: analytics analytics_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.analytics
    ADD CONSTRAINT analytics_pkey PRIMARY KEY (key);


--
-- Name: apiKeys apiKeys_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."apiKeys"
    ADD CONSTRAINT "apiKeys_pkey" PRIMARY KEY (id);


--
-- Name: assetData assetData_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."assetData"
    ADD CONSTRAINT "assetData_pkey" PRIMARY KEY (id);


--
-- Name: assetFolders assetFolders_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."assetFolders"
    ADD CONSTRAINT "assetFolders_pkey" PRIMARY KEY (id);


--
-- Name: assets assets_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.assets
    ADD CONSTRAINT assets_pkey PRIMARY KEY (id);


--
-- Name: authentication authentication_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.authentication
    ADD CONSTRAINT authentication_pkey PRIMARY KEY (key);


--
-- Name: commentProviders commentProviders_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."commentProviders"
    ADD CONSTRAINT "commentProviders_pkey" PRIMARY KEY (key);


--
-- Name: comments comments_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (id);


--
-- Name: editors editors_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.editors
    ADD CONSTRAINT editors_pkey PRIMARY KEY (key);


--
-- Name: groups groups_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.groups
    ADD CONSTRAINT groups_pkey PRIMARY KEY (id);


--
-- Name: locales locales_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.locales
    ADD CONSTRAINT locales_pkey PRIMARY KEY (code);


--
-- Name: loggers loggers_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.loggers
    ADD CONSTRAINT loggers_pkey PRIMARY KEY (key);


--
-- Name: migrations_lock migrations_lock_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.migrations_lock
    ADD CONSTRAINT migrations_lock_pkey PRIMARY KEY (index);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- Name: navigation navigation_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.navigation
    ADD CONSTRAINT navigation_pkey PRIMARY KEY (key);


--
-- Name: pageHistoryTags pageHistoryTags_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."pageHistoryTags"
    ADD CONSTRAINT "pageHistoryTags_pkey" PRIMARY KEY (id);


--
-- Name: pageHistory pageHistory_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."pageHistory"
    ADD CONSTRAINT "pageHistory_pkey" PRIMARY KEY (id);


--
-- Name: pageLinks pageLinks_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."pageLinks"
    ADD CONSTRAINT "pageLinks_pkey" PRIMARY KEY (id);


--
-- Name: pageTags pageTags_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."pageTags"
    ADD CONSTRAINT "pageTags_pkey" PRIMARY KEY (id);


--
-- Name: pageTree pageTree_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."pageTree"
    ADD CONSTRAINT "pageTree_pkey" PRIMARY KEY (id);


--
-- Name: pages pages_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.pages
    ADD CONSTRAINT pages_pkey PRIMARY KEY (id);


--
-- Name: renderers renderers_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.renderers
    ADD CONSTRAINT renderers_pkey PRIMARY KEY (key);


--
-- Name: searchEngines searchEngines_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."searchEngines"
    ADD CONSTRAINT "searchEngines_pkey" PRIMARY KEY (key);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (sid);


--
-- Name: settings settings_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.settings
    ADD CONSTRAINT settings_pkey PRIMARY KEY (key);


--
-- Name: storage storage_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.storage
    ADD CONSTRAINT storage_pkey PRIMARY KEY (key);


--
-- Name: tags tags_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (id);


--
-- Name: tags tags_tag_unique; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.tags
    ADD CONSTRAINT tags_tag_unique UNIQUE (tag);


--
-- Name: userAvatars userAvatars_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."userAvatars"
    ADD CONSTRAINT "userAvatars_pkey" PRIMARY KEY (id);


--
-- Name: userGroups userGroups_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."userGroups"
    ADD CONSTRAINT "userGroups_pkey" PRIMARY KEY (id);


--
-- Name: userKeys userKeys_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."userKeys"
    ADD CONSTRAINT "userKeys_pkey" PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users users_providerkey_email_unique; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_providerkey_email_unique UNIQUE ("providerKey", email);


--
-- Name: pagelinks_path_localecode_index; Type: INDEX; Schema: public; Owner: wikijs
--

CREATE INDEX pagelinks_path_localecode_index ON public."pageLinks" USING btree (path, "localeCode");


--
-- Name: sessions_expired_index; Type: INDEX; Schema: public; Owner: wikijs
--

CREATE INDEX sessions_expired_index ON public.sessions USING btree (expired);


--
-- Name: assetFolders assetfolders_parentid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."assetFolders"
    ADD CONSTRAINT assetfolders_parentid_foreign FOREIGN KEY ("parentId") REFERENCES public."assetFolders"(id);


--
-- Name: assets assets_authorid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.assets
    ADD CONSTRAINT assets_authorid_foreign FOREIGN KEY ("authorId") REFERENCES public.users(id);


--
-- Name: assets assets_folderid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.assets
    ADD CONSTRAINT assets_folderid_foreign FOREIGN KEY ("folderId") REFERENCES public."assetFolders"(id);


--
-- Name: comments comments_authorid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_authorid_foreign FOREIGN KEY ("authorId") REFERENCES public.users(id);


--
-- Name: comments comments_pageid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_pageid_foreign FOREIGN KEY ("pageId") REFERENCES public.pages(id);


--
-- Name: pageHistory pagehistory_authorid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."pageHistory"
    ADD CONSTRAINT pagehistory_authorid_foreign FOREIGN KEY ("authorId") REFERENCES public.users(id);


--
-- Name: pageHistory pagehistory_editorkey_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."pageHistory"
    ADD CONSTRAINT pagehistory_editorkey_foreign FOREIGN KEY ("editorKey") REFERENCES public.editors(key);


--
-- Name: pageHistory pagehistory_localecode_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."pageHistory"
    ADD CONSTRAINT pagehistory_localecode_foreign FOREIGN KEY ("localeCode") REFERENCES public.locales(code);


--
-- Name: pageHistoryTags pagehistorytags_pageid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."pageHistoryTags"
    ADD CONSTRAINT pagehistorytags_pageid_foreign FOREIGN KEY ("pageId") REFERENCES public."pageHistory"(id) ON DELETE CASCADE;


--
-- Name: pageHistoryTags pagehistorytags_tagid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."pageHistoryTags"
    ADD CONSTRAINT pagehistorytags_tagid_foreign FOREIGN KEY ("tagId") REFERENCES public.tags(id) ON DELETE CASCADE;


--
-- Name: pageLinks pagelinks_pageid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."pageLinks"
    ADD CONSTRAINT pagelinks_pageid_foreign FOREIGN KEY ("pageId") REFERENCES public.pages(id) ON DELETE CASCADE;


--
-- Name: pages pages_authorid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.pages
    ADD CONSTRAINT pages_authorid_foreign FOREIGN KEY ("authorId") REFERENCES public.users(id);


--
-- Name: pages pages_creatorid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.pages
    ADD CONSTRAINT pages_creatorid_foreign FOREIGN KEY ("creatorId") REFERENCES public.users(id);


--
-- Name: pages pages_editorkey_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.pages
    ADD CONSTRAINT pages_editorkey_foreign FOREIGN KEY ("editorKey") REFERENCES public.editors(key);


--
-- Name: pages pages_localecode_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.pages
    ADD CONSTRAINT pages_localecode_foreign FOREIGN KEY ("localeCode") REFERENCES public.locales(code);


--
-- Name: pageTags pagetags_pageid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."pageTags"
    ADD CONSTRAINT pagetags_pageid_foreign FOREIGN KEY ("pageId") REFERENCES public.pages(id) ON DELETE CASCADE;


--
-- Name: pageTags pagetags_tagid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."pageTags"
    ADD CONSTRAINT pagetags_tagid_foreign FOREIGN KEY ("tagId") REFERENCES public.tags(id) ON DELETE CASCADE;


--
-- Name: pageTree pagetree_localecode_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."pageTree"
    ADD CONSTRAINT pagetree_localecode_foreign FOREIGN KEY ("localeCode") REFERENCES public.locales(code);


--
-- Name: pageTree pagetree_pageid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."pageTree"
    ADD CONSTRAINT pagetree_pageid_foreign FOREIGN KEY ("pageId") REFERENCES public.pages(id) ON DELETE CASCADE;


--
-- Name: pageTree pagetree_parent_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."pageTree"
    ADD CONSTRAINT pagetree_parent_foreign FOREIGN KEY (parent) REFERENCES public."pageTree"(id) ON DELETE CASCADE;


--
-- Name: userGroups usergroups_groupid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."userGroups"
    ADD CONSTRAINT usergroups_groupid_foreign FOREIGN KEY ("groupId") REFERENCES public.groups(id) ON DELETE CASCADE;


--
-- Name: userGroups usergroups_userid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."userGroups"
    ADD CONSTRAINT usergroups_userid_foreign FOREIGN KEY ("userId") REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: userKeys userkeys_userid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."userKeys"
    ADD CONSTRAINT userkeys_userid_foreign FOREIGN KEY ("userId") REFERENCES public.users(id);


--
-- Name: users users_defaulteditor_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_defaulteditor_foreign FOREIGN KEY ("defaultEditor") REFERENCES public.editors(key);


--
-- Name: users users_localecode_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_localecode_foreign FOREIGN KEY ("localeCode") REFERENCES public.locales(code);


--
-- Name: users users_providerkey_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_providerkey_foreign FOREIGN KEY ("providerKey") REFERENCES public.authentication(key);


--
-- PostgreSQL database dump complete
--

\unrestrict EUFD6V7BkXm6vb9K7KcOibaedzVctfs6yReyRIdb4JKOA50H27ApBmenbMHzKOC

