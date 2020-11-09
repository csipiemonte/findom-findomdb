----------------------------------------------------------------------------
-- Copyright Regione Piemonte - 2020
-- SPDX-License-Identifier: EUPL-1.2-or-later
----------------------------------------------------------------------------
--
-- TOC entry 16127 (class 1259 OID 31175371)
-- Name: aggr_d_model_state; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.aggr_d_model_state (
    model_state character varying(2) NOT NULL,
    model_state_descr character varying(100) NOT NULL,
    from_date timestamp without time zone NOT NULL,
    end_date timestamp without time zone
);


ALTER TABLE findom_os.aggr_d_model_state OWNER TO findom_os;

--
-- TOC entry 16128 (class 1259 OID 31175374)
-- Name: aggr_t_model; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.aggr_t_model (
    model_id numeric(9,0) NOT NULL,
    template_code_fk character varying(40) NOT NULL,
    model_progr numeric(9,0) NOT NULL,
    user_id character varying(100) NOT NULL,
    serialized_model xml NOT NULL,
    model_state_fk character varying(2),
    model_name character varying(1000) NOT NULL,
    model_last_update timestamp without time zone
);


ALTER TABLE findom_os.aggr_t_model OWNER TO findom_os;

--
-- TOC entry 64221 (class 0 OID 0)
-- Dependencies: 16128
-- Name: TABLE aggr_t_model; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON TABLE findom_os.aggr_t_model IS 'Tabella che contiene i dati inseriti nei form dagli utenti';


--
-- TOC entry 16129 (class 1259 OID 31175380)
-- Name: aggr_t_model_index; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.aggr_t_model_index (
    model_id numeric(9,0) NOT NULL,
    index_id numeric(9,0) NOT NULL
);


ALTER TABLE findom_os.aggr_t_model_index OWNER TO findom_os;

--
-- TOC entry 16130 (class 1259 OID 31175383)
-- Name: aggr_t_rule; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.aggr_t_rule (
    rule_id numeric(9,0) NOT NULL,
    rule_name character varying(100) NOT NULL,
    end_point character varying(200) NOT NULL,
    template_code_fk character varying(40) NOT NULL
);


ALTER TABLE findom_os.aggr_t_rule OWNER TO findom_os;

--
-- TOC entry 16131 (class 1259 OID 31175386)
-- Name: aggr_t_submodel; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.aggr_t_submodel (
    submodel_id numeric(9,0) NOT NULL,
    model_id numeric(9,0) NOT NULL,
    model_progr numeric(9,0) NOT NULL,
    template_code_fk character varying(40) NOT NULL,
    user_id character varying(100) NOT NULL,
    xml_type character varying(40) NOT NULL,
    posizione numeric(9,0) NOT NULL,
    serialized_model xml NOT NULL,
    model_last_update timestamp without time zone
);


ALTER TABLE findom_os.aggr_t_submodel OWNER TO findom_os;

--
-- TOC entry 16132 (class 1259 OID 31175392)
-- Name: aggr_t_template; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.aggr_t_template (
    template_id numeric(9,0) NOT NULL,
    template_code character varying(40) NOT NULL,
    template xml NOT NULL,
    pdf_template xml,
    model_validation_rules text,
    template_description character varying(100),
    template_name character varying(100) NOT NULL,
    template_last_update timestamp without time zone,
    template_valid_from_date timestamp without time zone,
    template_valid_to_date timestamp without time zone,
    template_state character varying(50),
    command_validation_rules text,
    global_validation_rules text,
    template_splitted character varying(2),
    xslt_template xml
);


ALTER TABLE findom_os.aggr_t_template OWNER TO findom_os;

--
-- TOC entry 64222 (class 0 OID 0)
-- Dependencies: 16132
-- Name: TABLE aggr_t_template; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON TABLE findom_os.aggr_t_template IS 'Tabella che contiene i modelli del form, della stampa e della validazione';


--
-- TOC entry 16133 (class 1259 OID 31175398)
-- Name: aggr_t_template_index; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.aggr_t_template_index (
    index_id numeric(9,0) NOT NULL,
    template_fk numeric(9,0) NOT NULL,
    xpath_id numeric(4,0) NOT NULL,
    xpath_query character varying(50) NOT NULL,
    description1 character varying(250),
    description2 character varying(250),
    xpath_parent_id numeric(4,0),
    index_rules text,
    template_page xml,
    model_validation_rules_page text,
    command_validation_rules_page text
);


ALTER TABLE findom_os.aggr_t_template_index OWNER TO findom_os;

--
-- TOC entry 64223 (class 0 OID 0)
-- Dependencies: 16133
-- Name: TABLE aggr_t_template_index; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON TABLE findom_os.aggr_t_template_index IS 'Tabella che contiene la struttura di navigazione di un template';


--
-- TOC entry 16134 (class 1259 OID 31175404)
-- Name: csi_log_audit; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.csi_log_audit (
    id_traccia integer NOT NULL,
    data_ora timestamp without time zone,
    id_app character varying(100),
    ip_address character varying(40),
    utente character varying(100),
    operazione character varying(40),
    ogg_oper character varying(150),
    key_oper character varying(500)
);


ALTER TABLE findom_os.csi_log_audit OWNER TO findom_os;

--
-- TOC entry 64224 (class 0 OID 0)
-- Dependencies: 16134
-- Name: TABLE csi_log_audit; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON TABLE findom_os.csi_log_audit IS 'Tabella di interfaccia per la tracciatura delle operazioni secondo lo statdard CSI';


--
-- TOC entry 64225 (class 0 OID 0)
-- Dependencies: 16134
-- Name: COLUMN csi_log_audit.data_ora; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON COLUMN findom_os.csi_log_audit.data_ora IS 'Data e ora dell''evento';


--
-- TOC entry 64226 (class 0 OID 0)
-- Dependencies: 16134
-- Name: COLUMN csi_log_audit.id_app; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON COLUMN findom_os.csi_log_audit.id_app IS 'Codice identificativo dell''applicazione utilizzata dall''utente; da comporre con i valori presenti in Anagrafica Prodotti: <codice prodotto>_<codice linea cliente>_<codice ambiente>_<codice Unità di Installazione>';


--
-- TOC entry 64227 (class 0 OID 0)
-- Dependencies: 16134
-- Name: COLUMN csi_log_audit.utente; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON COLUMN findom_os.csi_log_audit.utente IS 'Identificativo univoco dell''utente che ha effettuato l''operazione (es. login / codice fiscale / matricola / ecc.)';


--
-- TOC entry 64228 (class 0 OID 0)
-- Dependencies: 16134
-- Name: COLUMN csi_log_audit.operazione; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON COLUMN findom_os.csi_log_audit.operazione IS 'Questo campo dovrà contenere l''informazione circa l''operazione effettuata; utilizzare uno dei seguenti valori: login / logout / read / insert / update / delete / merge';


--
-- TOC entry 64229 (class 0 OID 0)
-- Dependencies: 16134
-- Name: COLUMN csi_log_audit.ogg_oper; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON COLUMN findom_os.csi_log_audit.ogg_oper IS 'Questa campo  dovrà contenere il nome della tabella (o dell''oggetto) su cui è stata eseguita l''operazione; se la funzionalità lo permette, inserire la combinazione tabella.colonna . Se l''applicativo prevede accessi a schemi dati esterni, premettere il nome dello schema proprietario al nome dell''oggetto';


--
-- TOC entry 64230 (class 0 OID 0)
-- Dependencies: 16134
-- Name: COLUMN csi_log_audit.key_oper; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON COLUMN findom_os.csi_log_audit.key_oper IS 'Questo campo dovrà contenere l''identificativo univoco dell''oggetto dell''operazione oppure nel caso di aggiornamenti multipli del valore che caratterizza l''insieme di oggetti (es: modifica di un dato in tutta una categoria merceologica)';


--
-- TOC entry 16135 (class 1259 OID 31175410)
-- Name: csi_log_audit_id_traccia_seq; Type: SEQUENCE; Schema: findom_os; Owner: findom_os
--

CREATE SEQUENCE findom_os.csi_log_audit_id_traccia_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE findom_os.csi_log_audit_id_traccia_seq OWNER TO findom_os;

--
-- TOC entry 64231 (class 0 OID 0)
-- Dependencies: 16135
-- Name: csi_log_audit_id_traccia_seq; Type: SEQUENCE OWNED BY; Schema: findom_os; Owner: findom_os
--

ALTER SEQUENCE findom_os.csi_log_audit_id_traccia_seq OWNED BY findom_os.csi_log_audit.id_traccia;


--
-- TOC entry 16136 (class 1259 OID 31175412)
-- Name: ext_d_ateco; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.ext_d_ateco (
    id_ateco integer NOT NULL,
    cod_ateco character varying(8),
    desc_ateco character varying(250),
    cod_livello numeric(1,0),
    cod_ateco_norm character varying(6),
    cod_sezione character varying(1)
);


ALTER TABLE findom_os.ext_d_ateco OWNER TO findom_os;

--
-- TOC entry 16137 (class 1259 OID 31175415)
-- Name: ext_d_comuni; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.ext_d_comuni (
    regione character varying(2) NOT NULL,
    prov character varying(3) NOT NULL,
    comune character varying(6) NOT NULL,
    descom character varying(30) NOT NULL,
    cap character varying(5),
    codfisc character varying(4),
    montana character varying(2),
    ussl character varying(3),
    zonaalt character varying(1),
    zonaalts1 character varying(1),
    zonaalts2 character varying(1),
    regagri character varying(2),
    prov_old character varying(3),
    comune_old character varying(6),
    usl_old character varying(3),
    prov_new character varying(1),
    popolazione numeric(10,0),
    prefisso character varying(5),
    cod_bacino numeric(2,0),
    codice_fiscale character varying(16),
    classificazione character varying(20),
    CONSTRAINT cc_ext_d_comuni_classificazione CHECK (((classificazione)::text = ANY (ARRAY[('collina'::character varying)::text, ('montagna'::character varying)::text, ('pianura'::character varying)::text])))
);


ALTER TABLE findom_os.ext_d_comuni OWNER TO findom_os;

--
-- TOC entry 16138 (class 1259 OID 31175419)
-- Name: ext_d_enti_parchi; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.ext_d_enti_parchi (
    id integer NOT NULL,
    denominazione character varying(100) NOT NULL,
    codice_fiscale character varying(16) NOT NULL,
    piva character varying(16),
    pec character varying(100)
);


ALTER TABLE findom_os.ext_d_enti_parchi OWNER TO findom_os;

--
-- TOC entry 16139 (class 1259 OID 31175422)
-- Name: ext_d_forme_giuridiche; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.ext_d_forme_giuridiche (
    id_forma_giuridica integer NOT NULL,
    cod_forma_giuridica character varying(8) NOT NULL,
    descr_forma_giuridica character varying(200) NOT NULL,
    flag_pubblico_privato numeric(1,0) NOT NULL,
    cod_natura_giuridica character(2),
    CONSTRAINT cc_ext_d_forme_giuridiche_flag_pubblico_privato CHECK ((flag_pubblico_privato = ANY (ARRAY[(1)::numeric, (2)::numeric]))),
    CONSTRAINT cc_ext_d_forme_giuridiche_id_forma_giuridica CHECK ((flag_pubblico_privato = ANY (ARRAY[(1)::numeric, (2)::numeric])))
);


ALTER TABLE findom_os.ext_d_forme_giuridiche OWNER TO findom_os;

--
-- TOC entry 64232 (class 0 OID 0)
-- Dependencies: 16139
-- Name: COLUMN ext_d_forme_giuridiche.cod_natura_giuridica; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON COLUMN findom_os.ext_d_forme_giuridiche.cod_natura_giuridica IS 'Codice della natura giuridica camera commercio';


--
-- TOC entry 16140 (class 1259 OID 31175427)
-- Name: ext_d_province; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.ext_d_province (
    regione character varying(2) NOT NULL,
    prov character(3) NOT NULL,
    desprov character varying(30) NOT NULL,
    sigprov character varying(2) NOT NULL,
    codice_fiscale character varying(16),
    flag_citta_metro character(1),
    CONSTRAINT cc_ext_d_province_flag_citta_metro CHECK ((flag_citta_metro = 'S'::bpchar))
);


ALTER TABLE findom_os.ext_d_province OWNER TO findom_os;

--
-- TOC entry 64233 (class 0 OID 0)
-- Dependencies: 16140
-- Name: COLUMN ext_d_province.flag_citta_metro; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON COLUMN findom_os.ext_d_province.flag_citta_metro IS 'S=Indica che la provinia è una città metropolitana';


--
-- TOC entry 16141 (class 1259 OID 31175431)
-- Name: ext_d_stati_esteri; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.ext_d_stati_esteri (
    cod_stato character varying(3) NOT NULL,
    descrizione_stato character varying(100) NOT NULL,
    stato_cod_fiscale character varying(4),
    sigla_nazione character varying(10),
    flag_ue character(1),
    sigla_continente character varying(2),
    CONSTRAINT cc_ext_d_stati_esteri_flag_ue CHECK ((flag_ue = 'S'::bpchar)),
    CONSTRAINT cc_ext_d_stati_esteri_sigla_continente CHECK (((sigla_continente)::text = 'EU'::text))
);


ALTER TABLE findom_os.ext_d_stati_esteri OWNER TO findom_os;

--
-- TOC entry 64234 (class 0 OID 0)
-- Dependencies: 16141
-- Name: COLUMN ext_d_stati_esteri.flag_ue; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON COLUMN findom_os.ext_d_stati_esteri.flag_ue IS 'Se=S lo stato fa parte della comunita europea';


--
-- TOC entry 64235 (class 0 OID 0)
-- Dependencies: 16141
-- Name: COLUMN ext_d_stati_esteri.sigla_continente; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON COLUMN findom_os.ext_d_stati_esteri.sigla_continente IS 'Sigla del continente: EU=Europa';


--
-- TOC entry 16142 (class 1259 OID 31175436)
-- Name: findom_d_alimentazione_veicoli; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.findom_d_alimentazione_veicoli (
    id_aliment_veicolo integer NOT NULL,
    descr_breve character varying(20) NOT NULL,
    descrizione character varying(200) NOT NULL
);


ALTER TABLE findom_os.findom_d_alimentazione_veicoli OWNER TO findom_os;

--
-- TOC entry 64236 (class 0 OID 0)
-- Dependencies: 16142
-- Name: TABLE findom_d_alimentazione_veicoli; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON TABLE findom_os.findom_d_alimentazione_veicoli IS 'Tabella alimentazione veicoli (Utilizzata nella scheda rottamazione)';


--
-- TOC entry 16143 (class 1259 OID 31175439)
-- Name: findom_d_allegati; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.findom_d_allegati (
    id_allegato integer NOT NULL,
    descrizione character varying(300) NOT NULL
);


ALTER TABLE findom_os.findom_d_allegati OWNER TO findom_os;

--
-- TOC entry 16144 (class 1259 OID 31175442)
-- Name: findom_d_area_tematica; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.findom_d_area_tematica (
    id_area_tematica integer NOT NULL,
    descrizione character varying(100) NOT NULL
);


ALTER TABLE findom_os.findom_d_area_tematica OWNER TO findom_os;

--
-- TOC entry 64237 (class 0 OID 0)
-- Dependencies: 16144
-- Name: TABLE findom_d_area_tematica; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON TABLE findom_os.findom_d_area_tematica IS 'Tabella di definizione delle aree tematiche per i bandi';


--
-- TOC entry 16145 (class 1259 OID 31175445)
-- Name: findom_d_azioni_istruttoria; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.findom_d_azioni_istruttoria (
    id_azione integer NOT NULL,
    descrizione character varying(200) NOT NULL
);


ALTER TABLE findom_os.findom_d_azioni_istruttoria OWNER TO findom_os;

--
-- TOC entry 16146 (class 1259 OID 31175448)
-- Name: findom_d_campi_intervento; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.findom_d_campi_intervento (
    id_campo_intervento integer NOT NULL,
    cod_campo_intervento character varying(10) NOT NULL,
    descrizione character varying(2000) NOT NULL
);


ALTER TABLE findom_os.findom_d_campi_intervento OWNER TO findom_os;

--
-- TOC entry 16147 (class 1259 OID 31175454)
-- Name: findom_d_categ_veicoli; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.findom_d_categ_veicoli (
    id_categ_veicolo integer NOT NULL,
    descr_breve character varying(50) NOT NULL,
    descrizione character varying(500) NOT NULL
);


ALTER TABLE findom_os.findom_d_categ_veicoli OWNER TO findom_os;

--
-- TOC entry 64238 (class 0 OID 0)
-- Dependencies: 16147
-- Name: TABLE findom_d_categ_veicoli; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON TABLE findom_os.findom_d_categ_veicoli IS 'Categoria veicolo, (come definite all’art. 47, comma 2, lettera c) del D.Lgs. 30 aprile 1992 n. 285)';


--
-- TOC entry 16148 (class 1259 OID 31175460)
-- Name: findom_d_categ_voci_spesa; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.findom_d_categ_voci_spesa (
    id_categ_voce_spesa integer NOT NULL,
    descrizione character varying(200)
);


ALTER TABLE findom_os.findom_d_categ_voci_spesa OWNER TO findom_os;

--
-- TOC entry 16149 (class 1259 OID 31175463)
-- Name: findom_d_classif_bandi; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.findom_d_classif_bandi (
    id_classificazione integer NOT NULL,
    id_classificazione_padre integer,
    id_normativa integer NOT NULL,
    id_tipo_suddivisione integer NOT NULL,
    codice character varying(40) NOT NULL,
    descrizione character varying(4000) NOT NULL
);


ALTER TABLE findom_os.findom_d_classif_bandi OWNER TO findom_os;

--
-- TOC entry 64239 (class 0 OID 0)
-- Dependencies: 16149
-- Name: TABLE findom_d_classif_bandi; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON TABLE findom_os.findom_d_classif_bandi IS 'Tabella classificazioni bandi';


--
-- TOC entry 16150 (class 1259 OID 31175469)
-- Name: findom_d_covid_message; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.findom_d_covid_message (
    id_message numeric NOT NULL,
    http_code numeric NOT NULL,
    message_code character varying(50),
    message character varying NOT NULL
);


ALTER TABLE findom_os.findom_d_covid_message OWNER TO findom_os;

--
-- TOC entry 64240 (class 0 OID 0)
-- Dependencies: 16150
-- Name: COLUMN findom_d_covid_message.http_code; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON COLUMN findom_os.findom_d_covid_message.http_code IS 'http status code, restituito dal servizio';


--
-- TOC entry 64241 (class 0 OID 0)
-- Dependencies: 16150
-- Name: COLUMN findom_d_covid_message.message_code; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON COLUMN findom_os.findom_d_covid_message.message_code IS 'codice messaggio wrappato nel presentation layer';


--
-- TOC entry 64242 (class 0 OID 0)
-- Dependencies: 16150
-- Name: COLUMN findom_d_covid_message.message; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON COLUMN findom_os.findom_d_covid_message.message IS 'messaggio mostrato nel presentation layer';


--
-- TOC entry 16151 (class 1259 OID 31175475)
-- Name: findom_d_covid_testi; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.findom_d_covid_testi (
    id_testo integer NOT NULL,
    codice_testo character varying(50),
    testo text
);


ALTER TABLE findom_os.findom_d_covid_testi OWNER TO findom_os;

--
-- TOC entry 64243 (class 0 OID 0)
-- Dependencies: 16151
-- Name: TABLE findom_d_covid_testi; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON TABLE findom_os.findom_d_covid_testi IS 'Tabella testi es. Trattamento dati';


--
-- TOC entry 16152 (class 1259 OID 31175481)
-- Name: findom_d_criteri_valut; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.findom_d_criteri_valut (
    id_criterio integer NOT NULL,
    descrizione character varying(200) NOT NULL,
    descr_breve character varying(20) NOT NULL
);


ALTER TABLE findom_os.findom_d_criteri_valut OWNER TO findom_os;

--
-- TOC entry 64244 (class 0 OID 0)
-- Dependencies: 16152
-- Name: TABLE findom_d_criteri_valut; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON TABLE findom_os.findom_d_criteri_valut IS 'Criteri di valutazione nella graduatoria per la valutazione in fase di istruttoria';


--
-- TOC entry 16153 (class 1259 OID 31175484)
-- Name: findom_d_dett_tipol_aiuti; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.findom_d_dett_tipol_aiuti (
    id_dett_tipol_aiuti integer NOT NULL,
    descrizione character varying(200) NOT NULL,
    id_tipol_aiuto integer NOT NULL,
    link character varying(1000),
    codice character varying(40),
    flag_fittizio character(1),
    CONSTRAINT cc_ffindom_d_dett_tipol_aiuti_flag_fittizio CHECK ((flag_fittizio = 'S'::bpchar))
);


ALTER TABLE findom_os.findom_d_dett_tipol_aiuti OWNER TO findom_os;

--
-- TOC entry 64245 (class 0 OID 0)
-- Dependencies: 16153
-- Name: COLUMN findom_d_dett_tipol_aiuti.flag_fittizio; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON COLUMN findom_os.findom_d_dett_tipol_aiuti.flag_fittizio IS 'S=Il dettaglio coincide con la codifica della tipologia di aiuto; il record viene generato per associare la tipologia al bando';


--
-- TOC entry 16154 (class 1259 OID 31175491)
-- Name: findom_d_dett_tipol_interventi; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.findom_d_dett_tipol_interventi (
    id_dett_tipol_intervento integer NOT NULL,
    descrizione text NOT NULL,
    id_tipol_intervento integer NOT NULL,
    id_campo_intervento integer,
    codice character varying(20) NOT NULL
);


ALTER TABLE findom_os.findom_d_dett_tipol_interventi OWNER TO findom_os;

--
-- TOC entry 16155 (class 1259 OID 31175497)
-- Name: findom_d_dimensioni_imprese; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.findom_d_dimensioni_imprese (
    id_dimensione integer NOT NULL,
    descrizione character varying(40) NOT NULL,
    codice character varying(2)
);


ALTER TABLE findom_os.findom_d_dimensioni_imprese OWNER TO findom_os;

--
-- TOC entry 16156 (class 1259 OID 31175500)
-- Name: findom_d_dipartimenti; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.findom_d_dipartimenti (
    id_dipartimento integer NOT NULL,
    codice character varying(20) NOT NULL,
    descrizione character varying(200) NOT NULL,
    id_ente_strutt integer NOT NULL,
    dt_inizio date NOT NULL,
    dt_fine date
);


ALTER TABLE findom_os.findom_d_dipartimenti OWNER TO findom_os;

--
-- TOC entry 16157 (class 1259 OID 31175503)
-- Name: findom_d_direzioni; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.findom_d_direzioni (
    id_direzione integer NOT NULL,
    descrizione character varying(200),
    codice character varying(20)
);


ALTER TABLE findom_os.findom_d_direzioni OWNER TO findom_os;

--
-- TOC entry 16158 (class 1259 OID 31175506)
-- Name: findom_d_documenti_istruttoria; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.findom_d_documenti_istruttoria (
    id_documento_istr integer NOT NULL,
    codice character varying(10) NOT NULL,
    descrizione character varying(200) NOT NULL
);


ALTER TABLE findom_os.findom_d_documenti_istruttoria OWNER TO findom_os;

--
-- TOC entry 16159 (class 1259 OID 31175509)
-- Name: findom_d_emissioni_veicoli; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.findom_d_emissioni_veicoli (
    id_emissione integer NOT NULL,
    emissioni_co2 character varying(200) NOT NULL,
    emissioni_nox character varying(200) NOT NULL
);


ALTER TABLE findom_os.findom_d_emissioni_veicoli OWNER TO findom_os;

--
-- TOC entry 64246 (class 0 OID 0)
-- Dependencies: 16159
-- Name: TABLE findom_d_emissioni_veicoli; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON TABLE findom_os.findom_d_emissioni_veicoli IS 'Tabella emissioni veicoli';


--
-- TOC entry 16160 (class 1259 OID 31175512)
-- Name: findom_d_enti; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.findom_d_enti (
    id_ente integer NOT NULL,
    descr_breve character varying(40) NOT NULL,
    descrizione character varying(40) NOT NULL,
    indirizzo character varying(1000),
    cap character varying(5),
    pec character varying(200),
    descr_comune character varying(200),
    sigla_prov character varying(10),
    dest_file_domanda character varying(100)
);


ALTER TABLE findom_os.findom_d_enti OWNER TO findom_os;

--
-- TOC entry 16161 (class 1259 OID 31175518)
-- Name: findom_d_enti_strutturati; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.findom_d_enti_strutturati (
    id_ente_strutt integer NOT NULL,
    codice character varying(20) NOT NULL,
    cod_fiscale character varying(40) NOT NULL,
    descrizione character varying(200) NOT NULL,
    dt_inizio date NOT NULL,
    dt_fine date
);


ALTER TABLE findom_os.findom_d_enti_strutturati OWNER TO findom_os;

--
-- TOC entry 64247 (class 0 OID 0)
-- Dependencies: 16161
-- Name: TABLE findom_d_enti_strutturati; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON TABLE findom_os.findom_d_enti_strutturati IS 'Tabella enti strutturati Es. Politecnico, Università, Regione';


--
-- TOC entry 16162 (class 1259 OID 31175521)
-- Name: findom_d_forme_finanziamenti; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.findom_d_forme_finanziamenti (
    id_forma_finanziamento integer NOT NULL,
    cod_forma_finanziamento character varying(10) NOT NULL,
    descrizione character varying(200) NOT NULL,
    tipo_forma_finanziamento character(1) NOT NULL,
    CONSTRAINT cc_findom_d_forme_finanziamenti_tipo_forma_finanziamento CHECK ((tipo_forma_finanziamento = ANY (ARRAY['C'::bpchar, 'F'::bpchar, 'G'::bpchar])))
);


ALTER TABLE findom_os.findom_d_forme_finanziamenti OWNER TO findom_os;

--
-- TOC entry 64248 (class 0 OID 0)
-- Dependencies: 16162
-- Name: COLUMN findom_d_forme_finanziamenti.tipo_forma_finanziamento; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON COLUMN findom_os.findom_d_forme_finanziamenti.tipo_forma_finanziamento IS 'C= Contributo  F= Finanziamento G=Garanzia';


--
-- TOC entry 16163 (class 1259 OID 31175525)
-- Name: findom_d_funzionari; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.findom_d_funzionari (
    id_funzionario integer NOT NULL,
    cod_fiscale character varying(40) NOT NULL,
    cognome character varying(200),
    nome character varying(200),
    dt_inizio date NOT NULL,
    dt_fine date,
    id_ruolo integer NOT NULL,
    email character varying(200)
);


ALTER TABLE findom_os.findom_d_funzionari OWNER TO findom_os;

--
-- TOC entry 16164 (class 1259 OID 31175531)
-- Name: findom_d_incarichi; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.findom_d_incarichi (
    id_incarico integer NOT NULL,
    descrizione character varying(100) NOT NULL,
    dt_inizio date DEFAULT '2020-03-30'::date NOT NULL,
    dt_fine date,
    tipo_incarico character(1) NOT NULL,
    CONSTRAINT cc_findom_d_incarichi_tipo_incarico CHECK ((tipo_incarico = ANY (ARRAY['I'::bpchar, 'E'::bpchar])))
);


ALTER TABLE findom_os.findom_d_incarichi OWNER TO findom_os;

--
-- TOC entry 64249 (class 0 OID 0)
-- Dependencies: 16164
-- Name: COLUMN findom_d_incarichi.tipo_incarico; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON COLUMN findom_os.findom_d_incarichi.tipo_incarico IS 'I=Interno/Commissario Funzionario, E=Esterno/Commissario non funzionario';


--
-- TOC entry 16165 (class 1259 OID 31175536)
-- Name: findom_d_indicatori; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.findom_d_indicatori (
    id_indicatore integer NOT NULL,
    descrizione character varying(200) NOT NULL,
    codice character varying(20) NOT NULL,
    unita_misura character varying(200) NOT NULL,
    id_tipo_indicatore integer NOT NULL,
    link character varying(1000)
);


ALTER TABLE findom_os.findom_d_indicatori OWNER TO findom_os;

--
-- TOC entry 16166 (class 1259 OID 31175542)
-- Name: findom_d_motivazione_esito; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.findom_d_motivazione_esito (
    id_motivazione_esito integer NOT NULL,
    descr_motivazione_esito character varying(500) NOT NULL,
    cod_tipo_esito character varying(2) NOT NULL,
    flag_default boolean DEFAULT false NOT NULL
);


ALTER TABLE findom_os.findom_d_motivazione_esito OWNER TO findom_os;

--
-- TOC entry 64250 (class 0 OID 0)
-- Dependencies: 16166
-- Name: TABLE findom_d_motivazione_esito; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON TABLE findom_os.findom_d_motivazione_esito IS 'Contiene le motivazioni degli esiti di valutazione di una domanda';


--
-- TOC entry 64251 (class 0 OID 0)
-- Dependencies: 16166
-- Name: COLUMN findom_d_motivazione_esito.cod_tipo_esito; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON COLUMN findom_os.findom_d_motivazione_esito.cod_tipo_esito IS 'Indica se la motivazione è relativa a un esito di ammissibilità, di istruttoria amministrativa';


--
-- TOC entry 16167 (class 1259 OID 31175549)
-- Name: findom_d_normative; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.findom_d_normative (
    id_normativa integer NOT NULL,
    descr_breve character varying(40) NOT NULL,
    descrizione character varying(500) NOT NULL
);


ALTER TABLE findom_os.findom_d_normative OWNER TO findom_os;

--
-- TOC entry 64252 (class 0 OID 0)
-- Dependencies: 16167
-- Name: TABLE findom_d_normative; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON TABLE findom_os.findom_d_normative IS 'Tabella normative (POR-FESR, PAR-FAS)';


--
-- TOC entry 16168 (class 1259 OID 31175555)
-- Name: findom_d_parametri; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.findom_d_parametri (
    id_parametro integer NOT NULL,
    codice character varying(100) NOT NULL,
    num_max_file_in_zip integer,
    email_invio_anomalie character varying(2000),
    firma_xml character varying(200),
    tipi_doc character varying(1000),
    valore character varying(1000),
    descr_parametro character varying(100)
);


ALTER TABLE findom_os.findom_d_parametri OWNER TO findom_os;

--
-- TOC entry 64253 (class 0 OID 0)
-- Dependencies: 16168
-- Name: COLUMN findom_d_parametri.codice; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON COLUMN findom_os.findom_d_parametri.codice IS 'FILE_DOMANDA=Parametri per elaborazione batch per trasformazione XML - UPLOAD_FILE=Parametri per upload pdf domanda e allegati su index';


--
-- TOC entry 64254 (class 0 OID 0)
-- Dependencies: 16168
-- Name: COLUMN findom_d_parametri.tipi_doc; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON COLUMN findom_os.findom_d_parametri.tipi_doc IS 'Lista di tipi di estensione file consentiti per l''upload';


--
-- TOC entry 16169 (class 1259 OID 31175561)
-- Name: findom_d_parametri_specifiche_valut; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.findom_d_parametri_specifiche_valut (
    id_parametro integer NOT NULL,
    descrizione character varying(300),
    descr_breve character varying(50)
);


ALTER TABLE findom_os.findom_d_parametri_specifiche_valut OWNER TO findom_os;

--
-- TOC entry 16170 (class 1259 OID 31175564)
-- Name: findom_d_premialita; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.findom_d_premialita (
    id_premialita integer NOT NULL,
    descrizione character varying(200) NOT NULL,
    flag_tipo_dato_richiesto character(1) NOT NULL,
    dato_richiesto character varying(200) NOT NULL,
    link character varying(1000),
    CONSTRAINT cc_findom_d_premialita_flag_tipo_dato_richiesto CHECK ((flag_tipo_dato_richiesto = ANY (ARRAY['D'::bpchar, 'N'::bpchar, 'S'::bpchar])))
);


ALTER TABLE findom_os.findom_d_premialita OWNER TO findom_os;

--
-- TOC entry 64255 (class 0 OID 0)
-- Dependencies: 16170
-- Name: COLUMN findom_d_premialita.flag_tipo_dato_richiesto; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON COLUMN findom_os.findom_d_premialita.flag_tipo_dato_richiesto IS 'D=Date N=Numerico S=Stringa';


--
-- TOC entry 16171 (class 1259 OID 31175571)
-- Name: findom_d_range_graduatoria; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.findom_d_range_graduatoria (
    id_range integer NOT NULL,
    descrizione character varying(100),
    id_bando integer,
    punteggio_inizio integer,
    punteggio_fine integer,
    perc_contributo_richiesto numeric(5,2)
);


ALTER TABLE findom_os.findom_d_range_graduatoria OWNER TO findom_os;

--
-- TOC entry 64256 (class 0 OID 0)
-- Dependencies: 16171
-- Name: TABLE findom_d_range_graduatoria; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON TABLE findom_os.findom_d_range_graduatoria IS 'Range di punteggio graduatoria';


--
-- TOC entry 16172 (class 1259 OID 31175574)
-- Name: findom_d_range_graduatoria_id_range_seq; Type: SEQUENCE; Schema: findom_os; Owner: findom_os
--

CREATE SEQUENCE findom_os.findom_d_range_graduatoria_id_range_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE findom_os.findom_d_range_graduatoria_id_range_seq OWNER TO findom_os;

--
-- TOC entry 64257 (class 0 OID 0)
-- Dependencies: 16172
-- Name: findom_d_range_graduatoria_id_range_seq; Type: SEQUENCE OWNED BY; Schema: findom_os; Owner: findom_os
--

ALTER SEQUENCE findom_os.findom_d_range_graduatoria_id_range_seq OWNED BY findom_os.findom_d_range_graduatoria.id_range;


--
-- TOC entry 16173 (class 1259 OID 31175576)
-- Name: findom_d_regole; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.findom_d_regole (
    id_regola integer NOT NULL,
    cod_regola character varying(30) NOT NULL,
    descr_regola character varying(200) NOT NULL,
    corpo_regola text NOT NULL,
    id_tipo_regola integer
);


ALTER TABLE findom_os.findom_d_regole OWNER TO findom_os;

--
-- TOC entry 16174 (class 1259 OID 31175582)
-- Name: findom_d_risorse_umane; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.findom_d_risorse_umane (
    id_risorsa integer NOT NULL,
    descrizione character varying(200) NOT NULL
);


ALTER TABLE findom_os.findom_d_risorse_umane OWNER TO findom_os;

--
-- TOC entry 16175 (class 1259 OID 31175585)
-- Name: findom_d_ruoli_istr; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.findom_d_ruoli_istr (
    id_ruolo integer NOT NULL,
    codice_ruolo character varying(2) NOT NULL,
    descr_ruolo character varying(40) NOT NULL
);


ALTER TABLE findom_os.findom_d_ruoli_istr OWNER TO findom_os;

--
-- TOC entry 16176 (class 1259 OID 31175588)
-- Name: findom_d_settore_attivita; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.findom_d_settore_attivita (
    id_settore_attivita integer NOT NULL,
    cod_settore character varying(20) NOT NULL,
    desc_settore character varying(2000) NOT NULL,
    dt_inizio date NOT NULL,
    dt_fine date
);


ALTER TABLE findom_os.findom_d_settore_attivita OWNER TO findom_os;

--
-- TOC entry 16177 (class 1259 OID 31175594)
-- Name: findom_d_settori; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.findom_d_settori (
    id_settore integer NOT NULL,
    descrizione character varying(200) NOT NULL,
    id_direzione integer,
    codice character varying(20),
    dt_inizio date NOT NULL,
    dt_fine date
);


ALTER TABLE findom_os.findom_d_settori OWNER TO findom_os;

--
-- TOC entry 16178 (class 1259 OID 31175597)
-- Name: findom_d_sistema_protocollo; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.findom_d_sistema_protocollo (
    id_sistema_prot integer NOT NULL,
    descrizione character varying(50) NOT NULL
);


ALTER TABLE findom_os.findom_d_sistema_protocollo OWNER TO findom_os;

--
-- TOC entry 16179 (class 1259 OID 31175600)
-- Name: findom_d_specifiche_valut; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.findom_d_specifiche_valut (
    id_specifica integer NOT NULL,
    descrizione character varying(1000) NOT NULL,
    id_criterio integer NOT NULL,
    ordine numeric(9,0) NOT NULL,
    tipo_specifica character varying(3) DEFAULT 'VAL'::character varying,
    descr_breve character varying(50),
    CONSTRAINT cc_findom_d_specifiche_valut_tipo_specifica CHECK (((tipo_specifica)::text = ANY (ARRAY[('VAL'::character varying)::text, ('PRE'::character varying)::text, ('PEN'::character varying)::text])))
);


ALTER TABLE findom_os.findom_d_specifiche_valut OWNER TO findom_os;

--
-- TOC entry 64258 (class 0 OID 0)
-- Dependencies: 16179
-- Name: TABLE findom_d_specifiche_valut; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON TABLE findom_os.findom_d_specifiche_valut IS 'Specifiche di valutazione, dipendenti dai criteri,  nella graduatoria per la valutazione in fase di istruttoria';


--
-- TOC entry 64259 (class 0 OID 0)
-- Dependencies: 16179
-- Name: COLUMN findom_d_specifiche_valut.tipo_specifica; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON COLUMN findom_os.findom_d_specifiche_valut.tipo_specifica IS 'VAL=Valutazione, PRE=Premialità,PEN=Penalita';


--
-- TOC entry 16180 (class 1259 OID 31175608)
-- Name: findom_d_stato_documento_index; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.findom_d_stato_documento_index (
    id_stato_documento_index integer NOT NULL,
    descr_breve character varying(20),
    descrizione character varying(100)
);


ALTER TABLE findom_os.findom_d_stato_documento_index OWNER TO findom_os;

--
-- TOC entry 64260 (class 0 OID 0)
-- Dependencies: 16180
-- Name: TABLE findom_d_stato_documento_index; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON TABLE findom_os.findom_d_stato_documento_index IS 'Tabella stato documento index';


--
-- TOC entry 16181 (class 1259 OID 31175611)
-- Name: findom_d_stato_istruttoria; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.findom_d_stato_istruttoria (
    id_stato_istr integer NOT NULL,
    codice character varying(20) NOT NULL,
    descrizione character varying(100) NOT NULL,
    ordine numeric(9,0) NOT NULL,
    ordine_in_graduatoria_with_valut numeric(9,0),
    flag_stato_finale character(1),
    flag_stato_fittizio character(1),
    ordine_in_graduatoria_without_valut numeric(9,0),
    CONSTRAINT cc_findom_d_stato_istruttoria_flag_stato_finale CHECK ((flag_stato_finale = 'S'::bpchar)),
    CONSTRAINT cc_findom_d_stato_istruttoria_flag_visibile_in_istr CHECK ((flag_stato_fittizio = 'S'::bpchar))
);


ALTER TABLE findom_os.findom_d_stato_istruttoria OWNER TO findom_os;

--
-- TOC entry 64261 (class 0 OID 0)
-- Dependencies: 16181
-- Name: COLUMN findom_d_stato_istruttoria.ordine_in_graduatoria_with_valut; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON COLUMN findom_os.findom_d_stato_istruttoria.ordine_in_graduatoria_with_valut IS 'Ordinamento utilizzato per i bandi con valutazione interna';


--
-- TOC entry 64262 (class 0 OID 0)
-- Dependencies: 16181
-- Name: COLUMN findom_d_stato_istruttoria.ordine_in_graduatoria_without_valut; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON COLUMN findom_os.findom_d_stato_istruttoria.ordine_in_graduatoria_without_valut IS 'Ordinamento utilizzato per i bandi con valutazione esterna';


--
-- TOC entry 16182 (class 1259 OID 31175616)
-- Name: findom_d_stereotipi; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.findom_d_stereotipi (
    cod_stereotipo character varying(20) NOT NULL,
    descr_stereotipo character varying(200)
);


ALTER TABLE findom_os.findom_d_stereotipi OWNER TO findom_os;

--
-- TOC entry 16183 (class 1259 OID 31175619)
-- Name: findom_d_tipi_indicatori; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.findom_d_tipi_indicatori (
    id_tipo_indicatore integer NOT NULL,
    descrizione character varying(200) NOT NULL,
    flag_monit integer,
    CONSTRAINT cc_findom_d_tipi_indicatori_flag_monit CHECK ((flag_monit = 1))
);


ALTER TABLE findom_os.findom_d_tipi_indicatori OWNER TO findom_os;

--
-- TOC entry 16184 (class 1259 OID 31175623)
-- Name: findom_d_tipi_regole; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.findom_d_tipi_regole (
    id_tipo_regola integer NOT NULL,
    descr_breve character varying(10) NOT NULL,
    descrizione character varying(100) NOT NULL
);


ALTER TABLE findom_os.findom_d_tipi_regole OWNER TO findom_os;

--
-- TOC entry 64263 (class 0 OID 0)
-- Dependencies: 16184
-- Name: TABLE findom_d_tipi_regole; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON TABLE findom_os.findom_d_tipi_regole IS 'Tipologia regole';


--
-- TOC entry 16185 (class 1259 OID 31175626)
-- Name: findom_d_tipi_rottamazione; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.findom_d_tipi_rottamazione (
    id_tipo_rottamazione integer NOT NULL,
    codice_tipo_rottamazione character varying(20) NOT NULL,
    descrizione_tipo_rottamazione character varying(200) NOT NULL
);


ALTER TABLE findom_os.findom_d_tipi_rottamazione OWNER TO findom_os;

--
-- TOC entry 64264 (class 0 OID 0)
-- Dependencies: 16185
-- Name: TABLE findom_d_tipi_rottamazione; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON TABLE findom_os.findom_d_tipi_rottamazione IS 'Tabella tipi rottamazione veicoli';


--
-- TOC entry 16186 (class 1259 OID 31175629)
-- Name: findom_d_tipi_suddivisione; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.findom_d_tipi_suddivisione (
    id_tipo_suddivisione integer NOT NULL,
    descr_breve character varying(40) NOT NULL,
    descrizione character varying(40) NOT NULL
);


ALTER TABLE findom_os.findom_d_tipi_suddivisione OWNER TO findom_os;

--
-- TOC entry 64265 (class 0 OID 0)
-- Dependencies: 16186
-- Name: TABLE findom_d_tipi_suddivisione; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON TABLE findom_os.findom_d_tipi_suddivisione IS 'Tipi di suddivisione classificazione bandi';


--
-- TOC entry 16187 (class 1259 OID 31175632)
-- Name: findom_d_tipo_graduatoria; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.findom_d_tipo_graduatoria (
    id_tipo_graduatoria integer NOT NULL,
    cod_tipo_graduatoria character(10) NOT NULL,
    descrizione character(100) NOT NULL
);


ALTER TABLE findom_os.findom_d_tipo_graduatoria OWNER TO findom_os;

--
-- TOC entry 16188 (class 1259 OID 31175635)
-- Name: findom_d_tipol_aiuti; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.findom_d_tipol_aiuti (
    id_tipol_aiuto integer NOT NULL,
    descrizione character varying(200) NOT NULL,
    codice character varying(40)
);


ALTER TABLE findom_os.findom_d_tipol_aiuti OWNER TO findom_os;

--
-- TOC entry 16189 (class 1259 OID 31175638)
-- Name: findom_d_tipol_beneficiari; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.findom_d_tipol_beneficiari (
    id_tipol_beneficiario integer NOT NULL,
    descrizione character varying(200) NOT NULL,
    cod_stereotipo character varying(20) NOT NULL,
    flag_pubblico_privato numeric(1,0) NOT NULL,
    codice character varying(20) NOT NULL,
    CONSTRAINT cc_findom_d_tipol_beneficiari_flag_pubblico_privato CHECK ((flag_pubblico_privato = ANY (ARRAY[(1)::numeric, (2)::numeric])))
);


ALTER TABLE findom_os.findom_d_tipol_beneficiari OWNER TO findom_os;

--
-- TOC entry 64266 (class 0 OID 0)
-- Dependencies: 16189
-- Name: COLUMN findom_d_tipol_beneficiari.cod_stereotipo; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON COLUMN findom_os.findom_d_tipol_beneficiari.cod_stereotipo IS 'IM=Impresa OP=Opere pubbliche ER=Enti di ricerca';


--
-- TOC entry 64267 (class 0 OID 0)
-- Dependencies: 16189
-- Name: COLUMN findom_d_tipol_beneficiari.flag_pubblico_privato; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON COLUMN findom_os.findom_d_tipol_beneficiari.flag_pubblico_privato IS '1=Privato 2=Pubblico';


--
-- TOC entry 16190 (class 1259 OID 31175642)
-- Name: findom_d_tipol_interventi; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.findom_d_tipol_interventi (
    id_tipol_intervento integer NOT NULL,
    descrizione text NOT NULL,
    id_campo_intervento integer,
    codice character varying(20) NOT NULL
);


ALTER TABLE findom_os.findom_d_tipol_interventi OWNER TO findom_os;

--
-- TOC entry 16191 (class 1259 OID 31175648)
-- Name: findom_d_tipol_voci_spesa; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.findom_d_tipol_voci_spesa (
    id_tipol_voce_spesa integer NOT NULL,
    codice character varying(20) NOT NULL,
    descrizione character varying(200) NOT NULL
);


ALTER TABLE findom_os.findom_d_tipol_voci_spesa OWNER TO findom_os;

--
-- TOC entry 64268 (class 0 OID 0)
-- Dependencies: 16191
-- Name: TABLE findom_d_tipol_voci_spesa; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON TABLE findom_os.findom_d_tipol_voci_spesa IS 'Tipologie voci di spesa';


--
-- TOC entry 16192 (class 1259 OID 31175651)
-- Name: findom_d_tipologie_documenti; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.findom_d_tipologie_documenti (
    id_tipologia integer NOT NULL,
    descrizione character varying(40) NOT NULL
);


ALTER TABLE findom_os.findom_d_tipologie_documenti OWNER TO findom_os;

--
-- TOC entry 16193 (class 1259 OID 31175654)
-- Name: findom_d_ula; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.findom_d_ula (
    id_ula integer NOT NULL,
    descrizione character varying(100) NOT NULL
);


ALTER TABLE findom_os.findom_d_ula OWNER TO findom_os;

--
-- TOC entry 64269 (class 0 OID 0)
-- Dependencies: 16193
-- Name: TABLE findom_d_ula; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON TABLE findom_os.findom_d_ula IS 'Gestione Unità lavorative Annue';


--
-- TOC entry 16194 (class 1259 OID 31175657)
-- Name: findom_d_valoriz_econom; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.findom_d_valoriz_econom (
    id_valoriz_econom integer NOT NULL,
    tipo_valoriz_econom character(1) NOT NULL,
    descrizione character varying(200) NOT NULL,
    descr_breve character varying(50) NOT NULL,
    indicazioni character varying(200),
    flag_edit character(1),
    CONSTRAINT cc_findom_d_valoriz_econom_flag_edit CHECK ((flag_edit = 'S'::bpchar)),
    CONSTRAINT cc_findom_d_valoriz_econom_tipo_valoriz_econom CHECK ((tipo_valoriz_econom = ANY (ARRAY['E'::bpchar, 'U'::bpchar])))
);


ALTER TABLE findom_os.findom_d_valoriz_econom OWNER TO findom_os;

--
-- TOC entry 64270 (class 0 OID 0)
-- Dependencies: 16194
-- Name: COLUMN findom_d_valoriz_econom.tipo_valoriz_econom; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON COLUMN findom_os.findom_d_valoriz_econom.tipo_valoriz_econom IS 'E=Valorizzazione in entrata U=Valorizzazione in uscita';


--
-- TOC entry 64271 (class 0 OID 0)
-- Dependencies: 16194
-- Name: COLUMN findom_d_valoriz_econom.flag_edit; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON COLUMN findom_os.findom_d_valoriz_econom.flag_edit IS 'S=Deve essere imputato il campo previsto per il valore della colonna "INDICAZIONI"';


--
-- TOC entry 16195 (class 1259 OID 31175662)
-- Name: findom_d_voci_entrata; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.findom_d_voci_entrata (
    id_voce_entrata integer NOT NULL,
    descrizione character varying(200) NOT NULL,
    descr_breve character varying(20) NOT NULL,
    indicazioni character varying(200),
    flag_edit character(1),
    flag_risorse_proprie boolean DEFAULT false NOT NULL,
    CONSTRAINT cc_findom_d_voci_entrata_flag_edit CHECK ((flag_edit = 'S'::bpchar))
);


ALTER TABLE findom_os.findom_d_voci_entrata OWNER TO findom_os;

--
-- TOC entry 64272 (class 0 OID 0)
-- Dependencies: 16195
-- Name: COLUMN findom_d_voci_entrata.flag_edit; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON COLUMN findom_os.findom_d_voci_entrata.flag_edit IS 'S=Deve essere imputato il campo previsto per il valore della colonna "INDICAZIONI"';


--
-- TOC entry 16196 (class 1259 OID 31175667)
-- Name: findom_d_voci_spesa; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.findom_d_voci_spesa (
    id_voce_spesa integer NOT NULL,
    descrizione character varying(255) NOT NULL,
    descr_breve character varying(20) NOT NULL,
    id_categ_voce_spesa integer,
    flag_specificaz character(1),
    id_tipol_voce_spesa integer,
    CONSTRAINT cc_findom_d_voci_spesa_flag_specificaz CHECK ((flag_specificaz = 'S'::bpchar))
);


ALTER TABLE findom_os.findom_d_voci_spesa OWNER TO findom_os;

--
-- TOC entry 64273 (class 0 OID 0)
-- Dependencies: 16196
-- Name: COLUMN findom_d_voci_spesa.flag_specificaz; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON COLUMN findom_os.findom_d_voci_spesa.flag_specificaz IS 'Se=S attiva un campo di specificazioni per il beneficiario';


--
-- TOC entry 16197 (class 1259 OID 31175671)
-- Name: findom_r_bandi_allegati; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.findom_r_bandi_allegati (
    id_bando integer NOT NULL,
    id_allegato integer NOT NULL,
    flag_obbligatorio character(1) NOT NULL,
    dt_inizio date NOT NULL,
    dt_fine date,
    flag_differibile character(1),
    flag_firma_digitale character(1),
    CONSTRAINT cc_findom_r_bandi_allegati_flag_differibile CHECK ((flag_differibile = 'S'::bpchar)),
    CONSTRAINT cc_findom_r_bandi_allegati_flag_firma_digitale CHECK (((flag_firma_digitale)::text = 'S'::text)),
    CONSTRAINT cc_findom_r_bandi_allegati_flag_obbligatorio CHECK ((flag_obbligatorio = ANY (ARRAY['S'::bpchar, 'N'::bpchar])))
);


ALTER TABLE findom_os.findom_r_bandi_allegati OWNER TO findom_os;

--
-- TOC entry 64274 (class 0 OID 0)
-- Dependencies: 16197
-- Name: COLUMN findom_r_bandi_allegati.flag_obbligatorio; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON COLUMN findom_os.findom_r_bandi_allegati.flag_obbligatorio IS 'S=Obbligatorio';


--
-- TOC entry 64275 (class 0 OID 0)
-- Dependencies: 16197
-- Name: COLUMN findom_r_bandi_allegati.flag_differibile; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON COLUMN findom_os.findom_r_bandi_allegati.flag_differibile IS 'Flag differibile se valorizzato con ''S'' allora l''upload del file allegato può essere effettuato in un secondo momento';


--
-- TOC entry 64276 (class 0 OID 0)
-- Dependencies: 16197
-- Name: COLUMN findom_r_bandi_allegati.flag_firma_digitale; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON COLUMN findom_os.findom_r_bandi_allegati.flag_firma_digitale IS 'Se=S viene verificata l''estensione del file che deve essere prevista nella tabella FINDOM_D_PARAMETRI con codice=FIRMA_DIGITALE';


--
-- TOC entry 16198 (class 1259 OID 31175677)
-- Name: findom_r_bandi_ateco; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.findom_r_bandi_ateco (
    id_bando integer NOT NULL,
    id_ateco integer NOT NULL
);


ALTER TABLE findom_os.findom_r_bandi_ateco OWNER TO findom_os;

--
-- TOC entry 16199 (class 1259 OID 31175680)
-- Name: findom_r_bandi_ateco_escl; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.findom_r_bandi_ateco_escl (
    id_bando integer NOT NULL,
    id_ateco integer NOT NULL
);


ALTER TABLE findom_os.findom_r_bandi_ateco_escl OWNER TO findom_os;

--
-- TOC entry 16200 (class 1259 OID 31175683)
-- Name: findom_r_bandi_criteri_valut; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.findom_r_bandi_criteri_valut (
    id_bando integer NOT NULL,
    id_criterio integer NOT NULL,
    ordine integer NOT NULL,
    punteggio_min integer,
    punteggio_max integer,
    priorita_graduatoria integer,
    id_tipol_intervento integer,
    flag_visibile_in_domanda boolean DEFAULT false NOT NULL
);


ALTER TABLE findom_os.findom_r_bandi_criteri_valut OWNER TO findom_os;

--
-- TOC entry 64277 (class 0 OID 0)
-- Dependencies: 16200
-- Name: COLUMN findom_r_bandi_criteri_valut.priorita_graduatoria; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON COLUMN findom_os.findom_r_bandi_criteri_valut.priorita_graduatoria IS 'Priorità in graduatoria del criterio relativamente al punteggio';


--
-- TOC entry 64278 (class 0 OID 0)
-- Dependencies: 16200
-- Name: COLUMN findom_r_bandi_criteri_valut.id_tipol_intervento; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON COLUMN findom_os.findom_r_bandi_criteri_valut.id_tipol_intervento IS 'Configurazione specifica per tipologia di intervento';


--
-- TOC entry 64279 (class 0 OID 0)
-- Dependencies: 16200
-- Name: COLUMN findom_r_bandi_criteri_valut.flag_visibile_in_domanda; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON COLUMN findom_os.findom_r_bandi_criteri_valut.flag_visibile_in_domanda IS 'Flag che indica il criterio di valutazione visibile per scheda progetto';


--
-- TOC entry 16201 (class 1259 OID 31175687)
-- Name: findom_r_bandi_dett_tipol_aiuti; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.findom_r_bandi_dett_tipol_aiuti (
    id_bando integer NOT NULL,
    id_dett_tipol_aiuti integer NOT NULL,
    dt_inizio date NOT NULL,
    dt_fine date,
    flag_obbligatorio character(1) DEFAULT 'N'::bpchar,
    CONSTRAINT cc_findom_r_bandi_dett_tipol_aiuti_flag_obbligatorio CHECK ((flag_obbligatorio = ANY (ARRAY['S'::bpchar, 'N'::bpchar])))
);


ALTER TABLE findom_os.findom_r_bandi_dett_tipol_aiuti OWNER TO findom_os;

--
-- TOC entry 64280 (class 0 OID 0)
-- Dependencies: 16201
-- Name: TABLE findom_r_bandi_dett_tipol_aiuti; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON TABLE findom_os.findom_r_bandi_dett_tipol_aiuti IS 'Tabella di associazione tra il bando e i dettagli della tipologia di aiuto';


--
-- TOC entry 16202 (class 1259 OID 31175692)
-- Name: findom_r_bandi_forme_finanziamenti; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.findom_r_bandi_forme_finanziamenti (
    id_bando integer NOT NULL,
    id_forma_finanziamento integer NOT NULL,
    dt_inizio date NOT NULL,
    dt_fine date,
    perc_prevista numeric(5,2),
    flag_obbligatorio character(1) DEFAULT 'N'::bpchar,
    importo_minimo_erogabile numeric(13,2),
    importo_massimo_erogabile numeric(13,2),
    CONSTRAINT cc_findom_r_bandi_forme_finanziamenti_flag_obbligatorio CHECK ((flag_obbligatorio = ANY (ARRAY['S'::bpchar, 'N'::bpchar])))
);


ALTER TABLE findom_os.findom_r_bandi_forme_finanziamenti OWNER TO findom_os;

--
-- TOC entry 16203 (class 1259 OID 31175697)
-- Name: findom_r_bandi_indicatori; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.findom_r_bandi_indicatori (
    id_bando integer NOT NULL,
    id_indicatore integer NOT NULL,
    dt_inizio date NOT NULL,
    dt_fine date,
    flag_obbligatorio character(1) DEFAULT 'N'::bpchar,
    flag_alfa boolean DEFAULT false NOT NULL,
    CONSTRAINT cc_findom_r_bandi_indicatori_flag_obbligatorio CHECK ((flag_obbligatorio = ANY (ARRAY['S'::bpchar, 'N'::bpchar])))
);


ALTER TABLE findom_os.findom_r_bandi_indicatori OWNER TO findom_os;

--
-- TOC entry 64281 (class 0 OID 0)
-- Dependencies: 16203
-- Name: COLUMN findom_r_bandi_indicatori.flag_alfa; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON COLUMN findom_os.findom_r_bandi_indicatori.flag_alfa IS 'Flag che indica l''indicatore può essere alfanumerico';


--
-- TOC entry 16204 (class 1259 OID 31175703)
-- Name: findom_r_bandi_motivazioni_esito; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.findom_r_bandi_motivazioni_esito (
    id_bando integer NOT NULL,
    id_motivazione_esito integer NOT NULL,
    dt_inizio date NOT NULL,
    dt_fine date
);


ALTER TABLE findom_os.findom_r_bandi_motivazioni_esito OWNER TO findom_os;

--
-- TOC entry 16205 (class 1259 OID 31175706)
-- Name: findom_r_bandi_parametri_regole; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.findom_r_bandi_parametri_regole (
    id_bando integer NOT NULL,
    id_parametro integer NOT NULL,
    id_regola integer NOT NULL,
    valore_parametro character varying(500),
    dt_inizio date NOT NULL,
    dt_fine date
);


ALTER TABLE findom_os.findom_r_bandi_parametri_regole OWNER TO findom_os;

--
-- TOC entry 16206 (class 1259 OID 31175712)
-- Name: findom_r_bandi_premialita; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.findom_r_bandi_premialita (
    id_bando integer NOT NULL,
    id_premialita integer NOT NULL,
    dt_inizio date NOT NULL,
    dt_fine date
);


ALTER TABLE findom_os.findom_r_bandi_premialita OWNER TO findom_os;

--
-- TOC entry 16207 (class 1259 OID 31175715)
-- Name: findom_r_bandi_regole; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.findom_r_bandi_regole (
    id_bando integer NOT NULL,
    id_regola integer NOT NULL,
    ordine numeric(9,0)
);


ALTER TABLE findom_os.findom_r_bandi_regole OWNER TO findom_os;

--
-- TOC entry 16208 (class 1259 OID 31175718)
-- Name: findom_r_bandi_soggetti_abilitati; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.findom_r_bandi_soggetti_abilitati (
    id_sogg_abil integer NOT NULL,
    id_bando integer NOT NULL,
    importo_contributo numeric(13,2) NOT NULL,
    dt_inizio date NOT NULL,
    dt_fine date
);


ALTER TABLE findom_os.findom_r_bandi_soggetti_abilitati OWNER TO findom_os;

--
-- TOC entry 64282 (class 0 OID 0)
-- Dependencies: 16208
-- Name: TABLE findom_r_bandi_soggetti_abilitati; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON TABLE findom_os.findom_r_bandi_soggetti_abilitati IS 'Associazione Soggetti abilitati- Bandi';


--
-- TOC entry 16209 (class 1259 OID 31175721)
-- Name: findom_r_bandi_specifiche_valut; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.findom_r_bandi_specifiche_valut (
    id_bando integer NOT NULL,
    id_specifica integer NOT NULL,
    tipo_campo character varying(20) NOT NULL,
    punteggio_min integer,
    punteggio_max integer,
    id_regola integer,
    flag_visibile_in_domanda boolean DEFAULT false NOT NULL,
    CONSTRAINT cc_findom_r_bandi_specifiche_valut_tipo_campo CHECK (((tipo_campo)::text = ANY (ARRAY[('radiobutton'::character varying)::text, ('checkbox'::character varying)::text, ('text'::character varying)::text, ('calcolato'::character varying)::text])))
);


ALTER TABLE findom_os.findom_r_bandi_specifiche_valut OWNER TO findom_os;

--
-- TOC entry 64283 (class 0 OID 0)
-- Dependencies: 16209
-- Name: COLUMN findom_r_bandi_specifiche_valut.flag_visibile_in_domanda; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON COLUMN findom_os.findom_r_bandi_specifiche_valut.flag_visibile_in_domanda IS 'Flag che indica il criterio di valutazione visibile per scheda progetto';


--
-- TOC entry 16210 (class 1259 OID 31175726)
-- Name: findom_r_bandi_tipol_interventi; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.findom_r_bandi_tipol_interventi (
    id_bando integer NOT NULL,
    id_tipol_intervento integer NOT NULL,
    dt_inizio date NOT NULL,
    dt_fine date,
    flag_obbligatorio character(1) DEFAULT 'N'::bpchar,
    CONSTRAINT cc_findom_r_bandi_tipol_interventi_flag_obbligatorio CHECK ((flag_obbligatorio = ANY (ARRAY['S'::bpchar, 'N'::bpchar])))
);


ALTER TABLE findom_os.findom_r_bandi_tipol_interventi OWNER TO findom_os;

--
-- TOC entry 16211 (class 1259 OID 31175731)
-- Name: findom_r_bandi_valoriz_econom; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.findom_r_bandi_valoriz_econom (
    id_bando integer NOT NULL,
    id_valoriz_econom integer NOT NULL,
    flag_duplicabile character(1) NOT NULL,
    dt_inizio date NOT NULL,
    dt_fine date,
    CONSTRAINT cc_findom_r_bandi_valoriz_econom_flag_duplicabile CHECK ((flag_duplicabile = ANY (ARRAY['S'::bpchar, 'N'::bpchar])))
);


ALTER TABLE findom_os.findom_r_bandi_valoriz_econom OWNER TO findom_os;

--
-- TOC entry 64284 (class 0 OID 0)
-- Dependencies: 16211
-- Name: COLUMN findom_r_bandi_valoriz_econom.flag_duplicabile; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON COLUMN findom_os.findom_r_bandi_valoriz_econom.flag_duplicabile IS 'Se si permete la duplicazione della valorizzazione economica per il bando associato';


--
-- TOC entry 16212 (class 1259 OID 31175735)
-- Name: findom_r_bandi_voci_entrata; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.findom_r_bandi_voci_entrata (
    id_bando integer NOT NULL,
    id_voce_entrata integer NOT NULL,
    flag_duplicabile character(1) NOT NULL,
    dt_inizio date NOT NULL,
    dt_fine date,
    CONSTRAINT cc_findom_r_bandi_voci_entrata_flag_duplicabile CHECK ((flag_duplicabile = ANY (ARRAY['S'::bpchar, 'N'::bpchar])))
);


ALTER TABLE findom_os.findom_r_bandi_voci_entrata OWNER TO findom_os;

--
-- TOC entry 64285 (class 0 OID 0)
-- Dependencies: 16212
-- Name: COLUMN findom_r_bandi_voci_entrata.flag_duplicabile; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON COLUMN findom_os.findom_r_bandi_voci_entrata.flag_duplicabile IS 'Se si permete la duplicazione della voce di entrata per il bando associato';


--
-- TOC entry 16213 (class 1259 OID 31175739)
-- Name: findom_r_commissioni_commissari; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.findom_r_commissioni_commissari (
    id_commissione integer NOT NULL,
    id_commissario integer NOT NULL,
    id_incarico integer NOT NULL,
    dt_inizio date NOT NULL,
    dt_fine date
);


ALTER TABLE findom_os.findom_r_commissioni_commissari OWNER TO findom_os;

--
-- TOC entry 16214 (class 1259 OID 31175742)
-- Name: findom_r_dett_tipol_interventi_voci_spesa; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.findom_r_dett_tipol_interventi_voci_spesa (
    id_dett_tipol_intervento integer NOT NULL,
    id_voce_spesa integer NOT NULL,
    dt_inizio date NOT NULL,
    dt_fine date,
    pref_descr_voce character varying(20)
);


ALTER TABLE findom_os.findom_r_dett_tipol_interventi_voci_spesa OWNER TO findom_os;

--
-- TOC entry 16215 (class 1259 OID 31175745)
-- Name: findom_r_funzionari_direzioni; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.findom_r_funzionari_direzioni (
    id_funzionario integer NOT NULL,
    id_direzione integer NOT NULL,
    dt_inizio date NOT NULL,
    dt_fine date
);


ALTER TABLE findom_os.findom_r_funzionari_direzioni OWNER TO findom_os;

--
-- TOC entry 16216 (class 1259 OID 31175748)
-- Name: findom_r_funzionari_settori; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.findom_r_funzionari_settori (
    id_funzionario integer NOT NULL,
    id_settore integer NOT NULL,
    dt_inizio date NOT NULL,
    dt_fine date
);


ALTER TABLE findom_os.findom_r_funzionari_settori OWNER TO findom_os;

--
-- TOC entry 16217 (class 1259 OID 31175751)
-- Name: findom_r_sportelli_bandi_commissioni; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.findom_r_sportelli_bandi_commissioni (
    id_sportello_bando integer NOT NULL,
    id_commissione integer NOT NULL,
    dt_inizio date NOT NULL,
    dt_fine date
);


ALTER TABLE findom_os.findom_r_sportelli_bandi_commissioni OWNER TO findom_os;

--
-- TOC entry 16218 (class 1259 OID 31175754)
-- Name: findom_r_stato_azioni_istruttoria; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.findom_r_stato_azioni_istruttoria (
    id_stato_istr integer NOT NULL,
    id_azione integer NOT NULL,
    dt_inizio date NOT NULL,
    dt_fine date
);


ALTER TABLE findom_os.findom_r_stato_azioni_istruttoria OWNER TO findom_os;

--
-- TOC entry 16219 (class 1259 OID 31175757)
-- Name: findom_r_tipi_rottamaz_alimentaz_veicoli; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.findom_r_tipi_rottamaz_alimentaz_veicoli (
    id_sportello_bando integer NOT NULL,
    id_aliment_veicolo integer NOT NULL,
    id_tipo_rottamazione integer NOT NULL,
    dt_inizio date NOT NULL,
    dt_fine date
);


ALTER TABLE findom_os.findom_r_tipi_rottamaz_alimentaz_veicoli OWNER TO findom_os;

--
-- TOC entry 16220 (class 1259 OID 31175760)
-- Name: findom_r_tipi_rottamaz_categ_veicoli; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.findom_r_tipi_rottamaz_categ_veicoli (
    id_sportello_bando integer NOT NULL,
    id_categ_veicolo integer NOT NULL,
    id_tipo_rottamazione integer NOT NULL,
    dt_inizio date NOT NULL,
    dt_fine date
);


ALTER TABLE findom_os.findom_r_tipi_rottamaz_categ_veicoli OWNER TO findom_os;

--
-- TOC entry 16221 (class 1259 OID 31175763)
-- Name: findom_r_tipol_beneficiari_bandi; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.findom_r_tipol_beneficiari_bandi (
    id_tipol_beneficiario integer NOT NULL,
    id_bando integer NOT NULL,
    dt_inizio date NOT NULL,
    dt_fine date
);


ALTER TABLE findom_os.findom_r_tipol_beneficiari_bandi OWNER TO findom_os;

--
-- TOC entry 16222 (class 1259 OID 31175766)
-- Name: findom_r_tipol_interventi_voci_spesa; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.findom_r_tipol_interventi_voci_spesa (
    id_tipol_intervento integer NOT NULL,
    id_voce_spesa integer NOT NULL,
    dt_inizio date NOT NULL,
    dt_fine date,
    pref_descr_voce character varying(20)
);


ALTER TABLE findom_os.findom_r_tipol_interventi_voci_spesa OWNER TO findom_os;

--
-- TOC entry 16223 (class 1259 OID 31175769)
-- Name: findom_r_ula_tipol_beneficiari_bandi; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.findom_r_ula_tipol_beneficiari_bandi (
    id_ula integer NOT NULL,
    id_tipol_beneficiario integer NOT NULL,
    id_bando integer NOT NULL,
    ordine integer NOT NULL,
    dt_inizio date NOT NULL,
    dt_fine date
);


ALTER TABLE findom_os.findom_r_ula_tipol_beneficiari_bandi OWNER TO findom_os;

--
-- TOC entry 64286 (class 0 OID 0)
-- Dependencies: 16223
-- Name: TABLE findom_r_ula_tipol_beneficiari_bandi; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON TABLE findom_os.findom_r_ula_tipol_beneficiari_bandi IS 'Tabella di associazione ULA allatipologia di beneficiario per bando';


--
-- TOC entry 16224 (class 1259 OID 31175772)
-- Name: findom_t_allegati_sportello; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.findom_t_allegati_sportello (
    id integer NOT NULL,
    id_sportello_bando integer NOT NULL,
    id_tipol_beneficiario integer NOT NULL,
    id_allegato integer NOT NULL,
    flag_obbligatorio character(1) NOT NULL,
    flag_differibile character(1),
    flag_firma_digitale character(1),
    CONSTRAINT cc_findom_t_allegati_sportello_flag_differibile CHECK ((flag_differibile = 'S'::bpchar)),
    CONSTRAINT cc_findom_t_allegati_sportello_flag_firma_digitale CHECK ((flag_firma_digitale = 'S'::bpchar)),
    CONSTRAINT cc_findom_t_allegati_sportello_flag_obbligatorio CHECK ((flag_obbligatorio = ANY (ARRAY['S'::bpchar, 'N'::bpchar])))
);


ALTER TABLE findom_os.findom_t_allegati_sportello OWNER TO findom_os;

--
-- TOC entry 64287 (class 0 OID 0)
-- Dependencies: 16224
-- Name: TABLE findom_t_allegati_sportello; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON TABLE findom_os.findom_t_allegati_sportello IS 'Tabella di allegati obbligatori definiti a livello di sportello/tipologia beneficiario';


--
-- TOC entry 64288 (class 0 OID 0)
-- Dependencies: 16224
-- Name: COLUMN findom_t_allegati_sportello.flag_obbligatorio; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON COLUMN findom_os.findom_t_allegati_sportello.flag_obbligatorio IS 'S=Obbligatorio';


--
-- TOC entry 64289 (class 0 OID 0)
-- Dependencies: 16224
-- Name: COLUMN findom_t_allegati_sportello.flag_differibile; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON COLUMN findom_os.findom_t_allegati_sportello.flag_differibile IS 'Flag differibile se valorizzato con ''S'' allora l''upload del file allegato può essere effettuato in un secondo momento';


--
-- TOC entry 64290 (class 0 OID 0)
-- Dependencies: 16224
-- Name: COLUMN findom_t_allegati_sportello.flag_firma_digitale; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON COLUMN findom_os.findom_t_allegati_sportello.flag_firma_digitale IS 'Se=S viene verificata l''estensione del file che deve essere prevista nella tabella FINDOM_D_PARAMETRI con codice=FIRMA_DIGITALE';


--
-- TOC entry 16225 (class 1259 OID 31175778)
-- Name: findom_t_allegati_sportello_id_seq; Type: SEQUENCE; Schema: findom_os; Owner: findom_os
--

CREATE SEQUENCE findom_os.findom_t_allegati_sportello_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE findom_os.findom_t_allegati_sportello_id_seq OWNER TO findom_os;

--
-- TOC entry 64291 (class 0 OID 0)
-- Dependencies: 16225
-- Name: findom_t_allegati_sportello_id_seq; Type: SEQUENCE OWNED BY; Schema: findom_os; Owner: findom_os
--

ALTER SEQUENCE findom_os.findom_t_allegati_sportello_id_seq OWNED BY findom_os.findom_t_allegati_sportello.id;


--
-- TOC entry 16226 (class 1259 OID 31175780)
-- Name: findom_t_amministratori; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.findom_t_amministratori (
    id_amministratore integer NOT NULL,
    cod_fiscale character varying(16) NOT NULL,
    cognome character varying(40),
    nome character varying(40),
    id_ente_appartenenza integer NOT NULL,
    dt_inizio date NOT NULL,
    dt_fine date
);


ALTER TABLE findom_os.findom_t_amministratori OWNER TO findom_os;

--
-- TOC entry 16227 (class 1259 OID 31175783)
-- Name: findom_t_amministratori_id_amministratore_seq; Type: SEQUENCE; Schema: findom_os; Owner: findom_os
--

CREATE SEQUENCE findom_os.findom_t_amministratori_id_amministratore_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE findom_os.findom_t_amministratori_id_amministratore_seq OWNER TO findom_os;

--
-- TOC entry 64292 (class 0 OID 0)
-- Dependencies: 16227
-- Name: findom_t_amministratori_id_amministratore_seq; Type: SEQUENCE OWNED BY; Schema: findom_os; Owner: findom_os
--

ALTER SEQUENCE findom_os.findom_t_amministratori_id_amministratore_seq OWNED BY findom_os.findom_t_amministratori.id_amministratore;


--
-- TOC entry 16228 (class 1259 OID 31175785)
-- Name: findom_t_bandi; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.findom_t_bandi (
    id_bando integer NOT NULL,
    descrizione text NOT NULL,
    descr_breve character varying(200) NOT NULL,
    id_classificazione integer NOT NULL,
    template_id numeric(9,0) NOT NULL,
    id_ente_destinatario integer NOT NULL,
    num_max_domande integer,
    perc_max_contributo_erogabile numeric(5,2),
    flag_demat character(1),
    parola_chiave_acta character varying(30),
    feedback_acta character varying(100),
    tipo_firma character(1),
    perc_quota_parte numeric(5,2),
    id_settore integer NOT NULL,
    importo_massimo_erogabile numeric(13,2),
    importo_minimo_erogabile numeric(13,2),
    punteggio_min_valut integer,
    flag_valutazione_esterna character(1),
    flag_valutazione_massiva character(1),
    budget_disponibile numeric(13,2),
    tipologia_verifica_firma character(1),
    flag_verifica_firma character(1),
    flag_nuova_gestione boolean DEFAULT false NOT NULL,
    flag_istruttoria_esterna character(1),
    flag_rimodulazione boolean DEFAULT false NOT NULL,
    id_tipo_metadati numeric(1,0),
    dt_inizio_progetto date,
    dt_fine_progetto date,
    flag_dupl_parola_chiave_acta character varying(1),
    flag_progetti_comuni boolean DEFAULT false,
    dt_max_inizio_progetto date,
    cod_nodo_operativo character varying(100),
    flag_amm_aziende_estere boolean DEFAULT false NOT NULL,
    id_area_tematica integer,
    flag_scheda_progetto boolean DEFAULT false NOT NULL,
    flag_upload_index boolean DEFAULT true NOT NULL,
    flag_attiva_invio_doc boolean DEFAULT true NOT NULL,
    CONSTRAINT cc_findom_t_bandi_flag_demat CHECK ((flag_demat = 'S'::bpchar)),
    CONSTRAINT cc_findom_t_bandi_flag_dupl_parola_chiave_acta CHECK (((flag_dupl_parola_chiave_acta)::text = 'S'::text)),
    CONSTRAINT cc_findom_t_bandi_flag_istruttoria_esterna CHECK ((flag_istruttoria_esterna = 'S'::bpchar)),
    CONSTRAINT cc_findom_t_bandi_flag_valutazione_esterna CHECK ((flag_valutazione_esterna = 'S'::bpchar)),
    CONSTRAINT cc_findom_t_bandi_flag_valutazione_massiva CHECK ((flag_valutazione_massiva = 'S'::bpchar)),
    CONSTRAINT cc_findom_t_bandi_flag_verifica_firma CHECK ((flag_verifica_firma = ANY (ARRAY['S'::bpchar, 'N'::bpchar]))),
    CONSTRAINT cc_findom_t_bandi_tipo_firma CHECK ((tipo_firma = ANY (ARRAY['D'::bpchar, 'S'::bpchar]))),
    CONSTRAINT cc_findom_t_bandi_tipologia_verifica_firma CHECK ((tipologia_verifica_firma = ANY (ARRAY['F'::bpchar, 'D'::bpchar])))
);


ALTER TABLE findom_os.findom_t_bandi OWNER TO findom_os;

--
-- TOC entry 64293 (class 0 OID 0)
-- Dependencies: 16228
-- Name: COLUMN findom_t_bandi.flag_demat; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON COLUMN findom_os.findom_t_bandi.flag_demat IS 'Se=S attiva la dematerializzazione';


--
-- TOC entry 64294 (class 0 OID 0)
-- Dependencies: 16228
-- Name: COLUMN findom_t_bandi.tipo_firma; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON COLUMN findom_os.findom_t_bandi.tipo_firma IS 'D=Digitale S=Olografa da scansione';


--
-- TOC entry 64295 (class 0 OID 0)
-- Dependencies: 16228
-- Name: COLUMN findom_t_bandi.perc_quota_parte; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON COLUMN findom_os.findom_t_bandi.perc_quota_parte IS '% quota parte spese generali di funzionalità';


--
-- TOC entry 64296 (class 0 OID 0)
-- Dependencies: 16228
-- Name: COLUMN findom_t_bandi.flag_valutazione_esterna; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON COLUMN findom_os.findom_t_bandi.flag_valutazione_esterna IS 'Se ‘S’ la valutazione verrà effettuata su un sistema esterno ';


--
-- TOC entry 64297 (class 0 OID 0)
-- Dependencies: 16228
-- Name: COLUMN findom_t_bandi.flag_valutazione_massiva; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON COLUMN findom_os.findom_t_bandi.flag_valutazione_massiva IS 'Se ‘S’ la valutazione si attiva solo se tutte le domande del bando hanno stato istruttoria ? ricevuta e richiesta integrazione';


--
-- TOC entry 64298 (class 0 OID 0)
-- Dependencies: 16228
-- Name: COLUMN findom_t_bandi.tipologia_verifica_firma; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON COLUMN findom_os.findom_t_bandi.tipologia_verifica_firma IS 'F=Verifica forte (la verifica dovrà superare tutti i controlli, D=Debole (la verifica dovrà superare solo i controlli principali';


--
-- TOC entry 64299 (class 0 OID 0)
-- Dependencies: 16228
-- Name: COLUMN findom_t_bandi.flag_verifica_firma; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON COLUMN findom_os.findom_t_bandi.flag_verifica_firma IS 'S=Bloccante, N=Non bloccante (Solo se la tipologia della firma è Forte la verifica non è bloccante anche se non si superano tutti i controlli,superando però sempre i controlli principali';


--
-- TOC entry 64300 (class 0 OID 0)
-- Dependencies: 16228
-- Name: COLUMN findom_t_bandi.flag_istruttoria_esterna; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON COLUMN findom_os.findom_t_bandi.flag_istruttoria_esterna IS 'Se ‘S’ l''istruttoria verrà effettuata su un sistema esterno ';


--
-- TOC entry 64301 (class 0 OID 0)
-- Dependencies: 16228
-- Name: COLUMN findom_t_bandi.dt_inizio_progetto; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON COLUMN findom_os.findom_t_bandi.dt_inizio_progetto IS 'Se valorizzata, la data di inizio progetto sulla domanda  non può essere inferiore a questa data';


--
-- TOC entry 64302 (class 0 OID 0)
-- Dependencies: 16228
-- Name: COLUMN findom_t_bandi.dt_fine_progetto; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON COLUMN findom_os.findom_t_bandi.dt_fine_progetto IS 'Se valorizzata, la data di fine progetto sulla domanda  non può essere superiore a questa data';


--
-- TOC entry 64303 (class 0 OID 0)
-- Dependencies: 16228
-- Name: COLUMN findom_t_bandi.flag_dupl_parola_chiave_acta; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON COLUMN findom_os.findom_t_bandi.flag_dupl_parola_chiave_acta IS 'S= La parola chiave ACTA viene duplicata per il bando in base alla tipologia di beneficiario pubblico/privato (+T1=Privato,+T2=Pubblico)';


--
-- TOC entry 64304 (class 0 OID 0)
-- Dependencies: 16228
-- Name: COLUMN findom_t_bandi.dt_max_inizio_progetto; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON COLUMN findom_os.findom_t_bandi.dt_max_inizio_progetto IS 'Data massima di inizio progetto';


--
-- TOC entry 64305 (class 0 OID 0)
-- Dependencies: 16228
-- Name: COLUMN findom_t_bandi.cod_nodo_operativo; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON COLUMN findom_os.findom_t_bandi.cod_nodo_operativo IS 'Descrive la collocazione su Acta, se null vale il nodo responsabile';


--
-- TOC entry 64306 (class 0 OID 0)
-- Dependencies: 16228
-- Name: COLUMN findom_t_bandi.flag_amm_aziende_estere; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON COLUMN findom_os.findom_t_bandi.flag_amm_aziende_estere IS 'Flag che indica che il bando ammette aziende estere';


--
-- TOC entry 64307 (class 0 OID 0)
-- Dependencies: 16228
-- Name: COLUMN findom_t_bandi.id_area_tematica; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON COLUMN findom_os.findom_t_bandi.id_area_tematica IS 'Area tematica di riferimento';


--
-- TOC entry 64308 (class 0 OID 0)
-- Dependencies: 16228
-- Name: COLUMN findom_t_bandi.flag_scheda_progetto; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON COLUMN findom_os.findom_t_bandi.flag_scheda_progetto IS 'Flag di abilitazione delle domande del bando alla scheda progetto (Valutazioni compilate dal beneficiario)';


--
-- TOC entry 64309 (class 0 OID 0)
-- Dependencies: 16228
-- Name: COLUMN findom_t_bandi.flag_upload_index; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON COLUMN findom_os.findom_t_bandi.flag_upload_index IS 'Flag che indica il file allegato viene uploadato su sistema index altrimenti su shell_t_documento_index';


--
-- TOC entry 64310 (class 0 OID 0)
-- Dependencies: 16228
-- Name: COLUMN findom_t_bandi.flag_attiva_invio_doc; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON COLUMN findom_os.findom_t_bandi.flag_attiva_invio_doc IS 'Flag che attiva l''invio dei documenti nel batch Findomiddsh';


--
-- TOC entry 16229 (class 1259 OID 31175806)
-- Name: findom_t_bonus_turismo; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.findom_t_bonus_turismo (
    id_bonus_turismo integer NOT NULL,
    cod_regionale character varying(16) NOT NULL,
    importo_contributo numeric(13,2) NOT NULL
);


ALTER TABLE findom_os.findom_t_bonus_turismo OWNER TO findom_os;

--
-- TOC entry 64311 (class 0 OID 0)
-- Dependencies: 16229
-- Name: TABLE findom_t_bonus_turismo; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON TABLE findom_os.findom_t_bonus_turismo IS 'Abilitati a bonus Turismo';


--
-- TOC entry 16230 (class 1259 OID 31175809)
-- Name: findom_t_bonus_turismo_id_bonus_turismo_seq; Type: SEQUENCE; Schema: findom_os; Owner: findom_os
--

CREATE SEQUENCE findom_os.findom_t_bonus_turismo_id_bonus_turismo_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE findom_os.findom_t_bonus_turismo_id_bonus_turismo_seq OWNER TO findom_os;

--
-- TOC entry 64312 (class 0 OID 0)
-- Dependencies: 16230
-- Name: findom_t_bonus_turismo_id_bonus_turismo_seq; Type: SEQUENCE OWNED BY; Schema: findom_os; Owner: findom_os
--

ALTER SEQUENCE findom_os.findom_t_bonus_turismo_id_bonus_turismo_seq OWNED BY findom_os.findom_t_bonus_turismo.id_bonus_turismo;


--
-- TOC entry 16231 (class 1259 OID 31175811)
-- Name: findom_t_commissari; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.findom_t_commissari (
    id_commissario integer NOT NULL,
    cod_fiscale character varying(40),
    cognome character varying(200),
    nome character varying(200),
    email character varying(200),
    id_funzionario integer,
    dt_inizio date DEFAULT '2020-04-27'::date NOT NULL,
    dt_fine date
);


ALTER TABLE findom_os.findom_t_commissari OWNER TO findom_os;

--
-- TOC entry 16232 (class 1259 OID 31175818)
-- Name: findom_t_commissari_id_commissario_seq; Type: SEQUENCE; Schema: findom_os; Owner: findom_os
--

CREATE SEQUENCE findom_os.findom_t_commissari_id_commissario_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE findom_os.findom_t_commissari_id_commissario_seq OWNER TO findom_os;

--
-- TOC entry 64313 (class 0 OID 0)
-- Dependencies: 16232
-- Name: findom_t_commissari_id_commissario_seq; Type: SEQUENCE OWNED BY; Schema: findom_os; Owner: findom_os
--

ALTER SEQUENCE findom_os.findom_t_commissari_id_commissario_seq OWNED BY findom_os.findom_t_commissari.id_commissario;


--
-- TOC entry 16233 (class 1259 OID 31175820)
-- Name: findom_t_commissioni; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.findom_t_commissioni (
    id_commissione integer NOT NULL,
    dt_commissione date,
    descrizione text
);


ALTER TABLE findom_os.findom_t_commissioni OWNER TO findom_os;

--
-- TOC entry 16234 (class 1259 OID 31175826)
-- Name: findom_t_commissioni_id_commissione_seq; Type: SEQUENCE; Schema: findom_os; Owner: findom_os
--

CREATE SEQUENCE findom_os.findom_t_commissioni_id_commissione_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE findom_os.findom_t_commissioni_id_commissione_seq OWNER TO findom_os;

--
-- TOC entry 64314 (class 0 OID 0)
-- Dependencies: 16234
-- Name: findom_t_commissioni_id_commissione_seq; Type: SEQUENCE OWNED BY; Schema: findom_os; Owner: findom_os
--

ALTER SEQUENCE findom_os.findom_t_commissioni_id_commissione_seq OWNED BY findom_os.findom_t_commissioni.id_commissione;


--
-- TOC entry 16235 (class 1259 OID 31175828)
-- Name: findom_t_config_metadati; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.findom_t_config_metadati (
    id_tipo_metadati numeric(1,0) NOT NULL,
    query_oggetto_fascicolo character varying(2000),
    query_soggetto_fascicolo character varying(2000),
    query_conservazione_fascicolo character varying(2000),
    query_data_topica_documento character varying(2000)
);


ALTER TABLE findom_os.findom_t_config_metadati OWNER TO findom_os;

--
-- TOC entry 64315 (class 0 OID 0)
-- Dependencies: 16235
-- Name: TABLE findom_t_config_metadati; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON TABLE findom_os.findom_t_config_metadati IS 'Tabella di configurazione metadati per fascicolazione su ACTA';


--
-- TOC entry 64316 (class 0 OID 0)
-- Dependencies: 16235
-- Name: COLUMN findom_t_config_metadati.id_tipo_metadati; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON COLUMN findom_os.findom_t_config_metadati.id_tipo_metadati IS 'Id tipo metadati archiviazione';


--
-- TOC entry 64317 (class 0 OID 0)
-- Dependencies: 16235
-- Name: COLUMN findom_t_config_metadati.query_oggetto_fascicolo; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON COLUMN findom_os.findom_t_config_metadati.query_oggetto_fascicolo IS 'Query per determinare il nome fasicolo a partire dall''id_domanda';


--
-- TOC entry 16236 (class 1259 OID 31175834)
-- Name: findom_t_contrib_acq_veicoli; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.findom_t_contrib_acq_veicoli (
    id_contrib_acq_veicoli integer NOT NULL,
    id_voce_spesa integer NOT NULL,
    id_categ_veicolo integer,
    importo_contributo numeric(13,2) NOT NULL,
    id_sportello_bando integer NOT NULL,
    id_emissione integer
);


ALTER TABLE findom_os.findom_t_contrib_acq_veicoli OWNER TO findom_os;

--
-- TOC entry 64318 (class 0 OID 0)
-- Dependencies: 16236
-- Name: TABLE findom_t_contrib_acq_veicoli; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON TABLE findom_os.findom_t_contrib_acq_veicoli IS 'Tabella contributo per acquisto veicolo:  (in base a Voce di spesa e categoria del veicolo)';


--
-- TOC entry 16237 (class 1259 OID 31175837)
-- Name: findom_t_contrib_acq_veicoli_id_contrib_acq_veicoli_seq; Type: SEQUENCE; Schema: findom_os; Owner: findom_os
--

CREATE SEQUENCE findom_os.findom_t_contrib_acq_veicoli_id_contrib_acq_veicoli_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE findom_os.findom_t_contrib_acq_veicoli_id_contrib_acq_veicoli_seq OWNER TO findom_os;

--
-- TOC entry 64319 (class 0 OID 0)
-- Dependencies: 16237
-- Name: findom_t_contrib_acq_veicoli_id_contrib_acq_veicoli_seq; Type: SEQUENCE OWNED BY; Schema: findom_os; Owner: findom_os
--

ALTER SEQUENCE findom_os.findom_t_contrib_acq_veicoli_id_contrib_acq_veicoli_seq OWNED BY findom_os.findom_t_contrib_acq_veicoli.id_contrib_acq_veicoli;


--
-- TOC entry 16238 (class 1259 OID 31175839)
-- Name: findom_t_dich_presa_visione; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.findom_t_dich_presa_visione (
    id_dich_presa_visione integer NOT NULL,
    id_documento_comm integer NOT NULL,
    dt_presa_visione date NOT NULL,
    id_commissario integer NOT NULL,
    note text
);


ALTER TABLE findom_os.findom_t_dich_presa_visione OWNER TO findom_os;

--
-- TOC entry 16239 (class 1259 OID 31175845)
-- Name: findom_t_dich_presa_visione_id_dich_presa_visione_seq; Type: SEQUENCE; Schema: findom_os; Owner: findom_os
--

CREATE SEQUENCE findom_os.findom_t_dich_presa_visione_id_dich_presa_visione_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE findom_os.findom_t_dich_presa_visione_id_dich_presa_visione_seq OWNER TO findom_os;

--
-- TOC entry 64320 (class 0 OID 0)
-- Dependencies: 16239
-- Name: findom_t_dich_presa_visione_id_dich_presa_visione_seq; Type: SEQUENCE OWNED BY; Schema: findom_os; Owner: findom_os
--

ALTER SEQUENCE findom_os.findom_t_dich_presa_visione_id_dich_presa_visione_seq OWNED BY findom_os.findom_t_dich_presa_visione.id_dich_presa_visione;


--
-- TOC entry 16240 (class 1259 OID 31175847)
-- Name: findom_t_documenti_commissione; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.findom_t_documenti_commissione (
    id_documento_comm integer NOT NULL,
    id_documento_istr integer,
    oggetto text NOT NULL,
    dt_documento_comm date NOT NULL,
    id_documento_index_comm integer,
    flag_pubblico_privato numeric(1,0),
    id_commissione integer NOT NULL
);


ALTER TABLE findom_os.findom_t_documenti_commissione OWNER TO findom_os;

--
-- TOC entry 16241 (class 1259 OID 31175853)
-- Name: findom_t_documenti_commissione_id_documento_comm_seq; Type: SEQUENCE; Schema: findom_os; Owner: findom_os
--

CREATE SEQUENCE findom_os.findom_t_documenti_commissione_id_documento_comm_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE findom_os.findom_t_documenti_commissione_id_documento_comm_seq OWNER TO findom_os;

--
-- TOC entry 64321 (class 0 OID 0)
-- Dependencies: 16241
-- Name: findom_t_documenti_commissione_id_documento_comm_seq; Type: SEQUENCE OWNED BY; Schema: findom_os; Owner: findom_os
--

ALTER SEQUENCE findom_os.findom_t_documenti_commissione_id_documento_comm_seq OWNED BY findom_os.findom_t_documenti_commissione.id_documento_comm;


--
-- TOC entry 16242 (class 1259 OID 31175855)
-- Name: findom_t_param_sportelli_bandi; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.findom_t_param_sportelli_bandi (
    id_param integer NOT NULL,
    id_sportello_bando integer NOT NULL,
    id_tipol_intervento integer,
    flag_pubblico_privato numeric(1,0),
    importo_minimo_erogabile numeric(13,2),
    importo_massimo_erogabile numeric(13,2),
    budget_disponibile numeric(13,2),
    perc_max_contributo_erogabile numeric(5,2),
    totale_spese_minimo numeric(13,2),
    totale_spese_massimo numeric(13,2)
);


ALTER TABLE findom_os.findom_t_param_sportelli_bandi OWNER TO findom_os;

--
-- TOC entry 64322 (class 0 OID 0)
-- Dependencies: 16242
-- Name: TABLE findom_t_param_sportelli_bandi; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON TABLE findom_os.findom_t_param_sportelli_bandi IS 'Tabellone di parametri definiti a livello di sportell/tipologia intervento/ flag pubblico-privato';


--
-- TOC entry 16243 (class 1259 OID 31175858)
-- Name: findom_t_param_sportelli_bandi_id_param_seq; Type: SEQUENCE; Schema: findom_os; Owner: findom_os
--

CREATE SEQUENCE findom_os.findom_t_param_sportelli_bandi_id_param_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE findom_os.findom_t_param_sportelli_bandi_id_param_seq OWNER TO findom_os;

--
-- TOC entry 64323 (class 0 OID 0)
-- Dependencies: 16243
-- Name: findom_t_param_sportelli_bandi_id_param_seq; Type: SEQUENCE OWNED BY; Schema: findom_os; Owner: findom_os
--

ALTER SEQUENCE findom_os.findom_t_param_sportelli_bandi_id_param_seq OWNED BY findom_os.findom_t_param_sportelli_bandi.id_param;


--
-- TOC entry 16244 (class 1259 OID 31175860)
-- Name: findom_t_parametri_valut; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.findom_t_parametri_valut (
    id_parametro_valut integer NOT NULL,
    id_bando integer NOT NULL,
    id_specifica integer NOT NULL,
    id_parametro integer NOT NULL,
    ordine numeric(9,0) NOT NULL,
    flag_fittizio character(1),
    punteggio numeric NOT NULL,
    dt_inizio date NOT NULL,
    dt_fine date,
    CONSTRAINT cc_findom_t_parametri_valut_flag_fittizio CHECK ((flag_fittizio = 'S'::bpchar))
);


ALTER TABLE findom_os.findom_t_parametri_valut OWNER TO findom_os;

--
-- TOC entry 16245 (class 1259 OID 31175867)
-- Name: findom_t_parametri_valut_id_parametro_valut_seq; Type: SEQUENCE; Schema: findom_os; Owner: findom_os
--

CREATE SEQUENCE findom_os.findom_t_parametri_valut_id_parametro_valut_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE findom_os.findom_t_parametri_valut_id_parametro_valut_seq OWNER TO findom_os;

--
-- TOC entry 64324 (class 0 OID 0)
-- Dependencies: 16245
-- Name: findom_t_parametri_valut_id_parametro_valut_seq; Type: SEQUENCE OWNED BY; Schema: findom_os; Owner: findom_os
--

ALTER SEQUENCE findom_os.findom_t_parametri_valut_id_parametro_valut_seq OWNED BY findom_os.findom_t_parametri_valut.id_parametro_valut;


--
-- TOC entry 16246 (class 1259 OID 31175869)
-- Name: findom_t_soggetti_abilitati; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.findom_t_soggetti_abilitati (
    id_sogg_abil integer NOT NULL,
    codice_fiscale character varying(16) NOT NULL,
    denominazione character varying(1000)
);


ALTER TABLE findom_os.findom_t_soggetti_abilitati OWNER TO findom_os;

--
-- TOC entry 64325 (class 0 OID 0)
-- Dependencies: 16246
-- Name: TABLE findom_t_soggetti_abilitati; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON TABLE findom_os.findom_t_soggetti_abilitati IS 'Soggetti abilitati  a bandi Cultura';


--
-- TOC entry 16247 (class 1259 OID 31175875)
-- Name: findom_t_soggetti_abilitati_id_sogg_abil_seq; Type: SEQUENCE; Schema: findom_os; Owner: findom_os
--

CREATE SEQUENCE findom_os.findom_t_soggetti_abilitati_id_sogg_abil_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE findom_os.findom_t_soggetti_abilitati_id_sogg_abil_seq OWNER TO findom_os;

--
-- TOC entry 64326 (class 0 OID 0)
-- Dependencies: 16247
-- Name: findom_t_soggetti_abilitati_id_sogg_abil_seq; Type: SEQUENCE OWNED BY; Schema: findom_os; Owner: findom_os
--

ALTER SEQUENCE findom_os.findom_t_soggetti_abilitati_id_sogg_abil_seq OWNED BY findom_os.findom_t_soggetti_abilitati.id_sogg_abil;


--
-- TOC entry 16248 (class 1259 OID 31175877)
-- Name: findom_t_soggetti_bonus_covid; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.findom_t_soggetti_bonus_covid (
    id_soggetto_bonus_covid integer NOT NULL,
    cod_fiscale character varying(16) NOT NULL,
    partita_iva character varying(11),
    dt_inizio date,
    dt_fine date NOT NULL,
    cod_ateco character varying(8),
    importo_contributo numeric(13,2) NOT NULL,
    iban character varying(27)
);


ALTER TABLE findom_os.findom_t_soggetti_bonus_covid OWNER TO findom_os;

--
-- TOC entry 64327 (class 0 OID 0)
-- Dependencies: 16248
-- Name: TABLE findom_t_soggetti_bonus_covid; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON TABLE findom_os.findom_t_soggetti_bonus_covid IS 'Soggetti abilitati a ricevere il bonus fase 2 Covid-19';


--
-- TOC entry 16249 (class 1259 OID 31175880)
-- Name: findom_t_soggetti_bonus_covid_dett; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.findom_t_soggetti_bonus_covid_dett (
    id_soggetto_bonus_covid_dett integer NOT NULL,
    id_soggetto_bonus_covid integer NOT NULL,
    email character varying(200) NOT NULL,
    flag_tratt_dati boolean NOT NULL,
    id_testo_tratt_dati integer NOT NULL,
    dt_inserimento timestamp without time zone NOT NULL
);


ALTER TABLE findom_os.findom_t_soggetti_bonus_covid_dett OWNER TO findom_os;

--
-- TOC entry 64328 (class 0 OID 0)
-- Dependencies: 16249
-- Name: TABLE findom_t_soggetti_bonus_covid_dett; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON TABLE findom_os.findom_t_soggetti_bonus_covid_dett IS 'Dati integrativi per i soggetti abilitati a ricevere il bonus fase 2 Covid-19';


--
-- TOC entry 16250 (class 1259 OID 31175883)
-- Name: findom_t_soggetti_bonus_covid__id_soggetto_bonus_covid_dett_seq; Type: SEQUENCE; Schema: findom_os; Owner: findom_os
--

CREATE SEQUENCE findom_os.findom_t_soggetti_bonus_covid__id_soggetto_bonus_covid_dett_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE findom_os.findom_t_soggetti_bonus_covid__id_soggetto_bonus_covid_dett_seq OWNER TO findom_os;

--
-- TOC entry 64329 (class 0 OID 0)
-- Dependencies: 16250
-- Name: findom_t_soggetti_bonus_covid__id_soggetto_bonus_covid_dett_seq; Type: SEQUENCE OWNED BY; Schema: findom_os; Owner: findom_os
--

ALTER SEQUENCE findom_os.findom_t_soggetti_bonus_covid__id_soggetto_bonus_covid_dett_seq OWNED BY findom_os.findom_t_soggetti_bonus_covid_dett.id_soggetto_bonus_covid_dett;


--
-- TOC entry 16251 (class 1259 OID 31175885)
-- Name: findom_t_soggetti_bonus_covid_id_soggetto_bonus_covid_seq; Type: SEQUENCE; Schema: findom_os; Owner: findom_os
--

CREATE SEQUENCE findom_os.findom_t_soggetti_bonus_covid_id_soggetto_bonus_covid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE findom_os.findom_t_soggetti_bonus_covid_id_soggetto_bonus_covid_seq OWNER TO findom_os;

--
-- TOC entry 64330 (class 0 OID 0)
-- Dependencies: 16251
-- Name: findom_t_soggetti_bonus_covid_id_soggetto_bonus_covid_seq; Type: SEQUENCE OWNED BY; Schema: findom_os; Owner: findom_os
--

ALTER SEQUENCE findom_os.findom_t_soggetti_bonus_covid_id_soggetto_bonus_covid_seq OWNED BY findom_os.findom_t_soggetti_bonus_covid.id_soggetto_bonus_covid;


--
-- TOC entry 16252 (class 1259 OID 31175887)
-- Name: findom_t_sportelli_bandi; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.findom_t_sportelli_bandi (
    id_sportello_bando integer NOT NULL,
    num_atto character varying(40),
    dt_atto date,
    dt_apertura timestamp without time zone NOT NULL,
    dt_chiusura timestamp without time zone,
    num_max_domande integer,
    id_bando integer NOT NULL,
    edizione character varying(50),
    num_commissari numeric(3,0)
);


ALTER TABLE findom_os.findom_t_sportelli_bandi OWNER TO findom_os;

--
-- TOC entry 16253 (class 1259 OID 31175890)
-- Name: findom_t_sportelli_bandi_id_sportello_bando_seq; Type: SEQUENCE; Schema: findom_os; Owner: findom_os
--

CREATE SEQUENCE findom_os.findom_t_sportelli_bandi_id_sportello_bando_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE findom_os.findom_t_sportelli_bandi_id_sportello_bando_seq OWNER TO findom_os;

--
-- TOC entry 64331 (class 0 OID 0)
-- Dependencies: 16253
-- Name: findom_t_sportelli_bandi_id_sportello_bando_seq; Type: SEQUENCE OWNED BY; Schema: findom_os; Owner: findom_os
--

ALTER SEQUENCE findom_os.findom_t_sportelli_bandi_id_sportello_bando_seq OWNED BY findom_os.findom_t_sportelli_bandi.id_sportello_bando;


--
-- TOC entry 16254 (class 1259 OID 31175892)
-- Name: findom_t_sportelli_regole_param; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.findom_t_sportelli_regole_param (
    id_srp integer NOT NULL,
    id_sportello_bando integer NOT NULL,
    id_regola integer NOT NULL,
    id_parametro integer,
    ordine integer,
    valore character varying(200) NOT NULL,
    dt_inizio date NOT NULL,
    dt_fine date
);


ALTER TABLE findom_os.findom_t_sportelli_regole_param OWNER TO findom_os;

--
-- TOC entry 64332 (class 0 OID 0)
-- Dependencies: 16254
-- Name: TABLE findom_t_sportelli_regole_param; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON TABLE findom_os.findom_t_sportelli_regole_param IS 'Tabella associativa tra sportelli, regole, parametri';


--
-- TOC entry 16255 (class 1259 OID 31175895)
-- Name: findom_t_valori_sportello; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.findom_t_valori_sportello (
    id integer NOT NULL,
    id_sportello_bando integer NOT NULL,
    id_tipol_intervento integer,
    flag_pubblico_privato numeric(1,0),
    id_tipol_beneficiario integer,
    importo_minimo_erogabile numeric(13,2),
    importo_massimo_erogabile numeric(13,2),
    budget_disponibile numeric(13,2),
    perc_max_contributo_erogabile numeric(5,2),
    totale_spese_minimo numeric(13,2),
    totale_spese_massimo numeric(13,2),
    id_tipo_graduatoria integer
);


ALTER TABLE findom_os.findom_t_valori_sportello OWNER TO findom_os;

--
-- TOC entry 64333 (class 0 OID 0)
-- Dependencies: 16255
-- Name: TABLE findom_t_valori_sportello; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON TABLE findom_os.findom_t_valori_sportello IS 'Tabellone di parametri definiti a livello di sportell/tipologia intervento/ flag pubblico-privato/ Tipologia beneficiari';


--
-- TOC entry 64334 (class 0 OID 0)
-- Dependencies: 16255
-- Name: COLUMN findom_t_valori_sportello.id_tipo_graduatoria; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON COLUMN findom_os.findom_t_valori_sportello.id_tipo_graduatoria IS 'Tipologia graduatoria (Standard, Proporzionale)';


--
-- TOC entry 16256 (class 1259 OID 31175898)
-- Name: findom_t_valori_sportello_id_seq; Type: SEQUENCE; Schema: findom_os; Owner: findom_os
--

CREATE SEQUENCE findom_os.findom_t_valori_sportello_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE findom_os.findom_t_valori_sportello_id_seq OWNER TO findom_os;

--
-- TOC entry 64335 (class 0 OID 0)
-- Dependencies: 16256
-- Name: findom_t_valori_sportello_id_seq; Type: SEQUENCE OWNED BY; Schema: findom_os; Owner: findom_os
--

ALTER SEQUENCE findom_os.findom_t_valori_sportello_id_seq OWNED BY findom_os.findom_t_valori_sportello.id;


--
-- TOC entry 16266 (class 1259 OID 31175942)
-- Name: shell_t_domande; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.shell_t_domande (
    id_domanda numeric(9,0) NOT NULL,
    id_soggetto_creatore integer NOT NULL,
    id_soggetto_beneficiario integer NOT NULL,
    id_sportello_bando integer NOT NULL,
    id_soggetto_invio integer,
    dt_creazione timestamp without time zone NOT NULL,
    id_tipol_beneficiario integer NOT NULL,
    dt_invio_domanda timestamp without time zone,
    fascicolo_acta character varying(256),
    dt_conclusione timestamp without time zone,
    id_soggetto_conclusione integer,
    id_motivazione_esito integer,
    id_istruttore_amm integer,
    note_esito_istruttoria text,
    id_stato_istr integer,
    dt_richiesta_integrazione date,
    dt_upload_documenti date,
    note_richiesta_integrazione text,
    id_decisore integer,
    dt_rimodulazione_istruttore date,
    dt_rimodulazione_decisore date,
    dt_termine_integrazione date,
    flag_abilita_integrazione boolean DEFAULT false,
    id_funzionario_integrazione integer,
    sottofascicolo_acta character varying(256),
    note_valutazione text,
    note_prevalutazione text,
    flag_valutazione_completata boolean DEFAULT false NOT NULL
);


ALTER TABLE findom_os.shell_t_domande OWNER TO findom_os;

--
-- TOC entry 64336 (class 0 OID 0)
-- Dependencies: 16266
-- Name: COLUMN shell_t_domande.id_istruttore_amm; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON COLUMN findom_os.shell_t_domande.id_istruttore_amm IS 'id dell’ultimo funzionario che ha preso in carico l’istruttoria';


--
-- TOC entry 64337 (class 0 OID 0)
-- Dependencies: 16266
-- Name: COLUMN shell_t_domande.dt_termine_integrazione; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON COLUMN findom_os.shell_t_domande.dt_termine_integrazione IS 'Data oltre il quale non è possibile aggiungere altri documenti di integrazione alla domanda';


--
-- TOC entry 64338 (class 0 OID 0)
-- Dependencies: 16266
-- Name: COLUMN shell_t_domande.flag_abilita_integrazione; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON COLUMN findom_os.shell_t_domande.flag_abilita_integrazione IS 'TRUE quando l''istruttore invia richiesta di integrazione FALSE quando il beneficiario invia l''integrazione';


--
-- TOC entry 64339 (class 0 OID 0)
-- Dependencies: 16266
-- Name: COLUMN shell_t_domande.sottofascicolo_acta; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON COLUMN findom_os.shell_t_domande.sottofascicolo_acta IS 'Utilizzato per la classificazione dei documenti integrativi';


--
-- TOC entry 64340 (class 0 OID 0)
-- Dependencies: 16266
-- Name: COLUMN shell_t_domande.flag_valutazione_completata; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON COLUMN findom_os.shell_t_domande.flag_valutazione_completata IS 'Flag che indica che la valutazione è stata completata';


--
-- TOC entry 16267 (class 1259 OID 31175950)
-- Name: shell_t_graduatoria; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.shell_t_graduatoria (
    id_graduatoria integer NOT NULL,
    dt_chiusura_graduatoria timestamp without time zone,
    id_bando integer NOT NULL,
    id_sportello_bando integer NOT NULL,
    id_tipol_intervento integer,
    id_tipol_beneficiario integer,
    flag_pubblico_privato numeric(1,0),
    dt_elaborazione timestamp without time zone NOT NULL,
    id_funzionario integer NOT NULL,
    budget_disponibile numeric(13,2),
    budget_residuo numeric(13,2),
    id_graduatoria_rif integer,
    flag_rifinanziabile boolean DEFAULT false NOT NULL,
    id_documento_comm integer
);


ALTER TABLE findom_os.shell_t_graduatoria OWNER TO findom_os;

--
-- TOC entry 64341 (class 0 OID 0)
-- Dependencies: 16267
-- Name: COLUMN shell_t_graduatoria.dt_chiusura_graduatoria; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON COLUMN findom_os.shell_t_graduatoria.dt_chiusura_graduatoria IS 'NULL=Provvisoria, NOT NULL=Definitiva';


--
-- TOC entry 64342 (class 0 OID 0)
-- Dependencies: 16267
-- Name: COLUMN shell_t_graduatoria.id_tipol_beneficiario; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON COLUMN findom_os.shell_t_graduatoria.id_tipol_beneficiario IS 'Filtro su tipologia intervento selezionato nella domanda';


--
-- TOC entry 64343 (class 0 OID 0)
-- Dependencies: 16267
-- Name: COLUMN shell_t_graduatoria.flag_pubblico_privato; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON COLUMN findom_os.shell_t_graduatoria.flag_pubblico_privato IS 'Filtro sui beneficiari (Pubblico/Privato)';


--
-- TOC entry 64344 (class 0 OID 0)
-- Dependencies: 16267
-- Name: COLUMN shell_t_graduatoria.id_funzionario; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON COLUMN findom_os.shell_t_graduatoria.id_funzionario IS 'Istruttore che elabora la graduatoria';


--
-- TOC entry 64345 (class 0 OID 0)
-- Dependencies: 16267
-- Name: COLUMN shell_t_graduatoria.budget_disponibile; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON COLUMN findom_os.shell_t_graduatoria.budget_disponibile IS 'Valore storicizzato in gestione modifica del budget; la prima volta viene copiato dall''analoga colonna della tabella PBANDI_T_BANDI';


--
-- TOC entry 64346 (class 0 OID 0)
-- Dependencies: 16267
-- Name: COLUMN shell_t_graduatoria.id_graduatoria_rif; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON COLUMN findom_os.shell_t_graduatoria.id_graduatoria_rif IS 'Riferimento alla graduatoria rifinanziata';


--
-- TOC entry 64347 (class 0 OID 0)
-- Dependencies: 16267
-- Name: COLUMN shell_t_graduatoria.flag_rifinanziabile; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON COLUMN findom_os.shell_t_graduatoria.flag_rifinanziabile IS 'Flag che indica che la graduatoria è rifinanziabile';


--
-- TOC entry 64348 (class 0 OID 0)
-- Dependencies: 16267
-- Name: COLUMN shell_t_graduatoria.id_documento_comm; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON COLUMN findom_os.shell_t_graduatoria.id_documento_comm IS 'Riferimento a documento della Commissione';

--
-- TOC entry 16270 (class 1259 OID 31175964)
-- Name: shell_t_documento_index; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.shell_t_documento_index (
    id_documento_index integer NOT NULL,
    id_domanda numeric(9,0),
    uuid_nodo character varying(100) NOT NULL,
    repository character varying(100) NOT NULL,
    nome_file character varying(300),
    message_digest character varying(64),
    dt_verifica_firma timestamp without time zone,
    dt_marca_temporale timestamp without time zone,
    dt_inserimento timestamp without time zone,
    id_stato_documento_index integer,
    id_allegato integer,
    id_soggetto integer,
    flag_trasm_dest character(1),
    file_allegato bytea,
    CONSTRAINT cc_shell_t_documento_index_flag_trasm_dest CHECK ((flag_trasm_dest = 'S'::bpchar))
);


ALTER TABLE findom_os.shell_t_documento_index OWNER TO findom_os;

--
-- TOC entry 64349 (class 0 OID 0)
-- Dependencies: 16270
-- Name: TABLE shell_t_documento_index; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON TABLE findom_os.shell_t_documento_index IS 'Tabella di interfaccia per index';


--
-- TOC entry 64350 (class 0 OID 0)
-- Dependencies: 16270
-- Name: COLUMN shell_t_documento_index.message_digest; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON COLUMN findom_os.shell_t_documento_index.message_digest IS 'Impronta digitale del documento';


--
-- TOC entry 64351 (class 0 OID 0)
-- Dependencies: 16270
-- Name: COLUMN shell_t_documento_index.flag_trasm_dest; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON COLUMN findom_os.shell_t_documento_index.flag_trasm_dest IS 'S=Documento trasmesso a destinatario';


--
-- TOC entry 64352 (class 0 OID 0)
-- Dependencies: 16270
-- Name: COLUMN shell_t_documento_index.file_allegato; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON COLUMN findom_os.shell_t_documento_index.file_allegato IS 'Contiene il file dell''allegato se la configurazione del bando ha flag_upload_index=false';


--
-- TOC entry 16271 (class 1259 OID 31175971)
-- Name: shell_t_soggetti; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.shell_t_soggetti (
    id_soggetto integer NOT NULL,
    cod_fiscale character varying(40) NOT NULL,
    denominazione character varying(1000),
    id_forma_giuridica integer,
    cognome character varying(200),
    nome character varying(200),
    cod_ufficio character varying(20),
    sigla_nazione character varying(3)
);


ALTER TABLE findom_os.shell_t_soggetti OWNER TO findom_os;


--
-- TOC entry 16273 (class 1259 OID 31175982)
-- Name: shell_t_documento_prot; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.shell_t_documento_prot (
    id_documento_index integer NOT NULL,
    id_sistema_prot integer,
    num_protocollo character varying(100),
    dt_protocollo timestamp without time zone,
    dt_classificazione timestamp without time zone,
    classificazione_acta character varying(256)
);


ALTER TABLE findom_os.shell_t_documento_prot OWNER TO findom_os;

--
-- TOC entry 16274 (class 1259 OID 31175985)
-- Name: shell_t_file_domande; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.shell_t_file_domande (
    id_file_domanda integer NOT NULL,
    dt_invio_file timestamp without time zone,
    file_xml xml,
    file_pdf bytea,
    id_domanda numeric(9,0) NOT NULL,
    flag_trasformata_ok character(1),
    message_digest character varying(64),
    dt_invio_file_demat_finpis timestamp without time zone,
    file_demat_finpis bytea,
    flag_scarico_demat_ok character(1)
);


ALTER TABLE findom_os.shell_t_file_domande OWNER TO findom_os;

--
-- TOC entry 64353 (class 0 OID 0)
-- Dependencies: 16274
-- Name: COLUMN shell_t_file_domande.flag_trasformata_ok; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON COLUMN findom_os.shell_t_file_domande.flag_trasformata_ok IS 'Flag per esito OK trasformazione XML  S=OK N=KO';


--
-- TOC entry 64354 (class 0 OID 0)
-- Dependencies: 16274
-- Name: COLUMN shell_t_file_domande.dt_invio_file_demat_finpis; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON COLUMN findom_os.shell_t_file_domande.dt_invio_file_demat_finpis IS 'Data di invio file a Finpiemonte dei file dematerializzati';


--
-- TOC entry 64355 (class 0 OID 0)
-- Dependencies: 16274
-- Name: COLUMN shell_t_file_domande.file_demat_finpis; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON COLUMN findom_os.shell_t_file_domande.file_demat_finpis IS 'Contiene un file zip con la domanda p7m e gli allegati';


--
-- TOC entry 64356 (class 0 OID 0)
-- Dependencies: 16274
-- Name: COLUMN shell_t_file_domande.flag_scarico_demat_ok; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON COLUMN findom_os.shell_t_file_domande.flag_scarico_demat_ok IS 'Flag per esito OK per scarico file dematerializzati (Index) S=OK N=KO';


--
-- TOC entry 16276 (class 1259 OID 31175996)
-- Name: istr_d_model_state; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.istr_d_model_state (
    model_state character varying(2) NOT NULL,
    model_state_descr character varying(100) NOT NULL,
    from_date timestamp without time zone NOT NULL,
    end_date timestamp without time zone
);


ALTER TABLE findom_os.istr_d_model_state OWNER TO findom_os;

--
-- TOC entry 16277 (class 1259 OID 31175999)
-- Name: istr_t_model; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.istr_t_model (
    model_id numeric(9,0) NOT NULL,
    template_code_fk character varying(40) NOT NULL,
    model_progr numeric(9,0) NOT NULL,
    user_id character varying(100) NOT NULL,
    serialized_model xml NOT NULL,
    model_state_fk character varying(2),
    model_name character varying(1000) NOT NULL,
    model_last_update timestamp without time zone
);


ALTER TABLE findom_os.istr_t_model OWNER TO findom_os;

--
-- TOC entry 64357 (class 0 OID 0)
-- Dependencies: 16277
-- Name: TABLE istr_t_model; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON TABLE findom_os.istr_t_model IS 'Tabella che contiene i dati inseriti nei form dagli utenti';


--
-- TOC entry 16281 (class 1259 OID 31176020)
-- Name: shell_t_valut_domande; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.shell_t_valut_domande (
    id_valutazione integer NOT NULL,
    id_domanda numeric(9,0),
    id_parametro_valut integer,
    dt_valutazione date,
    punteggio numeric,
    stato_valut character(1),
    CONSTRAINT cc_shell_t_valut_domande_stato_valut CHECK ((stato_valut = ANY (ARRAY['P'::bpchar, 'V'::bpchar, 'D'::bpchar])))
);


ALTER TABLE findom_os.shell_t_valut_domande OWNER TO findom_os;

--
-- TOC entry 64358 (class 0 OID 0)
-- Dependencies: 16281
-- Name: COLUMN shell_t_valut_domande.dt_valutazione; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON COLUMN findom_os.shell_t_valut_domande.dt_valutazione IS 'Se nulla allora si è in stato di prevalutazione';


--
-- TOC entry 64359 (class 0 OID 0)
-- Dependencies: 16281
-- Name: COLUMN shell_t_valut_domande.stato_valut; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON COLUMN findom_os.shell_t_valut_domande.stato_valut IS 'P=Prevalutazione, V=Valutazione, D=Domanda';

--
-- TOC entry 16289 (class 1259 OID 31176062)
-- Name: shell_t_dett_graduatoria; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.shell_t_dett_graduatoria (
    id_dett_graduatoria integer NOT NULL,
    id_graduatoria integer,
    posizione numeric,
    id_domanda numeric(9,0),
    punteggio numeric(5,2),
    contributo_richiesto numeric(13,2),
    contributo_ammesso numeric(13,2),
    contributo_validato numeric(13,2),
    contributo_confermato numeric(13,2),
    id_motivazione_esito integer,
    id_stato_istr integer,
    cod_fiscale_beneficiario character varying(40),
    denominazione_beneficiario character varying(1000),
    contributo_pre_resti numeric(13,2),
    flag_finanz_parz boolean DEFAULT false NOT NULL,
    id_dett_graduatoria_parz_rif integer,
    contributo_punteggio numeric(13,2)
);


ALTER TABLE findom_os.shell_t_dett_graduatoria OWNER TO findom_os;

--
-- TOC entry 64360 (class 0 OID 0)
-- Dependencies: 16289
-- Name: COLUMN shell_t_dett_graduatoria.contributo_pre_resti; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON COLUMN findom_os.shell_t_dett_graduatoria.contributo_pre_resti IS 'Salvataggio del contributo calcolato prima dell''assegnazione dei resti';


--
-- TOC entry 64361 (class 0 OID 0)
-- Dependencies: 16289
-- Name: COLUMN shell_t_dett_graduatoria.flag_finanz_parz; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON COLUMN findom_os.shell_t_dett_graduatoria.flag_finanz_parz IS 'Flag che indica che la domanda è stata finanziata parzialmente';


--
-- TOC entry 64362 (class 0 OID 0)
-- Dependencies: 16289
-- Name: COLUMN shell_t_dett_graduatoria.id_dett_graduatoria_parz_rif; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON COLUMN findom_os.shell_t_dett_graduatoria.id_dett_graduatoria_parz_rif IS 'Riferimento alla domanda rifinanziata in graduatoria';


--
-- TOC entry 64363 (class 0 OID 0)
-- Dependencies: 16289
-- Name: COLUMN shell_t_dett_graduatoria.contributo_punteggio; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON COLUMN findom_os.shell_t_dett_graduatoria.contributo_punteggio IS 'Salvataggio del contributo calcolato prima dell''assegnazione dei resti';


--
-- TOC entry 16290 (class 1259 OID 31176069)
-- Name: shell_t_rimod_agev; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.shell_t_rimod_agev (
    id_domanda numeric(9,0) NOT NULL,
    tipo_rimodulazione character(1) NOT NULL,
    imp_erogabile numeric(13,2),
    imp_richiesto numeric(13,2),
    perc_qp_spese_gen_funz numeric(5,2),
    imp_risorse_proprie numeric(13,2),
    note text,
    CONSTRAINT cc_shell_t_rimod_agev CHECK ((tipo_rimodulazione = ANY (ARRAY['I'::bpchar, 'D'::bpchar])))
);


ALTER TABLE findom_os.shell_t_rimod_agev OWNER TO findom_os;

--
-- TOC entry 64364 (class 0 OID 0)
-- Dependencies: 16290
-- Name: TABLE shell_t_rimod_agev; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON TABLE findom_os.shell_t_rimod_agev IS 'Tabella per la rimodulazione dei contributi della domanda';


--
-- TOC entry 64365 (class 0 OID 0)
-- Dependencies: 16290
-- Name: COLUMN shell_t_rimod_agev.tipo_rimodulazione; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON COLUMN findom_os.shell_t_rimod_agev.tipo_rimodulazione IS 'I=Istruttore, D=Decisore';

--
-- TOC entry 16298 (class 1259 OID 31176111)
-- Name: shell_t_dett_criteri_graduatoria; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.shell_t_dett_criteri_graduatoria (
    id_dett_criteri_graduatoria integer NOT NULL,
    id_dett_graduatoria integer NOT NULL,
    id_criterio integer NOT NULL,
    punteggio numeric NOT NULL
);


ALTER TABLE findom_os.shell_t_dett_criteri_graduatoria OWNER TO findom_os;

--
-- TOC entry 64366 (class 0 OID 0)
-- Dependencies: 16298
-- Name: TABLE shell_t_dett_criteri_graduatoria; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON TABLE findom_os.shell_t_dett_criteri_graduatoria IS 'Tabella dove sono salvati i punteggi di valutazione dei criteri delle domande in graduatoria';


--
-- TOC entry 16309 (class 1259 OID 31176172)
-- Name: shell_t_rimod_spese; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.shell_t_rimod_spese (
    id_rimod_spese integer NOT NULL,
    id_domanda numeric(9,0) NOT NULL,
    id_tipol_intervento integer,
    id_dett_intervento integer,
    id_voce_spesa integer NOT NULL,
    tipo_rimodulazione character(1),
    importo numeric(13,2),
    CONSTRAINT cc_shell_t_rimod_spese CHECK ((tipo_rimodulazione = ANY (ARRAY['I'::bpchar, 'D'::bpchar])))
);


ALTER TABLE findom_os.shell_t_rimod_spese OWNER TO findom_os;

--
-- TOC entry 64367 (class 0 OID 0)
-- Dependencies: 16309
-- Name: TABLE shell_t_rimod_spese; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON TABLE findom_os.shell_t_rimod_spese IS 'Tabella per la rimodulazione delle spese della domanda';


--
-- TOC entry 64368 (class 0 OID 0)
-- Dependencies: 16309
-- Name: COLUMN shell_t_rimod_spese.tipo_rimodulazione; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON COLUMN findom_os.shell_t_rimod_spese.tipo_rimodulazione IS 'I=Istruttore, D=Decisore';


--
-- TOC entry 16312 (class 1259 OID 31176186)
-- Name: shell_t_rimod_entrate; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.shell_t_rimod_entrate (
    id_rimod_entrate integer NOT NULL,
    id_domanda numeric(9,0) NOT NULL,
    id_voce_entrata integer NOT NULL,
    dettaglio character varying(100),
    tipo_rimodulazione character(1),
    importo numeric(13,2),
    CONSTRAINT cc_shell_t_rimod_entrate CHECK ((tipo_rimodulazione = ANY (ARRAY['I'::bpchar, 'D'::bpchar])))
);


ALTER TABLE findom_os.shell_t_rimod_entrate OWNER TO findom_os;

--
-- TOC entry 64369 (class 0 OID 0)
-- Dependencies: 16312
-- Name: TABLE shell_t_rimod_entrate; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON TABLE findom_os.shell_t_rimod_entrate IS 'Tabella per la rimodulazione delle spese della domanda';


--
-- TOC entry 64370 (class 0 OID 0)
-- Dependencies: 16312
-- Name: COLUMN shell_t_rimod_entrate.tipo_rimodulazione; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON COLUMN findom_os.shell_t_rimod_entrate.tipo_rimodulazione IS 'I=Istruttore, D=Decisore';


--
-- TOC entry 16324 (class 1259 OID 31176254)
-- Name: istr_t_model_index; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.istr_t_model_index (
    model_id numeric(9,0) NOT NULL,
    index_id numeric(9,0) NOT NULL
);


ALTER TABLE findom_os.istr_t_model_index OWNER TO findom_os;

--
-- TOC entry 16325 (class 1259 OID 31176257)
-- Name: istr_t_rule; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.istr_t_rule (
    rule_id numeric(9,0) NOT NULL,
    rule_name character varying(100) NOT NULL,
    end_point character varying(200) NOT NULL,
    template_code_fk character varying(40) NOT NULL
);


ALTER TABLE findom_os.istr_t_rule OWNER TO findom_os;

--
-- TOC entry 16326 (class 1259 OID 31176260)
-- Name: istr_t_submodel; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.istr_t_submodel (
    submodel_id numeric(9,0) NOT NULL,
    model_id numeric(9,0) NOT NULL,
    model_progr numeric(9,0) NOT NULL,
    template_code_fk character varying(40) NOT NULL,
    user_id character varying(100) NOT NULL,
    xml_type character varying(40) NOT NULL,
    posizione numeric(9,0) NOT NULL,
    serialized_model xml NOT NULL,
    model_last_update timestamp without time zone
);


ALTER TABLE findom_os.istr_t_submodel OWNER TO findom_os;

--
-- TOC entry 16327 (class 1259 OID 31176266)
-- Name: istr_t_template; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.istr_t_template (
    template_id numeric(9,0) NOT NULL,
    template_code character varying(40) NOT NULL,
    template xml NOT NULL,
    pdf_template xml,
    model_validation_rules text,
    template_description character varying(100),
    template_name character varying(100) NOT NULL,
    template_last_update timestamp without time zone,
    template_valid_from_date timestamp without time zone,
    template_valid_to_date timestamp without time zone,
    template_state character varying(50),
    command_validation_rules text,
    global_validation_rules text,
    template_splitted character varying(2)
);


ALTER TABLE findom_os.istr_t_template OWNER TO findom_os;

--
-- TOC entry 64371 (class 0 OID 0)
-- Dependencies: 16327
-- Name: TABLE istr_t_template; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON TABLE findom_os.istr_t_template IS 'Tabella che contiene i modelli del form, della stampa e della validazione';


--
-- TOC entry 16328 (class 1259 OID 31176272)
-- Name: istr_t_template_index; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.istr_t_template_index (
    index_id numeric(9,0) NOT NULL,
    template_fk numeric(9,0) NOT NULL,
    xpath_id numeric(4,0) NOT NULL,
    xpath_query character varying(50) NOT NULL,
    description1 character varying(250),
    description2 character varying(250),
    xpath_parent_id numeric(4,0),
    index_rules text,
    template_page xml,
    model_validation_rules_page text,
    command_validation_rules_page text
);


ALTER TABLE findom_os.istr_t_template_index OWNER TO findom_os;

--
-- TOC entry 64372 (class 0 OID 0)
-- Dependencies: 16328
-- Name: TABLE istr_t_template_index; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON TABLE findom_os.istr_t_template_index IS 'Tabella che contiene la struttura di navigazione di un template';


--
-- TOC entry 16329 (class 1259 OID 31176278)
-- Name: log_t_batch; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.log_t_batch (
    id_log_batch integer NOT NULL,
    messaggio character varying(2000),
    dt_log timestamp without time zone NOT NULL,
    flag_invio_email integer NOT NULL,
    id_domanda numeric(9,0) NOT NULL,
    flag_errore_sistema character varying(1)
);


ALTER TABLE findom_os.log_t_batch OWNER TO findom_os;

--
-- TOC entry 64373 (class 0 OID 0)
-- Dependencies: 16329
-- Name: COLUMN log_t_batch.flag_invio_email; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON COLUMN findom_os.log_t_batch.flag_invio_email IS '0=Non inviata 1=Inviata';


--
-- TOC entry 64374 (class 0 OID 0)
-- Dependencies: 16329
-- Name: COLUMN log_t_batch.flag_errore_sistema; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON COLUMN findom_os.log_t_batch.flag_errore_sistema IS 'Indica che  il messaggio di errore viene  generato dal sistema operativo';


--
-- TOC entry 16330 (class 1259 OID 31176284)
-- Name: log_t_batch_id_log_batch_seq; Type: SEQUENCE; Schema: findom_os; Owner: findom_os
--

CREATE SEQUENCE findom_os.log_t_batch_id_log_batch_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE findom_os.log_t_batch_id_log_batch_seq OWNER TO findom_os;

--
-- TOC entry 64375 (class 0 OID 0)
-- Dependencies: 16330
-- Name: log_t_batch_id_log_batch_seq; Type: SEQUENCE OWNED BY; Schema: findom_os; Owner: findom_os
--

ALTER SEQUENCE findom_os.log_t_batch_id_log_batch_seq OWNED BY findom_os.log_t_batch.id_log_batch;


--
-- TOC entry 16331 (class 1259 OID 31176286)
-- Name: log_t_firma_digitale; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.log_t_firma_digitale (
    id_log_firma integer NOT NULL,
    messaggio character varying(200),
    dt_log timestamp without time zone,
    utente character varying(100),
    metodo character varying(200),
    id_domanda numeric(9,0)
);


ALTER TABLE findom_os.log_t_firma_digitale OWNER TO findom_os;

--
-- TOC entry 16332 (class 1259 OID 31176292)
-- Name: log_t_firma_digitale_id_log_firma_seq; Type: SEQUENCE; Schema: findom_os; Owner: findom_os
--

CREATE SEQUENCE findom_os.log_t_firma_digitale_id_log_firma_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE findom_os.log_t_firma_digitale_id_log_firma_seq OWNER TO findom_os;

--
-- TOC entry 64376 (class 0 OID 0)
-- Dependencies: 16332
-- Name: log_t_firma_digitale_id_log_firma_seq; Type: SEQUENCE OWNED BY; Schema: findom_os; Owner: findom_os
--

ALTER SEQUENCE findom_os.log_t_firma_digitale_id_log_firma_seq OWNED BY findom_os.log_t_firma_digitale.id_log_firma;


--
-- TOC entry 16333 (class 1259 OID 31176294)
-- Name: log_t_protocollo; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.log_t_protocollo (
    id_log_protocollo integer NOT NULL,
    messaggio character varying(200),
    dt_log timestamp without time zone,
    utente character varying(100),
    metodo character varying(200),
    id_documento_index integer,
    duration numeric(12,3),
    flag_esito character(1)
);


ALTER TABLE findom_os.log_t_protocollo OWNER TO findom_os;

--
-- TOC entry 16334 (class 1259 OID 31176300)
-- Name: log_t_protocollo_id_log_protocollo_seq; Type: SEQUENCE; Schema: findom_os; Owner: findom_os
--

CREATE SEQUENCE findom_os.log_t_protocollo_id_log_protocollo_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE findom_os.log_t_protocollo_id_log_protocollo_seq OWNER TO findom_os;

--
-- TOC entry 64377 (class 0 OID 0)
-- Dependencies: 16334
-- Name: log_t_protocollo_id_log_protocollo_seq; Type: SEQUENCE OWNED BY; Schema: findom_os; Owner: findom_os
--

ALTER SEQUENCE findom_os.log_t_protocollo_id_log_protocollo_seq OWNED BY findom_os.log_t_protocollo.id_log_protocollo;


--
-- TOC entry 16335 (class 1259 OID 31176320)
-- Name: seq_model; Type: SEQUENCE; Schema: findom_os; Owner: findom_os
--

CREATE SEQUENCE findom_os.seq_model
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE findom_os.seq_model OWNER TO findom_os;

--
-- TOC entry 16336 (class 1259 OID 31176322)
-- Name: seq_submodel; Type: SEQUENCE; Schema: findom_os; Owner: findom_os
--

CREATE SEQUENCE findom_os.seq_submodel
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE findom_os.seq_submodel OWNER TO findom_os;

--
-- TOC entry 16337 (class 1259 OID 31176324)
-- Name: seq_utl_d_istanza; Type: SEQUENCE; Schema: findom_os; Owner: findom_os
--

CREATE SEQUENCE findom_os.seq_utl_d_istanza
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE findom_os.seq_utl_d_istanza OWNER TO findom_os;

--
-- TOC entry 16338 (class 1259 OID 31176326)
-- Name: seq_utl_t_regola_routing; Type: SEQUENCE; Schema: findom_os; Owner: findom_os
--

CREATE SEQUENCE findom_os.seq_utl_t_regola_routing
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE findom_os.seq_utl_t_regola_routing OWNER TO findom_os;

--
-- TOC entry 16339 (class 1259 OID 31176328)
-- Name: shell_d_motivazione_esito; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.shell_d_motivazione_esito (
    id_motivazione_esito integer NOT NULL,
    descr_motivazione_esito character varying(500) NOT NULL,
    cod_tipo_esito character varying(2) NOT NULL,
    dt_inizio date NOT NULL,
    dt_fine date
);


ALTER TABLE findom_os.shell_d_motivazione_esito OWNER TO findom_os;

--
-- TOC entry 16340 (class 1259 OID 31176334)
-- Name: shell_r_capofila_acronimo_partner; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.shell_r_capofila_acronimo_partner (
    id_capofila_acronimo integer NOT NULL,
    id_partner integer NOT NULL,
    id_domanda_partner numeric(9,0),
    dt_attivazione date NOT NULL,
    dt_disattivazione date,
    note text
);


ALTER TABLE findom_os.shell_r_capofila_acronimo_partner OWNER TO findom_os;

--
-- TOC entry 64378 (class 0 OID 0)
-- Dependencies: 16340
-- Name: TABLE shell_r_capofila_acronimo_partner; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON TABLE findom_os.shell_r_capofila_acronimo_partner IS 'Tabella associativa tra Capofila e Partner';


--
-- TOC entry 16342 (class 1259 OID 31176345)
-- Name: shell_t_acronimo_bandi; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.shell_t_acronimo_bandi (
    id_acronimo_bando integer NOT NULL,
    id_bando integer NOT NULL,
    acronimo_progetto character varying(100) NOT NULL,
    titolo_progetto text NOT NULL,
    dt_attivazione timestamp without time zone NOT NULL,
    dt_disattivazione timestamp without time zone
);


ALTER TABLE findom_os.shell_t_acronimo_bandi OWNER TO findom_os;

--
-- TOC entry 64380 (class 0 OID 0)
-- Dependencies: 16342
-- Name: TABLE shell_t_acronimo_bandi; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON TABLE findom_os.shell_t_acronimo_bandi IS 'Tabella di definizione acronimo/bandi';


--
-- TOC entry 16343 (class 1259 OID 31176351)
-- Name: shell_t_acronimo_bandi_id_acronimo_bando_seq; Type: SEQUENCE; Schema: findom_os; Owner: findom_os
--

CREATE SEQUENCE findom_os.shell_t_acronimo_bandi_id_acronimo_bando_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE findom_os.shell_t_acronimo_bandi_id_acronimo_bando_seq OWNER TO findom_os;

--
-- TOC entry 64381 (class 0 OID 0)
-- Dependencies: 16343
-- Name: shell_t_acronimo_bandi_id_acronimo_bando_seq; Type: SEQUENCE OWNED BY; Schema: findom_os; Owner: findom_os
--

ALTER SEQUENCE findom_os.shell_t_acronimo_bandi_id_acronimo_bando_seq OWNED BY findom_os.shell_t_acronimo_bandi.id_acronimo_bando;


--
-- TOC entry 16344 (class 1259 OID 31176353)
-- Name: shell_t_capofila_acronimo; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.shell_t_capofila_acronimo (
    id_capofila_acronimo integer NOT NULL,
    id_domanda numeric(9,0) NOT NULL,
    id_acronimo_bando integer NOT NULL,
    dt_attivazione date NOT NULL,
    dt_disattivazione date
);


ALTER TABLE findom_os.shell_t_capofila_acronimo OWNER TO findom_os;

--
-- TOC entry 64382 (class 0 OID 0)
-- Dependencies: 16344
-- Name: TABLE shell_t_capofila_acronimo; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON TABLE findom_os.shell_t_capofila_acronimo IS 'Tabella di di definizione del capofila rispetto al progetto comune';


--
-- TOC entry 16345 (class 1259 OID 31176356)
-- Name: shell_t_capofila_acronimo_id_capofila_acronimo_seq; Type: SEQUENCE; Schema: findom_os; Owner: findom_os
--

CREATE SEQUENCE findom_os.shell_t_capofila_acronimo_id_capofila_acronimo_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE findom_os.shell_t_capofila_acronimo_id_capofila_acronimo_seq OWNER TO findom_os;

--
-- TOC entry 64383 (class 0 OID 0)
-- Dependencies: 16345
-- Name: shell_t_capofila_acronimo_id_capofila_acronimo_seq; Type: SEQUENCE OWNED BY; Schema: findom_os; Owner: findom_os
--

ALTER SEQUENCE findom_os.shell_t_capofila_acronimo_id_capofila_acronimo_seq OWNED BY findom_os.shell_t_capofila_acronimo.id_capofila_acronimo;


--
-- TOC entry 16346 (class 1259 OID 31176358)
-- Name: shell_t_dett_criteri_graduatori_id_dett_criteri_graduatoria_seq; Type: SEQUENCE; Schema: findom_os; Owner: findom_os
--

CREATE SEQUENCE findom_os.shell_t_dett_criteri_graduatori_id_dett_criteri_graduatoria_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE findom_os.shell_t_dett_criteri_graduatori_id_dett_criteri_graduatoria_seq OWNER TO findom_os;

--
-- TOC entry 64384 (class 0 OID 0)
-- Dependencies: 16346
-- Name: shell_t_dett_criteri_graduatori_id_dett_criteri_graduatoria_seq; Type: SEQUENCE OWNED BY; Schema: findom_os; Owner: findom_os
--

ALTER SEQUENCE findom_os.shell_t_dett_criteri_graduatori_id_dett_criteri_graduatoria_seq OWNED BY findom_os.shell_t_dett_criteri_graduatoria.id_dett_criteri_graduatoria;


--
-- TOC entry 16347 (class 1259 OID 31176360)
-- Name: shell_t_dett_graduatoria_id_dett_graduatoria_seq; Type: SEQUENCE; Schema: findom_os; Owner: findom_os
--

CREATE SEQUENCE findom_os.shell_t_dett_graduatoria_id_dett_graduatoria_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE findom_os.shell_t_dett_graduatoria_id_dett_graduatoria_seq OWNER TO findom_os;

--
-- TOC entry 64385 (class 0 OID 0)
-- Dependencies: 16347
-- Name: shell_t_dett_graduatoria_id_dett_graduatoria_seq; Type: SEQUENCE OWNED BY; Schema: findom_os; Owner: findom_os
--

ALTER SEQUENCE findom_os.shell_t_dett_graduatoria_id_dett_graduatoria_seq OWNED BY findom_os.shell_t_dett_graduatoria.id_dett_graduatoria;


--
-- TOC entry 16348 (class 1259 OID 31176362)
-- Name: shell_t_documento_index_id_documento_index_seq; Type: SEQUENCE; Schema: findom_os; Owner: findom_os
--

CREATE SEQUENCE findom_os.shell_t_documento_index_id_documento_index_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE findom_os.shell_t_documento_index_id_documento_index_seq OWNER TO findom_os;

--
-- TOC entry 64386 (class 0 OID 0)
-- Dependencies: 16348
-- Name: shell_t_documento_index_id_documento_index_seq; Type: SEQUENCE OWNED BY; Schema: findom_os; Owner: findom_os
--

ALTER SEQUENCE findom_os.shell_t_documento_index_id_documento_index_seq OWNED BY findom_os.shell_t_documento_index.id_documento_index;


--
-- TOC entry 16349 (class 1259 OID 31176364)
-- Name: shell_t_file_domande_id_file_domanda_seq; Type: SEQUENCE; Schema: findom_os; Owner: findom_os
--

CREATE SEQUENCE findom_os.shell_t_file_domande_id_file_domanda_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE findom_os.shell_t_file_domande_id_file_domanda_seq OWNER TO findom_os;

--
-- TOC entry 64387 (class 0 OID 0)
-- Dependencies: 16349
-- Name: shell_t_file_domande_id_file_domanda_seq; Type: SEQUENCE OWNED BY; Schema: findom_os; Owner: findom_os
--

ALTER SEQUENCE findom_os.shell_t_file_domande_id_file_domanda_seq OWNED BY findom_os.shell_t_file_domande.id_file_domanda;


--
-- TOC entry 16350 (class 1259 OID 31176366)
-- Name: shell_t_graduatoria_id_graduatoria_seq; Type: SEQUENCE; Schema: findom_os; Owner: findom_os
--

CREATE SEQUENCE findom_os.shell_t_graduatoria_id_graduatoria_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE findom_os.shell_t_graduatoria_id_graduatoria_seq OWNER TO findom_os;

--
-- TOC entry 64388 (class 0 OID 0)
-- Dependencies: 16350
-- Name: shell_t_graduatoria_id_graduatoria_seq; Type: SEQUENCE OWNED BY; Schema: findom_os; Owner: findom_os
--

ALTER SEQUENCE findom_os.shell_t_graduatoria_id_graduatoria_seq OWNED BY findom_os.shell_t_graduatoria.id_graduatoria;


--
-- TOC entry 16351 (class 1259 OID 31176368)
-- Name: shell_t_lock_graduatoria; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.shell_t_lock_graduatoria (
    id_lock integer NOT NULL,
    id_bando integer NOT NULL,
    dt_elab_graduatoria_start timestamp without time zone,
    dt_elab_graduatoria_stop timestamp without time zone,
    esito character varying(100),
    note text
);


ALTER TABLE findom_os.shell_t_lock_graduatoria OWNER TO findom_os;

--
-- TOC entry 64389 (class 0 OID 0)
-- Dependencies: 16351
-- Name: TABLE shell_t_lock_graduatoria; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON TABLE findom_os.shell_t_lock_graduatoria IS 'Scrittura di un record per bando all''esecuzione della graduatoria. A fine elaborazione il record viene eliminato';


--
-- TOC entry 64390 (class 0 OID 0)
-- Dependencies: 16351
-- Name: COLUMN shell_t_lock_graduatoria.esito; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON COLUMN findom_os.shell_t_lock_graduatoria.esito IS 'OK,KO';


--
-- TOC entry 16352 (class 1259 OID 31176374)
-- Name: shell_t_lock_graduatoria_id_lock_seq; Type: SEQUENCE; Schema: findom_os; Owner: findom_os
--

CREATE SEQUENCE findom_os.shell_t_lock_graduatoria_id_lock_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE findom_os.shell_t_lock_graduatoria_id_lock_seq OWNER TO findom_os;

--
-- TOC entry 64391 (class 0 OID 0)
-- Dependencies: 16352
-- Name: shell_t_lock_graduatoria_id_lock_seq; Type: SEQUENCE OWNED BY; Schema: findom_os; Owner: findom_os
--

ALTER SEQUENCE findom_os.shell_t_lock_graduatoria_id_lock_seq OWNED BY findom_os.shell_t_lock_graduatoria.id_lock;


--
-- TOC entry 16353 (class 1259 OID 31176376)
-- Name: shell_t_partner; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.shell_t_partner (
    id_partner integer NOT NULL,
    cod_fiscale character varying(16) NOT NULL,
    cod_ufficio character varying(20),
    denominazione character varying(1000),
    sigla_nazione character varying(3),
    dt_attivazione date NOT NULL,
    dt_disattivazione date
);


ALTER TABLE findom_os.shell_t_partner OWNER TO findom_os;

--
-- TOC entry 64392 (class 0 OID 0)
-- Dependencies: 16353
-- Name: TABLE shell_t_partner; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON TABLE findom_os.shell_t_partner IS 'Tabella Partner per progetti comuni';


--
-- TOC entry 16354 (class 1259 OID 31176382)
-- Name: shell_t_partner_id_partner_seq; Type: SEQUENCE; Schema: findom_os; Owner: findom_os
--

CREATE SEQUENCE findom_os.shell_t_partner_id_partner_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE findom_os.shell_t_partner_id_partner_seq OWNER TO findom_os;

--
-- TOC entry 64393 (class 0 OID 0)
-- Dependencies: 16354
-- Name: shell_t_partner_id_partner_seq; Type: SEQUENCE OWNED BY; Schema: findom_os; Owner: findom_os
--

ALTER SEQUENCE findom_os.shell_t_partner_id_partner_seq OWNED BY findom_os.shell_t_partner.id_partner;


--
-- TOC entry 16355 (class 1259 OID 31176384)
-- Name: shell_t_rimod_entrate_id_rimod_entrate_seq; Type: SEQUENCE; Schema: findom_os; Owner: findom_os
--

CREATE SEQUENCE findom_os.shell_t_rimod_entrate_id_rimod_entrate_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE findom_os.shell_t_rimod_entrate_id_rimod_entrate_seq OWNER TO findom_os;

--
-- TOC entry 64394 (class 0 OID 0)
-- Dependencies: 16355
-- Name: shell_t_rimod_entrate_id_rimod_entrate_seq; Type: SEQUENCE OWNED BY; Schema: findom_os; Owner: findom_os
--

ALTER SEQUENCE findom_os.shell_t_rimod_entrate_id_rimod_entrate_seq OWNED BY findom_os.shell_t_rimod_entrate.id_rimod_entrate;


--
-- TOC entry 16356 (class 1259 OID 31176386)
-- Name: shell_t_rimod_spese_id_rimod_spese_seq; Type: SEQUENCE; Schema: findom_os; Owner: findom_os
--

CREATE SEQUENCE findom_os.shell_t_rimod_spese_id_rimod_spese_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE findom_os.shell_t_rimod_spese_id_rimod_spese_seq OWNER TO findom_os;

--
-- TOC entry 64395 (class 0 OID 0)
-- Dependencies: 16356
-- Name: shell_t_rimod_spese_id_rimod_spese_seq; Type: SEQUENCE OWNED BY; Schema: findom_os; Owner: findom_os
--

ALTER SEQUENCE findom_os.shell_t_rimod_spese_id_rimod_spese_seq OWNED BY findom_os.shell_t_rimod_spese.id_rimod_spese;


--
-- TOC entry 16357 (class 1259 OID 31176388)
-- Name: shell_t_soggetti_id_soggetto_seq; Type: SEQUENCE; Schema: findom_os; Owner: findom_os
--

CREATE SEQUENCE findom_os.shell_t_soggetti_id_soggetto_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE findom_os.shell_t_soggetti_id_soggetto_seq OWNER TO findom_os;

--
-- TOC entry 64396 (class 0 OID 0)
-- Dependencies: 16357
-- Name: shell_t_soggetti_id_soggetto_seq; Type: SEQUENCE OWNED BY; Schema: findom_os; Owner: findom_os
--

ALTER SEQUENCE findom_os.shell_t_soggetti_id_soggetto_seq OWNED BY findom_os.shell_t_soggetti.id_soggetto;


--
-- TOC entry 16358 (class 1259 OID 31176390)
-- Name: shell_t_valut_domande_id_valutazione_seq; Type: SEQUENCE; Schema: findom_os; Owner: findom_os
--

CREATE SEQUENCE findom_os.shell_t_valut_domande_id_valutazione_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE findom_os.shell_t_valut_domande_id_valutazione_seq OWNER TO findom_os;

--
-- TOC entry 64397 (class 0 OID 0)
-- Dependencies: 16358
-- Name: shell_t_valut_domande_id_valutazione_seq; Type: SEQUENCE OWNED BY; Schema: findom_os; Owner: findom_os
--

ALTER SEQUENCE findom_os.shell_t_valut_domande_id_valutazione_seq OWNED BY findom_os.shell_t_valut_domande.id_valutazione;


--
-- TOC entry 16359 (class 1259 OID 31176410)
-- Name: utl_d_fase; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.utl_d_fase (
    cod_fase character varying(5) NOT NULL,
    descr_fase character varying(100) NOT NULL
);


ALTER TABLE findom_os.utl_d_fase OWNER TO findom_os;

--
-- TOC entry 16360 (class 1259 OID 31176413)
-- Name: utl_d_istanza; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.utl_d_istanza (
    id_utl_d_istanza integer NOT NULL,
    descr_istanza character varying(100) NOT NULL,
    base_url character varying(200) NOT NULL
);


ALTER TABLE findom_os.utl_d_istanza OWNER TO findom_os;

--
-- TOC entry 16361 (class 1259 OID 31176416)
-- Name: utl_t_regola_routing; Type: TABLE; Schema: findom_os; Owner: findom_os
--

CREATE TABLE findom_os.utl_t_regola_routing (
    it_utl_t_regola_routing integer NOT NULL,
    id_sportello_bando integer NOT NULL,
    cod_fase character varying(5) NOT NULL,
    id_utl_d_istanza integer,
    cod_user_inserim character varying(16) NOT NULL,
    d_inserim timestamp without time zone NOT NULL,
    cod_user_aggiorn character varying(16) NOT NULL,
    d_aggiorn timestamp without time zone NOT NULL
);


ALTER TABLE findom_os.utl_t_regola_routing OWNER TO findom_os;

--
-- TOC entry 56546 (class 2604 OID 31176422)
-- Name: csi_log_audit id_traccia; Type: DEFAULT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.csi_log_audit ALTER COLUMN id_traccia SET DEFAULT nextval('findom_os.csi_log_audit_id_traccia_seq'::regclass);


--
-- TOC entry 56559 (class 2604 OID 31176423)
-- Name: findom_d_range_graduatoria id_range; Type: DEFAULT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_d_range_graduatoria ALTER COLUMN id_range SET DEFAULT nextval('findom_os.findom_d_range_graduatoria_id_range_seq'::regclass);


--
-- TOC entry 56588 (class 2604 OID 31176424)
-- Name: findom_t_allegati_sportello id; Type: DEFAULT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_t_allegati_sportello ALTER COLUMN id SET DEFAULT nextval('findom_os.findom_t_allegati_sportello_id_seq'::regclass);


--
-- TOC entry 56592 (class 2604 OID 31176425)
-- Name: findom_t_amministratori id_amministratore; Type: DEFAULT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_t_amministratori ALTER COLUMN id_amministratore SET DEFAULT nextval('findom_os.findom_t_amministratori_id_amministratore_seq'::regclass);


--
-- TOC entry 56608 (class 2604 OID 31176426)
-- Name: findom_t_bonus_turismo id_bonus_turismo; Type: DEFAULT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_t_bonus_turismo ALTER COLUMN id_bonus_turismo SET DEFAULT nextval('findom_os.findom_t_bonus_turismo_id_bonus_turismo_seq'::regclass);


--
-- TOC entry 56609 (class 2604 OID 31176427)
-- Name: findom_t_commissari id_commissario; Type: DEFAULT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_t_commissari ALTER COLUMN id_commissario SET DEFAULT nextval('findom_os.findom_t_commissari_id_commissario_seq'::regclass);


--
-- TOC entry 56611 (class 2604 OID 31176428)
-- Name: findom_t_commissioni id_commissione; Type: DEFAULT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_t_commissioni ALTER COLUMN id_commissione SET DEFAULT nextval('findom_os.findom_t_commissioni_id_commissione_seq'::regclass);


--
-- TOC entry 56612 (class 2604 OID 31176429)
-- Name: findom_t_contrib_acq_veicoli id_contrib_acq_veicoli; Type: DEFAULT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_t_contrib_acq_veicoli ALTER COLUMN id_contrib_acq_veicoli SET DEFAULT nextval('findom_os.findom_t_contrib_acq_veicoli_id_contrib_acq_veicoli_seq'::regclass);


--
-- TOC entry 56613 (class 2604 OID 31176430)
-- Name: findom_t_dich_presa_visione id_dich_presa_visione; Type: DEFAULT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_t_dich_presa_visione ALTER COLUMN id_dich_presa_visione SET DEFAULT nextval('findom_os.findom_t_dich_presa_visione_id_dich_presa_visione_seq'::regclass);


--
-- TOC entry 56614 (class 2604 OID 31176431)
-- Name: findom_t_documenti_commissione id_documento_comm; Type: DEFAULT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_t_documenti_commissione ALTER COLUMN id_documento_comm SET DEFAULT nextval('findom_os.findom_t_documenti_commissione_id_documento_comm_seq'::regclass);


--
-- TOC entry 56615 (class 2604 OID 31176432)
-- Name: findom_t_param_sportelli_bandi id_param; Type: DEFAULT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_t_param_sportelli_bandi ALTER COLUMN id_param SET DEFAULT nextval('findom_os.findom_t_param_sportelli_bandi_id_param_seq'::regclass);


--
-- TOC entry 56616 (class 2604 OID 31176433)
-- Name: findom_t_parametri_valut id_parametro_valut; Type: DEFAULT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_t_parametri_valut ALTER COLUMN id_parametro_valut SET DEFAULT nextval('findom_os.findom_t_parametri_valut_id_parametro_valut_seq'::regclass);


--
-- TOC entry 56618 (class 2604 OID 31176434)
-- Name: findom_t_soggetti_abilitati id_sogg_abil; Type: DEFAULT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_t_soggetti_abilitati ALTER COLUMN id_sogg_abil SET DEFAULT nextval('findom_os.findom_t_soggetti_abilitati_id_sogg_abil_seq'::regclass);


--
-- TOC entry 56619 (class 2604 OID 31176435)
-- Name: findom_t_soggetti_bonus_covid id_soggetto_bonus_covid; Type: DEFAULT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_t_soggetti_bonus_covid ALTER COLUMN id_soggetto_bonus_covid SET DEFAULT nextval('findom_os.findom_t_soggetti_bonus_covid_id_soggetto_bonus_covid_seq'::regclass);


--
-- TOC entry 56620 (class 2604 OID 31176436)
-- Name: findom_t_soggetti_bonus_covid_dett id_soggetto_bonus_covid_dett; Type: DEFAULT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_t_soggetti_bonus_covid_dett ALTER COLUMN id_soggetto_bonus_covid_dett SET DEFAULT nextval('findom_os.findom_t_soggetti_bonus_covid__id_soggetto_bonus_covid_dett_seq'::regclass);


--
-- TOC entry 56621 (class 2604 OID 31176437)
-- Name: findom_t_sportelli_bandi id_sportello_bando; Type: DEFAULT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_t_sportelli_bandi ALTER COLUMN id_sportello_bando SET DEFAULT nextval('findom_os.findom_t_sportelli_bandi_id_sportello_bando_seq'::regclass);


--
-- TOC entry 56622 (class 2604 OID 31176438)
-- Name: findom_t_valori_sportello id; Type: DEFAULT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_t_valori_sportello ALTER COLUMN id SET DEFAULT nextval('findom_os.findom_t_valori_sportello_id_seq'::regclass);


--
-- TOC entry 56641 (class 2604 OID 31176439)
-- Name: log_t_batch id_log_batch; Type: DEFAULT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.log_t_batch ALTER COLUMN id_log_batch SET DEFAULT nextval('findom_os.log_t_batch_id_log_batch_seq'::regclass);


--
-- TOC entry 56642 (class 2604 OID 31176440)
-- Name: log_t_firma_digitale id_log_firma; Type: DEFAULT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.log_t_firma_digitale ALTER COLUMN id_log_firma SET DEFAULT nextval('findom_os.log_t_firma_digitale_id_log_firma_seq'::regclass);


--
-- TOC entry 56643 (class 2604 OID 31176441)
-- Name: log_t_protocollo id_log_protocollo; Type: DEFAULT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.log_t_protocollo ALTER COLUMN id_log_protocollo SET DEFAULT nextval('findom_os.log_t_protocollo_id_log_protocollo_seq'::regclass);


--
-- TOC entry 56644 (class 2604 OID 31176442)
-- Name: shell_t_acronimo_bandi id_acronimo_bando; Type: DEFAULT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.shell_t_acronimo_bandi ALTER COLUMN id_acronimo_bando SET DEFAULT nextval('findom_os.shell_t_acronimo_bandi_id_acronimo_bando_seq'::regclass);


--
-- TOC entry 56645 (class 2604 OID 31176443)
-- Name: shell_t_capofila_acronimo id_capofila_acronimo; Type: DEFAULT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.shell_t_capofila_acronimo ALTER COLUMN id_capofila_acronimo SET DEFAULT nextval('findom_os.shell_t_capofila_acronimo_id_capofila_acronimo_seq'::regclass);


--
-- TOC entry 56636 (class 2604 OID 31176444)
-- Name: shell_t_dett_criteri_graduatoria id_dett_criteri_graduatoria; Type: DEFAULT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.shell_t_dett_criteri_graduatoria ALTER COLUMN id_dett_criteri_graduatoria SET DEFAULT nextval('findom_os.shell_t_dett_criteri_graduatori_id_dett_criteri_graduatoria_seq'::regclass);


--
-- TOC entry 56633 (class 2604 OID 31176445)
-- Name: shell_t_dett_graduatoria id_dett_graduatoria; Type: DEFAULT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.shell_t_dett_graduatoria ALTER COLUMN id_dett_graduatoria SET DEFAULT nextval('findom_os.shell_t_dett_graduatoria_id_dett_graduatoria_seq'::regclass);


--
-- TOC entry 56627 (class 2604 OID 31176446)
-- Name: shell_t_documento_index id_documento_index; Type: DEFAULT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.shell_t_documento_index ALTER COLUMN id_documento_index SET DEFAULT nextval('findom_os.shell_t_documento_index_id_documento_index_seq'::regclass);


--
-- TOC entry 56630 (class 2604 OID 31176447)
-- Name: shell_t_file_domande id_file_domanda; Type: DEFAULT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.shell_t_file_domande ALTER COLUMN id_file_domanda SET DEFAULT nextval('findom_os.shell_t_file_domande_id_file_domanda_seq'::regclass);


--
-- TOC entry 56625 (class 2604 OID 31176448)
-- Name: shell_t_graduatoria id_graduatoria; Type: DEFAULT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.shell_t_graduatoria ALTER COLUMN id_graduatoria SET DEFAULT nextval('findom_os.shell_t_graduatoria_id_graduatoria_seq'::regclass);


--
-- TOC entry 56646 (class 2604 OID 31176449)
-- Name: shell_t_lock_graduatoria id_lock; Type: DEFAULT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.shell_t_lock_graduatoria ALTER COLUMN id_lock SET DEFAULT nextval('findom_os.shell_t_lock_graduatoria_id_lock_seq'::regclass);


--
-- TOC entry 56647 (class 2604 OID 31176450)
-- Name: shell_t_partner id_partner; Type: DEFAULT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.shell_t_partner ALTER COLUMN id_partner SET DEFAULT nextval('findom_os.shell_t_partner_id_partner_seq'::regclass);


--
-- TOC entry 56639 (class 2604 OID 31176451)
-- Name: shell_t_rimod_entrate id_rimod_entrate; Type: DEFAULT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.shell_t_rimod_entrate ALTER COLUMN id_rimod_entrate SET DEFAULT nextval('findom_os.shell_t_rimod_entrate_id_rimod_entrate_seq'::regclass);


--
-- TOC entry 56637 (class 2604 OID 31176452)
-- Name: shell_t_rimod_spese id_rimod_spese; Type: DEFAULT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.shell_t_rimod_spese ALTER COLUMN id_rimod_spese SET DEFAULT nextval('findom_os.shell_t_rimod_spese_id_rimod_spese_seq'::regclass);


--
-- TOC entry 56629 (class 2604 OID 31176453)
-- Name: shell_t_soggetti id_soggetto; Type: DEFAULT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.shell_t_soggetti ALTER COLUMN id_soggetto SET DEFAULT nextval('findom_os.shell_t_soggetti_id_soggetto_seq'::regclass);


--
-- TOC entry 56631 (class 2604 OID 31176454)
-- Name: shell_t_valut_domande id_valutazione; Type: DEFAULT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.shell_t_valut_domande ALTER COLUMN id_valutazione SET DEFAULT nextval('findom_os.shell_t_valut_domande_id_valutazione_seq'::regclass);

