SET check_function_bodies = false;
CREATE OR REPLACE FUNCTION public.set_current_timestamp_updated_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  _new record;
BEGIN
  _new := NEW;
  _new."updated_at" = NOW();
  RETURN _new;
END;
$$;
CREATE TABLE public.event_types (
    id integer NOT NULL,
    name text NOT NULL
);
CREATE SEQUENCE public.event_types_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.event_types_id_seq OWNED BY public.event_types.id;
CREATE TABLE public.location_events (
    id integer NOT NULL,
    hash text NOT NULL,
    event_id integer NOT NULL,
    message text NOT NULL,
    status text DEFAULT 'expected'::text NOT NULL,
    verified boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);
CREATE SEQUENCE public.location_events_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.location_events_id_seq OWNED BY public.location_events.id;
CREATE TABLE public.locations (
    id integer NOT NULL,
    hash text NOT NULL,
    city text NOT NULL,
    "cityId" integer NOT NULL,
    district text NOT NULL,
    neighborhood text NOT NULL
);
CREATE SEQUENCE public.locations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.locations_id_seq OWNED BY public.locations.id;
CREATE TABLE public.people (
    id integer NOT NULL,
    hash text NOT NULL,
    person text NOT NULL,
    "cityId" integer NOT NULL,
    building text,
    "buildingNo" text,
    floor text,
    "mainStreet" text,
    street text,
    description text,
    urls text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);
CREATE SEQUENCE public.people_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.people_id_seq OWNED BY public.people.id;
CREATE TABLE public.requests (
    id integer NOT NULL,
    hash text NOT NULL,
    "cityId" integer NOT NULL,
    building text,
    "buildingNo" text,
    floor text,
    "mainStreet" text,
    street text,
    description text,
    urls text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);
COMMENT ON TABLE public.requests IS 'id';
CREATE SEQUENCE public.requests_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.requests_id_seq OWNED BY public.requests.id;
ALTER TABLE ONLY public.event_types ALTER COLUMN id SET DEFAULT nextval('public.event_types_id_seq'::regclass);
ALTER TABLE ONLY public.location_events ALTER COLUMN id SET DEFAULT nextval('public.location_events_id_seq'::regclass);
ALTER TABLE ONLY public.locations ALTER COLUMN id SET DEFAULT nextval('public.locations_id_seq'::regclass);
ALTER TABLE ONLY public.people ALTER COLUMN id SET DEFAULT nextval('public.people_id_seq'::regclass);
ALTER TABLE ONLY public.requests ALTER COLUMN id SET DEFAULT nextval('public.requests_id_seq'::regclass);
ALTER TABLE ONLY public.event_types
    ADD CONSTRAINT event_types_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.location_events
    ADD CONSTRAINT location_events_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.locations
    ADD CONSTRAINT locations_hash_key UNIQUE (hash);
ALTER TABLE ONLY public.locations
    ADD CONSTRAINT locations_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.people
    ADD CONSTRAINT people_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.requests
    ADD CONSTRAINT requests_pkey PRIMARY KEY (id);
CREATE TRIGGER set_public_location_events_updated_at BEFORE UPDATE ON public.location_events FOR EACH ROW EXECUTE FUNCTION public.set_current_timestamp_updated_at();
COMMENT ON TRIGGER set_public_location_events_updated_at ON public.location_events IS 'trigger to set value of column "updated_at" to current timestamp on row update';
CREATE TRIGGER set_public_people_updated_at BEFORE UPDATE ON public.people FOR EACH ROW EXECUTE FUNCTION public.set_current_timestamp_updated_at();
COMMENT ON TRIGGER set_public_people_updated_at ON public.people IS 'trigger to set value of column "updated_at" to current timestamp on row update';
CREATE TRIGGER set_public_requests_updated_at BEFORE UPDATE ON public.requests FOR EACH ROW EXECUTE FUNCTION public.set_current_timestamp_updated_at();
COMMENT ON TRIGGER set_public_requests_updated_at ON public.requests IS 'trigger to set value of column "updated_at" to current timestamp on row update';
ALTER TABLE ONLY public.location_events
    ADD CONSTRAINT location_events_event_id_fkey FOREIGN KEY (event_id) REFERENCES public.event_types(id);
ALTER TABLE ONLY public.location_events
    ADD CONSTRAINT location_events_hash_fkey FOREIGN KEY (hash) REFERENCES public.locations(hash);
ALTER TABLE ONLY public.people
    ADD CONSTRAINT people_hash_fkey FOREIGN KEY (hash) REFERENCES public.locations(hash) ON UPDATE SET NULL ON DELETE SET NULL;
ALTER TABLE ONLY public.requests
    ADD CONSTRAINT requests_hash_fkey FOREIGN KEY (hash) REFERENCES public.locations(hash);
