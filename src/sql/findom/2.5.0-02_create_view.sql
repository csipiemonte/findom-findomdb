----------------------------------------------------------------------------
-- Copyright Regione Piemonte - 2020
-- SPDX-License-Identifier: EUPL-1.2-or-later
----------------------------------------------------------------------------
--
-- TOC entry 16257 (class 1259 OID 31175900)
-- Name: findom_v_primi_livelli_settore_ateco; Type: VIEW; Schema: findom_os; Owner: findom_os
--

CREATE VIEW findom_os.findom_v_primi_livelli_settore_ateco AS
 SELECT ba.id_bando,
    b.id_ateco,
    b.cod_ateco,
    b.desc_ateco,
    b.cod_sezione
   FROM ((findom_os.findom_r_bandi_ateco ba
     JOIN findom_os.ext_d_ateco a ON (((ba.id_ateco = a.id_ateco) AND (a.cod_livello = (1)::numeric))))
     JOIN findom_os.ext_d_ateco b ON ((((b.cod_sezione)::text = (a.cod_sezione)::text) AND (b.cod_livello = (2)::numeric))))
UNION ALL
 SELECT ba.id_bando,
    a.id_ateco,
    a.cod_ateco,
    a.desc_ateco,
    a.cod_sezione
   FROM (findom_os.findom_r_bandi_ateco ba
     JOIN findom_os.ext_d_ateco a ON (((ba.id_ateco = a.id_ateco) AND (a.cod_livello <> (1)::numeric))));


ALTER TABLE findom_os.findom_v_primi_livelli_settore_ateco OWNER TO findom_os;

--
-- TOC entry 16258 (class 1259 OID 31175905)
-- Name: findom_v_sezioni_ateco; Type: VIEW; Schema: findom_os; Owner: findom_os
--

CREATE VIEW findom_os.findom_v_sezioni_ateco AS
 SELECT ext_d_ateco.cod_ateco AS cod_sezione,
    ext_d_ateco.desc_ateco AS desc_sezione
   FROM findom_os.ext_d_ateco
  WHERE (ext_d_ateco.cod_livello = (1)::numeric);


ALTER TABLE findom_os.findom_v_sezioni_ateco OWNER TO findom_os;

--
-- TOC entry 16259 (class 1259 OID 31175909)
-- Name: findom_v_ateco_ammissibili; Type: VIEW; Schema: findom_os; Owner: findom_os
--

CREATE VIEW findom_os.findom_v_ateco_ammissibili AS
 SELECT x.id_bando,
    x.id_ateco,
    x.cod_ateco,
    x.cod_ateco_norm,
    x.desc_ateco,
    sz.cod_sezione,
    sz.desc_sezione
   FROM ((
                 SELECT a.id_bando,
                    b.id_ateco,
                    b.cod_ateco,
                    b.cod_sezione,
                    b.desc_ateco,
                    b.cod_ateco_norm
                   FROM (findom_os.findom_v_primi_livelli_settore_ateco a
                     JOIN findom_os.ext_d_ateco b ON (((b.cod_ateco)::text ~~ ((a.cod_ateco)::text || '%'::text))))
                EXCEPT
                 SELECT ba.id_bando,
                    b.id_ateco,
                    b.cod_ateco,
                    b.cod_sezione,
                    b.desc_ateco,
                    b.cod_ateco_norm
                   FROM ((findom_os.findom_r_bandi_ateco_escl ba
                     JOIN findom_os.ext_d_ateco a ON ((ba.id_ateco = a.id_ateco)))
                     JOIN findom_os.ext_d_ateco b ON (((b.cod_ateco)::text ~~ ((a.cod_ateco)::text || '%'::text))))
        ) UNION ALL
         SELECT a.id_bando,
            b.id_ateco,
            b.cod_ateco,
            b.cod_sezione,
            b.desc_ateco,
            b.cod_ateco_norm
           FROM findom_os.findom_t_bandi a,
            findom_os.ext_d_ateco b
          WHERE ((NOT (EXISTS ( SELECT NULL::unknown AS unknown
                   FROM findom_os.findom_r_bandi_ateco
                  WHERE (findom_r_bandi_ateco.id_bando = a.id_bando)))) AND (b.cod_livello <> (1)::numeric))) x,
    findom_os.findom_v_sezioni_ateco sz
  WHERE ((x.cod_sezione)::text = (sz.cod_sezione)::text)
  ORDER BY x.id_bando, x.id_ateco;


ALTER TABLE findom_os.findom_v_ateco_ammissibili OWNER TO findom_os;

--
-- TOC entry 16260 (class 1259 OID 31175914)
-- Name: findom_v_ateco_config; Type: VIEW; Schema: findom_os; Owner: findom_os
--

CREATE VIEW findom_os.findom_v_ateco_config AS
 SELECT a.id_bando,
    b.cod_ateco_norm
   FROM findom_os.findom_r_bandi_ateco a,
    findom_os.ext_d_ateco b
  WHERE (a.id_ateco = b.id_ateco);


ALTER TABLE findom_os.findom_v_ateco_config OWNER TO findom_os;

--
-- TOC entry 16261 (class 1259 OID 31175918)
-- Name: findom_v_ateco_escl_config; Type: VIEW; Schema: findom_os; Owner: findom_os
--

CREATE VIEW findom_os.findom_v_ateco_escl_config AS
 SELECT a.id_bando,
    b.cod_ateco_norm
   FROM findom_os.findom_r_bandi_ateco_escl a,
    findom_os.ext_d_ateco b
  WHERE (a.id_ateco = b.id_ateco);


ALTER TABLE findom_os.findom_v_ateco_escl_config OWNER TO findom_os;

--
-- TOC entry 16262 (class 1259 OID 31175922)
-- Name: findom_v_bandi_motivazione_esito; Type: VIEW; Schema: findom_os; Owner: findom_os
--

CREATE VIEW findom_os.findom_v_bandi_motivazione_esito AS
 SELECT b.id_bando,
    b.descr_breve,
    me.id_motivazione_esito,
    me.cod_tipo_esito,
    me.descr_motivazione_esito
   FROM ((findom_os.findom_t_bandi b
     JOIN findom_os.findom_r_bandi_motivazioni_esito rbme USING (id_bando))
     JOIN findom_os.findom_d_motivazione_esito me USING (id_motivazione_esito))
  WHERE (rbme.dt_fine IS NULL)
UNION
 SELECT b.id_bando,
    b.descr_breve,
    me.id_motivazione_esito,
    me.cod_tipo_esito,
    me.descr_motivazione_esito
   FROM findom_os.findom_d_motivazione_esito me,
    findom_os.findom_t_bandi b
  WHERE ((me.flag_default IS TRUE) AND (NOT (EXISTS ( SELECT findom_r_bandi_motivazioni_esito.id_bando
           FROM findom_os.findom_r_bandi_motivazioni_esito
          WHERE (findom_r_bandi_motivazioni_esito.id_bando = b.id_bando)))))
  ORDER BY 1, 3;


ALTER TABLE findom_os.findom_v_bandi_motivazione_esito OWNER TO findom_os;

--
-- TOC entry 16263 (class 1259 OID 31175927)
-- Name: findom_v_bandi_parametri_valut; Type: VIEW; Schema: findom_os; Owner: findom_os
--

CREATE VIEW findom_os.findom_v_bandi_parametri_valut AS
 SELECT pv.id_bando,
    cv.id_criterio,
    ti.id_tipol_intervento,
    pv.id_specifica,
    sv.descrizione AS descr_specifica,
    spv.tipo_campo,
    spv.punteggio_max,
    spv.id_regola,
    pv.id_parametro,
    psv.descrizione AS descr_parametro,
    pv.punteggio,
    pv.ordine,
    pv.flag_fittizio,
    pv.id_parametro_valut,
    cv.descrizione AS descr_criterio,
    b.descr_breve AS descr_breve_bando,
    ti.descrizione AS descrizione_tipol_intervento
   FROM (((((((findom_os.findom_t_parametri_valut pv
     JOIN findom_os.findom_d_specifiche_valut sv USING (id_specifica))
     JOIN findom_os.findom_d_parametri_specifiche_valut psv USING (id_parametro))
     JOIN findom_os.findom_d_criteri_valut cv ON ((cv.id_criterio = sv.id_criterio)))
     JOIN findom_os.findom_t_bandi b ON ((b.id_bando = pv.id_bando)))
     JOIN findom_os.findom_r_bandi_specifiche_valut spv ON (((spv.id_bando = b.id_bando) AND (spv.id_specifica = sv.id_specifica))))
     JOIN findom_os.findom_r_bandi_criteri_valut bcv ON (((bcv.id_bando = b.id_bando) AND (bcv.id_criterio = sv.id_criterio))))
     LEFT JOIN findom_os.findom_d_tipol_interventi ti ON ((ti.id_tipol_intervento = bcv.id_tipol_intervento)))
  ORDER BY pv.id_bando, bcv.ordine, sv.ordine, pv.ordine;


ALTER TABLE findom_os.findom_v_bandi_parametri_valut OWNER TO findom_os;

--
-- TOC entry 16264 (class 1259 OID 31175932)
-- Name: findom_v_bandi_specifiche_valut; Type: VIEW; Schema: findom_os; Owner: findom_os
--

CREATE VIEW findom_os.findom_v_bandi_specifiche_valut AS
 SELECT bcv.id_bando,
    b.descr_breve,
    ti.id_tipol_intervento,
    ti.descrizione AS descrizione_tipol_intervento,
    bcv.id_criterio,
    cv.descrizione AS descr_criterio,
    bcv.punteggio_min AS punteggio_min_criterio,
    bcv.punteggio_max AS punteggio_max_criterio,
    bcv.ordine AS ordine_criterio,
    bcv.priorita_graduatoria,
    bsv.id_specifica,
    sv.descrizione AS descr_specifica,
    bsv.tipo_campo,
    bsv.punteggio_min AS punteggio_min_specifica,
    bsv.punteggio_max AS punteggio_max_specifica,
    sv.ordine AS ordine_specifica,
    r.corpo_regola,
    bsv.flag_visibile_in_domanda
   FROM ((((((findom_os.findom_r_bandi_criteri_valut bcv
     LEFT JOIN findom_os.findom_d_tipol_interventi ti ON ((ti.id_tipol_intervento = bcv.id_tipol_intervento)))
     JOIN findom_os.findom_d_specifiche_valut sv ON ((sv.id_criterio = bcv.id_criterio)))
     JOIN findom_os.findom_r_bandi_specifiche_valut bsv ON (((bsv.id_bando = bcv.id_bando) AND (bsv.id_specifica = sv.id_specifica))))
     JOIN findom_os.findom_t_bandi b ON ((b.id_bando = bcv.id_bando)))
     JOIN findom_os.findom_d_criteri_valut cv ON ((cv.id_criterio = bcv.id_criterio)))
     LEFT JOIN findom_os.findom_d_regole r ON ((r.id_regola = bsv.id_regola)))
  ORDER BY bcv.ordine, sv.ordine;


ALTER TABLE findom_os.findom_v_bandi_specifiche_valut OWNER TO findom_os;

--
-- TOC entry 16265 (class 1259 OID 31175937)
-- Name: findom_v_classif_bandi; Type: VIEW; Schema: findom_os; Owner: findom_os
--

CREATE VIEW findom_os.findom_v_classif_bandi AS
 SELECT n.id_normativa,
    n.descr_breve AS normativa,
    ap.id_classificazione AS id_asse,
    ap.codice AS codice_asse,
    ap.descrizione AS descrizione_asse,
    pi.id_classificazione AS id_priorita_investimento,
    pi.codice AS codice_priorita_investimento,
    pi.descrizione AS descrizione_priorita_investimento,
    os.id_classificazione AS id_obiettivo_specifico,
    os.codice AS codice_obiettivo_specifico,
    os.descrizione AS descrizione_obiettivo_specifico,
    az.id_classificazione AS id_azione,
    az.codice AS codice_azione,
    az.descrizione AS descrizione_azione
   FROM ((((findom_os.findom_d_classif_bandi ap
     JOIN findom_os.findom_d_classif_bandi pi ON (((pi.id_classificazione_padre = ap.id_classificazione) AND (pi.id_tipo_suddivisione = 3))))
     JOIN findom_os.findom_d_classif_bandi os ON (((os.id_classificazione_padre = pi.id_classificazione) AND (os.id_tipo_suddivisione = 4))))
     JOIN findom_os.findom_d_classif_bandi az ON (((az.id_classificazione_padre = os.id_classificazione) AND (az.id_tipo_suddivisione = 5))))
     JOIN findom_os.findom_d_normative n ON ((n.id_normativa = ap.id_normativa)))
  WHERE (ap.id_classificazione_padre IS NULL)
UNION ALL
 SELECT n.id_normativa,
    n.descr_breve AS normativa,
    ap.id_classificazione AS id_asse,
    ap.codice AS codice_asse,
    ap.descrizione AS descrizione_asse,
    NULL::integer AS id_priorita_investimento,
    NULL::character varying AS codice_priorita_investimento,
    NULL::character varying AS descrizione_priorita_investimento,
    os.id_classificazione AS id_obiettivo_specifico,
    os.codice AS codice_obiettivo_specifico,
    os.descrizione AS descrizione_obiettivo_specifico,
    az.id_classificazione AS id_azione,
    az.codice AS codice_azione,
    az.descrizione AS descrizione_azione
   FROM (((findom_os.findom_d_classif_bandi ap
     JOIN findom_os.findom_d_classif_bandi os ON (((os.id_classificazione_padre = ap.id_classificazione) AND (os.id_tipo_suddivisione = 4))))
     JOIN findom_os.findom_d_classif_bandi az ON (((az.id_classificazione_padre = os.id_classificazione) AND (az.id_tipo_suddivisione = 5))))
     JOIN findom_os.findom_d_normative n ON ((n.id_normativa = ap.id_normativa)))
  WHERE (ap.id_classificazione_padre IS NULL);


ALTER TABLE findom_os.findom_v_classif_bandi OWNER TO findom_os;


--
-- TOC entry 16268 (class 1259 OID 31175954)
-- Name: findom_v_commissari_bandi; Type: VIEW; Schema: findom_os; Owner: findom_os
--

CREATE VIEW findom_os.findom_v_commissari_bandi AS
 WITH istruttoria_aperta AS (
         SELECT DISTINCT b_1.id_bando
           FROM (((findom_os.shell_t_domande d_1
             JOIN findom_os.findom_d_stato_istruttoria si ON (((si.id_stato_istr = d_1.id_stato_istr) AND (si.flag_stato_finale IS NULL))))
             JOIN findom_os.findom_t_sportelli_bandi sp ON ((sp.id_sportello_bando = d_1.id_sportello_bando)))
             JOIN findom_os.findom_t_bandi b_1 ON ((b_1.id_bando = sp.id_bando)))
        ), graduatoria_chiusa AS (
         SELECT DISTINCT shell_t_graduatoria.id_bando
           FROM findom_os.shell_t_graduatoria
          WHERE (shell_t_graduatoria.dt_chiusura_graduatoria IS NOT NULL)
        )
 SELECT a.id_commissario,
    a.id_commissione,
    a.dt_inizio AS dt_inizio_commissario_commissione,
    a.dt_fine AS dt_fine_commissario_commissione,
    e.id_funzionario,
    d.id_bando,
    d.descrizione AS descrizione_bando,
    d.descr_breve AS descr_breve_bando,
    c.id_sportello_bando,
    c.dt_apertura AS dt_apertura_sportello,
    c.dt_chiusura AS dt_chiusura_sportello,
    b.dt_inizio AS dt_inizio_sportello_commissione,
    b.dt_fine AS dt_fine_sportello_commissione,
    COALESCE(e.cod_fiscale, h.cod_fiscale) AS cod_fiscale_commissario,
    COALESCE(e.cognome, h.cognome) AS cognome_commissario,
    COALESCE(e.nome, h.nome) AS nome_commissario,
    COALESCE(e.email, h.email) AS email_commissario,
    e.dt_fine AS dt_fine_commissario,
    g.id_settore,
    g.codice AS codice_settore,
    g.descrizione AS descr_settore,
    f.id_incarico,
    f.descrizione AS descrizione_incarico,
        CASE
            WHEN (i.id_bando IS NOT NULL) THEN 'S'::text
            ELSE 'N'::text
        END AS flag_istruttoria_aperta,
        CASE
            WHEN (j.id_bando IS NOT NULL) THEN 'S'::text
            ELSE 'N'::text
        END AS flag_graduatoria_chiusa
   FROM (((((((((findom_os.findom_r_commissioni_commissari a
     JOIN findom_os.findom_r_sportelli_bandi_commissioni b ON ((b.id_commissione = a.id_commissione)))
     JOIN findom_os.findom_t_sportelli_bandi c ON ((c.id_sportello_bando = b.id_sportello_bando)))
     JOIN findom_os.findom_t_bandi d ON ((d.id_bando = c.id_bando)))
     JOIN findom_os.findom_t_commissari e ON ((e.id_commissario = a.id_commissario)))
     JOIN findom_os.findom_d_incarichi f ON ((f.id_incarico = a.id_incarico)))
     JOIN findom_os.findom_d_settori g ON ((g.id_settore = d.id_settore)))
     LEFT JOIN findom_os.findom_d_funzionari h ON ((h.id_funzionario = e.id_funzionario)))
     LEFT JOIN istruttoria_aperta i ON ((i.id_bando = d.id_bando)))
     LEFT JOIN graduatoria_chiusa j ON ((j.id_bando = d.id_bando)));


ALTER TABLE findom_os.findom_v_commissari_bandi OWNER TO findom_os;

--
-- TOC entry 16269 (class 1259 OID 31175959)
-- Name: findom_v_dett_tipol_aiuti; Type: VIEW; Schema: findom_os; Owner: findom_os
--

CREATE VIEW findom_os.findom_v_dett_tipol_aiuti AS
 SELECT b.id_bando,
    dta.id_dett_tipol_aiuti,
    dta.descrizione,
    dta.id_tipol_aiuto,
    dta.link,
    dta.codice,
    rbdta.dt_inizio,
    rbdta.dt_fine
   FROM (((findom_os.findom_t_bandi b
     JOIN findom_os.findom_r_bandi_dett_tipol_aiuti rbdta USING (id_bando))
     JOIN findom_os.findom_d_dett_tipol_aiuti dta USING (id_dett_tipol_aiuti))
     JOIN findom_os.findom_d_tipol_aiuti ta USING (id_tipol_aiuto))
  WHERE (dta.flag_fittizio IS NULL)
  ORDER BY b.id_bando, dta.codice;


ALTER TABLE findom_os.findom_v_dett_tipol_aiuti OWNER TO findom_os;


--
-- TOC entry 16272 (class 1259 OID 31175977)
-- Name: findom_v_doc_cartacei_batch; Type: VIEW; Schema: findom_os; Owner: findom_os
--

CREATE VIEW findom_os.findom_v_doc_cartacei_batch AS
 SELECT x.id_domanda,
    x.dt_invio_domanda,
    x.id_documento_index,
    x.id_bando,
    x.uuid_nodo,
    x.nome_file,
    x.stato_documento,
    x.id_allegato,
    x.tipo_allegato,
    x.codice_settore,
    x.descrizione_settore,
    x.codice_direzione,
    x.descrizione_direzione,
    x.flag_regionale,
    x.flag_finpiemonte,
    x.dest_file_domanda,
    x.flag_trasm_dest,
    x.cod_fiscale_beneficiario,
    x.denominazione_beneficiario,
    x.flag_upload_index,
    x.flag_attiva_invio_doc
   FROM ( SELECT dom.id_domanda,
            dom.dt_invio_domanda,
            di.id_documento_index,
            findom_t_sportelli_bandi.id_bando,
            b.tipo_firma,
            b.tipologia_verifica_firma,
            b.flag_verifica_firma,
            di.uuid_nodo,
            di.nome_file,
            sdi.descrizione AS stato_documento,
            to_char(di.dt_verifica_firma, 'DD/MM/YYYY HH24:MI:SS'::text) AS data_verifica_firma,
            to_char(di.dt_marca_temporale, 'DD/MM/YYYY HH24:MI:SS'::text) AS data_marca_temporale,
            di.id_allegato,
            al.descrizione AS tipo_allegato,
            s.codice AS codice_settore,
            s.descrizione AS descrizione_settore,
            d.codice AS codice_direzione,
            d.descrizione AS descrizione_direzione,
                CASE
                    WHEN ((e.dest_file_domanda)::text = ANY (ARRAY['REGIONE'::text, 'REGIONE_FINPIS'::text])) THEN 'S'::text
                    ELSE 'N'::text
                END AS flag_regionale,
                CASE
                    WHEN ((e.dest_file_domanda)::text = ANY (ARRAY['FINPIEMONTE'::text, 'FINPIEMONTE_SIFPL'::text, 'REGIONE_FINPIS'::text, 'FINPIEMONTE_NO_PB'::text])) THEN 'S'::text
                    ELSE 'N'::text
                END AS flag_finpiemonte,
            e.dest_file_domanda,
            COALESCE(di.flag_trasm_dest, 'N'::bpchar) AS flag_trasm_dest,
            dom.fascicolo_acta,
            dom.sottofascicolo_acta,
            b.cod_nodo_operativo,
            sog.cod_fiscale AS cod_fiscale_beneficiario,
            sog.denominazione AS denominazione_beneficiario,
            si.cod_fiscale AS cod_fiscale_originatore,
            si.cognome AS cognome_soggetto_originatore,
            si.nome AS nome_soggetto_originatore,
            b.flag_upload_index,
            b.flag_attiva_invio_doc
           FROM (((((((((((findom_os.shell_t_domande dom
             JOIN findom_os.findom_d_tipol_beneficiari tb ON ((tb.id_tipol_beneficiario = dom.id_tipol_beneficiario)))
             JOIN findom_os.shell_t_documento_index di ON ((di.id_domanda = dom.id_domanda)))
             JOIN findom_os.shell_t_soggetti sog ON ((sog.id_soggetto = dom.id_soggetto_beneficiario)))
             LEFT JOIN findom_os.shell_t_soggetti si ON ((si.id_soggetto = dom.id_soggetto_invio)))
             JOIN findom_os.findom_t_sportelli_bandi USING (id_sportello_bando))
             JOIN findom_os.findom_t_bandi b USING (id_bando))
             JOIN findom_os.findom_d_enti e ON ((b.id_ente_destinatario = e.id_ente)))
             JOIN findom_os.findom_d_settori s USING (id_settore))
             JOIN findom_os.findom_d_direzioni d USING (id_direzione))
             JOIN findom_os.findom_d_stato_documento_index sdi ON ((sdi.id_stato_documento_index = di.id_stato_documento_index)))
             JOIN findom_os.findom_d_allegati al ON ((al.id_allegato = di.id_allegato)))
          WHERE ((b.flag_demat IS NULL) AND (dom.dt_invio_domanda IS NOT NULL))
          ORDER BY di.id_domanda, COALESCE(di.id_allegato, 0)) x;


ALTER TABLE findom_os.findom_v_doc_cartacei_batch OWNER TO findom_os;


--
-- TOC entry 16275 (class 1259 OID 31175991)
-- Name: findom_v_doc_demat_batch; Type: VIEW; Schema: findom_os; Owner: findom_os
--

CREATE VIEW findom_os.findom_v_doc_demat_batch AS
 SELECT x.id_domanda,
    x.dt_invio_domanda,
    x.id_documento_index,
    x.id_bando,
    x.tipo_firma,
    x.tipologia_verifica_firma,
    x.flag_verifica_firma,
    x.uuid_nodo,
    x.nome_file,
    x.stato_documento,
    x.data_verifica_firma,
    x.data_marca_temporale,
    x.data_classificazione,
    x.data_protocollo,
    x.azione,
    x.id_allegato,
    x.tipo_allegato,
    x.totale_allegati,
    x.codice_settore,
    x.descrizione_settore,
    x.codice_direzione,
    x.descrizione_direzione,
    x.flag_regionale,
    x.flag_finpiemonte,
    x.dest_file_domanda,
    x.flag_trasm_dest,
    x.parola_chiave_acta,
    x.fascicolo_acta,
    x.sottofascicolo_acta,
    x.cod_nodo_operativo,
    x.cod_fiscale_beneficiario,
    x.denominazione_beneficiario,
    x.classificazione_acta,
    x.legale_rappr_codice_fiscale,
    x.legale_rappr_cognome,
    x.legale_rappr_nome,
        CASE
            WHEN (x.sogg_deleg_codice_fiscale = ''::text) THEN x.legale_rappr_codice_fiscale
            ELSE x.sogg_deleg_codice_fiscale
        END AS scrittore_codice_fiscale,
        CASE
            WHEN (x.sogg_deleg_cognome = ''::text) THEN x.legale_rappr_cognome
            ELSE x.sogg_deleg_cognome
        END AS scrittore_cognome,
        CASE
            WHEN (x.sogg_deleg_nome = ''::text) THEN x.legale_rappr_nome
            ELSE x.sogg_deleg_nome
        END AS scrittore_nome,
    x.cod_fiscale_originatore,
    x.cognome_soggetto_originatore,
    x.nome_soggetto_originatore
   FROM ( SELECT fd.id_domanda,
            dom.dt_invio_domanda,
            di.id_documento_index,
            findom_t_sportelli_bandi.id_bando,
            b.tipo_firma,
            b.tipologia_verifica_firma,
            b.flag_verifica_firma,
            di.uuid_nodo,
            di.nome_file,
            sdi.descrizione AS stato_documento,
            to_char(di.dt_verifica_firma, 'DD/MM/YYYY HH24:MI:SS'::text) AS data_verifica_firma,
            to_char(di.dt_marca_temporale, 'DD/MM/YYYY HH24:MI:SS'::text) AS data_marca_temporale,
            to_char(dp.dt_classificazione, 'DD/MM/YYYY HH24:MI:SS'::text) AS data_classificazione,
            to_char(dp.dt_protocollo, 'DD/MM/YYYY HH24:MI:SS'::text) AS data_protocollo,
                CASE
                    WHEN (dp.dt_protocollo IS NOT NULL) THEN 'PROTOCOLLATO'::text
                    WHEN (dp.dt_classificazione IS NOT NULL) THEN 'DA_PROTOCOLLARE'::text
                    WHEN (di_dom.dt_marca_temporale IS NOT NULL) THEN 'DA_CLASSIFICARE'::text
                    WHEN (((di.dt_verifica_firma IS NOT NULL) OR (b.tipo_firma = 'S'::bpchar)) AND (di.id_allegato IS NULL)) THEN 'DA_MARCARE_TEMPORALMENTE'::text
                    WHEN ((sdi.descr_breve)::text = 'DIF'::text) THEN 'FUORI SISTEMA'::text
                    ELSE 'DA_VALIDARE_FIRMA'::text
                END AS azione,
            di.id_allegato,
                CASE
                    WHEN (di.id_allegato IS NULL) THEN 'DOMANDA'::character varying
                    ELSE al.descrizione
                END AS tipo_allegato,
                CASE
                    WHEN (di.id_allegato IS NULL) THEN COALESCE(ta.totale_allegati, (0)::bigint)
                    ELSE NULL::bigint
                END AS totale_allegati,
            s.codice AS codice_settore,
            s.descrizione AS descrizione_settore,
            d.codice AS codice_direzione,
            d.descrizione AS descrizione_direzione,
                CASE
                    WHEN ((e.dest_file_domanda)::text = ANY (ARRAY['REGIONE'::text, 'REGIONE_FINPIS'::text])) THEN 'S'::text
                    ELSE 'N'::text
                END AS flag_regionale,
                CASE
                    WHEN ((e.dest_file_domanda)::text = ANY (ARRAY['FINPIEMONTE'::text, 'FINPIEMONTE_SIFPL'::text, 'REGIONE_FINPIS'::text])) THEN 'S'::text
                    ELSE 'N'::text
                END AS flag_finpiemonte,
            e.dest_file_domanda,
            COALESCE(di.flag_trasm_dest, 'N'::bpchar) AS flag_trasm_dest,
                CASE
                    WHEN ((b.flag_dupl_parola_chiave_acta)::text = 'S'::text) THEN (((b.parola_chiave_acta)::text || tb.flag_pubblico_privato))::character varying
                    ELSE b.parola_chiave_acta
                END AS parola_chiave_acta,
            dom.fascicolo_acta,
            dom.sottofascicolo_acta,
            b.cod_nodo_operativo,
            sog.cod_fiscale AS cod_fiscale_beneficiario,
            sog.denominazione AS denominazione_beneficiario,
            dp.classificazione_acta,
            replace(replace((xpath('/tree-map/_legaleRappresentante/map/codiceFiscale/text()'::text, m.serialized_model))::text, '{'::text, ''::text), '}'::text, ''::text) AS legale_rappr_codice_fiscale,
            replace(replace(replace((xpath('/tree-map/_legaleRappresentante/map/cognome/text()'::text, m.serialized_model))::text, '{'::text, ''::text), '}'::text, ''::text), '"'::text, ''::text) AS legale_rappr_cognome,
            replace(replace(replace((xpath('/tree-map/_legaleRappresentante/map/nome/text()'::text, m.serialized_model))::text, '{'::text, ''::text), '}'::text, ''::text), '"'::text, ''::text) AS legale_rappr_nome,
            replace(replace(replace((xpath('/tree-map/_legaleRappresentante/map/indirizzo/text()'::text, m.serialized_model))::text, '{'::text, ''::text), '}'::text, ''::text), '"'::text, ''::text) AS legale_rappr_indirizzo,
            replace(replace((xpath('/tree-map/_soggettoDelegato/map/codiceFiscale/text()'::text, m.serialized_model))::text, '{'::text, ''::text), '}'::text, ''::text) AS sogg_deleg_codice_fiscale,
            replace(replace(replace((xpath('/tree-map/_soggettoDelegato/map/cognome/text()'::text, m.serialized_model))::text, '{'::text, ''::text), '}'::text, ''::text), '"'::text, ''::text) AS sogg_deleg_cognome,
            replace(replace(replace((xpath('/tree-map/_soggettoDelegato/map/nome/text()'::text, m.serialized_model))::text, '{'::text, ''::text), '}'::text, ''::text), '"'::text, ''::text) AS sogg_deleg_nome,
            replace(replace(replace((xpath('/tree-map/_soggettoDelegato/map/indirizzo/text()'::text, m.serialized_model))::text, '{'::text, ''::text), '}'::text, ''::text), '"'::text, ''::text) AS sogg_deleg_indirizzo,
            si.cod_fiscale AS cod_fiscale_originatore,
            si.cognome AS cognome_soggetto_originatore,
            si.nome AS nome_soggetto_originatore
           FROM (((((((((((((((((findom_os.shell_t_file_domande fd
             JOIN findom_os.shell_t_domande dom ON ((dom.id_domanda = fd.id_domanda)))
             JOIN findom_os.findom_d_tipol_beneficiari tb ON ((tb.id_tipol_beneficiario = dom.id_tipol_beneficiario)))
             JOIN findom_os.aggr_t_model m ON ((m.model_id = dom.id_domanda)))
             JOIN findom_os.shell_t_documento_index di_dom ON (((di_dom.id_domanda = dom.id_domanda) AND (di_dom.id_allegato IS NULL))))
             LEFT JOIN findom_os.shell_t_documento_prot dp_dom ON ((dp_dom.id_documento_index = di_dom.id_documento_index)))
             JOIN findom_os.shell_t_soggetti sog ON ((sog.id_soggetto = dom.id_soggetto_beneficiario)))
             LEFT JOIN findom_os.shell_t_soggetti si ON ((si.id_soggetto = dom.id_soggetto_invio)))
             JOIN findom_os.findom_t_sportelli_bandi USING (id_sportello_bando))
             JOIN findom_os.findom_t_bandi b USING (id_bando))
             JOIN findom_os.findom_d_enti e ON ((b.id_ente_destinatario = e.id_ente)))
             JOIN findom_os.findom_d_settori s USING (id_settore))
             JOIN findom_os.findom_d_direzioni d USING (id_direzione))
             LEFT JOIN findom_os.shell_t_documento_index di ON ((di.id_domanda = dom.id_domanda)))
             JOIN findom_os.findom_d_stato_documento_index sdi ON ((sdi.id_stato_documento_index = di.id_stato_documento_index)))
             LEFT JOIN findom_os.shell_t_documento_prot dp ON ((dp.id_documento_index = di.id_documento_index)))
             LEFT JOIN findom_os.findom_d_allegati al ON ((al.id_allegato = di.id_allegato)))
             LEFT JOIN ( SELECT shell_t_documento_index.id_domanda,
                    count(*) AS totale_allegati
                   FROM findom_os.shell_t_documento_index
                  WHERE ((shell_t_documento_index.id_allegato IS NOT NULL) AND ((shell_t_documento_index.uuid_nodo)::text <> ''::text))
                  GROUP BY shell_t_documento_index.id_domanda) ta ON ((dom.id_domanda = ta.id_domanda)))
          WHERE ((b.flag_demat = 'S'::bpchar) AND ((di.uuid_nodo)::text <> ''::text))
          ORDER BY di.id_domanda, COALESCE(di.id_allegato, 0)) x;


ALTER TABLE findom_os.findom_v_doc_demat_batch OWNER TO findom_os;


--
-- TOC entry 16278 (class 1259 OID 31176005)
-- Name: findom_v_domande; Type: VIEW; Schema: findom_os; Owner: findom_os
--

CREATE VIEW findom_os.findom_v_domande AS
 SELECT d.id_domanda,
    ms.model_state AS cod_stato_domanda,
    ms.model_state_descr AS stato_domanda,
    sis.codice AS cod_stato_istruttoria_new,
    sis.descrizione AS stato_istruttoria_new,
    ims.model_state AS cod_stato_istruttoria,
    ims.model_state_descr AS stato_istruttoria,
    funz.id_funzionario AS id_istruttore_amm,
    funz.cod_fiscale AS codice_fiscale_istruttore_amm,
    funz.cognome AS cognome_istruttore_amm,
    funz.nome AS nome_istruttore_amm,
    decis.id_funzionario AS id_decisore,
    decis.cod_fiscale AS codice_fiscale_decisore,
    decis.cognome AS cognome_decisore,
    decis.nome AS nome_decisore,
    dp.num_protocollo AS numero_protocollo,
    to_char(dp.dt_protocollo, 'DD/MM/YYYY HH24:MI'::text) AS data_protocollo,
    dp.classificazione_acta,
    to_char(dp.dt_classificazione, 'DD/MM/YYYY HH24:MI'::text) AS data_classificazione,
    tb.id_tipol_beneficiario,
    tb.descrizione AS descrizione_tipol_beneficiario,
    tb.codice AS codice_tipol_beneficiario,
        CASE
            WHEN (tb.flag_pubblico_privato = (1)::numeric) THEN 'Privato'::text
            WHEN (tb.flag_pubblico_privato = (2)::numeric) THEN 'Pubblico'::text
            ELSE NULL::text
        END AS tipo_ente_beneficiario,
    tb.cod_stereotipo,
    st.descr_stereotipo,
    tb.flag_pubblico_privato,
    d.id_soggetto_creatore,
    sc.cognome AS cognome_soggetto_creatore,
    sc.nome AS nome_soggetto_creatore,
    to_char(d.dt_creazione, 'DD/MM/YYYY HH24:MI'::text) AS dt_creazione_domanda,
    d.id_soggetto_conclusione,
    sl.cognome AS cognome_soggetto_conclusione,
    sl.nome AS nome_soggetto_conclusione,
    to_char(d.dt_conclusione, 'DD/MM/YYYY HH24:MI'::text) AS dt_conclusione,
    d.id_soggetto_invio,
    si.cognome AS cognome_soggetto_invio,
    si.nome AS nome_soggetto_invio,
    to_char(d.dt_invio_domanda, 'DD/MM/YYYY HH24:MI'::text) AS dt_invio_domanda,
    d.id_soggetto_beneficiario,
    sb.denominazione AS denominazione_soggetto_beneficiario,
    sb.cod_fiscale AS cod_fiscale_beneficiario,
    sb.sigla_nazione,
    sp.id_sportello_bando,
    sp.num_atto,
    sp.dt_atto,
    to_char(sp.dt_apertura, 'DD/MM/YYYY HH24:MI'::text) AS dt_apertura_sportello,
    to_char(sp.dt_chiusura, 'DD/MM/YYYY HH24:MI'::text) AS dt_chiusura_sportello,
    sp.id_bando,
    b.flag_demat,
    b.tipo_firma,
    b.descrizione AS descr_bando,
    b.flag_progetti_comuni,
    (((az.codice)::text || ' - '::text) || (b.descr_breve)::text) AS descr_breve_bando,
    b.id_ente_destinatario AS id_ente,
    n.id_normativa,
    n.descr_breve AS normativa,
    ap.id_classificazione AS id_classificazione_asse_prioritario,
    ap.codice AS codice_asse_prioritario,
    ap.descrizione AS descrizione_asse_prioritario,
    pi.id_classificazione AS id_classificazione_priorita_investimento,
    pi.codice AS codice_priorita_investimento,
    pi.descrizione AS descrizione_priorita_investimento,
    os.id_classificazione AS id_classificazione_misura,
    os.codice AS codice_misura,
    os.descrizione AS descrizione_misura,
    az.id_classificazione AS id_classificazione_azione,
    az.codice AS codice_azione,
    az.descrizione AS descrizione_azione,
        CASE
            WHEN ((e.dest_file_domanda)::text = 'REGIONE'::text) THEN 'REGIONE PIEMONTE'::character varying
            WHEN ((e.dest_file_domanda)::text = 'FINPIEMONTE'::text) THEN 'FINPIEMONTE S.p.A.'::character varying
            ELSE e.dest_file_domanda
        END AS destinatario_descrizione,
        CASE
            WHEN ((e.dest_file_domanda)::text = 'FINPIEMONTE'::text) THEN NULL::character varying
            ELSE e.descrizione
        END AS destinatario_direzione,
    e.indirizzo AS destinatario_indirizzo,
    e.cap AS destinatario_cap,
    e.descr_comune AS destinatario_citta,
    e.sigla_prov AS destinatario_provincia,
    e.pec AS destinatario_pec,
    (((((((n.descr_breve)::text || ' '::text) || (ap.codice)::text) || ' '::text) || (os.codice)::text) || '-'::text) || (b.descr_breve)::text) AS norma_incentivazione,
    ( SELECT string_agg((x.codice)::text, '-'::text) AS string_agg
           FROM ( SELECT b_1.id_bando,
                    a.codice
                   FROM findom_os.findom_d_tipol_interventi a,
                    findom_os.findom_r_bandi_tipol_interventi b_1
                  WHERE ((a.id_tipol_intervento = b_1.id_tipol_intervento) AND (b_1.id_bando = sp.id_bando))
                  ORDER BY a.codice) x
          GROUP BY x.id_bando) AS codice_intervento,
    ( SELECT string_agg(x.descrizione, ' - '::text) AS string_agg
           FROM ( SELECT b_1.id_bando,
                    a.descrizione
                   FROM findom_os.findom_d_tipol_interventi a,
                    findom_os.findom_r_bandi_tipol_interventi b_1
                  WHERE ((a.id_tipol_intervento = b_1.id_tipol_intervento) AND (b_1.id_bando = sp.id_bando))
                  ORDER BY a.codice) x
          GROUP BY x.id_bando) AS descrizione_intervento,
    at.id_area_tematica,
    at.descrizione AS descrizione_area_tematica
   FROM ((((((((((((((((((((((((findom_os.shell_t_domande d
     JOIN findom_os.aggr_t_model m ON ((m.model_id = d.id_domanda)))
     JOIN findom_os.aggr_d_model_state ms ON (((ms.model_state)::text = (m.model_state_fk)::text)))
     LEFT JOIN findom_os.istr_t_model i ON ((i.model_id = d.id_domanda)))
     LEFT JOIN findom_os.istr_d_model_state ims ON (((ims.model_state)::text = (i.model_state_fk)::text)))
     LEFT JOIN findom_os.findom_d_stato_istruttoria sis ON (((sis.id_stato_istr)::text = (d.id_stato_istr)::text)))
     LEFT JOIN findom_os.findom_d_funzionari funz ON ((funz.id_funzionario = d.id_istruttore_amm)))
     LEFT JOIN findom_os.findom_d_funzionari decis ON ((decis.id_funzionario = d.id_decisore)))
     JOIN findom_os.findom_d_tipol_beneficiari tb ON ((tb.id_tipol_beneficiario = d.id_tipol_beneficiario)))
     JOIN findom_os.findom_d_stereotipi st ON (((st.cod_stereotipo)::text = (tb.cod_stereotipo)::text)))
     JOIN findom_os.shell_t_soggetti sc ON ((sc.id_soggetto = d.id_soggetto_creatore)))
     JOIN findom_os.shell_t_soggetti sb ON ((sb.id_soggetto = d.id_soggetto_beneficiario)))
     LEFT JOIN findom_os.shell_t_soggetti si ON ((si.id_soggetto = d.id_soggetto_invio)))
     LEFT JOIN findom_os.shell_t_soggetti sl ON ((sl.id_soggetto = d.id_soggetto_conclusione)))
     LEFT JOIN findom_os.shell_t_documento_index di ON (((di.id_domanda = d.id_domanda) AND (di.id_allegato IS NULL))))
     LEFT JOIN findom_os.shell_t_documento_prot dp ON ((dp.id_documento_index = di.id_documento_index)))
     JOIN findom_os.findom_t_sportelli_bandi sp ON ((sp.id_sportello_bando = d.id_sportello_bando)))
     JOIN findom_os.findom_t_bandi b ON (((b.id_bando = sp.id_bando) AND (b.flag_nuova_gestione = false))))
     LEFT JOIN findom_os.findom_d_area_tematica at ON ((at.id_area_tematica = b.id_area_tematica)))
     JOIN findom_os.findom_d_enti e ON ((e.id_ente = b.id_ente_destinatario)))
     JOIN findom_os.findom_d_classif_bandi az ON (((az.id_classificazione = b.id_classificazione) AND (az.id_tipo_suddivisione = 5))))
     JOIN findom_os.findom_d_classif_bandi os ON (((az.id_classificazione_padre = os.id_classificazione) AND (os.id_tipo_suddivisione = 4))))
     JOIN findom_os.findom_d_classif_bandi pi ON (((os.id_classificazione_padre = pi.id_classificazione) AND (pi.id_tipo_suddivisione = 3))))
     JOIN findom_os.findom_d_classif_bandi ap ON (((pi.id_classificazione_padre = ap.id_classificazione) AND (ap.id_tipo_suddivisione = 1))))
     JOIN findom_os.findom_d_normative n ON ((n.id_normativa = ap.id_normativa)))
UNION ALL
 SELECT d.id_domanda,
    ms.model_state AS cod_stato_domanda,
    ms.model_state_descr AS stato_domanda,
    sis.codice AS cod_stato_istruttoria_new,
    sis.descrizione AS stato_istruttoria_new,
    ims.model_state AS cod_stato_istruttoria,
    ims.model_state_descr AS stato_istruttoria,
    funz.id_funzionario AS id_istruttore_amm,
    funz.cod_fiscale AS codice_fiscale_istruttore_amm,
    funz.cognome AS cognome_istruttore_amm,
    funz.nome AS nome_istruttore_amm,
    decis.id_funzionario AS id_decisore,
    decis.cod_fiscale AS codice_fiscale_decisore,
    decis.cognome AS cognome_decisore,
    decis.nome AS nome_decisore,
    dp.num_protocollo AS numero_protocollo,
    to_char(dp.dt_protocollo, 'DD/MM/YYYY HH24:MI'::text) AS data_protocollo,
    dp.classificazione_acta,
    to_char(dp.dt_classificazione, 'DD/MM/YYYY HH24:MI'::text) AS data_classificazione,
    tb.id_tipol_beneficiario,
    tb.descrizione AS descrizione_tipol_beneficiario,
    tb.codice AS codice_tipol_beneficiario,
        CASE
            WHEN (tb.flag_pubblico_privato = (1)::numeric) THEN 'Privato'::text
            WHEN (tb.flag_pubblico_privato = (2)::numeric) THEN 'Pubblico'::text
            ELSE NULL::text
        END AS tipo_ente_beneficiario,
    tb.cod_stereotipo,
    st.descr_stereotipo,
    tb.flag_pubblico_privato,
    d.id_soggetto_creatore,
    sc.cognome AS cognome_soggetto_creatore,
    sc.nome AS nome_soggetto_creatore,
    to_char(d.dt_creazione, 'DD/MM/YYYY HH24:MI'::text) AS dt_creazione_domanda,
    d.id_soggetto_conclusione,
    sl.cognome AS cognome_soggetto_conclusione,
    sl.nome AS nome_soggetto_conclusione,
    to_char(d.dt_conclusione, 'DD/MM/YYYY HH24:MI'::text) AS dt_conclusione,
    d.id_soggetto_invio,
    si.cognome AS cognome_soggetto_invio,
    si.nome AS nome_soggetto_invio,
    to_char(d.dt_invio_domanda, 'DD/MM/YYYY HH24:MI'::text) AS dt_invio_domanda,
    d.id_soggetto_beneficiario,
    sb.denominazione AS denominazione_soggetto_beneficiario,
    sb.cod_fiscale AS cod_fiscale_beneficiario,
    sb.sigla_nazione,
    sp.id_sportello_bando,
    sp.num_atto,
    sp.dt_atto,
    to_char(sp.dt_apertura, 'DD/MM/YYYY HH24:MI'::text) AS dt_apertura_sportello,
    to_char(sp.dt_chiusura, 'DD/MM/YYYY HH24:MI'::text) AS dt_chiusura_sportello,
    sp.id_bando,
    b.flag_demat,
    b.tipo_firma,
    b.descrizione AS descr_bando,
    b.flag_progetti_comuni,
    (((az.codice)::text || ' - '::text) || (b.descr_breve)::text) AS descr_breve_bando,
    b.id_ente_destinatario AS id_ente,
    n.id_normativa,
    n.descr_breve AS normativa,
    ap.id_classificazione AS id_classificazione_asse_prioritario,
    ap.codice AS codice_asse_prioritario,
    ap.descrizione AS descrizione_asse_prioritario,
    NULL::integer AS id_classificazione_priorita_investimento,
    NULL::character varying AS codice_priorita_investimento,
    NULL::character varying AS descrizione_priorita_investimento,
    os.id_classificazione AS id_classificazione_misura,
    os.codice AS codice_misura,
    os.descrizione AS descrizione_misura,
    az.id_classificazione AS id_classificazione_azione,
    az.codice AS codice_azione,
    az.descrizione AS descrizione_azione,
        CASE
            WHEN ((e.dest_file_domanda)::text = 'REGIONE'::text) THEN 'REGIONE PIEMONTE'::character varying
            WHEN ((e.dest_file_domanda)::text = 'FINPIEMONTE'::text) THEN 'FINPIEMONTE S.p.A.'::character varying
            ELSE e.dest_file_domanda
        END AS destinatario_descrizione,
        CASE
            WHEN ((e.dest_file_domanda)::text = 'FINPIEMONTE'::text) THEN NULL::character varying
            ELSE e.descrizione
        END AS destinatario_direzione,
    e.indirizzo AS destinatario_indirizzo,
    e.cap AS destinatario_cap,
    e.descr_comune AS destinatario_citta,
    e.sigla_prov AS destinatario_provincia,
    e.pec AS destinatario_pec,
    (((((((n.descr_breve)::text || ' '::text) || (ap.codice)::text) || ' '::text) || (os.codice)::text) || '-'::text) || (b.descr_breve)::text) AS norma_incentivazione,
    ( SELECT string_agg((x.codice)::text, '-'::text) AS string_agg
           FROM ( SELECT b_1.id_bando,
                    a.codice
                   FROM findom_os.findom_d_tipol_interventi a,
                    findom_os.findom_r_bandi_tipol_interventi b_1
                  WHERE ((a.id_tipol_intervento = b_1.id_tipol_intervento) AND (b_1.id_bando = sp.id_bando))
                  ORDER BY a.codice) x
          GROUP BY x.id_bando) AS codice_intervento,
    ( SELECT string_agg(x.descrizione, ' - '::text) AS string_agg
           FROM ( SELECT b_1.id_bando,
                    a.descrizione
                   FROM findom_os.findom_d_tipol_interventi a,
                    findom_os.findom_r_bandi_tipol_interventi b_1
                  WHERE ((a.id_tipol_intervento = b_1.id_tipol_intervento) AND (b_1.id_bando = sp.id_bando))
                  ORDER BY a.codice) x
          GROUP BY x.id_bando) AS descrizione_intervento,
    at.id_area_tematica,
    at.descrizione AS descrizione_area_tematica
   FROM (((((((((((((((((((((((findom_os.shell_t_domande d
     JOIN findom_os.aggr_t_model m ON ((m.model_id = d.id_domanda)))
     JOIN findom_os.aggr_d_model_state ms ON (((ms.model_state)::text = (m.model_state_fk)::text)))
     LEFT JOIN findom_os.istr_t_model i ON ((i.model_id = d.id_domanda)))
     LEFT JOIN findom_os.istr_d_model_state ims ON (((ims.model_state)::text = (i.model_state_fk)::text)))
     LEFT JOIN findom_os.findom_d_stato_istruttoria sis ON (((sis.id_stato_istr)::text = (d.id_stato_istr)::text)))
     LEFT JOIN findom_os.findom_d_funzionari funz ON ((funz.id_funzionario = d.id_istruttore_amm)))
     LEFT JOIN findom_os.findom_d_funzionari decis ON ((decis.id_funzionario = d.id_decisore)))
     JOIN findom_os.findom_d_tipol_beneficiari tb ON ((tb.id_tipol_beneficiario = d.id_tipol_beneficiario)))
     JOIN findom_os.findom_d_stereotipi st ON (((st.cod_stereotipo)::text = (tb.cod_stereotipo)::text)))
     JOIN findom_os.shell_t_soggetti sc ON ((sc.id_soggetto = d.id_soggetto_creatore)))
     JOIN findom_os.shell_t_soggetti sb ON ((sb.id_soggetto = d.id_soggetto_beneficiario)))
     LEFT JOIN findom_os.shell_t_soggetti si ON ((si.id_soggetto = d.id_soggetto_invio)))
     LEFT JOIN findom_os.shell_t_soggetti sl ON ((sl.id_soggetto = d.id_soggetto_conclusione)))
     LEFT JOIN findom_os.shell_t_documento_index di ON (((di.id_domanda = d.id_domanda) AND (di.id_allegato IS NULL))))
     LEFT JOIN findom_os.shell_t_documento_prot dp ON ((dp.id_documento_index = di.id_documento_index)))
     JOIN findom_os.findom_t_sportelli_bandi sp ON ((sp.id_sportello_bando = d.id_sportello_bando)))
     JOIN findom_os.findom_t_bandi b ON (((b.id_bando = sp.id_bando) AND (b.flag_nuova_gestione = false))))
     LEFT JOIN findom_os.findom_d_area_tematica at ON ((at.id_area_tematica = b.id_area_tematica)))
     JOIN findom_os.findom_d_enti e ON ((e.id_ente = b.id_ente_destinatario)))
     JOIN findom_os.findom_d_classif_bandi az ON (((az.id_classificazione = b.id_classificazione) AND (az.id_tipo_suddivisione = 5))))
     JOIN findom_os.findom_d_classif_bandi os ON (((az.id_classificazione_padre = os.id_classificazione) AND (os.id_tipo_suddivisione = 4))))
     JOIN findom_os.findom_d_classif_bandi ap ON (((os.id_classificazione_padre = ap.id_classificazione) AND (ap.id_tipo_suddivisione = 1))))
     JOIN findom_os.findom_d_normative n ON ((n.id_normativa = ap.id_normativa)));


ALTER TABLE findom_os.findom_v_domande OWNER TO findom_os;

--
-- TOC entry 16279 (class 1259 OID 31176010)
-- Name: findom_v_domande2; Type: VIEW; Schema: findom_os; Owner: findom_os
--

CREATE VIEW findom_os.findom_v_domande2 AS
 SELECT d.id_domanda,
        CASE
            WHEN ((m.serialized_model)::text = '<tree-map/>'::text) THEN 'SI'::character varying
            ELSE 'NO'::character varying
        END AS domanda_vuota,
    ms.model_state AS cod_stato_domanda,
    ms.model_state_descr AS stato_domanda,
    (((az.codice)::text || ' - '::text) || (b.descr_breve)::text) AS descr_breve_bando,
    tb.id_tipol_beneficiario,
    tb.descrizione AS descrizione_tipol_beneficiario,
        CASE
            WHEN (tb.flag_pubblico_privato = (1)::numeric) THEN 'Privato'::text
            WHEN (tb.flag_pubblico_privato = (2)::numeric) THEN 'Pubblico'::text
            ELSE NULL::text
        END AS tipo_ente_beneficiario,
    tb.cod_stereotipo,
    st.descr_stereotipo,
    tb.flag_pubblico_privato,
    d.id_soggetto_creatore,
    sc.cognome AS cognome_soggetto_creatore,
    sc.nome AS nome_soggetto_creatore,
    sc.cod_fiscale AS cod_fiscale_soggetto_creatore,
    to_char(d.dt_creazione, 'DD/MM/YYYY HH24hMI'::text) AS dt_creazione_domanda,
    d.id_soggetto_invio,
    si.cognome AS cognome_soggetto_invio,
    si.nome AS nome_soggetto_invio,
    si.cod_fiscale AS cod_fiscale_soggetto_invio,
    to_char(d.dt_invio_domanda, 'DD/MM/YYYY HH24hMI'::text) AS dt_invio_domanda,
    to_char(fd.dt_invio_file, 'DD/MM/YYYY HH24hMI'::text) AS dt_invio_file_xml,
    d.id_soggetto_beneficiario,
    sb.denominazione AS denominazione_soggetto_beneficiario,
    sb.cod_fiscale AS cod_fiscale_soggetto_beneficiario,
    replace(replace(replace((xpath('/tree-map/_operatorePresentatore/map/descrizioneAteco2007/text()'::text, m.serialized_model))::text, '{'::text, ''::text), '}'::text, ''::text), '"'::text, ''::text) AS descrizione_impresa,
    replace(replace((xpath('/tree-map/_operatorePresentatore/map/partitaIva/text()'::text, m.serialized_model))::text, '{'::text, ''::text), '}'::text, ''::text) AS partita_iva,
    replace(replace((xpath('/tree-map/_operatorePresentatore/map/indirizzoPec/text()'::text, m.serialized_model))::text, '{'::text, ''::text), '}'::text, ''::text) AS indirizzo_pec,
    replace(replace((xpath('/tree-map/_estremiBancari/map/iban/text()'::text, m.serialized_model))::text, '{'::text, ''::text), '}'::text, ''::text) AS iban,
    replace(replace((xpath('/tree-map/_estremiBancari/map/bic/text()'::text, m.serialized_model))::text, '{'::text, ''::text), '}'::text, ''::text) AS bic,
    replace(replace((xpath('/tree-map/_sedeLegale/map/statoEstero/text()'::text, m.serialized_model))::text, '{'::text, ''::text), '}'::text, ''::text) AS sede_legale_stato_estero,
    replace(replace((xpath('/tree-map/_sedeLegale/map/cittaEstera/text()'::text, m.serialized_model))::text, '{'::text, ''::text), '}'::text, ''::text) AS sede_legale_citta_estera,
    replace(replace((xpath('/tree-map/_sedeLegale/map/comuneDescrizione/text()'::text, m.serialized_model))::text, '{'::text, ''::text), '}'::text, ''::text) AS sede_legale_comune,
    replace(replace((xpath('/tree-map/_sedeLegale/map/provinciaSigla/text()'::text, m.serialized_model))::text, '{'::text, ''::text), '}'::text, ''::text) AS sede_legale_provincia,
    replace(replace((xpath('/tree-map/_sedeLegale/map/cap/text()'::text, m.serialized_model))::text, '{'::text, ''::text), '}'::text, ''::text) AS sede_legale_cap,
    replace(replace((xpath('/tree-map/_sedeLegale/map/numCivico/text()'::text, m.serialized_model))::text, '{'::text, ''::text), '}'::text, ''::text) AS sede_legale_num_civico,
    replace(replace(replace((xpath('/tree-map/_sedeLegale/map/indirizzo/text()'::text, m.serialized_model))::text, '{'::text, ''::text), '}'::text, ''::text), '"'::text, ''::text) AS sede_legale_indirizzo,
    replace(replace((xpath('/tree-map/_riferimenti/map/personaImpresa/map/cognome/text()'::text, m.serialized_model))::text, '{'::text, ''::text), '}'::text, ''::text) AS contatto_regione_cognome,
    replace(replace((xpath('/tree-map/_riferimenti/map/personaImpresa/map/nome/text()'::text, m.serialized_model))::text, '{'::text, ''::text), '}'::text, ''::text) AS contatto_regione_nome,
    replace(replace((xpath('/tree-map/_riferimenti/map/personaImpresa/map/telefono/text()'::text, m.serialized_model))::text, '{'::text, ''::text), '}'::text, ''::text) AS contatto_regione_telefono,
    replace(replace((xpath('/tree-map/_riferimenti/map/personaImpresa/map/email/text()'::text, m.serialized_model))::text, '{'::text, ''::text), '}'::text, ''::text) AS contatto_regione_email,
    replace(replace((xpath('/tree-map/_legaleRappresentante/map/codiceFiscale/text()'::text, m.serialized_model))::text, '{'::text, ''::text), '}'::text, ''::text) AS legale_rappr_codice_fiscale,
    replace(replace(replace((xpath('/tree-map/_legaleRappresentante/map/cognome/text()'::text, m.serialized_model))::text, '{'::text, ''::text), '}'::text, ''::text), '"'::text, ''::text) AS legale_rappr_cognome,
    replace(replace(replace((xpath('/tree-map/_legaleRappresentante/map/nome/text()'::text, m.serialized_model))::text, '{'::text, ''::text), '}'::text, ''::text), '"'::text, ''::text) AS legale_rappr_nome,
    replace(replace(replace((xpath('/tree-map/_legaleRappresentante/map/indirizzo/text()'::text, m.serialized_model))::text, '{'::text, ''::text), '}'::text, ''::text), '"'::text, ''::text) AS legale_rappr_indirizzo,
    replace(replace((xpath('/tree-map/_legaleRappresentante/map/numCivico/text()'::text, m.serialized_model))::text, '{'::text, ''::text), '}'::text, ''::text) AS legale_rappr_civico,
    replace(replace((xpath('/tree-map/_legaleRappresentante/map/cap/text()'::text, m.serialized_model))::text, '{'::text, ''::text), '}'::text, ''::text) AS legale_rappr_cap,
    replace(replace((xpath('/tree-map/_legaleRappresentante/map/comuneResidenzaDescrizione/text()'::text, m.serialized_model))::text, '{'::text, ''::text), '}'::text, ''::text) AS legale_rappr_comune_resid,
    replace(replace((xpath('/tree-map/_legaleRappresentante/map/provinciaResidenzaDescrizione/text()'::text, m.serialized_model))::text, '{'::text, ''::text), '}'::text, ''::text) AS legale_rappr_prov_resid,
    fg.descr_forma_giuridica,
    sp.id_sportello_bando,
    sp.num_atto,
    sp.dt_atto,
    to_char(sp.dt_apertura, 'DD/MM/YYYY HH24hMI'::text) AS dt_apertura_sportello,
    to_char(sp.dt_chiusura, 'DD/MM/YYYY HH24hMI'::text) AS dt_chiusura_sportello,
    sp.id_bando,
    b.descrizione AS descr_bando,
    n.id_normativa,
    n.descr_breve AS normativa,
    ap.id_classificazione AS id_classificazione_asse_prioritario,
    ap.codice AS codice_asse_prioritario,
    ap.descrizione AS descrizione_asse_prioritario,
    pi.id_classificazione AS id_classificazione_priorita_investimento,
    pi.codice AS codice_priorita_investimento,
    pi.descrizione AS descrizione_priorita_investimento,
    os.id_classificazione AS id_classificazione_misura,
    os.codice AS codice_misura,
    os.descrizione AS descrizione_misura,
    az.id_classificazione AS id_classificazione_azione,
    az.codice AS codice_azione,
    az.descrizione AS descrizione_azione,
        CASE
            WHEN ((e.dest_file_domanda)::text = 'REGIONE'::text) THEN 'REGIONE PIEMONTE'::character varying
            WHEN ((e.dest_file_domanda)::text = 'FINPIEMONTE'::text) THEN 'FINPIEMONTE S.p.A.'::character varying
            ELSE e.dest_file_domanda
        END AS destinatario_descrizione,
        CASE
            WHEN ((e.dest_file_domanda)::text = 'FINPIEMONTE'::text) THEN NULL::character varying
            ELSE e.descrizione
        END AS destinatario_direzione,
    e.indirizzo AS destinatario_indirizzo,
    e.cap AS destinatario_cap,
    e.descr_comune AS destinatario_citta,
    e.sigla_prov AS destinatario_provincia,
    e.pec AS destinatario_pec,
    (((((((n.descr_breve)::text || ' '::text) || (ap.codice)::text) || ' '::text) || (os.codice)::text) || '-'::text) || (b.descr_breve)::text) AS norma_incentivazione,
    ( SELECT string_agg((x.codice)::text, '-'::text) AS string_agg
           FROM ( SELECT b_1.id_bando,
                    a.codice
                   FROM findom_os.findom_d_tipol_interventi a,
                    findom_os.findom_r_bandi_tipol_interventi b_1
                  WHERE ((a.id_tipol_intervento = b_1.id_tipol_intervento) AND (b_1.id_bando = sp.id_bando))
                  ORDER BY a.codice) x
          GROUP BY x.id_bando) AS codice_intervento,
    ( SELECT string_agg(x.descrizione, ' - '::text) AS string_agg
           FROM ( SELECT b_1.id_bando,
                    a.descrizione
                   FROM findom_os.findom_d_tipol_interventi a,
                    findom_os.findom_r_bandi_tipol_interventi b_1
                  WHERE ((a.id_tipol_intervento = b_1.id_tipol_intervento) AND (b_1.id_bando = sp.id_bando))
                  ORDER BY a.codice) x
          GROUP BY x.id_bando) AS descrizione_intervento,
    replace(replace((xpath('/tree-map/_abstractProgetto/map/acronimo/text()'::text, m.serialized_model))::text, '{'::text, ''::text), '}'::text, ''::text) AS acronimo,
    replace(replace(replace((xpath('/tree-map/_pianoSpese/map/totale/text()'::text, m.serialized_model))::text, '{'::text, ''::text), '}'::text, ''::text), '"'::text, ''::text) AS totale_spese,
    replace(replace(replace((xpath('/tree-map/_formaFinanziamento/map/importoRichiesto/text()'::text, m.serialized_model))::text, '{'::text, ''::text), '}'::text, ''::text), '"'::text, ''::text) AS importo_richiesto,
    replace(replace(replace((xpath('/tree-map/_formaFinanziamento/map/totContributoRichiesto/text()'::text, m.serialized_model))::text, '{'::text, ''::text), '}'::text, ''::text), '"'::text, ''::text) AS importo_contributo,
    replace(replace(replace((xpath('/tree-map/_formaFinanziamento/map/totFinanziamentoRichiesto/text()'::text, m.serialized_model))::text, '{'::text, ''::text), '}'::text, ''::text), '"'::text, ''::text) AS importo_finanziamento,
    replace(replace(replace((xpath('/tree-map/_abstractProgetto/map/poloAppartenenzaDescrizione/text()'::text, m.serialized_model))::text, '{'::text, ''::text), '}'::text, ''::text), '"'::text, ''::text) AS polo_appartenenza,
    replace(replace((xpath('/tree-map/_dimensioni/map/descrizioneDimensioneImpresa/text()'::text, m.serialized_model))::text, '{'::text, ''::text), '}'::text, ''::text) AS dimensione_impresa
   FROM (((((((((((((((((findom_os.shell_t_domande d
     JOIN findom_os.aggr_t_model m ON ((m.model_id = d.id_domanda)))
     JOIN findom_os.aggr_d_model_state ms ON (((ms.model_state)::text = (m.model_state_fk)::text)))
     JOIN findom_os.findom_d_tipol_beneficiari tb ON ((tb.id_tipol_beneficiario = d.id_tipol_beneficiario)))
     JOIN findom_os.findom_d_stereotipi st ON (((st.cod_stereotipo)::text = (tb.cod_stereotipo)::text)))
     JOIN findom_os.shell_t_soggetti sc ON ((sc.id_soggetto = d.id_soggetto_creatore)))
     JOIN findom_os.shell_t_soggetti sb ON ((sb.id_soggetto = d.id_soggetto_beneficiario)))
     LEFT JOIN findom_os.ext_d_forme_giuridiche fg ON ((fg.id_forma_giuridica = sb.id_forma_giuridica)))
     LEFT JOIN findom_os.shell_t_soggetti si ON ((si.id_soggetto = d.id_soggetto_invio)))
     LEFT JOIN findom_os.shell_t_file_domande fd ON ((fd.id_domanda = d.id_domanda)))
     JOIN findom_os.findom_t_sportelli_bandi sp ON ((sp.id_sportello_bando = d.id_sportello_bando)))
     JOIN findom_os.findom_t_bandi b ON ((b.id_bando = sp.id_bando)))
     JOIN findom_os.findom_d_enti e ON ((e.id_ente = b.id_ente_destinatario)))
     JOIN findom_os.findom_d_classif_bandi az ON (((az.id_classificazione = b.id_classificazione) AND (az.id_tipo_suddivisione = 5))))
     JOIN findom_os.findom_d_classif_bandi os ON (((az.id_classificazione_padre = os.id_classificazione) AND (os.id_tipo_suddivisione = 4))))
     JOIN findom_os.findom_d_classif_bandi pi ON (((os.id_classificazione_padre = pi.id_classificazione) AND (pi.id_tipo_suddivisione = 3))))
     JOIN findom_os.findom_d_classif_bandi ap ON (((pi.id_classificazione_padre = ap.id_classificazione) AND (ap.id_tipo_suddivisione = 1))))
     JOIN findom_os.findom_d_normative n ON ((n.id_normativa = ap.id_normativa)))
UNION ALL
 SELECT d.id_domanda,
        CASE
            WHEN ((m.serialized_model)::text = '<tree-map/>'::text) THEN 'SI'::character varying
            ELSE 'NO'::character varying
        END AS domanda_vuota,
    ms.model_state AS cod_stato_domanda,
    ms.model_state_descr AS stato_domanda,
    (((az.codice)::text || ' - '::text) || (b.descr_breve)::text) AS descr_breve_bando,
    tb.id_tipol_beneficiario,
    tb.descrizione AS descrizione_tipol_beneficiario,
        CASE
            WHEN (tb.flag_pubblico_privato = (1)::numeric) THEN 'Privato'::text
            WHEN (tb.flag_pubblico_privato = (2)::numeric) THEN 'Pubblico'::text
            ELSE NULL::text
        END AS tipo_ente_beneficiario,
    tb.cod_stereotipo,
    st.descr_stereotipo,
    tb.flag_pubblico_privato,
    d.id_soggetto_creatore,
    sc.cognome AS cognome_soggetto_creatore,
    sc.nome AS nome_soggetto_creatore,
    sc.cod_fiscale AS cod_fiscale_soggetto_creatore,
    to_char(d.dt_creazione, 'DD/MM/YYYY HH24hMI'::text) AS dt_creazione_domanda,
    d.id_soggetto_invio,
    si.cognome AS cognome_soggetto_invio,
    si.nome AS nome_soggetto_invio,
    si.cod_fiscale AS cod_fiscale_soggetto_invio,
    to_char(d.dt_invio_domanda, 'DD/MM/YYYY HH24hMI'::text) AS dt_invio_domanda,
    to_char(fd.dt_invio_file, 'DD/MM/YYYY HH24hMI'::text) AS dt_invio_file_xml,
    d.id_soggetto_beneficiario,
    sb.denominazione AS denominazione_soggetto_beneficiario,
    sb.cod_fiscale AS cod_fiscale_soggetto_beneficiario,
    replace(replace(replace((xpath('/tree-map/_operatorePresentatore/map/descrizioneAteco2007/text()'::text, m.serialized_model))::text, '{'::text, ''::text), '}'::text, ''::text), '"'::text, ''::text) AS descrizione_impresa,
    replace(replace((xpath('/tree-map/_operatorePresentatore/map/partitaIva/text()'::text, m.serialized_model))::text, '{'::text, ''::text), '}'::text, ''::text) AS partita_iva,
    replace(replace((xpath('/tree-map/_operatorePresentatore/map/indirizzoPec/text()'::text, m.serialized_model))::text, '{'::text, ''::text), '}'::text, ''::text) AS indirizzo_pec,
    replace(replace((xpath('/tree-map/_estremiBancari/map/iban/text()'::text, m.serialized_model))::text, '{'::text, ''::text), '}'::text, ''::text) AS iban,
    replace(replace((xpath('/tree-map/_estremiBancari/map/bic/text()'::text, m.serialized_model))::text, '{'::text, ''::text), '}'::text, ''::text) AS bic,
    replace(replace((xpath('/tree-map/_sedeLegale/map/statoEstero/text()'::text, m.serialized_model))::text, '{'::text, ''::text), '}'::text, ''::text) AS sede_legale_stato_estero,
    replace(replace((xpath('/tree-map/_sedeLegale/map/cittaEstera/text()'::text, m.serialized_model))::text, '{'::text, ''::text), '}'::text, ''::text) AS sede_legale_citta_estera,
    replace(replace((xpath('/tree-map/_sedeLegale/map/comuneDescrizione/text()'::text, m.serialized_model))::text, '{'::text, ''::text), '}'::text, ''::text) AS sede_legale_comune,
    replace(replace((xpath('/tree-map/_sedeLegale/map/provinciaSigla/text()'::text, m.serialized_model))::text, '{'::text, ''::text), '}'::text, ''::text) AS sede_legale_provincia,
    replace(replace((xpath('/tree-map/_sedeLegale/map/cap/text()'::text, m.serialized_model))::text, '{'::text, ''::text), '}'::text, ''::text) AS sede_legale_cap,
    replace(replace((xpath('/tree-map/_sedeLegale/map/numCivico/text()'::text, m.serialized_model))::text, '{'::text, ''::text), '}'::text, ''::text) AS sede_legale_num_civico,
    replace(replace(replace((xpath('/tree-map/_sedeLegale/map/indirizzo/text()'::text, m.serialized_model))::text, '{'::text, ''::text), '}'::text, ''::text), '"'::text, ''::text) AS sede_legale_indirizzo,
    replace(replace((xpath('/tree-map/_riferimenti/map/personaImpresa/map/cognome/text()'::text, m.serialized_model))::text, '{'::text, ''::text), '}'::text, ''::text) AS contatto_regione_cognome,
    replace(replace((xpath('/tree-map/_riferimenti/map/personaImpresa/map/nome/text()'::text, m.serialized_model))::text, '{'::text, ''::text), '}'::text, ''::text) AS contatto_regione_nome,
    replace(replace((xpath('/tree-map/_riferimenti/map/personaImpresa/map/telefono/text()'::text, m.serialized_model))::text, '{'::text, ''::text), '}'::text, ''::text) AS contatto_regione_telefono,
    replace(replace((xpath('/tree-map/_riferimenti/map/personaImpresa/map/email/text()'::text, m.serialized_model))::text, '{'::text, ''::text), '}'::text, ''::text) AS contatto_regione_email,
    replace(replace((xpath('/tree-map/_legaleRappresentante/map/codiceFiscale/text()'::text, m.serialized_model))::text, '{'::text, ''::text), '}'::text, ''::text) AS legale_rappr_codice_fiscale,
    replace(replace(replace((xpath('/tree-map/_legaleRappresentante/map/cognome/text()'::text, m.serialized_model))::text, '{'::text, ''::text), '}'::text, ''::text), '"'::text, ''::text) AS legale_rappr_cognome,
    replace(replace(replace((xpath('/tree-map/_legaleRappresentante/map/nome/text()'::text, m.serialized_model))::text, '{'::text, ''::text), '}'::text, ''::text), '"'::text, ''::text) AS legale_rappr_nome,
    replace(replace(replace((xpath('/tree-map/_legaleRappresentante/map/indirizzo/text()'::text, m.serialized_model))::text, '{'::text, ''::text), '}'::text, ''::text), '"'::text, ''::text) AS legale_rappr_indirizzo,
    replace(replace((xpath('/tree-map/_legaleRappresentante/map/numCivico/text()'::text, m.serialized_model))::text, '{'::text, ''::text), '}'::text, ''::text) AS legale_rappr_civico,
    replace(replace((xpath('/tree-map/_legaleRappresentante/map/cap/text()'::text, m.serialized_model))::text, '{'::text, ''::text), '}'::text, ''::text) AS legale_rappr_cap,
    replace(replace((xpath('/tree-map/_legaleRappresentante/map/comuneResidenzaDescrizione/text()'::text, m.serialized_model))::text, '{'::text, ''::text), '}'::text, ''::text) AS legale_rappr_comune_resid,
    replace(replace((xpath('/tree-map/_legaleRappresentante/map/provinciaResidenzaDescrizione/text()'::text, m.serialized_model))::text, '{'::text, ''::text), '}'::text, ''::text) AS legale_rappr_prov_resid,
    fg.descr_forma_giuridica,
    sp.id_sportello_bando,
    sp.num_atto,
    sp.dt_atto,
    to_char(sp.dt_apertura, 'DD/MM/YYYY HH24hMI'::text) AS dt_apertura_sportello,
    to_char(sp.dt_chiusura, 'DD/MM/YYYY HH24hMI'::text) AS dt_chiusura_sportello,
    sp.id_bando,
    b.descrizione AS descr_bando,
    n.id_normativa,
    n.descr_breve AS normativa,
    ap.id_classificazione AS id_classificazione_asse_prioritario,
    ap.codice AS codice_asse_prioritario,
    ap.descrizione AS descrizione_asse_prioritario,
    NULL::integer AS id_classificazione_priorita_investimento,
    NULL::character varying AS codice_priorita_investimento,
    NULL::character varying AS descrizione_priorita_investimento,
    os.id_classificazione AS id_classificazione_misura,
    os.codice AS codice_misura,
    os.descrizione AS descrizione_misura,
    az.id_classificazione AS id_classificazione_azione,
    az.codice AS codice_azione,
    az.descrizione AS descrizione_azione,
        CASE
            WHEN ((e.dest_file_domanda)::text = 'REGIONE'::text) THEN 'REGIONE PIEMONTE'::character varying
            WHEN ((e.dest_file_domanda)::text = 'FINPIEMONTE'::text) THEN 'FINPIEMONTE S.p.A.'::character varying
            ELSE e.dest_file_domanda
        END AS destinatario_descrizione,
        CASE
            WHEN ((e.dest_file_domanda)::text = 'FINPIEMONTE'::text) THEN NULL::character varying
            ELSE e.descrizione
        END AS destinatario_direzione,
    e.indirizzo AS destinatario_indirizzo,
    e.cap AS destinatario_cap,
    e.descr_comune AS destinatario_citta,
    e.sigla_prov AS destinatario_provincia,
    e.pec AS destinatario_pec,
    (((((((n.descr_breve)::text || ' '::text) || (ap.codice)::text) || ' '::text) || (os.codice)::text) || '-'::text) || (b.descr_breve)::text) AS norma_incentivazione,
    ( SELECT string_agg((x.codice)::text, '-'::text) AS string_agg
           FROM ( SELECT b_1.id_bando,
                    a.codice
                   FROM findom_os.findom_d_tipol_interventi a,
                    findom_os.findom_r_bandi_tipol_interventi b_1
                  WHERE ((a.id_tipol_intervento = b_1.id_tipol_intervento) AND (b_1.id_bando = sp.id_bando))
                  ORDER BY a.codice) x
          GROUP BY x.id_bando) AS codice_intervento,
    ( SELECT string_agg(x.descrizione, ' - '::text) AS string_agg
           FROM ( SELECT b_1.id_bando,
                    a.descrizione
                   FROM findom_os.findom_d_tipol_interventi a,
                    findom_os.findom_r_bandi_tipol_interventi b_1
                  WHERE ((a.id_tipol_intervento = b_1.id_tipol_intervento) AND (b_1.id_bando = sp.id_bando))
                  ORDER BY a.codice) x
          GROUP BY x.id_bando) AS descrizione_intervento,
    replace(replace((xpath('/tree-map/_abstractProgetto/map/acronimo/text()'::text, m.serialized_model))::text, '{'::text, ''::text), '}'::text, ''::text) AS acronimo,
    replace(replace(replace((xpath('/tree-map/_pianoSpese/map/totale/text()'::text, m.serialized_model))::text, '{'::text, ''::text), '}'::text, ''::text), '"'::text, ''::text) AS totale_spese,
    replace(replace(replace((xpath('/tree-map/_formaFinanziamento/map/importoRichiesto/text()'::text, m.serialized_model))::text, '{'::text, ''::text), '}'::text, ''::text), '"'::text, ''::text) AS importo_richiesto,
    replace(replace(replace((xpath('/tree-map/_formaFinanziamento/map/totContributoRichiesto/text()'::text, m.serialized_model))::text, '{'::text, ''::text), '}'::text, ''::text), '"'::text, ''::text) AS importo_contributo,
    replace(replace(replace((xpath('/tree-map/_formaFinanziamento/map/totFinanziamentoRichiesto/text()'::text, m.serialized_model))::text, '{'::text, ''::text), '}'::text, ''::text), '"'::text, ''::text) AS importo_finanziamento,
    replace(replace(replace((xpath('/tree-map/_abstractProgetto/map/poloAppartenenzaDescrizione/text()'::text, m.serialized_model))::text, '{'::text, ''::text), '}'::text, ''::text), '"'::text, ''::text) AS polo_appartenenza,
    replace(replace((xpath('/tree-map/_dimensioni/map/descrizioneDimensioneImpresa/text()'::text, m.serialized_model))::text, '{'::text, ''::text), '}'::text, ''::text) AS dimensione_impresa
   FROM ((((((((((((((((findom_os.shell_t_domande d
     JOIN findom_os.aggr_t_model m ON ((m.model_id = d.id_domanda)))
     JOIN findom_os.aggr_d_model_state ms ON (((ms.model_state)::text = (m.model_state_fk)::text)))
     JOIN findom_os.findom_d_tipol_beneficiari tb ON ((tb.id_tipol_beneficiario = d.id_tipol_beneficiario)))
     JOIN findom_os.findom_d_stereotipi st ON (((st.cod_stereotipo)::text = (tb.cod_stereotipo)::text)))
     JOIN findom_os.shell_t_soggetti sc ON ((sc.id_soggetto = d.id_soggetto_creatore)))
     JOIN findom_os.shell_t_soggetti sb ON ((sb.id_soggetto = d.id_soggetto_beneficiario)))
     LEFT JOIN findom_os.ext_d_forme_giuridiche fg ON ((fg.id_forma_giuridica = sb.id_forma_giuridica)))
     LEFT JOIN findom_os.shell_t_soggetti si ON ((si.id_soggetto = d.id_soggetto_invio)))
     LEFT JOIN findom_os.shell_t_file_domande fd ON ((fd.id_domanda = d.id_domanda)))
     JOIN findom_os.findom_t_sportelli_bandi sp ON ((sp.id_sportello_bando = d.id_sportello_bando)))
     JOIN findom_os.findom_t_bandi b ON ((b.id_bando = sp.id_bando)))
     JOIN findom_os.findom_d_enti e ON ((e.id_ente = b.id_ente_destinatario)))
     JOIN findom_os.findom_d_classif_bandi az ON (((az.id_classificazione = b.id_classificazione) AND (az.id_tipo_suddivisione = 5))))
     JOIN findom_os.findom_d_classif_bandi os ON (((az.id_classificazione_padre = os.id_classificazione) AND (os.id_tipo_suddivisione = 4))))
     JOIN findom_os.findom_d_classif_bandi ap ON (((os.id_classificazione_padre = ap.id_classificazione) AND (ap.id_tipo_suddivisione = 1))))
     JOIN findom_os.findom_d_normative n ON ((n.id_normativa = ap.id_normativa)))
  ORDER BY 1 DESC;


ALTER TABLE findom_os.findom_v_domande2 OWNER TO findom_os;

--
-- TOC entry 16280 (class 1259 OID 31176015)
-- Name: findom_v_domande_beneficiari; Type: VIEW; Schema: findom_os; Owner: findom_os
--

CREATE VIEW findom_os.findom_v_domande_beneficiari AS
 SELECT DISTINCT b.id_bando,
    sp.id_sportello_bando,
    to_char(sp.dt_apertura, 'DD/MM/YYYY HH24:MI'::text) AS dt_apertura,
    to_char(sp.dt_chiusura, 'DD/MM/YYYY HH24:MI'::text) AS dt_chiusura,
    sb.id_soggetto AS id_soggetto_beneficiario,
    count(*) OVER (PARTITION BY sb.id_soggetto, b.id_bando) AS num_domande_bando,
    count(*) OVER (PARTITION BY sb.id_soggetto, sp.id_sportello_bando) AS num_domande_sportello
   FROM (((((findom_os.findom_t_sportelli_bandi sp
     JOIN findom_os.findom_t_bandi b ON ((b.id_bando = sp.id_bando)))
     JOIN findom_os.shell_t_domande d ON ((d.id_sportello_bando = sp.id_sportello_bando)))
     JOIN findom_os.aggr_t_model md ON ((md.model_id = d.id_domanda)))
     JOIN findom_os.aggr_d_model_state ms ON (((ms.model_state)::text = (md.model_state_fk)::text)))
     JOIN findom_os.shell_t_soggetti sb ON ((sb.id_soggetto = d.id_soggetto_beneficiario)))
  WHERE ((ms.model_state)::text = 'IN'::text);


ALTER TABLE findom_os.findom_v_domande_beneficiari OWNER TO findom_os;


--
-- TOC entry 16282 (class 1259 OID 31176027)
-- Name: findom_v_domande_da_istruire; Type: VIEW; Schema: findom_os; Owner: findom_os
--

CREATE VIEW findom_os.findom_v_domande_da_istruire AS
 WITH cte_valutaz AS (
         SELECT x_1.id_bando,
            x_1.descr_breve_bando,
            x_1.flag_valutazione_esterna,
            x_1.id_sportello_bando,
            x_1.dt_apertura,
            x_1.dt_chiusura,
            x_1.id_domanda,
            x_1.id_tipol_intervento,
            x_1.descrizione_tipol_intervento,
            x_1.stato_valut,
            x_1.denominazione_beneficiario,
            x_1.codice_fiscale_beneficiario,
            x_1.id_tipol_beneficiario,
            x_1.codice_tipol_beneficiario,
            x_1.flag_pubblico_privato,
            x_1.id_stato_istruttoria,
            x_1.cod_stato_istruttoria,
            x_1.stato_istruttoria,
            x_1.ordine_in_graduatoria_with_valut,
            x_1.ordine_in_graduatoria_without_valut,
            x_1.id_motivazione_esito,
            x_1.descr_motivazione_esito,
            x_1.id_istruttore_amm,
            x_1.cognome_istruttore_amm,
            x_1.nome_istruttore_amm,
            x_1.id_decisore,
            x_1.cognome_decisore,
            x_1.nome_decisore,
            x_1.dt_richiesta_integrazione,
            x_1.flag_abilita_integrazione,
            x_1.id_criterio,
            x_1.descrizione_criterio,
            x_1.descr_breve_criterio,
            sum(x_1.punteggio) AS punteggio,
            x_1.tot_punteggio_domanda,
            x_1.tot_punteggio_priorita_criterio,
            x_1.priorita_graduatoria,
            x_1.ordine,
            x_1.flag_valutazione_completata,
            x_1.dt_invio_domanda
           FROM ( SELECT b.id_bando,
                    b.descr_breve AS descr_breve_bando,
                    b.flag_valutazione_esterna,
                    sb.id_sportello_bando,
                    to_char(sb.dt_apertura, 'YYYY-MM-DD HH24:MI:SS'::text) AS dt_apertura,
                    to_char(sb.dt_chiusura, 'YYYY-MM-DD HH24:MI:SS'::text) AS dt_chiusura,
                    vd.id_domanda,
                    ti.id_tipol_intervento,
                    ti.descrizione AS descrizione_tipol_intervento,
                    vd.stato_valut,
                    s.cod_fiscale AS codice_fiscale_beneficiario,
                    s.denominazione AS denominazione_beneficiario,
                    tb.id_tipol_beneficiario,
                    tb.codice AS codice_tipol_beneficiario,
                    tb.flag_pubblico_privato,
                    si.id_stato_istr AS id_stato_istruttoria,
                    si.codice AS cod_stato_istruttoria,
                    si.descrizione AS stato_istruttoria,
                    si.ordine_in_graduatoria_with_valut,
                    si.ordine_in_graduatoria_without_valut,
                    f.id_funzionario AS id_istruttore_amm,
                    f.cognome AS cognome_istruttore_amm,
                    f.nome AS nome_istruttore_amm,
                    f1.id_funzionario AS id_decisore,
                    f1.cognome AS cognome_decisore,
                    f1.nome AS nome_decisore,
                    to_char((d.dt_richiesta_integrazione)::timestamp with time zone, 'dd/mm/yyyy'::text) AS dt_richiesta_integrazione,
                    d.flag_abilita_integrazione,
                    me.id_motivazione_esito,
                    me.descr_motivazione_esito,
                    cv.id_criterio,
                    cv.descrizione AS descrizione_criterio,
                    cv.descr_breve AS descr_breve_criterio,
                    sv.descrizione AS descrizione_specifica,
                    psv.descrizione AS descrizione_parametro,
                    vd.punteggio,
                    sum(vd.punteggio) OVER (PARTITION BY vd.id_domanda, vd.stato_valut, cv.id_criterio) AS tot_punteggio_criterio,
                    sum(vd.punteggio) OVER (PARTITION BY vd.id_domanda, vd.stato_valut) AS tot_punteggio_domanda,
                    sum((vd.punteggio * power((100)::numeric, ((100)::numeric - (COALESCE(bcv.priorita_graduatoria, 0))::numeric)))) OVER (PARTITION BY vd.id_domanda, vd.stato_valut) AS tot_punteggio_priorita_criterio,
                    COALESCE(bcv.priorita_graduatoria, 0) AS priorita_graduatoria,
                    bcv.ordine,
                    d.flag_valutazione_completata,
                    d.dt_invio_domanda
                   FROM (((((((((((((((findom_os.findom_r_bandi_criteri_valut bcv
                     JOIN findom_os.findom_d_criteri_valut cv ON ((cv.id_criterio = bcv.id_criterio)))
                     LEFT JOIN findom_os.findom_d_tipol_interventi ti ON ((ti.id_tipol_intervento = bcv.id_tipol_intervento)))
                     JOIN findom_os.findom_d_specifiche_valut sv ON ((sv.id_criterio = cv.id_criterio)))
                     JOIN findom_os.findom_t_parametri_valut pv ON (((pv.id_specifica = sv.id_specifica) AND (pv.id_bando = bcv.id_bando))))
                     JOIN findom_os.findom_d_parametri_specifiche_valut psv ON ((psv.id_parametro = pv.id_parametro)))
                     JOIN findom_os.shell_t_valut_domande vd ON (((vd.id_parametro_valut = pv.id_parametro_valut) AND (vd.stato_valut <> 'D'::bpchar))))
                     JOIN findom_os.findom_t_bandi b ON ((b.id_bando = bcv.id_bando)))
                     JOIN findom_os.shell_t_domande d ON ((d.id_domanda = vd.id_domanda)))
                     JOIN findom_os.findom_d_tipol_beneficiari tb ON ((tb.id_tipol_beneficiario = d.id_tipol_beneficiario)))
                     JOIN findom_os.findom_t_sportelli_bandi sb ON (((sb.id_sportello_bando = d.id_sportello_bando) AND (sb.id_bando = bcv.id_bando))))
                     LEFT JOIN findom_os.shell_t_soggetti s ON ((s.id_soggetto = d.id_soggetto_beneficiario)))
                     JOIN findom_os.findom_d_stato_istruttoria si ON (((si.id_stato_istr = d.id_stato_istr) AND (si.flag_stato_finale IS NULL))))
                     LEFT JOIN findom_os.findom_d_funzionari f ON ((f.id_funzionario = d.id_istruttore_amm)))
                     LEFT JOIN findom_os.findom_d_funzionari f1 ON ((f1.id_funzionario = d.id_decisore)))
                     LEFT JOIN findom_os.findom_d_motivazione_esito me ON ((me.id_motivazione_esito = d.id_motivazione_esito)))) x_1
          GROUP BY x_1.id_bando, x_1.descr_breve_bando, x_1.flag_valutazione_esterna, x_1.id_sportello_bando, x_1.dt_apertura, x_1.dt_chiusura, x_1.id_domanda, x_1.id_tipol_intervento, x_1.descrizione_tipol_intervento, x_1.stato_valut, x_1.denominazione_beneficiario, x_1.codice_fiscale_beneficiario, x_1.id_tipol_beneficiario, x_1.codice_tipol_beneficiario, x_1.flag_pubblico_privato, x_1.id_stato_istruttoria, x_1.cod_stato_istruttoria, x_1.stato_istruttoria, x_1.ordine_in_graduatoria_with_valut, x_1.ordine_in_graduatoria_without_valut, x_1.id_motivazione_esito, x_1.descr_motivazione_esito, x_1.id_istruttore_amm, x_1.cognome_istruttore_amm, x_1.nome_istruttore_amm, x_1.id_decisore, x_1.cognome_decisore, x_1.nome_decisore, x_1.dt_richiesta_integrazione, x_1.flag_abilita_integrazione, x_1.id_criterio, x_1.descrizione_criterio, x_1.descr_breve_criterio, x_1.tot_punteggio_domanda, x_1.tot_punteggio_priorita_criterio, x_1.priorita_graduatoria, x_1.ordine, x_1.flag_valutazione_completata, x_1.dt_invio_domanda
        )
 SELECT x.id_bando,
    x.descr_breve_bando,
    x.flag_valutazione_esterna,
    x.id_sportello_bando,
    x.dt_apertura,
    x.dt_chiusura,
    x.id_domanda,
    x.id_tipol_intervento,
    x.descrizione_tipol_intervento,
    x.stato_valut,
    x.denominazione_beneficiario,
    x.codice_fiscale_beneficiario,
    x.id_tipol_beneficiario,
    x.codice_tipol_beneficiario,
    x.flag_pubblico_privato,
    x.id_stato_istruttoria,
    x.cod_stato_istruttoria,
    x.stato_istruttoria,
    x.ordine_in_graduatoria_with_valut,
    x.ordine_in_graduatoria_without_valut,
    x.id_motivazione_esito,
    x.descr_motivazione_esito,
    x.id_istruttore_amm,
    x.cognome_istruttore_amm,
    x.nome_istruttore_amm,
    x.id_decisore,
    x.cognome_decisore,
    x.nome_decisore,
    x.dt_richiesta_integrazione,
    x.flag_abilita_integrazione,
    x.id_criterio,
    x.descrizione_criterio,
    x.descr_breve_criterio,
    x.punteggio,
    x.tot_punteggio_domanda,
    x.tot_punteggio_priorita_criterio,
    x.priorita_graduatoria,
    x.ordine,
    x.flag_valutazione_completata,
    x.dt_invio_domanda
   FROM ( SELECT cte_valutaz.id_bando,
            cte_valutaz.descr_breve_bando,
            cte_valutaz.flag_valutazione_esterna,
            cte_valutaz.id_sportello_bando,
            cte_valutaz.dt_apertura,
            cte_valutaz.dt_chiusura,
            cte_valutaz.id_domanda,
            cte_valutaz.id_tipol_intervento,
            cte_valutaz.descrizione_tipol_intervento,
            cte_valutaz.stato_valut,
            cte_valutaz.denominazione_beneficiario,
            cte_valutaz.codice_fiscale_beneficiario,
            cte_valutaz.id_tipol_beneficiario,
            cte_valutaz.codice_tipol_beneficiario,
            cte_valutaz.flag_pubblico_privato,
            cte_valutaz.id_stato_istruttoria,
            cte_valutaz.cod_stato_istruttoria,
            cte_valutaz.stato_istruttoria,
            cte_valutaz.ordine_in_graduatoria_with_valut,
            cte_valutaz.ordine_in_graduatoria_without_valut,
            cte_valutaz.id_motivazione_esito,
            cte_valutaz.descr_motivazione_esito,
            cte_valutaz.id_istruttore_amm,
            cte_valutaz.cognome_istruttore_amm,
            cte_valutaz.nome_istruttore_amm,
            cte_valutaz.id_decisore,
            cte_valutaz.cognome_decisore,
            cte_valutaz.nome_decisore,
            cte_valutaz.dt_richiesta_integrazione,
            cte_valutaz.flag_abilita_integrazione,
            cte_valutaz.id_criterio,
            cte_valutaz.descrizione_criterio,
            cte_valutaz.descr_breve_criterio,
            cte_valutaz.punteggio,
            cte_valutaz.tot_punteggio_domanda,
            cte_valutaz.tot_punteggio_priorita_criterio,
            cte_valutaz.priorita_graduatoria,
            cte_valutaz.ordine,
            cte_valutaz.flag_valutazione_completata,
            cte_valutaz.dt_invio_domanda
           FROM cte_valutaz
        UNION ALL
         SELECT DISTINCT b.id_bando,
            b.descr_breve AS descr_breve_bando,
            b.flag_valutazione_esterna,
            sb.id_sportello_bando,
            to_char(sb.dt_apertura, 'YYYY-MM-DD HH24:MI:SS'::text) AS dt_apertura,
            to_char(sb.dt_chiusura, 'YYYY-MM-DD HH24:MI:SS'::text) AS dt_chiusura,
            d.id_domanda,
            ti.id_tipol_intervento,
            ti.descrizione AS descrizione_tipol_intervento,
            (COALESCE(vd.stato_valut, 'P'::bpchar))::character(1) AS stato_valut,
            s.denominazione AS denominazione_beneficiario,
            s.cod_fiscale AS codice_fiscale_beneficiario,
            tb.id_tipol_beneficiario,
            tb.codice AS codice_tipol_beneficiario,
            tb.flag_pubblico_privato,
            si.id_stato_istr AS id_stato_istruttoria,
            si.codice AS cod_stato_istruttoria,
            si.descrizione AS stato_istruttoria,
            si.ordine_in_graduatoria_with_valut,
            si.ordine_in_graduatoria_without_valut,
            me.id_motivazione_esito,
            me.descr_motivazione_esito,
            f.id_funzionario AS id_istruttore_amm,
            f.cognome AS cognome_istruttore_amm,
            f.nome AS nome_istruttore_amm,
            f1.id_funzionario AS id_decisore,
            f1.cognome AS cognome_decisore,
            f1.nome AS nome_decisore,
            to_char((d.dt_richiesta_integrazione)::timestamp with time zone, 'dd/mm/yyyy'::text) AS dt_richiesta_integrazione,
            d.flag_abilita_integrazione,
            bcv.id_criterio,
            cv.descrizione AS descrizione_criterio,
            cv.descr_breve AS descr_breve_criterio,
            NULL::numeric AS punteggio,
            ( SELECT sum(shell_t_valut_domande.punteggio) AS sum
                   FROM findom_os.shell_t_valut_domande
                  WHERE ((shell_t_valut_domande.id_domanda = d.id_domanda) AND (shell_t_valut_domande.stato_valut = COALESCE(vd.stato_valut, 'P'::bpchar)))) AS tot_punteggio_domanda,
            NULL::numeric AS tot_punteggio_priorita_criterio,
            NULL::numeric AS priorita_graduatoria,
            bcv.ordine,
            d.flag_valutazione_completata,
            d.dt_invio_domanda
           FROM ((((((((((((findom_os.shell_t_domande d
             JOIN findom_os.findom_d_tipol_beneficiari tb ON ((tb.id_tipol_beneficiario = d.id_tipol_beneficiario)))
             JOIN findom_os.findom_t_sportelli_bandi sb ON ((sb.id_sportello_bando = d.id_sportello_bando)))
             JOIN findom_os.findom_t_bandi b ON ((b.id_bando = sb.id_bando)))
             JOIN findom_os.findom_r_bandi_criteri_valut bcv ON ((bcv.id_bando = b.id_bando)))
             LEFT JOIN findom_os.findom_d_tipol_interventi ti ON ((ti.id_tipol_intervento = bcv.id_tipol_intervento)))
             LEFT JOIN findom_os.shell_t_valut_domande vd ON (((vd.id_domanda = d.id_domanda) AND (vd.stato_valut <> 'D'::bpchar))))
             LEFT JOIN findom_os.shell_t_soggetti s ON ((s.id_soggetto = d.id_soggetto_beneficiario)))
             JOIN findom_os.findom_d_stato_istruttoria si ON (((si.id_stato_istr = d.id_stato_istr) AND (si.flag_stato_finale IS NULL))))
             LEFT JOIN findom_os.findom_d_funzionari f ON ((f.id_funzionario = d.id_istruttore_amm)))
             LEFT JOIN findom_os.findom_d_funzionari f1 ON ((f1.id_funzionario = d.id_decisore)))
             JOIN findom_os.findom_d_criteri_valut cv ON ((cv.id_criterio = bcv.id_criterio)))
             LEFT JOIN findom_os.findom_d_motivazione_esito me ON ((me.id_motivazione_esito = d.id_motivazione_esito)))
          WHERE (NOT (EXISTS ( SELECT NULL::unknown AS unknown
                   FROM cte_valutaz
                  WHERE ((cte_valutaz.id_domanda = d.id_domanda) AND (cte_valutaz.stato_valut = COALESCE(vd.stato_valut, 'P'::bpchar)) AND (cte_valutaz.id_criterio = cv.id_criterio)))))
        UNION ALL
         SELECT DISTINCT b.id_bando,
            b.descr_breve AS descr_breve_bando,
            b.flag_valutazione_esterna,
            sb.id_sportello_bando,
            to_char(sb.dt_apertura, 'YYYY-MM-DD HH24:MI:SS'::text) AS dt_apertura,
            to_char(sb.dt_chiusura, 'YYYY-MM-DD HH24:MI:SS'::text) AS dt_chiusura,
            d.id_domanda,
            NULL::integer AS id_tipol_intervento,
            NULL::character varying(200) AS descrizione_tipol_intervento,
            NULL::character(1) AS stato_valut,
            s.denominazione AS denominazione_beneficiario,
            s.cod_fiscale AS codice_fiscale_beneficiario,
            tb.id_tipol_beneficiario,
            tb.codice AS codice_tipol_beneficiario,
            tb.flag_pubblico_privato,
            si.id_stato_istr AS id_stato_istruttoria,
            si.codice AS cod_stato_istruttoria,
            si.descrizione AS stato_istruttoria,
            si.ordine_in_graduatoria_with_valut,
            si.ordine_in_graduatoria_without_valut,
            me.id_motivazione_esito,
            me.descr_motivazione_esito,
            f.id_funzionario AS id_istruttore_amm,
            f.cognome AS cognome_istruttore_amm,
            f.nome AS nome_istruttore_amm,
            f1.id_funzionario AS id_decisore,
            f1.cognome AS cognome_decisore,
            f1.nome AS nome_decisore,
            to_char((d.dt_richiesta_integrazione)::timestamp with time zone, 'dd/mm/yyyy'::text) AS dt_richiesta_integrazione,
            d.flag_abilita_integrazione,
            NULL::integer AS id_criterio,
            NULL::character varying(200) AS descrizione_criterio,
            NULL::character varying(20) AS descr_breve_criterio,
            NULL::numeric AS punteggio,
            NULL::numeric AS tot_punteggio_domanda,
            NULL::numeric AS tot_punteggio_priorita_criterio,
            NULL::numeric AS priorita_graduatoria,
            NULL::integer AS ordine,
            d.flag_valutazione_completata,
            d.dt_invio_domanda
           FROM ((((((((findom_os.shell_t_domande d
             JOIN findom_os.findom_d_tipol_beneficiari tb ON ((tb.id_tipol_beneficiario = d.id_tipol_beneficiario)))
             JOIN findom_os.findom_t_sportelli_bandi sb ON ((sb.id_sportello_bando = d.id_sportello_bando)))
             JOIN findom_os.findom_t_bandi b ON (((b.id_bando = sb.id_bando) AND (b.flag_valutazione_esterna = 'S'::bpchar))))
             LEFT JOIN findom_os.shell_t_soggetti s ON ((s.id_soggetto = d.id_soggetto_beneficiario)))
             JOIN findom_os.findom_d_stato_istruttoria si ON (((si.id_stato_istr = d.id_stato_istr) AND (si.flag_stato_finale IS NULL))))
             LEFT JOIN findom_os.findom_d_funzionari f ON ((f.id_funzionario = d.id_istruttore_amm)))
             LEFT JOIN findom_os.findom_d_funzionari f1 ON ((f1.id_funzionario = d.id_decisore)))
             LEFT JOIN findom_os.findom_d_motivazione_esito me ON ((me.id_motivazione_esito = d.id_motivazione_esito)))) x
  ORDER BY x.id_bando, x.id_domanda DESC, x.stato_valut, x.ordine;


ALTER TABLE findom_os.findom_v_domande_da_istruire OWNER TO findom_os;

--
-- TOC entry 16283 (class 1259 OID 31176032)
-- Name: findom_v_domande_da_istruire_new; Type: VIEW; Schema: findom_os; Owner: findom_os
--

CREATE VIEW findom_os.findom_v_domande_da_istruire_new AS
 SELECT x.id_bando,
    x.descr_breve_bando,
    x.flag_valutazione_esterna,
    x.id_sportello_bando,
    x.dt_apertura,
    x.dt_chiusura,
    x.id_domanda,
    x.denominazione_beneficiario,
    x.codice_fiscale_beneficiario,
    x.id_tipol_beneficiario,
    x.codice_tipol_beneficiario,
    x.flag_pubblico_privato,
    x.id_stato_istruttoria,
    x.cod_stato_istruttoria,
    x.stato_istruttoria,
    x.ordine_in_graduatoria_with_valut,
    x.ordine_in_graduatoria_without_valut,
    x.id_motivazione_esito,
    x.descr_motivazione_esito,
    x.id_istruttore_amm,
    x.cognome_istruttore_amm,
    x.nome_istruttore_amm,
    x.id_decisore,
    x.cognome_decisore,
    x.nome_decisore,
    x.dt_richiesta_integrazione,
    x.flag_abilita_integrazione,
    x.dt_invio_domanda
   FROM ( SELECT b.id_bando,
            b.descr_breve AS descr_breve_bando,
            b.flag_valutazione_esterna,
            sb.id_sportello_bando,
            to_char(sb.dt_apertura, 'YYYY-MM-DD HH24:MI:SS'::text) AS dt_apertura,
            to_char(sb.dt_chiusura, 'YYYY-MM-DD HH24:MI:SS'::text) AS dt_chiusura,
            d.id_domanda,
            s.denominazione AS denominazione_beneficiario,
            s.cod_fiscale AS codice_fiscale_beneficiario,
            tb.id_tipol_beneficiario,
            tb.codice AS codice_tipol_beneficiario,
            tb.flag_pubblico_privato,
            si.id_stato_istr AS id_stato_istruttoria,
            si.codice AS cod_stato_istruttoria,
            si.descrizione AS stato_istruttoria,
            si.ordine_in_graduatoria_with_valut,
            si.ordine_in_graduatoria_without_valut,
            me.id_motivazione_esito,
            me.descr_motivazione_esito,
            f.id_funzionario AS id_istruttore_amm,
            f.cognome AS cognome_istruttore_amm,
            f.nome AS nome_istruttore_amm,
            f1.id_funzionario AS id_decisore,
            f1.cognome AS cognome_decisore,
            f1.nome AS nome_decisore,
            to_char((d.dt_richiesta_integrazione)::timestamp with time zone, 'dd/mm/yyyy'::text) AS dt_richiesta_integrazione,
            d.flag_abilita_integrazione,
            d.dt_invio_domanda
           FROM ((((((((findom_os.shell_t_domande d
             JOIN findom_os.findom_d_tipol_beneficiari tb ON ((tb.id_tipol_beneficiario = d.id_tipol_beneficiario)))
             JOIN findom_os.findom_t_sportelli_bandi sb ON ((sb.id_sportello_bando = d.id_sportello_bando)))
             JOIN findom_os.findom_t_bandi b ON (((b.id_bando = sb.id_bando) AND (b.flag_istruttoria_esterna IS NULL))))
             LEFT JOIN findom_os.shell_t_soggetti s ON ((s.id_soggetto = d.id_soggetto_beneficiario)))
             JOIN findom_os.findom_d_stato_istruttoria si ON (((si.id_stato_istr = d.id_stato_istr) AND (si.flag_stato_finale IS NULL))))
             LEFT JOIN findom_os.findom_d_funzionari f ON ((f.id_funzionario = d.id_istruttore_amm)))
             LEFT JOIN findom_os.findom_d_funzionari f1 ON ((f1.id_funzionario = d.id_decisore)))
             LEFT JOIN findom_os.findom_d_motivazione_esito me ON ((me.id_motivazione_esito = d.id_motivazione_esito)))) x
  ORDER BY x.id_bando, x.id_domanda DESC;


ALTER TABLE findom_os.findom_v_domande_da_istruire_new OWNER TO findom_os;

--
-- TOC entry 16284 (class 1259 OID 31176037)
-- Name: findom_v_domande_da_istruire_parametri; Type: VIEW; Schema: findom_os; Owner: findom_os
--

CREATE VIEW findom_os.findom_v_domande_da_istruire_parametri AS
 WITH cte_valutaz AS (
         SELECT b.id_bando,
            b.descr_breve AS descr_breve_bando,
            vd.id_domanda,
            ti.id_tipol_intervento,
            ti.descrizione AS descrizione_tipol_intervento,
            vd.stato_valut,
            si.codice AS cod_stato_istruttoria,
            si.descrizione AS stato_istruttoria,
            cv.id_criterio,
            cv.descr_breve AS descr_breve_criterio,
            bcv.ordine AS ordine_criterio,
            bsv.id_specifica,
            sv.descrizione AS descrizione_specifica,
            COALESCE(sv.descr_breve, sv.descrizione) AS descr_breve_specifica,
            sv.ordine AS ordine_specifica,
            pv.id_parametro,
            psv.descrizione AS descrizione_parametro,
            (((COALESCE(sv.descr_breve, sv.descrizione))::text || ' - '::text) || (COALESCE(psv.descr_breve, psv.descrizione))::text) AS descr_breve_parametro,
            pv.ordine AS ordine_parametro,
            pv.flag_fittizio,
            pv.id_parametro_valut,
                CASE
                    WHEN ((sv.tipo_specifica)::text = 'PEN'::text) THEN (pv.punteggio * ('-1'::integer)::numeric)
                    ELSE pv.punteggio
                END AS punteggio_parametro,
            vd.punteggio AS punteggio_assegnato
           FROM (((((((((((findom_os.findom_r_bandi_specifiche_valut bsv
             JOIN findom_os.findom_d_specifiche_valut sv ON ((sv.id_specifica = bsv.id_specifica)))
             JOIN findom_os.findom_r_bandi_criteri_valut bcv ON (((bcv.id_bando = bsv.id_bando) AND (bcv.id_criterio = sv.id_criterio))))
             LEFT JOIN findom_os.findom_d_tipol_interventi ti ON ((ti.id_tipol_intervento = bcv.id_tipol_intervento)))
             JOIN findom_os.findom_t_parametri_valut pv ON (((pv.id_bando = bsv.id_bando) AND (pv.id_specifica = bsv.id_specifica))))
             JOIN findom_os.findom_d_parametri_specifiche_valut psv ON ((psv.id_parametro = pv.id_parametro)))
             JOIN findom_os.shell_t_valut_domande vd ON (((vd.id_parametro_valut = pv.id_parametro_valut) AND (vd.stato_valut <> 'D'::bpchar))))
             JOIN findom_os.shell_t_domande d ON ((d.id_domanda = vd.id_domanda)))
             JOIN findom_os.findom_t_sportelli_bandi sb ON (((sb.id_sportello_bando = d.id_sportello_bando) AND (sb.id_bando = bsv.id_bando))))
             JOIN findom_os.findom_d_stato_istruttoria si ON (((si.id_stato_istr = d.id_stato_istr) AND (si.flag_stato_finale IS NULL))))
             JOIN findom_os.findom_t_bandi b ON ((b.id_bando = bsv.id_bando)))
             JOIN findom_os.findom_d_criteri_valut cv ON ((cv.id_criterio = sv.id_criterio)))
        )
 SELECT x.id_bando,
    x.descr_breve_bando,
    x.id_domanda,
    x.id_tipol_intervento,
    x.descrizione_tipol_intervento,
    x.stato_valut,
    x.cod_stato_istruttoria,
    x.stato_istruttoria,
    x.id_criterio,
    x.descr_breve_criterio,
    x.ordine_criterio,
    x.id_specifica,
    x.descrizione_specifica,
    x.descr_breve_specifica,
    x.ordine_specifica,
    x.id_parametro,
    x.descrizione_parametro,
    x.descr_breve_parametro,
    x.ordine_parametro,
    x.flag_fittizio,
    x.id_parametro_valut,
    x.punteggio_parametro,
    x.punteggio_assegnato
   FROM ( SELECT cte_valutaz.id_bando,
            cte_valutaz.descr_breve_bando,
            cte_valutaz.id_domanda,
            cte_valutaz.id_tipol_intervento,
            cte_valutaz.descrizione_tipol_intervento,
            cte_valutaz.stato_valut,
            cte_valutaz.cod_stato_istruttoria,
            cte_valutaz.stato_istruttoria,
            cte_valutaz.id_criterio,
            cte_valutaz.descr_breve_criterio,
            cte_valutaz.ordine_criterio,
            cte_valutaz.id_specifica,
            cte_valutaz.descrizione_specifica,
            cte_valutaz.descr_breve_specifica,
            cte_valutaz.ordine_specifica,
            cte_valutaz.id_parametro,
            cte_valutaz.descrizione_parametro,
            cte_valutaz.descr_breve_parametro,
            cte_valutaz.ordine_parametro,
            cte_valutaz.flag_fittizio,
            cte_valutaz.id_parametro_valut,
            cte_valutaz.punteggio_parametro,
            cte_valutaz.punteggio_assegnato
           FROM cte_valutaz
        UNION ALL
         SELECT DISTINCT b.id_bando,
            b.descr_breve AS descr_breve_bando,
            d.id_domanda,
            ti.id_tipol_intervento,
            ti.descrizione AS descrizione_tipol_intervento,
            (COALESCE(vd.stato_valut, 'P'::bpchar))::character(1) AS stato_valut,
            si.codice AS cod_stato_istruttoria,
            si.descrizione AS stato_istruttoria,
            bcv.id_criterio,
            cv.descr_breve AS descr_breve_criterio,
            bcv.ordine AS ordine_criterio,
            bsv.id_specifica,
            sv.descrizione AS descrizione_specifica,
            COALESCE(sv.descr_breve, sv.descrizione) AS descr_breve_specifica,
            sv.ordine AS ordine_specifica,
            pv.id_parametro,
            psv.descrizione AS descrizione_parametro,
            (((COALESCE(sv.descr_breve, sv.descrizione))::text || ' - '::text) || (COALESCE(psv.descr_breve, psv.descrizione))::text) AS descr_breve_parametro,
            pv.ordine AS ordine_parametro,
            pv.flag_fittizio,
            pv.id_parametro_valut,
                CASE
                    WHEN ((sv.tipo_specifica)::text = 'PEN'::text) THEN (pv.punteggio * ('-1'::integer)::numeric)
                    ELSE pv.punteggio
                END AS punteggio_parametro,
            NULL::numeric AS punteggio_assegnato
           FROM (((((((((((findom_os.shell_t_domande d
             JOIN findom_os.findom_d_stato_istruttoria si ON (((si.id_stato_istr = d.id_stato_istr) AND (si.flag_stato_finale IS NULL))))
             JOIN findom_os.findom_t_sportelli_bandi sb ON ((sb.id_sportello_bando = d.id_sportello_bando)))
             JOIN findom_os.findom_t_bandi b ON ((b.id_bando = sb.id_bando)))
             JOIN findom_os.findom_r_bandi_specifiche_valut bsv ON ((bsv.id_bando = b.id_bando)))
             JOIN findom_os.findom_d_specifiche_valut sv ON ((sv.id_specifica = bsv.id_specifica)))
             JOIN findom_os.findom_d_criteri_valut cv ON ((cv.id_criterio = sv.id_criterio)))
             JOIN findom_os.findom_r_bandi_criteri_valut bcv ON (((bcv.id_bando = bsv.id_bando) AND (bcv.id_criterio = sv.id_criterio))))
             LEFT JOIN findom_os.findom_d_tipol_interventi ti ON ((ti.id_tipol_intervento = bcv.id_tipol_intervento)))
             JOIN findom_os.findom_t_parametri_valut pv ON (((pv.id_bando = bsv.id_bando) AND (pv.id_specifica = bsv.id_specifica))))
             JOIN findom_os.findom_d_parametri_specifiche_valut psv ON ((psv.id_parametro = pv.id_parametro)))
             LEFT JOIN findom_os.shell_t_valut_domande vd ON (((vd.id_domanda = d.id_domanda) AND (vd.stato_valut <> 'D'::bpchar))))
          WHERE (NOT (EXISTS ( SELECT NULL::unknown AS unknown
                   FROM cte_valutaz
                  WHERE ((cte_valutaz.id_domanda = d.id_domanda) AND (cte_valutaz.stato_valut = COALESCE(vd.stato_valut, 'P'::bpchar)) AND (cte_valutaz.id_criterio = cv.id_criterio) AND (cte_valutaz.id_specifica = bsv.id_specifica) AND (cte_valutaz.id_parametro = pv.id_parametro)))))) x
  ORDER BY x.id_bando, x.id_domanda DESC, x.stato_valut, x.ordine_criterio, x.ordine_specifica, x.ordine_parametro;


ALTER TABLE findom_os.findom_v_domande_da_istruire_parametri OWNER TO findom_os;

--
-- TOC entry 16285 (class 1259 OID 31176042)
-- Name: findom_v_domande_da_istruire_specifiche; Type: VIEW; Schema: findom_os; Owner: findom_os
--

CREATE VIEW findom_os.findom_v_domande_da_istruire_specifiche AS
 WITH cte_valutaz AS (
         SELECT x_1.id_bando,
            x_1.descr_breve_bando,
            x_1.id_domanda,
            x_1.id_tipol_intervento,
            x_1.descrizione_tipol_intervento,
            x_1.stato_valut,
            x_1.cod_stato_istruttoria,
            x_1.stato_istruttoria,
            x_1.id_criterio,
            x_1.descr_breve_criterio,
            x_1.ordine_criterio,
            x_1.id_specifica,
            x_1.descrizione_specifica,
            x_1.descr_breve_specifica,
            x_1.ordine_specifica,
            x_1.tipo_specifica,
            x_1.tipo_campo,
            x_1.corpo_regola,
            x_1.punteggio_min,
            x_1.punteggio_max,
            sum(x_1.punteggio) AS punteggio,
                CASE
                    WHEN (sum(x_1.punteggio) < (x_1.punteggio_min)::numeric) THEN 1
                    ELSE NULL::integer
                END AS tipo_errore,
            x_1.tot_punteggio_domanda
           FROM ( SELECT b.id_bando,
                    b.descr_breve AS descr_breve_bando,
                    vd.id_domanda,
                    ti.id_tipol_intervento,
                    ti.descrizione AS descrizione_tipol_intervento,
                    vd.stato_valut,
                    si.codice AS cod_stato_istruttoria,
                    si.descrizione AS stato_istruttoria,
                    cv.id_criterio,
                    cv.descr_breve AS descr_breve_criterio,
                    bcv.ordine AS ordine_criterio,
                    bsv.id_specifica,
                    sv.descrizione AS descrizione_specifica,
                    COALESCE(sv.descr_breve, sv.descrizione) AS descr_breve_specifica,
                    sv.ordine AS ordine_specifica,
                    sv.tipo_specifica,
                    bsv.tipo_campo,
                    r.corpo_regola,
                    bsv.punteggio_min,
                    bsv.punteggio_max,
                    vd.punteggio,
                    sum(vd.punteggio) OVER (PARTITION BY vd.id_domanda, vd.stato_valut) AS tot_punteggio_domanda
                   FROM (((((((((((findom_os.findom_r_bandi_specifiche_valut bsv
                     JOIN findom_os.findom_d_specifiche_valut sv ON ((sv.id_specifica = bsv.id_specifica)))
                     JOIN findom_os.findom_r_bandi_criteri_valut bcv ON (((bcv.id_bando = bsv.id_bando) AND (bcv.id_criterio = sv.id_criterio))))
                     LEFT JOIN findom_os.findom_d_tipol_interventi ti ON ((ti.id_tipol_intervento = bcv.id_tipol_intervento)))
                     JOIN findom_os.findom_t_parametri_valut pv ON (((pv.id_bando = bsv.id_bando) AND (pv.id_specifica = bsv.id_specifica))))
                     JOIN findom_os.shell_t_valut_domande vd ON (((vd.id_parametro_valut = pv.id_parametro_valut) AND (vd.stato_valut <> 'D'::bpchar))))
                     JOIN findom_os.shell_t_domande d ON ((d.id_domanda = vd.id_domanda)))
                     JOIN findom_os.findom_t_sportelli_bandi sb ON (((sb.id_sportello_bando = d.id_sportello_bando) AND (sb.id_bando = bsv.id_bando))))
                     JOIN findom_os.findom_d_stato_istruttoria si ON (((si.id_stato_istr = d.id_stato_istr) AND (si.flag_stato_finale IS NULL))))
                     JOIN findom_os.findom_t_bandi b ON ((b.id_bando = bsv.id_bando)))
                     JOIN findom_os.findom_d_criteri_valut cv ON ((cv.id_criterio = sv.id_criterio)))
                     LEFT JOIN findom_os.findom_d_regole r ON ((r.id_regola = bsv.id_regola)))) x_1
          GROUP BY x_1.id_bando, x_1.descr_breve_bando, x_1.id_domanda, x_1.id_tipol_intervento, x_1.descrizione_tipol_intervento, x_1.stato_valut, x_1.cod_stato_istruttoria, x_1.stato_istruttoria, x_1.id_specifica, x_1.descrizione_specifica, x_1.descr_breve_specifica, x_1.tipo_campo, x_1.corpo_regola, x_1.punteggio_min, x_1.punteggio_max, x_1.tot_punteggio_domanda, x_1.ordine_specifica, x_1.tipo_specifica, x_1.id_criterio, x_1.descr_breve_criterio, x_1.ordine_criterio
        )
 SELECT x.id_bando,
    x.descr_breve_bando,
    x.id_domanda,
    x.id_tipol_intervento,
    x.descrizione_tipol_intervento,
    x.stato_valut,
    x.cod_stato_istruttoria,
    x.stato_istruttoria,
    x.id_criterio,
    x.descr_breve_criterio,
    x.ordine_criterio,
    x.id_specifica,
    x.descrizione_specifica,
    x.descr_breve_specifica,
    row_number() OVER (PARTITION BY x.id_domanda, x.stato_valut, x.id_criterio ORDER BY x.ordine_specifica) AS ordine_specifica,
    x.tipo_specifica,
    x.tipo_campo,
    x.corpo_regola,
    x.punteggio_min,
    x.punteggio_max,
    x.punteggio,
    x.tipo_errore,
    x.tot_punteggio_domanda
   FROM ( SELECT cte_valutaz.id_bando,
            cte_valutaz.descr_breve_bando,
            cte_valutaz.id_domanda,
            cte_valutaz.id_tipol_intervento,
            cte_valutaz.descrizione_tipol_intervento,
            cte_valutaz.stato_valut,
            cte_valutaz.cod_stato_istruttoria,
            cte_valutaz.stato_istruttoria,
            cte_valutaz.id_criterio,
            cte_valutaz.descr_breve_criterio,
            cte_valutaz.ordine_criterio,
            cte_valutaz.id_specifica,
            cte_valutaz.descrizione_specifica,
            cte_valutaz.descr_breve_specifica,
            cte_valutaz.ordine_specifica,
            cte_valutaz.tipo_specifica,
            cte_valutaz.tipo_campo,
            cte_valutaz.corpo_regola,
            cte_valutaz.punteggio_min,
            cte_valutaz.punteggio_max,
            cte_valutaz.punteggio,
            cte_valutaz.tipo_errore,
            cte_valutaz.tot_punteggio_domanda
           FROM cte_valutaz
        UNION ALL
         SELECT DISTINCT b.id_bando,
            b.descr_breve AS descr_breve_bando,
            d.id_domanda,
            ti.id_tipol_intervento,
            ti.descrizione AS descrizione_tipol_intervento,
            (COALESCE(vd.stato_valut, 'P'::bpchar))::character(1) AS stato_valut,
            si.codice AS cod_stato_istruttoria,
            si.descrizione AS stato_istruttoria,
            bcv.id_criterio,
            cv.descr_breve AS descr_breve_criterio,
            bcv.ordine AS ordine_criterio,
            bsv.id_specifica,
            sv.descrizione AS descrizione_specifica,
            COALESCE(sv.descr_breve, sv.descrizione) AS descr_breve_specifica,
            sv.ordine AS ordine_specifica,
            sv.tipo_specifica,
            bsv.tipo_campo,
            r.corpo_regola,
            bsv.punteggio_min,
            bsv.punteggio_max,
            NULL::numeric AS punteggio,
            NULL::numeric AS tipo_errore,
            ( SELECT sum(shell_t_valut_domande.punteggio) AS sum
                   FROM findom_os.shell_t_valut_domande
                  WHERE ((shell_t_valut_domande.id_domanda = d.id_domanda) AND (shell_t_valut_domande.stato_valut = COALESCE(vd.stato_valut, 'P'::bpchar)))) AS tot_punteggio_domanda
           FROM ((((((((((findom_os.shell_t_domande d
             JOIN findom_os.findom_d_stato_istruttoria si ON (((si.id_stato_istr = d.id_stato_istr) AND (si.flag_stato_finale IS NULL))))
             JOIN findom_os.findom_t_sportelli_bandi sb ON ((sb.id_sportello_bando = d.id_sportello_bando)))
             JOIN findom_os.findom_t_bandi b ON ((b.id_bando = sb.id_bando)))
             JOIN findom_os.findom_r_bandi_specifiche_valut bsv ON ((bsv.id_bando = b.id_bando)))
             JOIN findom_os.findom_d_specifiche_valut sv ON ((sv.id_specifica = bsv.id_specifica)))
             JOIN findom_os.findom_d_criteri_valut cv ON ((cv.id_criterio = sv.id_criterio)))
             JOIN findom_os.findom_r_bandi_criteri_valut bcv ON (((bcv.id_bando = bsv.id_bando) AND (bcv.id_criterio = sv.id_criterio))))
             LEFT JOIN findom_os.findom_d_tipol_interventi ti ON ((ti.id_tipol_intervento = bcv.id_tipol_intervento)))
             LEFT JOIN findom_os.shell_t_valut_domande vd ON (((vd.id_domanda = d.id_domanda) AND (vd.stato_valut <> 'D'::bpchar))))
             LEFT JOIN findom_os.findom_d_regole r ON ((r.id_regola = bsv.id_regola)))
          WHERE (NOT (EXISTS ( SELECT NULL::unknown AS unknown
                   FROM cte_valutaz
                  WHERE ((cte_valutaz.id_domanda = d.id_domanda) AND (cte_valutaz.stato_valut = COALESCE(vd.stato_valut, 'P'::bpchar)) AND (cte_valutaz.id_criterio = cv.id_criterio) AND (cte_valutaz.id_specifica = bsv.id_specifica)))))) x
  ORDER BY x.id_bando, x.id_domanda DESC, x.stato_valut, x.ordine_criterio, x.ordine_specifica;


ALTER TABLE findom_os.findom_v_domande_da_istruire_specifiche OWNER TO findom_os;

--
-- TOC entry 16286 (class 1259 OID 31176047)
-- Name: findom_v_domande_fast; Type: VIEW; Schema: findom_os; Owner: findom_os
--

CREATE VIEW findom_os.findom_v_domande_fast AS
 SELECT d.id_domanda,
        CASE
            WHEN ((m.serialized_model)::text = '<tree-map/>'::text) THEN 'SI'::character varying
            ELSE 'NO'::character varying
        END AS domanda_vuota,
    ms.model_state AS cod_stato_domanda,
    ms.model_state_descr AS stato_domanda,
    (((az.codice)::text || ' - '::text) || (b.descr_breve)::text) AS descr_breve_bando,
    tb.id_tipol_beneficiario,
    tb.descrizione AS descrizione_tipol_beneficiario,
        CASE
            WHEN (tb.flag_pubblico_privato = (1)::numeric) THEN 'Privato'::text
            WHEN (tb.flag_pubblico_privato = (2)::numeric) THEN 'Pubblico'::text
            ELSE NULL::text
        END AS tipo_ente_beneficiario,
    tb.cod_stereotipo,
    st.descr_stereotipo,
    tb.flag_pubblico_privato,
    d.id_soggetto_creatore,
    sc.cognome AS cognome_soggetto_creatore,
    sc.nome AS nome_soggetto_creatore,
    sc.cod_fiscale AS cod_fiscale_soggetto_creatore,
    to_char(d.dt_creazione, 'DD/MM/YYYY HH24hMI.SS'::text) AS dt_creazione_domanda,
    d.id_soggetto_invio,
    si.cognome AS cognome_soggetto_invio,
    si.nome AS nome_soggetto_invio,
    si.cod_fiscale AS cod_fiscale_soggetto_invio,
    to_char(d.dt_invio_domanda, 'DD/MM/YYYY HH24hMI.SS'::text) AS dt_invio_domanda,
    to_char(fd.dt_invio_file, 'DD/MM/YYYY HH24hMI.SS'::text) AS dt_invio_file_xml,
    d.id_soggetto_beneficiario,
    sb.denominazione AS denominazione_soggetto_beneficiario,
    sb.cod_fiscale AS cod_fiscale_soggetto_beneficiario,
    fg.descr_forma_giuridica,
    sp.id_sportello_bando,
    sp.num_atto,
    sp.dt_atto,
    to_char(sp.dt_apertura, 'DD/MM/YYYY HH24hMI'::text) AS dt_apertura_sportello,
    to_char(sp.dt_chiusura, 'DD/MM/YYYY HH24hMI'::text) AS dt_chiusura_sportello,
    sp.id_bando,
    b.descrizione AS descr_bando,
    n.id_normativa,
    n.descr_breve AS normativa,
    ap.id_classificazione AS id_classificazione_asse_prioritario,
    ap.codice AS codice_asse_prioritario,
    ap.descrizione AS descrizione_asse_prioritario,
    pi.id_classificazione AS id_classificazione_priorita_investimento,
    pi.codice AS codice_priorita_investimento,
    pi.descrizione AS descrizione_priorita_investimento,
    os.id_classificazione AS id_classificazione_misura,
    os.codice AS codice_misura,
    os.descrizione AS descrizione_misura,
    az.id_classificazione AS id_classificazione_azione,
    az.codice AS codice_azione,
    az.descrizione AS descrizione_azione,
        CASE
            WHEN ((e.dest_file_domanda)::text = 'REGIONE'::text) THEN 'REGIONE PIEMONTE'::character varying
            WHEN ((e.dest_file_domanda)::text = 'FINPIEMONTE'::text) THEN 'FINPIEMONTE S.p.A.'::character varying
            ELSE e.dest_file_domanda
        END AS destinatario_descrizione,
        CASE
            WHEN ((e.dest_file_domanda)::text = 'FINPIEMONTE'::text) THEN NULL::character varying
            ELSE e.descrizione
        END AS destinatario_direzione,
    e.indirizzo AS destinatario_indirizzo,
    e.cap AS destinatario_cap,
    e.descr_comune AS destinatario_citta,
    e.sigla_prov AS destinatario_provincia,
    e.pec AS destinatario_pec,
    (((((((n.descr_breve)::text || ' '::text) || (ap.codice)::text) || ' '::text) || (os.codice)::text) || '-'::text) || (b.descr_breve)::text) AS norma_incentivazione,
    ( SELECT string_agg((x.codice)::text, '-'::text) AS string_agg
           FROM ( SELECT b_1.id_bando,
                    a.codice
                   FROM findom_os.findom_d_tipol_interventi a,
                    findom_os.findom_r_bandi_tipol_interventi b_1
                  WHERE ((a.id_tipol_intervento = b_1.id_tipol_intervento) AND (b_1.id_bando = sp.id_bando))
                  ORDER BY a.codice) x
          GROUP BY x.id_bando) AS codice_intervento,
    ( SELECT string_agg(x.descrizione, ' - '::text) AS string_agg
           FROM ( SELECT b_1.id_bando,
                    a.descrizione
                   FROM findom_os.findom_d_tipol_interventi a,
                    findom_os.findom_r_bandi_tipol_interventi b_1
                  WHERE ((a.id_tipol_intervento = b_1.id_tipol_intervento) AND (b_1.id_bando = sp.id_bando))
                  ORDER BY a.codice) x
          GROUP BY x.id_bando) AS descrizione_intervento
   FROM (((((((((((((((((findom_os.shell_t_domande d
     JOIN findom_os.aggr_t_model m ON ((m.model_id = d.id_domanda)))
     JOIN findom_os.aggr_d_model_state ms ON (((ms.model_state)::text = (m.model_state_fk)::text)))
     JOIN findom_os.findom_d_tipol_beneficiari tb ON ((tb.id_tipol_beneficiario = d.id_tipol_beneficiario)))
     JOIN findom_os.findom_d_stereotipi st ON (((st.cod_stereotipo)::text = (tb.cod_stereotipo)::text)))
     JOIN findom_os.shell_t_soggetti sc ON ((sc.id_soggetto = d.id_soggetto_creatore)))
     JOIN findom_os.shell_t_soggetti sb ON ((sb.id_soggetto = d.id_soggetto_beneficiario)))
     LEFT JOIN findom_os.ext_d_forme_giuridiche fg ON ((fg.id_forma_giuridica = sb.id_forma_giuridica)))
     LEFT JOIN findom_os.shell_t_soggetti si ON ((si.id_soggetto = d.id_soggetto_invio)))
     LEFT JOIN findom_os.shell_t_file_domande fd ON ((fd.id_domanda = d.id_domanda)))
     JOIN findom_os.findom_t_sportelli_bandi sp ON ((sp.id_sportello_bando = d.id_sportello_bando)))
     JOIN findom_os.findom_t_bandi b ON ((b.id_bando = sp.id_bando)))
     JOIN findom_os.findom_d_enti e ON ((e.id_ente = b.id_ente_destinatario)))
     JOIN findom_os.findom_d_classif_bandi az ON (((az.id_classificazione = b.id_classificazione) AND (az.id_tipo_suddivisione = 5))))
     JOIN findom_os.findom_d_classif_bandi os ON (((az.id_classificazione_padre = os.id_classificazione) AND (os.id_tipo_suddivisione = 4))))
     JOIN findom_os.findom_d_classif_bandi pi ON (((os.id_classificazione_padre = pi.id_classificazione) AND (pi.id_tipo_suddivisione = 3))))
     JOIN findom_os.findom_d_classif_bandi ap ON (((pi.id_classificazione_padre = ap.id_classificazione) AND (ap.id_tipo_suddivisione = 1))))
     JOIN findom_os.findom_d_normative n ON ((n.id_normativa = ap.id_normativa)))
UNION ALL
 SELECT d.id_domanda,
        CASE
            WHEN ((m.serialized_model)::text = '<tree-map/>'::text) THEN 'SI'::character varying
            ELSE 'NO'::character varying
        END AS domanda_vuota,
    ms.model_state AS cod_stato_domanda,
    ms.model_state_descr AS stato_domanda,
    (((az.codice)::text || ' - '::text) || (b.descr_breve)::text) AS descr_breve_bando,
    tb.id_tipol_beneficiario,
    tb.descrizione AS descrizione_tipol_beneficiario,
        CASE
            WHEN (tb.flag_pubblico_privato = (1)::numeric) THEN 'Privato'::text
            WHEN (tb.flag_pubblico_privato = (2)::numeric) THEN 'Pubblico'::text
            ELSE NULL::text
        END AS tipo_ente_beneficiario,
    tb.cod_stereotipo,
    st.descr_stereotipo,
    tb.flag_pubblico_privato,
    d.id_soggetto_creatore,
    sc.cognome AS cognome_soggetto_creatore,
    sc.nome AS nome_soggetto_creatore,
    sc.cod_fiscale AS cod_fiscale_soggetto_creatore,
    to_char(d.dt_creazione, 'DD/MM/YYYY HH24hMI.SS'::text) AS dt_creazione_domanda,
    d.id_soggetto_invio,
    si.cognome AS cognome_soggetto_invio,
    si.nome AS nome_soggetto_invio,
    si.cod_fiscale AS cod_fiscale_soggetto_invio,
    to_char(d.dt_invio_domanda, 'DD/MM/YYYY HH24hMI.SS'::text) AS dt_invio_domanda,
    to_char(fd.dt_invio_file, 'DD/MM/YYYY HH24hMI.SS'::text) AS dt_invio_file_xml,
    d.id_soggetto_beneficiario,
    sb.denominazione AS denominazione_soggetto_beneficiario,
    sb.cod_fiscale AS cod_fiscale_soggetto_beneficiario,
    fg.descr_forma_giuridica,
    sp.id_sportello_bando,
    sp.num_atto,
    sp.dt_atto,
    to_char(sp.dt_apertura, 'DD/MM/YYYY HH24hMI'::text) AS dt_apertura_sportello,
    to_char(sp.dt_chiusura, 'DD/MM/YYYY HH24hMI'::text) AS dt_chiusura_sportello,
    sp.id_bando,
    b.descrizione AS descr_bando,
    n.id_normativa,
    n.descr_breve AS normativa,
    ap.id_classificazione AS id_classificazione_asse_prioritario,
    ap.codice AS codice_asse_prioritario,
    ap.descrizione AS descrizione_asse_prioritario,
    NULL::integer AS id_classificazione_priorita_investimento,
    NULL::character varying AS codice_priorita_investimento,
    NULL::character varying AS descrizione_priorita_investimento,
    os.id_classificazione AS id_classificazione_misura,
    os.codice AS codice_misura,
    os.descrizione AS descrizione_misura,
    az.id_classificazione AS id_classificazione_azione,
    az.codice AS codice_azione,
    az.descrizione AS descrizione_azione,
        CASE
            WHEN ((e.dest_file_domanda)::text = 'REGIONE'::text) THEN 'REGIONE PIEMONTE'::character varying
            WHEN ((e.dest_file_domanda)::text = 'FINPIEMONTE'::text) THEN 'FINPIEMONTE S.p.A.'::character varying
            ELSE e.dest_file_domanda
        END AS destinatario_descrizione,
        CASE
            WHEN ((e.dest_file_domanda)::text = 'FINPIEMONTE'::text) THEN NULL::character varying
            ELSE e.descrizione
        END AS destinatario_direzione,
    e.indirizzo AS destinatario_indirizzo,
    e.cap AS destinatario_cap,
    e.descr_comune AS destinatario_citta,
    e.sigla_prov AS destinatario_provincia,
    e.pec AS destinatario_pec,
    (((((((n.descr_breve)::text || ' '::text) || (ap.codice)::text) || ' '::text) || (os.codice)::text) || '-'::text) || (b.descr_breve)::text) AS norma_incentivazione,
    ( SELECT string_agg((x.codice)::text, '-'::text) AS string_agg
           FROM ( SELECT b_1.id_bando,
                    a.codice
                   FROM findom_os.findom_d_tipol_interventi a,
                    findom_os.findom_r_bandi_tipol_interventi b_1
                  WHERE ((a.id_tipol_intervento = b_1.id_tipol_intervento) AND (b_1.id_bando = sp.id_bando))
                  ORDER BY a.codice) x
          GROUP BY x.id_bando) AS codice_intervento,
    ( SELECT string_agg(x.descrizione, ' - '::text) AS string_agg
           FROM ( SELECT b_1.id_bando,
                    a.descrizione
                   FROM findom_os.findom_d_tipol_interventi a,
                    findom_os.findom_r_bandi_tipol_interventi b_1
                  WHERE ((a.id_tipol_intervento = b_1.id_tipol_intervento) AND (b_1.id_bando = sp.id_bando))
                  ORDER BY a.codice) x
          GROUP BY x.id_bando) AS descrizione_intervento
   FROM ((((((((((((((((findom_os.shell_t_domande d
     JOIN findom_os.aggr_t_model m ON ((m.model_id = d.id_domanda)))
     JOIN findom_os.aggr_d_model_state ms ON (((ms.model_state)::text = (m.model_state_fk)::text)))
     JOIN findom_os.findom_d_tipol_beneficiari tb ON ((tb.id_tipol_beneficiario = d.id_tipol_beneficiario)))
     JOIN findom_os.findom_d_stereotipi st ON (((st.cod_stereotipo)::text = (tb.cod_stereotipo)::text)))
     JOIN findom_os.shell_t_soggetti sc ON ((sc.id_soggetto = d.id_soggetto_creatore)))
     JOIN findom_os.shell_t_soggetti sb ON ((sb.id_soggetto = d.id_soggetto_beneficiario)))
     LEFT JOIN findom_os.ext_d_forme_giuridiche fg ON ((fg.id_forma_giuridica = sb.id_forma_giuridica)))
     LEFT JOIN findom_os.shell_t_soggetti si ON ((si.id_soggetto = d.id_soggetto_invio)))
     LEFT JOIN findom_os.shell_t_file_domande fd ON ((fd.id_domanda = d.id_domanda)))
     JOIN findom_os.findom_t_sportelli_bandi sp ON ((sp.id_sportello_bando = d.id_sportello_bando)))
     JOIN findom_os.findom_t_bandi b ON ((b.id_bando = sp.id_bando)))
     JOIN findom_os.findom_d_enti e ON ((e.id_ente = b.id_ente_destinatario)))
     JOIN findom_os.findom_d_classif_bandi az ON (((az.id_classificazione = b.id_classificazione) AND (az.id_tipo_suddivisione = 5))))
     JOIN findom_os.findom_d_classif_bandi os ON (((az.id_classificazione_padre = os.id_classificazione) AND (os.id_tipo_suddivisione = 4))))
     JOIN findom_os.findom_d_classif_bandi ap ON (((os.id_classificazione_padre = ap.id_classificazione) AND (ap.id_tipo_suddivisione = 1))))
     JOIN findom_os.findom_d_normative n ON ((n.id_normativa = ap.id_normativa)))
  ORDER BY 1 DESC;


ALTER TABLE findom_os.findom_v_domande_fast OWNER TO findom_os;

--
-- TOC entry 16287 (class 1259 OID 31176052)
-- Name: findom_v_domande_file_dest; Type: VIEW; Schema: findom_os; Owner: findom_os
--

CREATE VIEW findom_os.findom_v_domande_file_dest AS
 SELECT x.id_domanda,
    (((((x.pref_classificazione || '_'::text) || x.data_invio_domanda) || '_'::text) || x.blocco) || '_XML.zip'::text) AS zip_nome_file_xml,
    (((((x.pref_classificazione || '_'::text) || x.data_invio_domanda) || '_'::text) || x.blocco) || '_PDF.zip'::text) AS zip_nome_file_pdf,
    x.nome_file_xml,
    x.dest_file_domanda,
    x.id_bando
   FROM ( SELECT d.id_domanda,
            b.id_bando,
            ((((((replace((n.descr_breve)::text, ' '::text, '_'::text) || '_'::text) || (ap.codice)::text) || '_'::text) || (pi.codice)::text) || '_'::text) || replace((az.codice)::text, '.'::text, '-'::text)) AS pref_classificazione,
            (((((((((((((replace((n.descr_breve)::text, ' '::text, '_'::text) || '_'::text) || (ap.codice)::text) || '_'::text) || (pi.codice)::text) || '_'::text) || replace((az.codice)::text, '.'::text, '-'::text)) || '_'::text) || d.id_domanda) || '_'::text) || d.id_soggetto_beneficiario) || '_'::text) || to_char(d.dt_invio_domanda, 'DDMMYYYYHH24MISS'::text)) || '.xml'::text) AS nome_file_xml,
            (((((((((((((replace((n.descr_breve)::text, ' '::text, '_'::text) || '_'::text) || (ap.codice)::text) || '_'::text) || (pi.codice)::text) || '_'::text) || replace((az.codice)::text, '.'::text, '-'::text)) || '_'::text) || d.id_domanda) || '_'::text) || d.id_soggetto_beneficiario) || '_'::text) || to_char(d.dt_invio_domanda, 'DDMMYYYYHH24MISS'::text)) || '.pdf'::text) AS nome_file_pdf,
            p.num_max_file_in_zip,
            e.dest_file_domanda,
            to_char(((d.dt_invio_domanda)::date)::timestamp without time zone, 'YYYYMMDD'::text) AS data_invio_domanda,
            ceil(((row_number() OVER (PARTITION BY n.descr_breve, ap.codice, pi.codice, az.codice, b.id_bando, ((d.dt_invio_domanda)::date) ORDER BY d.id_domanda))::numeric / (p.num_max_file_in_zip)::numeric)) AS blocco
           FROM ((((((((((((findom_os.shell_t_domande d
             LEFT JOIN findom_os.shell_t_file_domande fd ON ((fd.id_domanda = d.id_domanda)))
             JOIN findom_os.findom_d_parametri p ON (((p.codice)::bpchar = 'FILE_DOMANDA'::bpchar)))
             JOIN findom_os.aggr_t_model md ON ((md.model_id = d.id_domanda)))
             JOIN findom_os.aggr_d_model_state ms ON (((ms.model_state)::text = (md.model_state_fk)::text)))
             JOIN findom_os.findom_t_sportelli_bandi sp ON ((sp.id_sportello_bando = d.id_sportello_bando)))
             JOIN findom_os.findom_t_bandi b ON ((b.id_bando = sp.id_bando)))
             JOIN findom_os.findom_d_enti e ON ((e.id_ente = b.id_ente_destinatario)))
             JOIN findom_os.findom_d_classif_bandi az ON (((az.id_classificazione = b.id_classificazione) AND (az.id_tipo_suddivisione = 5))))
             JOIN findom_os.findom_d_classif_bandi os ON (((az.id_classificazione_padre = os.id_classificazione) AND (os.id_tipo_suddivisione = 4))))
             JOIN findom_os.findom_d_classif_bandi pi ON (((os.id_classificazione_padre = pi.id_classificazione) AND (pi.id_tipo_suddivisione = 3))))
             JOIN findom_os.findom_d_classif_bandi ap ON (((pi.id_classificazione_padre = ap.id_classificazione) AND (ap.id_tipo_suddivisione = 1))))
             JOIN findom_os.findom_d_normative n ON ((n.id_normativa = ap.id_normativa)))
          WHERE (((ms.model_state)::text = 'IN'::text) AND (d.dt_invio_domanda IS NOT NULL))
        UNION ALL
         SELECT d.id_domanda,
            b.id_bando,
            ((((replace((n.descr_breve)::text, ' '::text, '_'::text) || '_'::text) || (ap.codice)::text) || '__'::text) || (az.codice)::text) AS pref_classificazione,
            (((((((((((replace((n.descr_breve)::text, ' '::text, '_'::text) || '_'::text) || (ap.codice)::text) || '__'::text) || replace((az.codice)::text, '.'::text, '-'::text)) || '_'::text) || d.id_domanda) || '_'::text) || d.id_soggetto_beneficiario) || '_'::text) || to_char(d.dt_invio_domanda, 'DDMMYYYYHH24MISS'::text)) || '.xml'::text) AS nome_file_xml,
            (((((((((((replace((n.descr_breve)::text, ' '::text, '_'::text) || '_'::text) || (ap.codice)::text) || '__'::text) || replace((az.codice)::text, '.'::text, '-'::text)) || '_'::text) || d.id_domanda) || '_'::text) || d.id_soggetto_beneficiario) || '_'::text) || to_char(d.dt_invio_domanda, 'DDMMYYYYHH24MISS'::text)) || '.pdf'::text) AS nome_file_pdf,
            p.num_max_file_in_zip,
            e.dest_file_domanda,
            to_char(((d.dt_invio_domanda)::date)::timestamp without time zone, 'YYYYMMDD'::text) AS data_invio_domanda,
            ceil(((row_number() OVER (PARTITION BY n.descr_breve, ap.codice, az.codice, b.id_bando, ((d.dt_invio_domanda)::date) ORDER BY d.id_domanda))::numeric / (p.num_max_file_in_zip)::numeric)) AS blocco
           FROM (((((((((((findom_os.shell_t_domande d
             LEFT JOIN findom_os.shell_t_file_domande fd ON ((fd.id_domanda = d.id_domanda)))
             JOIN findom_os.findom_d_parametri p ON (((p.codice)::bpchar = 'FILE_DOMANDA'::bpchar)))
             JOIN findom_os.aggr_t_model md ON ((md.model_id = d.id_domanda)))
             JOIN findom_os.aggr_d_model_state ms ON (((ms.model_state)::text = (md.model_state_fk)::text)))
             JOIN findom_os.findom_t_sportelli_bandi sp ON ((sp.id_sportello_bando = d.id_sportello_bando)))
             JOIN findom_os.findom_t_bandi b ON ((b.id_bando = sp.id_bando)))
             JOIN findom_os.findom_d_enti e ON ((e.id_ente = b.id_ente_destinatario)))
             JOIN findom_os.findom_d_classif_bandi az ON (((az.id_classificazione = b.id_classificazione) AND (az.id_tipo_suddivisione = 5))))
             JOIN findom_os.findom_d_classif_bandi os ON (((az.id_classificazione_padre = os.id_classificazione) AND (os.id_tipo_suddivisione = 4))))
             JOIN findom_os.findom_d_classif_bandi ap ON (((os.id_classificazione_padre = ap.id_classificazione) AND (ap.id_tipo_suddivisione = 1))))
             JOIN findom_os.findom_d_normative n ON ((n.id_normativa = ap.id_normativa)))
          WHERE (((ms.model_state)::text = 'IN'::text) AND (d.dt_invio_domanda IS NOT NULL))) x;


ALTER TABLE findom_os.findom_v_domande_file_dest OWNER TO findom_os;

--
-- TOC entry 16288 (class 1259 OID 31176057)
-- Name: findom_v_domande_fornitori_spese; Type: VIEW; Schema: findom_os; Owner: findom_os
--

CREATE VIEW findom_os.findom_v_domande_fornitori_spese AS
 SELECT DISTINCT a.id_domanda,
    ('FD'::text || a.id_domanda) AS numero_domanda,
    a.cod_stato_domanda,
    a.id_bando,
    a.descr_breve_bando,
    a.cod_fiscale_soggetto_beneficiario,
    a.denominazione_soggetto_beneficiario,
    a.id_voce_spesa,
    a.descr_voce_spesa,
    a.fornitore,
    a.codicefiscale
   FROM ( SELECT y.id_domanda,
            d.cod_stato_domanda,
            d.id_bando,
            d.descr_breve_bando,
            d.cod_fiscale_soggetto_beneficiario,
            d.denominazione_soggetto_beneficiario,
            y.id_voce_spesa,
            y.descr_voce_spesa,
            y.fornitore,
            y.codicefiscale
           FROM (( SELECT x.id_domanda,
                    (unnest(xpath('//descrVoceSpesa/text()'::text, x.cat)))::text AS descr_voce_spesa,
                    ((unnest(xpath('//idVoceSpesa/text()'::text, x.cat)))::text)::integer AS id_voce_spesa,
                    (unnest(xpath('//fornitore/text()'::text, x.cat)))::text AS fornitore,
                    (unnest(xpath('//codiceFiscale/text()'::text, x.cat)))::text AS codicefiscale
                   FROM ( SELECT m.model_id AS id_domanda,
                            unnest(xpath('/tree-map/_pianoSpese/map/dettaglioCostiList/list/map'::text, m.serialized_model)) AS cat
                           FROM findom_os.aggr_t_model m) x) y
             JOIN findom_os.findom_v_domande_fast d ON ((y.id_domanda = d.id_domanda)))) a;


ALTER TABLE findom_os.findom_v_domande_fornitori_spese OWNER TO findom_os;


--
-- TOC entry 16291 (class 1259 OID 31176076)
-- Name: findom_v_domande_graduatoria; Type: VIEW; Schema: findom_os; Owner: findom_os
--

CREATE VIEW findom_os.findom_v_domande_graduatoria AS
 WITH v_rimod_agev AS (
         SELECT x.id_domanda,
                CASE
                    WHEN xpath_exists('//importoRichiesto/text()'::text, x.cat) THEN (replace((unnest(xpath('//importoRichiesto/text()'::text, x.cat)))::text, ','::text, '.'::text))::numeric
                    ELSE NULL::numeric
                END AS imp_richiesto,
            ra_i.imp_richiesto AS imp_richiesto_rim_istruttore,
            ra_d.imp_richiesto AS imp_richiesto_rim_decisore
           FROM ((( SELECT m.model_id AS id_domanda,
                    unnest(xpath('/tree-map/_formaAgevolazione/map'::text, m.serialized_model)) AS cat
                   FROM findom_os.aggr_t_model m
                  WHERE ((m.model_state_fk)::text = 'IN'::text)
                UNION ALL
                 SELECT m.model_id AS id_domanda,
                    unnest(xpath('/tree-map/_formaAgevolazioneB/map'::text, m.serialized_model)) AS cat
                   FROM findom_os.aggr_t_model m
                  WHERE ((m.model_state_fk)::text = 'IN'::text)) x
             LEFT JOIN findom_os.shell_t_rimod_agev ra_i ON (((x.id_domanda = ra_i.id_domanda) AND (ra_i.tipo_rimodulazione = 'I'::bpchar))))
             LEFT JOIN findom_os.shell_t_rimod_agev ra_d ON (((x.id_domanda = ra_d.id_domanda) AND (ra_d.tipo_rimodulazione = 'D'::bpchar))))
        )
 SELECT d.id_bando,
    d.descr_breve_bando,
    d.id_sportello_bando,
    d.dt_apertura,
    d.dt_chiusura,
    d.id_domanda,
    d.stato_valut,
    a.imp_richiesto,
    a.imp_richiesto_rim_istruttore,
    a.imp_richiesto_rim_decisore,
    d.denominazione_beneficiario,
    d.codice_fiscale_beneficiario,
    d.id_tipol_beneficiario,
    d.codice_tipol_beneficiario,
    d.flag_pubblico_privato,
    d.id_stato_istruttoria,
    d.cod_stato_istruttoria,
    d.stato_istruttoria,
    public.decode(d.flag_valutazione_esterna, NULL::bpchar, d.ordine_in_graduatoria_with_valut, NULL::numeric) AS ordine_in_graduatoria_with_valut,
    d.id_motivazione_esito,
    d.descr_motivazione_esito,
    d.id_istruttore_amm,
    d.id_decisore,
    d.id_criterio,
    d.descrizione_criterio,
    d.descr_breve_criterio,
    d.punteggio,
    d.tot_punteggio_domanda,
    d.ordine,
    d.flag_valutazione_completata,
    g.flag_finanz_parz,
    to_char(d.dt_invio_domanda, 'YYYY/MM/DD HH24:MI:SS'::text) AS dt_invio_domanda
   FROM ((findom_os.findom_v_domande_da_istruire d
     LEFT JOIN v_rimod_agev a ON ((a.id_domanda = d.id_domanda)))
     LEFT JOIN ( SELECT a_1.id_domanda,
            a_1.flag_finanz_parz
           FROM findom_os.shell_t_dett_graduatoria a_1
          WHERE (a_1.id_dett_graduatoria = ( SELECT max(shell_t_dett_graduatoria.id_dett_graduatoria) AS max
                   FROM findom_os.shell_t_dett_graduatoria
                  WHERE (shell_t_dett_graduatoria.id_domanda = a_1.id_domanda)))) g ON ((g.id_domanda = d.id_domanda)))
  WHERE (d.flag_valutazione_esterna IS NULL)
  ORDER BY d.id_bando, COALESCE(d.tot_punteggio_domanda, (0)::numeric) DESC, d.tot_punteggio_priorita_criterio DESC, d.dt_invio_domanda, d.id_domanda, d.stato_valut, d.ordine;


ALTER TABLE findom_os.findom_v_domande_graduatoria OWNER TO findom_os;

--
-- TOC entry 16292 (class 1259 OID 31176081)
-- Name: findom_v_domande_graduatoria_senza_valut; Type: VIEW; Schema: findom_os; Owner: findom_os
--

CREATE VIEW findom_os.findom_v_domande_graduatoria_senza_valut AS
 WITH v_rimod_agev AS (
         SELECT x.id_domanda,
                CASE
                    WHEN xpath_exists('//importoRichiesto/text()'::text, x.cat) THEN (replace((unnest(xpath('//importoRichiesto/text()'::text, x.cat)))::text, ','::text, '.'::text))::numeric
                    ELSE NULL::numeric
                END AS imp_richiesto,
            ra_i.imp_richiesto AS imp_richiesto_rim_istruttore,
            ra_d.imp_richiesto AS imp_richiesto_rim_decisore
           FROM ((( SELECT m.model_id AS id_domanda,
                    unnest(xpath('/tree-map/_formaAgevolazione/map'::text, m.serialized_model)) AS cat
                   FROM findom_os.aggr_t_model m
                  WHERE ((m.model_state_fk)::text = 'IN'::text)
                UNION ALL
                 SELECT m.model_id AS id_domanda,
                    unnest(xpath('/tree-map/_formaAgevolazioneB/map'::text, m.serialized_model)) AS cat
                   FROM findom_os.aggr_t_model m
                  WHERE ((m.model_state_fk)::text = 'IN'::text)) x
             LEFT JOIN findom_os.shell_t_rimod_agev ra_i ON (((x.id_domanda = ra_i.id_domanda) AND (ra_i.tipo_rimodulazione = 'I'::bpchar))))
             LEFT JOIN findom_os.shell_t_rimod_agev ra_d ON (((x.id_domanda = ra_d.id_domanda) AND (ra_d.tipo_rimodulazione = 'D'::bpchar))))
        )
 SELECT d.id_bando,
    d.descr_breve_bando,
    d.id_sportello_bando,
    d.dt_apertura,
    d.dt_chiusura,
    d.id_domanda,
    a.imp_richiesto,
    a.imp_richiesto_rim_istruttore,
    a.imp_richiesto_rim_decisore,
    d.denominazione_beneficiario,
    d.codice_fiscale_beneficiario,
    d.id_tipol_beneficiario,
    d.codice_tipol_beneficiario,
    d.flag_pubblico_privato,
    d.id_stato_istruttoria,
    d.cod_stato_istruttoria,
    d.stato_istruttoria,
    public.decode(d.flag_valutazione_esterna, 'S'::bpchar, d.ordine_in_graduatoria_without_valut, NULL::numeric) AS ordine_in_graduatoria_without_valut,
    d.id_motivazione_esito,
    d.descr_motivazione_esito,
    d.id_istruttore_amm,
    d.id_decisore,
    g.flag_finanz_parz,
    to_char(d.dt_invio_domanda, 'YYYY/MM/DD HH24:MI:SS'::text) AS dt_invio_domanda
   FROM ((findom_os.findom_v_domande_da_istruire_new d
     LEFT JOIN v_rimod_agev a ON ((a.id_domanda = d.id_domanda)))
     LEFT JOIN ( SELECT a_1.id_domanda,
            a_1.flag_finanz_parz
           FROM findom_os.shell_t_dett_graduatoria a_1
          WHERE (a_1.id_dett_graduatoria = ( SELECT max(shell_t_dett_graduatoria.id_dett_graduatoria) AS max
                   FROM findom_os.shell_t_dett_graduatoria
                  WHERE (shell_t_dett_graduatoria.id_domanda = a_1.id_domanda)))) g ON ((g.id_domanda = d.id_domanda)))
  WHERE (d.flag_valutazione_esterna = 'S'::bpchar)
  ORDER BY d.id_bando, d.dt_invio_domanda, d.id_domanda;


ALTER TABLE findom_os.findom_v_domande_graduatoria_senza_valut OWNER TO findom_os;

--
-- TOC entry 16293 (class 1259 OID 31176086)
-- Name: findom_v_domande_tipol_interventi; Type: VIEW; Schema: findom_os; Owner: findom_os
--

CREATE VIEW findom_os.findom_v_domande_tipol_interventi AS
 SELECT a.id_bando,
    a.descr_breve AS descr_breve_bando,
    a.id_domanda,
    a.id_sportello_bando,
    a.flag_pubblico_privato,
    a.id_tipol_intervento,
    a.tipologia_intervento,
    a.id_dett_intervento,
    a.dettaglio_intervento
   FROM ( SELECT y.id_domanda,
            y.id_bando,
            y.descr_breve,
            y.id_sportello_bando,
            y.flag_pubblico_privato,
            y.id_tipol_intervento,
            y.tipo_record,
            ti.descrizione AS tipologia_intervento,
            NULL::integer AS id_dett_intervento,
            NULL::text AS dettaglio_intervento
           FROM (( SELECT x.id_domanda,
                    x.id_bando,
                    x.descr_breve,
                    x.id_sportello_bando,
                    x.flag_pubblico_privato,
                    ((unnest(xpath('//idTipoIntervento/text()'::text, x.cat)))::text)::integer AS id_tipol_intervento,
                    ((unnest(xpath('//tipoRecord/text()'::text, x.cat)))::text)::integer AS tipo_record
                   FROM ( SELECT m.model_id AS id_domanda,
                            b.id_bando,
                            b.descr_breve,
                            sb.id_sportello_bando,
                            tb.flag_pubblico_privato,
                            unnest(xpath('/tree-map/_pianoSpese/map/pianoSpeseList/list/map'::text, m.serialized_model)) AS cat
                           FROM ((((findom_os.aggr_t_model m
                             JOIN findom_os.shell_t_domande d ON ((d.id_domanda = m.model_id)))
                             JOIN findom_os.findom_t_sportelli_bandi sb ON ((sb.id_sportello_bando = d.id_sportello_bando)))
                             JOIN findom_os.findom_t_bandi b ON (((b.id_bando = sb.id_bando) AND (b.flag_istruttoria_esterna IS NULL))))
                             JOIN findom_os.findom_d_tipol_beneficiari tb ON ((tb.id_tipol_beneficiario = d.id_tipol_beneficiario)))
                          WHERE ((m.model_state_fk)::text = 'IN'::text)) x) y
             JOIN findom_os.findom_d_tipol_interventi ti ON ((y.id_tipol_intervento = ti.id_tipol_intervento)))) a
  WHERE (a.tipo_record = 1)
UNION ALL
 SELECT a.id_bando,
    a.descr_breve AS descr_breve_bando,
    a.id_domanda,
    a.id_sportello_bando,
    a.flag_pubblico_privato,
    a.id_tipol_intervento,
    a.tipologia_intervento,
    a.id_dett_intervento,
    a.dettaglio_intervento
   FROM ( SELECT y.id_domanda,
            y.id_bando,
            y.descr_breve,
            y.id_sportello_bando,
            y.flag_pubblico_privato,
            ti.id_tipol_intervento,
            ti.descrizione AS tipologia_intervento,
            y.id_dett_intervento,
            y.tipo_record,
            dti.descrizione AS dettaglio_intervento
           FROM ((( SELECT x.id_domanda,
                    x.id_bando,
                    x.descr_breve,
                    x.id_sportello_bando,
                    x.flag_pubblico_privato,
                    ((unnest(xpath('//idDettIntervento/text()'::text, x.cat)))::text)::integer AS id_dett_intervento,
                    ((unnest(xpath('//tipoRecord/text()'::text, x.cat)))::text)::integer AS tipo_record
                   FROM ( SELECT m.model_id AS id_domanda,
                            b.id_bando,
                            b.descr_breve,
                            sb.id_sportello_bando,
                            tb.flag_pubblico_privato,
                            unnest(xpath('/tree-map/_pianoSpese/map/pianoSpeseList/list/map'::text, m.serialized_model)) AS cat
                           FROM ((((findom_os.aggr_t_model m
                             JOIN findom_os.shell_t_domande d ON ((d.id_domanda = m.model_id)))
                             JOIN findom_os.findom_t_sportelli_bandi sb ON ((sb.id_sportello_bando = d.id_sportello_bando)))
                             JOIN findom_os.findom_t_bandi b ON (((b.id_bando = sb.id_bando) AND (b.flag_istruttoria_esterna IS NULL))))
                             JOIN findom_os.findom_d_tipol_beneficiari tb ON ((tb.id_tipol_beneficiario = d.id_tipol_beneficiario)))
                          WHERE ((m.model_state_fk)::text = 'IN'::text)) x) y
             JOIN findom_os.findom_d_dett_tipol_interventi dti ON ((y.id_dett_intervento = dti.id_dett_tipol_intervento)))
             JOIN findom_os.findom_d_tipol_interventi ti ON ((ti.id_tipol_intervento = dti.id_tipol_intervento)))) a
  WHERE (a.tipo_record = 2);


ALTER TABLE findom_os.findom_v_domande_tipol_interventi OWNER TO findom_os;

--
-- TOC entry 16294 (class 1259 OID 31176091)
-- Name: findom_v_domande_graduatoria_x_filtro; Type: VIEW; Schema: findom_os; Owner: findom_os
--

CREATE VIEW findom_os.findom_v_domande_graduatoria_x_filtro AS
 SELECT d.id_bando,
    d.id_domanda,
    d.id_sportello_bando,
    i.id_tipol_intervento,
    d.id_tipol_beneficiario,
    d.flag_pubblico_privato
   FROM (findom_os.findom_v_domande_da_istruire_new d
     LEFT JOIN findom_os.findom_v_domande_tipol_interventi i ON ((i.id_domanda = d.id_domanda)));


ALTER TABLE findom_os.findom_v_domande_graduatoria_x_filtro OWNER TO findom_os;

--
-- TOC entry 16295 (class 1259 OID 31176096)
-- Name: findom_v_domande_interventi_spese; Type: VIEW; Schema: findom_os; Owner: findom_os
--

CREATE VIEW findom_os.findom_v_domande_interventi_spese AS
 SELECT a.id_domanda,
    ('FD'::text || a.id_domanda) AS numero_domanda,
    ((COALESCE(a.codice_dett_tipologia_intervento, (a.codice_tipologia_intervento)::text) || '_'::text) || (a.codice_spesa)::text) AS key_spesa,
    a.id_tipol_intervento,
    a.tipologia_intervento,
    a.codice_tipologia_intervento,
    a.id_dett_tipol_intervento,
    a.dettaglio_intervento,
    a.codice_dett_tipologia_intervento,
    a.id_voce_spesa,
    a.codice_spesa,
    a.voce_spesa,
    (replace(a.totalevocespesa, ','::text, '.'::text))::numeric AS replace
   FROM ( SELECT y.id_domanda,
            y.id_tipol_intervento,
            ti.descrizione AS tipologia_intervento,
            ti.codice AS codice_tipologia_intervento,
            NULL::integer AS id_dett_tipol_intervento,
            NULL::text AS dettaglio_intervento,
            NULL::text AS codice_dett_tipologia_intervento,
            y.id_voce_spesa,
            vs.descr_breve AS codice_spesa,
            vs.descrizione AS voce_spesa,
            y.totalevocespesa
           FROM ((( SELECT x.id_domanda,
                    ((unnest(xpath('//idTipoIntervento/text()'::text, x.cat)))::text)::integer AS id_tipol_intervento,
                    ((unnest(xpath('//idVoceSpesa/text()'::text, x.cat)))::text)::integer AS id_voce_spesa,
                    (unnest(xpath('//totaleVoceSpesa/text()'::text, x.cat)))::text AS totalevocespesa
                   FROM ( SELECT m.model_id AS id_domanda,
                            unnest(xpath('/tree-map/_pianoSpese/map/pianoSpeseList/list/map'::text, m.serialized_model)) AS cat
                           FROM findom_os.aggr_t_model m) x) y
             JOIN findom_os.findom_d_tipol_interventi ti ON ((y.id_tipol_intervento = ti.id_tipol_intervento)))
             JOIN findom_os.findom_d_voci_spesa vs ON ((y.id_voce_spesa = vs.id_voce_spesa)))
        UNION ALL
         SELECT y.id_domanda,
            ti.id_tipol_intervento,
            ti.descrizione AS tipologia_intervento,
            ti.codice AS codice_tipologia_intervento,
            y.id_dett_tipol_intervento,
            dti.descrizione AS dettaglio_intervento,
            dti.codice AS codice_dett_tipologia_intervento,
            y.id_voce_spesa,
            vs.descr_breve AS codice_spesa,
            vs.descrizione AS voce_spesa,
            y.totalevocespesa
           FROM (((( SELECT x.id_domanda,
                    ((unnest(xpath('//idDettIntervento/text()'::text, x.cat)))::text)::integer AS id_dett_tipol_intervento,
                    ((unnest(xpath('//idVoceSpesa/text()'::text, x.cat)))::text)::integer AS id_voce_spesa,
                    (unnest(xpath('//totaleVoceSpesa/text()'::text, x.cat)))::text AS totalevocespesa
                   FROM ( SELECT m.model_id AS id_domanda,
                            unnest(xpath('/tree-map/_pianoSpese/map/pianoSpeseList/list/map'::text, m.serialized_model)) AS cat
                           FROM findom_os.aggr_t_model m) x) y
             JOIN findom_os.findom_d_dett_tipol_interventi dti ON ((y.id_dett_tipol_intervento = dti.id_dett_tipol_intervento)))
             JOIN findom_os.findom_d_voci_spesa vs ON ((y.id_voce_spesa = vs.id_voce_spesa)))
             JOIN findom_os.findom_d_tipol_interventi ti ON ((ti.id_tipol_intervento = dti.id_tipol_intervento)))) a
  WHERE ((a.id_dett_tipol_intervento IS NULL) AND (NOT (EXISTS ( SELECT NULL::unknown AS unknown
           FROM ( SELECT y.id_domanda,
                    y.id_tipol_intervento,
                    ti.descrizione AS tipologia_intervento,
                    ti.codice AS codice_tipologia_intervento,
                    NULL::integer AS id_dett_tipol_intervento,
                    NULL::text AS dettaglio_intervento,
                    NULL::text AS codice_dett_tipologia_intervento,
                    y.id_voce_spesa,
                    vs.descr_breve AS codice_spesa,
                    vs.descrizione AS voce_spesa,
                    y.totalevocespesa
                   FROM ((( SELECT x.id_domanda,
                            ((unnest(xpath('//idTipoIntervento/text()'::text, x.cat)))::text)::integer AS id_tipol_intervento,
                            ((unnest(xpath('//idVoceSpesa/text()'::text, x.cat)))::text)::integer AS id_voce_spesa,
                            (unnest(xpath('//totaleVoceSpesa/text()'::text, x.cat)))::text AS totalevocespesa
                           FROM ( SELECT m.model_id AS id_domanda,
                                    unnest(xpath('/tree-map/_pianoSpese/map/pianoSpeseList/list/map'::text, m.serialized_model)) AS cat
                                   FROM findom_os.aggr_t_model m) x) y
                     JOIN findom_os.findom_d_tipol_interventi ti ON ((y.id_tipol_intervento = ti.id_tipol_intervento)))
                     JOIN findom_os.findom_d_voci_spesa vs ON ((y.id_voce_spesa = vs.id_voce_spesa)))
                UNION ALL
                 SELECT y.id_domanda,
                    ti.id_tipol_intervento,
                    ti.descrizione AS tipologia_intervento,
                    ti.codice AS codice_tipologia_intervento,
                    y.id_dett_tipol_intervento,
                    dti.descrizione AS dettaglio_intervento,
                    dti.codice AS codice_dett_tipologia_intervento,
                    y.id_voce_spesa,
                    vs.descrizione AS voce_spesa,
                    vs.descr_breve AS codice_spesa,
                    y.totalevocespesa
                   FROM (((( SELECT x.id_domanda,
                            ((unnest(xpath('//idDettIntervento/text()'::text, x.cat)))::text)::integer AS id_dett_tipol_intervento,
                            ((unnest(xpath('//idVoceSpesa/text()'::text, x.cat)))::text)::integer AS id_voce_spesa,
                            (unnest(xpath('//totaleVoceSpesa/text()'::text, x.cat)))::text AS totalevocespesa
                           FROM ( SELECT m.model_id AS id_domanda,
                                    unnest(xpath('/tree-map/_pianoSpese/map/pianoSpeseList/list/map'::text, m.serialized_model)) AS cat
                                   FROM findom_os.aggr_t_model m) x) y
                     JOIN findom_os.findom_d_dett_tipol_interventi dti ON ((y.id_dett_tipol_intervento = dti.id_dett_tipol_intervento)))
                     JOIN findom_os.findom_d_voci_spesa vs ON ((y.id_voce_spesa = vs.id_voce_spesa)))
                     JOIN findom_os.findom_d_tipol_interventi ti ON ((ti.id_tipol_intervento = dti.id_tipol_intervento)))) findom_v_domande_interventi_spese
          WHERE ((findom_v_domande_interventi_spese.id_domanda = a.id_domanda) AND (findom_v_domande_interventi_spese.id_tipol_intervento = a.id_tipol_intervento) AND (findom_v_domande_interventi_spese.id_voce_spesa = a.id_voce_spesa) AND (findom_v_domande_interventi_spese.id_dett_tipol_intervento IS NOT NULL))))))
UNION ALL
 SELECT a.id_domanda,
    ('FD'::text || a.id_domanda) AS numero_domanda,
    ((COALESCE(a.codice_dett_tipologia_intervento, (a.codice_tipologia_intervento)::text) || '_'::text) || (a.codice_spesa)::text) AS key_spesa,
    a.id_tipol_intervento,
    a.tipologia_intervento,
    a.codice_tipologia_intervento,
    a.id_dett_tipol_intervento,
    a.dettaglio_intervento,
    a.codice_dett_tipologia_intervento,
    a.id_voce_spesa,
    a.codice_spesa,
    a.voce_spesa,
    (replace(a.totalevocespesa, ','::text, '.'::text))::numeric AS replace
   FROM ( SELECT y.id_domanda,
            y.id_tipol_intervento,
            ti.descrizione AS tipologia_intervento,
            ti.codice AS codice_tipologia_intervento,
            NULL::integer AS id_dett_tipol_intervento,
            NULL::text AS dettaglio_intervento,
            NULL::text AS codice_dett_tipologia_intervento,
            y.id_voce_spesa,
            vs.descr_breve AS codice_spesa,
            vs.descrizione AS voce_spesa,
            y.totalevocespesa
           FROM ((( SELECT x.id_domanda,
                    ((unnest(xpath('//idTipoIntervento/text()'::text, x.cat)))::text)::integer AS id_tipol_intervento,
                    ((unnest(xpath('//idVoceSpesa/text()'::text, x.cat)))::text)::integer AS id_voce_spesa,
                    (unnest(xpath('//totaleVoceSpesa/text()'::text, x.cat)))::text AS totalevocespesa
                   FROM ( SELECT m.model_id AS id_domanda,
                            unnest(xpath('/tree-map/_pianoSpese/map/pianoSpeseList/list/map'::text, m.serialized_model)) AS cat
                           FROM findom_os.aggr_t_model m) x) y
             JOIN findom_os.findom_d_tipol_interventi ti ON ((y.id_tipol_intervento = ti.id_tipol_intervento)))
             JOIN findom_os.findom_d_voci_spesa vs ON ((y.id_voce_spesa = vs.id_voce_spesa)))
        UNION ALL
         SELECT y.id_domanda,
            ti.id_tipol_intervento,
            ti.descrizione AS tipologia_intervento,
            ti.codice AS codice_tipologia_intervento,
            y.id_dett_tipol_intervento,
            dti.descrizione AS dettaglio_intervento,
            dti.codice AS codice_dett_tipologia_intervento,
            y.id_voce_spesa,
            vs.descr_breve AS codice_spesa,
            vs.descrizione AS voce_spesa,
            y.totalevocespesa
           FROM (((( SELECT x.id_domanda,
                    ((unnest(xpath('//idDettIntervento/text()'::text, x.cat)))::text)::integer AS id_dett_tipol_intervento,
                    ((unnest(xpath('//idVoceSpesa/text()'::text, x.cat)))::text)::integer AS id_voce_spesa,
                    (unnest(xpath('//totaleVoceSpesa/text()'::text, x.cat)))::text AS totalevocespesa
                   FROM ( SELECT m.model_id AS id_domanda,
                            unnest(xpath('/tree-map/_pianoSpese/map/pianoSpeseList/list/map'::text, m.serialized_model)) AS cat
                           FROM findom_os.aggr_t_model m) x) y
             JOIN findom_os.findom_d_dett_tipol_interventi dti ON ((y.id_dett_tipol_intervento = dti.id_dett_tipol_intervento)))
             JOIN findom_os.findom_d_voci_spesa vs ON ((y.id_voce_spesa = vs.id_voce_spesa)))
             JOIN findom_os.findom_d_tipol_interventi ti ON ((ti.id_tipol_intervento = dti.id_tipol_intervento)))) a
  WHERE (a.id_dett_tipol_intervento IS NOT NULL)
  ORDER BY 1;


ALTER TABLE findom_os.findom_v_domande_interventi_spese OWNER TO findom_os;

--
-- TOC entry 16296 (class 1259 OID 31176101)
-- Name: findom_v_domande_inviate_da_elaborare; Type: VIEW; Schema: findom_os; Owner: findom_os
--

CREATE VIEW findom_os.findom_v_domande_inviate_da_elaborare AS
 SELECT x.id_domanda,
    (((((x.pref_classificazione || '_'::text) || x.data_invio_domanda) || '_'::text) || x.blocco) || '_XML.zip'::text) AS zip_nome_file_xml,
    (((((x.pref_classificazione || '_'::text) || x.data_invio_domanda) || '_'::text) || x.blocco) || '_PDF.zip'::text) AS zip_nome_file_pdf,
    x.nome_file_xml,
    x.nome_file_pdf,
    x.dest_file_domanda,
    x.serialized_model,
    x.template_id,
    x.flag_trasformata_ok
   FROM ( SELECT d.id_domanda,
            b.template_id,
            fd.flag_trasformata_ok,
            md.serialized_model,
            ((((((replace((n.descr_breve)::text, ' '::text, '_'::text) || '_'::text) || (ap.codice)::text) || '_'::text) || (pi.codice)::text) || '_'::text) || replace((az.codice)::text, '.'::text, '-'::text)) AS pref_classificazione,
            (((((((((((((replace((n.descr_breve)::text, ' '::text, '_'::text) || '_'::text) || (ap.codice)::text) || '_'::text) || (pi.codice)::text) || '_'::text) || replace((az.codice)::text, '.'::text, '-'::text)) || '_'::text) || d.id_domanda) || '_'::text) || d.id_soggetto_beneficiario) || '_'::text) || to_char(d.dt_invio_domanda, 'DDMMYYYYHH24MISS'::text)) || '.xml'::text) AS nome_file_xml,
            (((((((((((((replace((n.descr_breve)::text, ' '::text, '_'::text) || '_'::text) || (ap.codice)::text) || '_'::text) || (pi.codice)::text) || '_'::text) || replace((az.codice)::text, '.'::text, '-'::text)) || '_'::text) || d.id_domanda) || '_'::text) || d.id_soggetto_beneficiario) || '_'::text) || to_char(d.dt_invio_domanda, 'DDMMYYYYHH24MISS'::text)) || '.pdf'::text) AS nome_file_pdf,
            p.num_max_file_in_zip,
            e.dest_file_domanda,
            to_char(((d.dt_invio_domanda)::date)::timestamp without time zone, 'YYYYMMDD'::text) AS data_invio_domanda,
            ceil(((row_number() OVER (PARTITION BY n.descr_breve, ap.codice, pi.codice, az.codice, b.id_bando, ((d.dt_invio_domanda)::date) ORDER BY d.id_domanda))::numeric / (p.num_max_file_in_zip)::numeric)) AS blocco
           FROM (((((((((((((((findom_os.shell_t_domande d
             JOIN findom_os.shell_t_file_domande fd ON ((fd.id_domanda = d.id_domanda)))
             JOIN findom_os.findom_d_parametri p ON (((p.codice)::bpchar = 'FILE_DOMANDA'::bpchar)))
             JOIN findom_os.aggr_t_model md ON ((md.model_id = d.id_domanda)))
             JOIN findom_os.aggr_d_model_state ms ON (((ms.model_state)::text = (md.model_state_fk)::text)))
             LEFT JOIN findom_os.istr_t_model imd ON ((imd.model_id = d.id_domanda)))
             LEFT JOIN findom_os.istr_d_model_state ims ON (((ims.model_state)::text = (imd.model_state_fk)::text)))
             LEFT JOIN findom_os.findom_d_stato_istruttoria si ON ((si.id_stato_istr = d.id_stato_istr)))
             JOIN findom_os.findom_t_sportelli_bandi sp ON ((sp.id_sportello_bando = d.id_sportello_bando)))
             JOIN findom_os.findom_t_bandi b ON ((b.id_bando = sp.id_bando)))
             JOIN findom_os.findom_d_enti e ON ((e.id_ente = b.id_ente_destinatario)))
             JOIN findom_os.findom_d_classif_bandi az ON (((az.id_classificazione = b.id_classificazione) AND (az.id_tipo_suddivisione = 5))))
             JOIN findom_os.findom_d_classif_bandi os ON (((az.id_classificazione_padre = os.id_classificazione) AND (os.id_tipo_suddivisione = 4))))
             JOIN findom_os.findom_d_classif_bandi pi ON (((os.id_classificazione_padre = pi.id_classificazione) AND (pi.id_tipo_suddivisione = 3))))
             JOIN findom_os.findom_d_classif_bandi ap ON (((pi.id_classificazione_padre = ap.id_classificazione) AND (ap.id_tipo_suddivisione = 1))))
             JOIN findom_os.findom_d_normative n ON ((n.id_normativa = ap.id_normativa)))
          WHERE (((((ms.model_state)::text = 'IN'::text) AND ((e.dest_file_domanda)::text = ANY (ARRAY[('FINPIEMONTE'::character varying)::text, ('FINPIEMONTE_SIFPL'::character varying)::text, ('REGIONE_FINPIS'::character varying)::text, ('FINPIEMONTE_NO_PB'::character varying)::text]))) OR ((((ims.model_state)::text = 'AM'::text) OR ((si.codice)::text = 'ALE'::text)) AND ((e.dest_file_domanda)::text = 'REGIONE'::text))) AND (fd.dt_invio_file IS NULL) AND (d.dt_invio_domanda IS NOT NULL) AND ((d.dt_invio_domanda)::date < ('now'::text)::date))
        UNION ALL
         SELECT d.id_domanda,
            b.template_id,
            fd.flag_trasformata_ok,
            md.serialized_model,
            ((((replace((n.descr_breve)::text, ' '::text, '_'::text) || '_'::text) || (ap.codice)::text) || '__'::text) || (az.codice)::text) AS pref_classificazione,
            (((((((((((replace((n.descr_breve)::text, ' '::text, '_'::text) || '_'::text) || (ap.codice)::text) || '__'::text) || replace((az.codice)::text, '.'::text, '-'::text)) || '_'::text) || d.id_domanda) || '_'::text) || d.id_soggetto_beneficiario) || '_'::text) || to_char(d.dt_invio_domanda, 'DDMMYYYYHH24MISS'::text)) || '.xml'::text) AS nome_file_xml,
            (((((((((((replace((n.descr_breve)::text, ' '::text, '_'::text) || '_'::text) || (ap.codice)::text) || '__'::text) || replace((az.codice)::text, '.'::text, '-'::text)) || '_'::text) || d.id_domanda) || '_'::text) || d.id_soggetto_beneficiario) || '_'::text) || to_char(d.dt_invio_domanda, 'DDMMYYYYHH24MISS'::text)) || '.pdf'::text) AS nome_file_pdf,
            p.num_max_file_in_zip,
            e.dest_file_domanda,
            to_char(((d.dt_invio_domanda)::date)::timestamp without time zone, 'YYYYMMDD'::text) AS data_invio_domanda,
            ceil(((row_number() OVER (PARTITION BY n.descr_breve, ap.codice, az.codice, b.id_bando, ((d.dt_invio_domanda)::date) ORDER BY d.id_domanda))::numeric / (p.num_max_file_in_zip)::numeric)) AS blocco
           FROM ((((((((((((((findom_os.shell_t_domande d
             JOIN findom_os.shell_t_file_domande fd ON ((fd.id_domanda = d.id_domanda)))
             JOIN findom_os.findom_d_parametri p ON (((p.codice)::bpchar = 'FILE_DOMANDA'::bpchar)))
             JOIN findom_os.aggr_t_model md ON ((md.model_id = d.id_domanda)))
             JOIN findom_os.aggr_d_model_state ms ON (((ms.model_state)::text = (md.model_state_fk)::text)))
             LEFT JOIN findom_os.istr_t_model imd ON ((imd.model_id = d.id_domanda)))
             LEFT JOIN findom_os.istr_d_model_state ims ON (((ims.model_state)::text = (imd.model_state_fk)::text)))
             LEFT JOIN findom_os.findom_d_stato_istruttoria si ON ((si.id_stato_istr = d.id_stato_istr)))
             JOIN findom_os.findom_t_sportelli_bandi sp ON ((sp.id_sportello_bando = d.id_sportello_bando)))
             JOIN findom_os.findom_t_bandi b ON ((b.id_bando = sp.id_bando)))
             JOIN findom_os.findom_d_enti e ON ((e.id_ente = b.id_ente_destinatario)))
             JOIN findom_os.findom_d_classif_bandi az ON (((az.id_classificazione = b.id_classificazione) AND (az.id_tipo_suddivisione = 5))))
             JOIN findom_os.findom_d_classif_bandi os ON (((az.id_classificazione_padre = os.id_classificazione) AND (os.id_tipo_suddivisione = 4))))
             JOIN findom_os.findom_d_classif_bandi ap ON (((os.id_classificazione_padre = ap.id_classificazione) AND (ap.id_tipo_suddivisione = 1))))
             JOIN findom_os.findom_d_normative n ON ((n.id_normativa = ap.id_normativa)))
          WHERE (((((ms.model_state)::text = 'IN'::text) AND ((e.dest_file_domanda)::text = ANY (ARRAY[('FINPIEMONTE'::character varying)::text, ('FINPIEMONTE_SIFPL'::character varying)::text, ('REGIONE_FINPIS'::character varying)::text, ('FINPIEMONTE_NO_PB'::character varying)::text]))) OR ((((ims.model_state)::text = 'AM'::text) OR ((si.codice)::text = 'ALE'::text)) AND ((e.dest_file_domanda)::text = 'REGIONE'::text))) AND (fd.dt_invio_file IS NULL) AND (d.dt_invio_domanda IS NOT NULL) AND ((d.dt_invio_domanda)::date < ('now'::text)::date))) x;


ALTER TABLE findom_os.findom_v_domande_inviate_da_elaborare OWNER TO findom_os;

--
-- TOC entry 16297 (class 1259 OID 31176106)
-- Name: findom_v_domande_istr; Type: VIEW; Schema: findom_os; Owner: findom_os
--

CREATE VIEW findom_os.findom_v_domande_istr AS
 SELECT d.id_domanda,
    ms.model_state AS cod_stato_domanda,
    ms.model_state_descr AS stato_domanda,
    sis.codice AS cod_stato_istruttoria_new,
    sis.descrizione AS stato_istruttoria_new,
    ims.model_state AS cod_stato_istruttoria,
    ims.model_state_descr AS stato_istruttoria,
    funz.id_funzionario AS id_istruttore_amm,
    funz.cod_fiscale AS codice_fiscale_istruttore_amm,
    funz.cognome AS cognome_istruttore_amm,
    funz.nome AS nome_istruttore_amm,
    decis.id_funzionario AS id_decisore,
    decis.cod_fiscale AS codice_fiscale_decisore,
    decis.cognome AS cognome_decisore,
    decis.nome AS nome_decisore,
    dp.num_protocollo AS numero_protocollo,
    to_char(dp.dt_protocollo, 'DD/MM/YYYY HH24:MI'::text) AS data_protocollo,
    dp.classificazione_acta,
    to_char(dp.dt_classificazione, 'DD/MM/YYYY HH24:MI'::text) AS data_classificazione,
    tb.id_tipol_beneficiario,
    tb.descrizione AS descrizione_tipol_beneficiario,
    tb.codice AS codice_tipol_beneficiario,
        CASE
            WHEN (tb.flag_pubblico_privato = (1)::numeric) THEN 'Privato'::text
            WHEN (tb.flag_pubblico_privato = (2)::numeric) THEN 'Pubblico'::text
            ELSE NULL::text
        END AS tipo_ente_beneficiario,
    tb.cod_stereotipo,
    st.descr_stereotipo,
    tb.flag_pubblico_privato,
    d.id_soggetto_creatore,
    sc.cognome AS cognome_soggetto_creatore,
    sc.nome AS nome_soggetto_creatore,
    to_char(d.dt_creazione, 'DD/MM/YYYY HH24:MI'::text) AS dt_creazione_domanda,
    d.id_soggetto_conclusione,
    sl.cognome AS cognome_soggetto_conclusione,
    sl.nome AS nome_soggetto_conclusione,
    to_char(d.dt_conclusione, 'DD/MM/YYYY HH24:MI'::text) AS dt_conclusione,
    d.id_soggetto_invio,
    si.cognome AS cognome_soggetto_invio,
    si.nome AS nome_soggetto_invio,
    to_char(d.dt_invio_domanda, 'DD/MM/YYYY HH24:MI'::text) AS dt_invio_domanda,
    d.id_soggetto_beneficiario,
    sb.denominazione AS denominazione_soggetto_beneficiario,
    sb.cod_fiscale AS cod_fiscale_beneficiario,
    sb.sigla_nazione,
    sp.id_sportello_bando,
    sp.num_atto,
    sp.dt_atto,
    to_char(sp.dt_apertura, 'DD/MM/YYYY HH24:MI'::text) AS dt_apertura_sportello,
    to_char(sp.dt_chiusura, 'DD/MM/YYYY HH24:MI'::text) AS dt_chiusura_sportello,
    sp.id_bando,
    b.flag_demat,
    b.tipo_firma,
    b.descrizione AS descr_bando,
    b.flag_progetti_comuni,
    (((az.codice)::text || ' - '::text) || (b.descr_breve)::text) AS descr_breve_bando,
    b.id_ente_destinatario AS id_ente,
    n.id_normativa,
    n.descr_breve AS normativa,
    ap.id_classificazione AS id_classificazione_asse_prioritario,
    ap.codice AS codice_asse_prioritario,
    ap.descrizione AS descrizione_asse_prioritario,
    pi.id_classificazione AS id_classificazione_priorita_investimento,
    pi.codice AS codice_priorita_investimento,
    pi.descrizione AS descrizione_priorita_investimento,
    os.id_classificazione AS id_classificazione_misura,
    os.codice AS codice_misura,
    os.descrizione AS descrizione_misura,
    az.id_classificazione AS id_classificazione_azione,
    az.codice AS codice_azione,
    az.descrizione AS descrizione_azione,
        CASE
            WHEN ((e.dest_file_domanda)::text = 'REGIONE'::text) THEN 'REGIONE PIEMONTE'::character varying
            WHEN ((e.dest_file_domanda)::text = 'FINPIEMONTE'::text) THEN 'FINPIEMONTE S.p.A.'::character varying
            ELSE e.dest_file_domanda
        END AS destinatario_descrizione,
        CASE
            WHEN ((e.dest_file_domanda)::text = 'FINPIEMONTE'::text) THEN NULL::character varying
            ELSE e.descrizione
        END AS destinatario_direzione,
    e.indirizzo AS destinatario_indirizzo,
    e.cap AS destinatario_cap,
    e.descr_comune AS destinatario_citta,
    e.sigla_prov AS destinatario_provincia,
    e.pec AS destinatario_pec,
    (((((((n.descr_breve)::text || ' '::text) || (ap.codice)::text) || ' '::text) || (os.codice)::text) || '-'::text) || (b.descr_breve)::text) AS norma_incentivazione,
    ( SELECT string_agg((x.codice)::text, '-'::text) AS string_agg
           FROM ( SELECT b_1.id_bando,
                    a.codice
                   FROM findom_os.findom_d_tipol_interventi a,
                    findom_os.findom_r_bandi_tipol_interventi b_1
                  WHERE ((a.id_tipol_intervento = b_1.id_tipol_intervento) AND (b_1.id_bando = sp.id_bando))
                  ORDER BY a.codice) x
          GROUP BY x.id_bando) AS codice_intervento,
    ( SELECT string_agg(x.descrizione, ' - '::text) AS string_agg
           FROM ( SELECT b_1.id_bando,
                    a.descrizione
                   FROM findom_os.findom_d_tipol_interventi a,
                    findom_os.findom_r_bandi_tipol_interventi b_1
                  WHERE ((a.id_tipol_intervento = b_1.id_tipol_intervento) AND (b_1.id_bando = sp.id_bando))
                  ORDER BY a.codice) x
          GROUP BY x.id_bando) AS descrizione_intervento,
    at.id_area_tematica,
    at.descrizione AS descrizione_area_tematica
   FROM ((((((((((((((((((((((((findom_os.shell_t_domande d
     JOIN findom_os.aggr_t_model m ON ((m.model_id = d.id_domanda)))
     JOIN findom_os.aggr_d_model_state ms ON (((ms.model_state)::text = (m.model_state_fk)::text)))
     LEFT JOIN findom_os.istr_t_model i ON ((i.model_id = d.id_domanda)))
     LEFT JOIN findom_os.findom_d_stato_istruttoria sis ON (((sis.id_stato_istr)::text = (d.id_stato_istr)::text)))
     LEFT JOIN findom_os.istr_d_model_state ims ON (((ims.model_state)::text = (i.model_state_fk)::text)))
     LEFT JOIN findom_os.findom_d_funzionari funz ON ((funz.id_funzionario = d.id_istruttore_amm)))
     LEFT JOIN findom_os.findom_d_funzionari decis ON ((decis.id_funzionario = d.id_decisore)))
     JOIN findom_os.findom_d_tipol_beneficiari tb ON ((tb.id_tipol_beneficiario = d.id_tipol_beneficiario)))
     JOIN findom_os.findom_d_stereotipi st ON (((st.cod_stereotipo)::text = (tb.cod_stereotipo)::text)))
     JOIN findom_os.shell_t_soggetti sc ON ((sc.id_soggetto = d.id_soggetto_creatore)))
     JOIN findom_os.shell_t_soggetti sb ON ((sb.id_soggetto = d.id_soggetto_beneficiario)))
     LEFT JOIN findom_os.shell_t_soggetti si ON ((si.id_soggetto = d.id_soggetto_invio)))
     LEFT JOIN findom_os.shell_t_soggetti sl ON ((sl.id_soggetto = d.id_soggetto_conclusione)))
     LEFT JOIN findom_os.shell_t_documento_index di ON (((di.id_domanda = d.id_domanda) AND (di.id_allegato IS NULL))))
     LEFT JOIN findom_os.shell_t_documento_prot dp ON ((dp.id_documento_index = di.id_documento_index)))
     JOIN findom_os.findom_t_sportelli_bandi sp ON ((sp.id_sportello_bando = d.id_sportello_bando)))
     JOIN findom_os.findom_t_bandi b ON ((b.id_bando = sp.id_bando)))
     LEFT JOIN findom_os.findom_d_area_tematica at ON ((at.id_area_tematica = b.id_area_tematica)))
     JOIN findom_os.findom_d_enti e ON ((e.id_ente = b.id_ente_destinatario)))
     JOIN findom_os.findom_d_classif_bandi az ON (((az.id_classificazione = b.id_classificazione) AND (az.id_tipo_suddivisione = 5))))
     JOIN findom_os.findom_d_classif_bandi os ON (((az.id_classificazione_padre = os.id_classificazione) AND (os.id_tipo_suddivisione = 4))))
     JOIN findom_os.findom_d_classif_bandi pi ON (((os.id_classificazione_padre = pi.id_classificazione) AND (pi.id_tipo_suddivisione = 3))))
     JOIN findom_os.findom_d_classif_bandi ap ON (((pi.id_classificazione_padre = ap.id_classificazione) AND (ap.id_tipo_suddivisione = 1))))
     JOIN findom_os.findom_d_normative n ON ((n.id_normativa = ap.id_normativa)))
UNION ALL
 SELECT d.id_domanda,
    ms.model_state AS cod_stato_domanda,
    ms.model_state_descr AS stato_domanda,
    sis.codice AS cod_stato_istruttoria_new,
    sis.descrizione AS stato_istruttoria_new,
    ims.model_state AS cod_stato_istruttoria,
    ims.model_state_descr AS stato_istruttoria,
    funz.id_funzionario AS id_istruttore_amm,
    funz.cod_fiscale AS codice_fiscale_istruttore_amm,
    funz.cognome AS cognome_istruttore_amm,
    funz.nome AS nome_istruttore_amm,
    decis.id_funzionario AS id_decisore,
    decis.cod_fiscale AS codice_fiscale_decisore,
    decis.cognome AS cognome_decisore,
    decis.nome AS nome_decisore,
    dp.num_protocollo AS numero_protocollo,
    to_char(dp.dt_protocollo, 'DD/MM/YYYY HH24:MI'::text) AS data_protocollo,
    dp.classificazione_acta,
    to_char(dp.dt_classificazione, 'DD/MM/YYYY HH24:MI'::text) AS data_classificazione,
    tb.id_tipol_beneficiario,
    tb.descrizione AS descrizione_tipol_beneficiario,
    tb.codice AS codice_tipol_beneficiario,
        CASE
            WHEN (tb.flag_pubblico_privato = (1)::numeric) THEN 'Privato'::text
            WHEN (tb.flag_pubblico_privato = (2)::numeric) THEN 'Pubblico'::text
            ELSE NULL::text
        END AS tipo_ente_beneficiario,
    tb.cod_stereotipo,
    st.descr_stereotipo,
    tb.flag_pubblico_privato,
    d.id_soggetto_creatore,
    sc.cognome AS cognome_soggetto_creatore,
    sc.nome AS nome_soggetto_creatore,
    to_char(d.dt_creazione, 'DD/MM/YYYY HH24:MI'::text) AS dt_creazione_domanda,
    d.id_soggetto_conclusione,
    sl.cognome AS cognome_soggetto_conclusione,
    sl.nome AS nome_soggetto_conclusione,
    to_char(d.dt_conclusione, 'DD/MM/YYYY HH24:MI'::text) AS dt_conclusione,
    d.id_soggetto_invio,
    si.cognome AS cognome_soggetto_invio,
    si.nome AS nome_soggetto_invio,
    to_char(d.dt_invio_domanda, 'DD/MM/YYYY HH24:MI'::text) AS dt_invio_domanda,
    d.id_soggetto_beneficiario,
    sb.denominazione AS denominazione_soggetto_beneficiario,
    sb.cod_fiscale AS cod_fiscale_beneficiario,
    sb.sigla_nazione,
    sp.id_sportello_bando,
    sp.num_atto,
    sp.dt_atto,
    to_char(sp.dt_apertura, 'DD/MM/YYYY HH24:MI'::text) AS dt_apertura_sportello,
    to_char(sp.dt_chiusura, 'DD/MM/YYYY HH24:MI'::text) AS dt_chiusura_sportello,
    sp.id_bando,
    b.flag_demat,
    b.tipo_firma,
    b.descrizione AS descr_bando,
    b.flag_progetti_comuni,
    (((az.codice)::text || ' - '::text) || (b.descr_breve)::text) AS descr_breve_bando,
    b.id_ente_destinatario AS id_ente,
    n.id_normativa,
    n.descr_breve AS normativa,
    ap.id_classificazione AS id_classificazione_asse_prioritario,
    ap.codice AS codice_asse_prioritario,
    ap.descrizione AS descrizione_asse_prioritario,
    NULL::integer AS id_classificazione_priorita_investimento,
    NULL::character varying AS codice_priorita_investimento,
    NULL::character varying AS descrizione_priorita_investimento,
    os.id_classificazione AS id_classificazione_misura,
    os.codice AS codice_misura,
    os.descrizione AS descrizione_misura,
    az.id_classificazione AS id_classificazione_azione,
    az.codice AS codice_azione,
    az.descrizione AS descrizione_azione,
        CASE
            WHEN ((e.dest_file_domanda)::text = 'REGIONE'::text) THEN 'REGIONE PIEMONTE'::character varying
            WHEN ((e.dest_file_domanda)::text = 'FINPIEMONTE'::text) THEN 'FINPIEMONTE S.p.A.'::character varying
            ELSE e.dest_file_domanda
        END AS destinatario_descrizione,
        CASE
            WHEN ((e.dest_file_domanda)::text = 'FINPIEMONTE'::text) THEN NULL::character varying
            ELSE e.descrizione
        END AS destinatario_direzione,
    e.indirizzo AS destinatario_indirizzo,
    e.cap AS destinatario_cap,
    e.descr_comune AS destinatario_citta,
    e.sigla_prov AS destinatario_provincia,
    e.pec AS destinatario_pec,
    (((((((n.descr_breve)::text || ' '::text) || (ap.codice)::text) || ' '::text) || (os.codice)::text) || '-'::text) || (b.descr_breve)::text) AS norma_incentivazione,
    ( SELECT string_agg((x.codice)::text, '-'::text) AS string_agg
           FROM ( SELECT b_1.id_bando,
                    a.codice
                   FROM findom_os.findom_d_tipol_interventi a,
                    findom_os.findom_r_bandi_tipol_interventi b_1
                  WHERE ((a.id_tipol_intervento = b_1.id_tipol_intervento) AND (b_1.id_bando = sp.id_bando))
                  ORDER BY a.codice) x
          GROUP BY x.id_bando) AS codice_intervento,
    ( SELECT string_agg(x.descrizione, ' - '::text) AS string_agg
           FROM ( SELECT b_1.id_bando,
                    a.descrizione
                   FROM findom_os.findom_d_tipol_interventi a,
                    findom_os.findom_r_bandi_tipol_interventi b_1
                  WHERE ((a.id_tipol_intervento = b_1.id_tipol_intervento) AND (b_1.id_bando = sp.id_bando))
                  ORDER BY a.codice) x
          GROUP BY x.id_bando) AS descrizione_intervento,
    at.id_area_tematica,
    at.descrizione AS descrizione_area_tematica
   FROM (((((((((((((((((((((((findom_os.shell_t_domande d
     JOIN findom_os.aggr_t_model m ON ((m.model_id = d.id_domanda)))
     JOIN findom_os.aggr_d_model_state ms ON (((ms.model_state)::text = (m.model_state_fk)::text)))
     LEFT JOIN findom_os.istr_t_model i ON ((i.model_id = d.id_domanda)))
     LEFT JOIN findom_os.findom_d_stato_istruttoria sis ON (((sis.id_stato_istr)::text = (d.id_stato_istr)::text)))
     LEFT JOIN findom_os.istr_d_model_state ims ON (((ims.model_state)::text = (i.model_state_fk)::text)))
     LEFT JOIN findom_os.findom_d_funzionari funz ON ((funz.id_funzionario = d.id_istruttore_amm)))
     LEFT JOIN findom_os.findom_d_funzionari decis ON ((decis.id_funzionario = d.id_decisore)))
     JOIN findom_os.findom_d_tipol_beneficiari tb ON ((tb.id_tipol_beneficiario = d.id_tipol_beneficiario)))
     JOIN findom_os.findom_d_stereotipi st ON (((st.cod_stereotipo)::text = (tb.cod_stereotipo)::text)))
     JOIN findom_os.shell_t_soggetti sc ON ((sc.id_soggetto = d.id_soggetto_creatore)))
     JOIN findom_os.shell_t_soggetti sb ON ((sb.id_soggetto = d.id_soggetto_beneficiario)))
     LEFT JOIN findom_os.shell_t_soggetti si ON ((si.id_soggetto = d.id_soggetto_invio)))
     LEFT JOIN findom_os.shell_t_soggetti sl ON ((sl.id_soggetto = d.id_soggetto_conclusione)))
     LEFT JOIN findom_os.shell_t_documento_index di ON (((di.id_domanda = d.id_domanda) AND (di.id_allegato IS NULL))))
     LEFT JOIN findom_os.shell_t_documento_prot dp ON ((dp.id_documento_index = di.id_documento_index)))
     JOIN findom_os.findom_t_sportelli_bandi sp ON ((sp.id_sportello_bando = d.id_sportello_bando)))
     JOIN findom_os.findom_t_bandi b ON ((b.id_bando = sp.id_bando)))
     LEFT JOIN findom_os.findom_d_area_tematica at ON ((at.id_area_tematica = b.id_area_tematica)))
     JOIN findom_os.findom_d_enti e ON ((e.id_ente = b.id_ente_destinatario)))
     JOIN findom_os.findom_d_classif_bandi az ON (((az.id_classificazione = b.id_classificazione) AND (az.id_tipo_suddivisione = 5))))
     JOIN findom_os.findom_d_classif_bandi os ON (((az.id_classificazione_padre = os.id_classificazione) AND (os.id_tipo_suddivisione = 4))))
     JOIN findom_os.findom_d_classif_bandi ap ON (((os.id_classificazione_padre = ap.id_classificazione) AND (ap.id_tipo_suddivisione = 1))))
     JOIN findom_os.findom_d_normative n ON ((n.id_normativa = ap.id_normativa)));


ALTER TABLE findom_os.findom_v_domande_istr OWNER TO findom_os;


--
-- TOC entry 16299 (class 1259 OID 31176117)
-- Name: findom_v_domande_istruite; Type: VIEW; Schema: findom_os; Owner: findom_os
--

CREATE VIEW findom_os.findom_v_domande_istruite AS
 WITH cte_valutaz AS (
         SELECT x_1.id_bando,
            x_1.descr_breve_bando,
            x_1.flag_valutazione_esterna,
            x_1.id_sportello_bando,
            x_1.dt_apertura,
            x_1.dt_chiusura,
            x_1.id_domanda,
            x_1.id_tipol_intervento,
            x_1.descrizione_tipol_intervento,
            x_1.stato_valut,
            x_1.denominazione_beneficiario,
            x_1.codice_fiscale_beneficiario,
            x_1.id_tipol_beneficiario,
            x_1.codice_tipol_beneficiario,
            x_1.flag_pubblico_privato,
            x_1.id_stato_istruttoria,
            x_1.cod_stato_istruttoria,
            x_1.stato_istruttoria,
            x_1.ordine_in_graduatoria_with_valut,
            x_1.ordine_in_graduatoria_without_valut,
            x_1.id_motivazione_esito,
            x_1.descr_motivazione_esito,
            x_1.id_istruttore_amm,
            x_1.cognome_istruttore_amm,
            x_1.nome_istruttore_amm,
            x_1.id_decisore,
            x_1.cognome_decisore,
            x_1.nome_decisore,
            x_1.dt_richiesta_integrazione,
            x_1.flag_abilita_integrazione,
            x_1.id_criterio,
            x_1.descrizione_criterio,
            x_1.descr_breve_criterio,
            sum(x_1.punteggio) AS punteggio,
            x_1.tot_punteggio_domanda,
            x_1.tot_punteggio_priorita_criterio,
            x_1.priorita_graduatoria,
            x_1.ordine
           FROM ( SELECT b.id_bando,
                    b.descr_breve AS descr_breve_bando,
                    b.flag_valutazione_esterna,
                    sb.id_sportello_bando,
                    to_char(sb.dt_apertura, 'YYYY-MM-DD HH24:MI:SS'::text) AS dt_apertura,
                    to_char(sb.dt_chiusura, 'YYYY-MM-DD HH24:MI:SS'::text) AS dt_chiusura,
                    vd.id_domanda,
                    ti.id_tipol_intervento,
                    ti.descrizione AS descrizione_tipol_intervento,
                    vd.stato_valut,
                    s.cod_fiscale AS codice_fiscale_beneficiario,
                    s.denominazione AS denominazione_beneficiario,
                    tb.id_tipol_beneficiario,
                    tb.codice AS codice_tipol_beneficiario,
                    tb.flag_pubblico_privato,
                    si.id_stato_istr AS id_stato_istruttoria,
                    si.codice AS cod_stato_istruttoria,
                    si.descrizione AS stato_istruttoria,
                    si.ordine_in_graduatoria_with_valut,
                    si.ordine_in_graduatoria_without_valut,
                    f.id_funzionario AS id_istruttore_amm,
                    f.cognome AS cognome_istruttore_amm,
                    f.nome AS nome_istruttore_amm,
                    f1.id_funzionario AS id_decisore,
                    f1.cognome AS cognome_decisore,
                    f1.nome AS nome_decisore,
                    to_char((d.dt_richiesta_integrazione)::timestamp with time zone, 'dd/mm/yyyy'::text) AS dt_richiesta_integrazione,
                    d.flag_abilita_integrazione,
                    me.id_motivazione_esito,
                    me.descr_motivazione_esito,
                    cv.id_criterio,
                    cv.descrizione AS descrizione_criterio,
                    cv.descr_breve AS descr_breve_criterio,
                    sv.descrizione AS descrizione_specifica,
                    psv.descrizione AS descrizione_parametro,
                    vd.punteggio,
                    sum(vd.punteggio) OVER (PARTITION BY vd.id_domanda, vd.stato_valut, cv.id_criterio) AS tot_punteggio_criterio,
                    sum(vd.punteggio) OVER (PARTITION BY vd.id_domanda, vd.stato_valut) AS tot_punteggio_domanda,
                    sum((vd.punteggio * power((100)::numeric, ((100)::numeric - (COALESCE(bcv.priorita_graduatoria, 0))::numeric)))) OVER (PARTITION BY vd.id_domanda, vd.stato_valut) AS tot_punteggio_priorita_criterio,
                    COALESCE(bcv.priorita_graduatoria, 0) AS priorita_graduatoria,
                    bcv.ordine
                   FROM (((((((((((((((findom_os.findom_r_bandi_criteri_valut bcv
                     LEFT JOIN findom_os.findom_d_tipol_interventi ti ON ((ti.id_tipol_intervento = bcv.id_tipol_intervento)))
                     JOIN findom_os.findom_d_criteri_valut cv ON ((cv.id_criterio = bcv.id_criterio)))
                     JOIN findom_os.findom_d_specifiche_valut sv ON ((sv.id_criterio = cv.id_criterio)))
                     JOIN findom_os.findom_t_parametri_valut pv ON (((pv.id_specifica = sv.id_specifica) AND (pv.id_bando = bcv.id_bando))))
                     JOIN findom_os.findom_d_parametri_specifiche_valut psv ON ((psv.id_parametro = pv.id_parametro)))
                     JOIN findom_os.shell_t_valut_domande vd ON (((vd.id_parametro_valut = pv.id_parametro_valut) AND (vd.stato_valut <> 'D'::bpchar))))
                     JOIN findom_os.findom_t_bandi b ON ((b.id_bando = bcv.id_bando)))
                     JOIN findom_os.shell_t_domande d ON ((d.id_domanda = vd.id_domanda)))
                     JOIN findom_os.findom_d_tipol_beneficiari tb ON ((tb.id_tipol_beneficiario = d.id_tipol_beneficiario)))
                     JOIN findom_os.findom_t_sportelli_bandi sb ON (((sb.id_sportello_bando = d.id_sportello_bando) AND (sb.id_bando = bcv.id_bando))))
                     LEFT JOIN findom_os.shell_t_soggetti s ON ((s.id_soggetto = d.id_soggetto_beneficiario)))
                     JOIN findom_os.findom_d_stato_istruttoria si ON (((si.id_stato_istr = d.id_stato_istr) AND (si.flag_stato_finale IS NOT NULL))))
                     LEFT JOIN findom_os.findom_d_funzionari f ON ((f.id_funzionario = d.id_istruttore_amm)))
                     LEFT JOIN findom_os.findom_d_funzionari f1 ON ((f1.id_funzionario = d.id_decisore)))
                     LEFT JOIN findom_os.findom_d_motivazione_esito me ON ((me.id_motivazione_esito = d.id_motivazione_esito)))) x_1
          GROUP BY x_1.id_bando, x_1.descr_breve_bando, x_1.flag_valutazione_esterna, x_1.id_sportello_bando, x_1.dt_apertura, x_1.dt_chiusura, x_1.id_domanda, x_1.id_tipol_intervento, x_1.descrizione_tipol_intervento, x_1.stato_valut, x_1.denominazione_beneficiario, x_1.codice_fiscale_beneficiario, x_1.id_tipol_beneficiario, x_1.codice_tipol_beneficiario, x_1.flag_pubblico_privato, x_1.id_stato_istruttoria, x_1.cod_stato_istruttoria, x_1.stato_istruttoria, x_1.ordine_in_graduatoria_with_valut, x_1.ordine_in_graduatoria_without_valut, x_1.id_motivazione_esito, x_1.descr_motivazione_esito, x_1.id_istruttore_amm, x_1.cognome_istruttore_amm, x_1.nome_istruttore_amm, x_1.id_decisore, x_1.cognome_decisore, x_1.nome_decisore, x_1.dt_richiesta_integrazione, x_1.flag_abilita_integrazione, x_1.id_criterio, x_1.descrizione_criterio, x_1.descr_breve_criterio, x_1.tot_punteggio_domanda, x_1.tot_punteggio_priorita_criterio, x_1.priorita_graduatoria, x_1.ordine
        )
 SELECT x.id_bando,
    x.descr_breve_bando,
    x.flag_valutazione_esterna,
    x.id_sportello_bando,
    x.dt_apertura,
    x.dt_chiusura,
    x.id_domanda,
    x.id_tipol_intervento,
    x.descrizione_tipol_intervento,
    x.stato_valut,
    x.denominazione_beneficiario,
    x.codice_fiscale_beneficiario,
    x.id_tipol_beneficiario,
    x.codice_tipol_beneficiario,
    x.flag_pubblico_privato,
    x.id_stato_istruttoria,
    x.cod_stato_istruttoria,
    x.stato_istruttoria,
    x.ordine_in_graduatoria_with_valut,
    x.ordine_in_graduatoria_without_valut,
    x.id_motivazione_esito,
    x.descr_motivazione_esito,
    x.id_istruttore_amm,
    x.cognome_istruttore_amm,
    x.nome_istruttore_amm,
    x.id_decisore,
    x.cognome_decisore,
    x.nome_decisore,
    x.dt_richiesta_integrazione,
    x.flag_abilita_integrazione,
    x.id_criterio,
    x.descrizione_criterio,
    x.descr_breve_criterio,
    x.punteggio,
    x.tot_punteggio_domanda,
    x.tot_punteggio_priorita_criterio,
    x.priorita_graduatoria,
    x.ordine,
    x.posizione_graduatoria,
    x.punteggio_graduatoria,
    x.dt_chiusura_graduatoria,
    x.budget_disponibile
   FROM ( SELECT cte_valutaz.id_bando,
            cte_valutaz.descr_breve_bando,
            cte_valutaz.flag_valutazione_esterna,
            cte_valutaz.id_sportello_bando,
            cte_valutaz.dt_apertura,
            cte_valutaz.dt_chiusura,
            cte_valutaz.id_domanda,
            cte_valutaz.id_tipol_intervento,
            cte_valutaz.descrizione_tipol_intervento,
            cte_valutaz.stato_valut,
            cte_valutaz.denominazione_beneficiario,
            cte_valutaz.codice_fiscale_beneficiario,
            cte_valutaz.id_tipol_beneficiario,
            cte_valutaz.codice_tipol_beneficiario,
            cte_valutaz.flag_pubblico_privato,
            cte_valutaz.id_stato_istruttoria,
            cte_valutaz.cod_stato_istruttoria,
            cte_valutaz.stato_istruttoria,
            cte_valutaz.ordine_in_graduatoria_with_valut,
            cte_valutaz.ordine_in_graduatoria_without_valut,
            cte_valutaz.id_motivazione_esito,
            cte_valutaz.descr_motivazione_esito,
            cte_valutaz.id_istruttore_amm,
            cte_valutaz.cognome_istruttore_amm,
            cte_valutaz.nome_istruttore_amm,
            cte_valutaz.id_decisore,
            cte_valutaz.cognome_decisore,
            cte_valutaz.nome_decisore,
            cte_valutaz.dt_richiesta_integrazione,
            cte_valutaz.flag_abilita_integrazione,
            cte_valutaz.id_criterio,
            cte_valutaz.descrizione_criterio,
            cte_valutaz.descr_breve_criterio,
            cte_valutaz.punteggio,
            cte_valutaz.tot_punteggio_domanda,
            cte_valutaz.tot_punteggio_priorita_criterio,
            cte_valutaz.priorita_graduatoria,
            cte_valutaz.ordine,
            a.posizione AS posizione_graduatoria,
            a.punteggio AS punteggio_graduatoria,
            c.dt_chiusura_graduatoria,
            c.budget_disponibile
           FROM (((cte_valutaz
             JOIN findom_os.shell_t_dett_graduatoria a ON ((a.id_domanda = cte_valutaz.id_domanda)))
             JOIN findom_os.shell_t_dett_criteri_graduatoria b ON (((b.id_dett_graduatoria = a.id_dett_graduatoria) AND (b.id_criterio = cte_valutaz.id_criterio))))
             JOIN findom_os.shell_t_graduatoria c ON (((c.id_graduatoria = a.id_graduatoria) AND (c.dt_chiusura_graduatoria IS NOT NULL))))
        UNION ALL
         SELECT DISTINCT b.id_bando,
            b.descr_breve AS descr_breve_bando,
            b.flag_valutazione_esterna,
            sb.id_sportello_bando,
            to_char(sb.dt_apertura, 'YYYY-MM-DD HH24:MI:SS'::text) AS dt_apertura,
            to_char(sb.dt_chiusura, 'YYYY-MM-DD HH24:MI:SS'::text) AS dt_chiusura,
            d.id_domanda,
            ti.id_tipol_intervento,
            ti.descrizione AS descrizione_tipol_intervento,
            (COALESCE(vd.stato_valut, 'P'::bpchar))::character(1) AS stato_valut,
            s.denominazione AS denominazione_beneficiario,
            s.cod_fiscale AS codice_fiscale_beneficiario,
            tb.id_tipol_beneficiario,
            tb.codice AS codice_tipol_beneficiario,
            tb.flag_pubblico_privato,
            si.id_stato_istr AS id_stato_istruttoria,
            si.codice AS cod_stato_istruttoria,
            si.descrizione AS stato_istruttoria,
            si.ordine_in_graduatoria_with_valut,
            si.ordine_in_graduatoria_without_valut,
            me.id_motivazione_esito,
            me.descr_motivazione_esito,
            f.id_funzionario AS id_istruttore_amm,
            f.cognome AS cognome_istruttore_amm,
            f.nome AS nome_istruttore_amm,
            f1.id_funzionario AS id_decisore,
            f1.cognome AS cognome_decisore,
            f1.nome AS nome_decisore,
            to_char((d.dt_richiesta_integrazione)::timestamp with time zone, 'dd/mm/yyyy'::text) AS dt_richiesta_integrazione,
            d.flag_abilita_integrazione,
            bcv.id_criterio,
            cv.descrizione AS descrizione_criterio,
            cv.descr_breve AS descr_breve_criterio,
            NULL::numeric AS punteggio,
            ( SELECT sum(shell_t_valut_domande.punteggio) AS sum
                   FROM findom_os.shell_t_valut_domande
                  WHERE (shell_t_valut_domande.id_domanda = d.id_domanda)) AS tot_punteggio_domanda,
            NULL::numeric AS tot_punteggio_priorita_criterio,
            NULL::numeric AS priorita_graduatoria,
            bcv.ordine,
            NULL::numeric AS posizione_graduatoria,
            NULL::numeric AS punteggio_graduatoria,
            NULL::date AS dt_chiusura_graduatoria,
            NULL::numeric AS budget_disponibile
           FROM ((((((((((((findom_os.shell_t_domande d
             JOIN findom_os.findom_d_tipol_beneficiari tb ON ((tb.id_tipol_beneficiario = d.id_tipol_beneficiario)))
             JOIN findom_os.findom_t_sportelli_bandi sb ON ((sb.id_sportello_bando = d.id_sportello_bando)))
             JOIN findom_os.findom_t_bandi b ON ((b.id_bando = sb.id_bando)))
             JOIN findom_os.findom_r_bandi_criteri_valut bcv ON ((bcv.id_bando = b.id_bando)))
             LEFT JOIN findom_os.findom_d_tipol_interventi ti ON ((ti.id_tipol_intervento = bcv.id_tipol_intervento)))
             LEFT JOIN findom_os.shell_t_valut_domande vd ON (((vd.id_domanda = d.id_domanda) AND (vd.stato_valut <> 'D'::bpchar))))
             LEFT JOIN findom_os.shell_t_soggetti s ON ((s.id_soggetto = d.id_soggetto_beneficiario)))
             JOIN findom_os.findom_d_stato_istruttoria si ON (((si.id_stato_istr = d.id_stato_istr) AND (si.flag_stato_finale IS NOT NULL))))
             LEFT JOIN findom_os.findom_d_funzionari f ON ((f.id_funzionario = d.id_istruttore_amm)))
             LEFT JOIN findom_os.findom_d_funzionari f1 ON ((f1.id_funzionario = d.id_decisore)))
             JOIN findom_os.findom_d_criteri_valut cv ON ((cv.id_criterio = bcv.id_criterio)))
             LEFT JOIN findom_os.findom_d_motivazione_esito me ON ((me.id_motivazione_esito = d.id_motivazione_esito)))
          WHERE (NOT (EXISTS ( SELECT NULL::unknown AS unknown
                   FROM cte_valutaz
                  WHERE ((cte_valutaz.id_domanda = d.id_domanda) AND (cte_valutaz.stato_valut = COALESCE(vd.stato_valut, 'P'::bpchar)) AND (cte_valutaz.id_criterio = cv.id_criterio)))))
        UNION ALL
         SELECT DISTINCT b.id_bando,
            b.descr_breve AS descr_breve_bando,
            b.flag_valutazione_esterna,
            sb.id_sportello_bando,
            to_char(sb.dt_apertura, 'YYYY-MM-DD HH24:MI:SS'::text) AS dt_apertura,
            to_char(sb.dt_chiusura, 'YYYY-MM-DD HH24:MI:SS'::text) AS dt_chiusura,
            d.id_domanda,
            NULL::integer AS id_tipol_intervento,
            NULL::character varying(200) AS descrizione_tipol_intervento,
            NULL::character(1) AS stato_valut,
            s.denominazione AS denominazione_beneficiario,
            s.cod_fiscale AS codice_fiscale_beneficiario,
            tb.id_tipol_beneficiario,
            tb.codice AS codice_tipol_beneficiario,
            tb.flag_pubblico_privato,
            si.id_stato_istr AS id_stato_istruttoria,
            si.codice AS cod_stato_istruttoria,
            si.descrizione AS stato_istruttoria,
            si.ordine_in_graduatoria_with_valut,
            si.ordine_in_graduatoria_without_valut,
            me.id_motivazione_esito,
            me.descr_motivazione_esito,
            f.id_funzionario AS id_istruttore_amm,
            f.cognome AS cognome_istruttore_amm,
            f.nome AS nome_istruttore_amm,
            f1.id_funzionario AS id_decisore,
            f1.cognome AS cognome_decisore,
            f1.nome AS nome_decisore,
            to_char((d.dt_richiesta_integrazione)::timestamp with time zone, 'dd/mm/yyyy'::text) AS dt_richiesta_integrazione,
            d.flag_abilita_integrazione,
            NULL::integer AS id_criterio,
            NULL::character varying(200) AS descrizione_criterio,
            NULL::character varying(20) AS descr_breve_criterio,
            NULL::numeric AS punteggio,
            NULL::numeric AS tot_punteggio_domanda,
            NULL::numeric AS tot_punteggio_priorita_criterio,
            NULL::numeric AS priorita_graduatoria,
            NULL::integer AS ordine,
            NULL::numeric AS posizione_graduatoria,
            NULL::numeric AS punteggio_graduatoria,
            NULL::date AS dt_chiusura_graduatoria,
            NULL::numeric AS budget_disponibile
           FROM ((((((((findom_os.shell_t_domande d
             JOIN findom_os.findom_d_tipol_beneficiari tb ON ((tb.id_tipol_beneficiario = d.id_tipol_beneficiario)))
             JOIN findom_os.findom_t_sportelli_bandi sb ON ((sb.id_sportello_bando = d.id_sportello_bando)))
             JOIN findom_os.findom_t_bandi b ON (((b.id_bando = sb.id_bando) AND (b.flag_valutazione_esterna = 'S'::bpchar))))
             LEFT JOIN findom_os.shell_t_soggetti s ON ((s.id_soggetto = d.id_soggetto_beneficiario)))
             JOIN findom_os.findom_d_stato_istruttoria si ON (((si.id_stato_istr = d.id_stato_istr) AND (si.flag_stato_finale IS NOT NULL))))
             LEFT JOIN findom_os.findom_d_funzionari f ON ((f.id_funzionario = d.id_istruttore_amm)))
             LEFT JOIN findom_os.findom_d_funzionari f1 ON ((f1.id_funzionario = d.id_decisore)))
             LEFT JOIN findom_os.findom_d_motivazione_esito me ON ((me.id_motivazione_esito = d.id_motivazione_esito)))) x
  ORDER BY x.id_bando, x.id_domanda DESC, x.stato_valut, x.ordine;


ALTER TABLE findom_os.findom_v_domande_istruite OWNER TO findom_os;

--
-- TOC entry 16300 (class 1259 OID 31176122)
-- Name: findom_v_domande_istruite_parametri; Type: VIEW; Schema: findom_os; Owner: findom_os
--

CREATE VIEW findom_os.findom_v_domande_istruite_parametri AS
 WITH cte_valutaz AS (
         SELECT b.id_bando,
            b.descr_breve AS descr_breve_bando,
            vd.id_domanda,
            ti.id_tipol_intervento,
            ti.descrizione AS descrizione_tipol_intervento,
            vd.stato_valut,
            si.codice AS cod_stato_istruttoria,
            si.descrizione AS stato_istruttoria,
            cv.id_criterio,
            cv.descr_breve AS descr_breve_criterio,
            bcv.ordine AS ordine_criterio,
            bsv.id_specifica,
            sv.descrizione AS descrizione_specifica,
            COALESCE(sv.descr_breve, sv.descrizione) AS descr_breve_specifica,
            sv.ordine AS ordine_specifica,
            pv.id_parametro,
            psv.descrizione AS descrizione_parametro,
            (((COALESCE(sv.descr_breve, sv.descrizione))::text || ' - '::text) || (COALESCE(psv.descr_breve, psv.descrizione))::text) AS descr_breve_parametro,
            pv.ordine AS ordine_parametro,
            pv.flag_fittizio,
            pv.id_parametro_valut,
                CASE
                    WHEN ((sv.tipo_specifica)::text = 'PEN'::text) THEN (pv.punteggio * ('-1'::integer)::numeric)
                    ELSE pv.punteggio
                END AS punteggio_parametro,
            vd.punteggio AS punteggio_assegnato
           FROM (((((((((((findom_os.findom_r_bandi_specifiche_valut bsv
             JOIN findom_os.findom_d_specifiche_valut sv ON ((sv.id_specifica = bsv.id_specifica)))
             JOIN findom_os.findom_r_bandi_criteri_valut bcv ON (((bcv.id_bando = bsv.id_bando) AND (bcv.id_criterio = sv.id_criterio))))
             LEFT JOIN findom_os.findom_d_tipol_interventi ti ON ((ti.id_tipol_intervento = bcv.id_tipol_intervento)))
             JOIN findom_os.findom_t_parametri_valut pv ON (((pv.id_bando = bsv.id_bando) AND (pv.id_specifica = bsv.id_specifica))))
             JOIN findom_os.findom_d_parametri_specifiche_valut psv ON ((psv.id_parametro = pv.id_parametro)))
             JOIN findom_os.shell_t_valut_domande vd ON (((vd.id_parametro_valut = pv.id_parametro_valut) AND (vd.stato_valut <> 'D'::bpchar))))
             JOIN findom_os.shell_t_domande d ON ((d.id_domanda = vd.id_domanda)))
             JOIN findom_os.findom_t_sportelli_bandi sb ON (((sb.id_sportello_bando = d.id_sportello_bando) AND (sb.id_bando = bsv.id_bando))))
             JOIN findom_os.findom_d_stato_istruttoria si ON (((si.id_stato_istr = d.id_stato_istr) AND (si.flag_stato_finale IS NOT NULL))))
             JOIN findom_os.findom_t_bandi b ON ((b.id_bando = bsv.id_bando)))
             JOIN findom_os.findom_d_criteri_valut cv ON ((cv.id_criterio = sv.id_criterio)))
        )
 SELECT x.id_bando,
    x.descr_breve_bando,
    x.id_domanda,
    x.id_tipol_intervento,
    x.descrizione_tipol_intervento,
    x.stato_valut,
    x.cod_stato_istruttoria,
    x.stato_istruttoria,
    x.id_criterio,
    x.descr_breve_criterio,
    x.ordine_criterio,
    x.id_specifica,
    x.descrizione_specifica,
    x.descr_breve_specifica,
    x.ordine_specifica,
    x.id_parametro,
    x.descrizione_parametro,
    x.descr_breve_parametro,
    x.ordine_parametro,
    x.flag_fittizio,
    x.id_parametro_valut,
    x.punteggio_parametro,
    x.punteggio_assegnato
   FROM ( SELECT cte_valutaz.id_bando,
            cte_valutaz.descr_breve_bando,
            cte_valutaz.id_domanda,
            cte_valutaz.id_tipol_intervento,
            cte_valutaz.descrizione_tipol_intervento,
            cte_valutaz.stato_valut,
            cte_valutaz.cod_stato_istruttoria,
            cte_valutaz.stato_istruttoria,
            cte_valutaz.id_criterio,
            cte_valutaz.descr_breve_criterio,
            cte_valutaz.ordine_criterio,
            cte_valutaz.id_specifica,
            cte_valutaz.descrizione_specifica,
            cte_valutaz.descr_breve_specifica,
            cte_valutaz.ordine_specifica,
            cte_valutaz.id_parametro,
            cte_valutaz.descrizione_parametro,
            cte_valutaz.descr_breve_parametro,
            cte_valutaz.ordine_parametro,
            cte_valutaz.flag_fittizio,
            cte_valutaz.id_parametro_valut,
            cte_valutaz.punteggio_parametro,
            cte_valutaz.punteggio_assegnato
           FROM (((cte_valutaz
             JOIN findom_os.shell_t_dett_graduatoria a ON ((a.id_domanda = cte_valutaz.id_domanda)))
             JOIN findom_os.shell_t_dett_criteri_graduatoria b ON (((b.id_dett_graduatoria = a.id_dett_graduatoria) AND (b.id_criterio = cte_valutaz.id_criterio))))
             JOIN findom_os.shell_t_graduatoria c ON (((c.id_graduatoria = a.id_graduatoria) AND (c.dt_chiusura_graduatoria IS NOT NULL))))
        UNION ALL
         SELECT DISTINCT b.id_bando,
            b.descr_breve AS descr_breve_bando,
            d.id_domanda,
            ti.id_tipol_intervento,
            ti.descrizione AS descrizione_tipol_intervento,
            (COALESCE(vd.stato_valut, 'P'::bpchar))::character(1) AS stato_valut,
            si.codice AS cod_stato_istruttoria,
            si.descrizione AS stato_istruttoria,
            bcv.id_criterio,
            cv.descr_breve AS descr_breve_criterio,
            bcv.ordine AS ordine_criterio,
            bsv.id_specifica,
            sv.descrizione AS descrizione_specifica,
            COALESCE(sv.descr_breve, sv.descrizione) AS descr_breve_specifica,
            sv.ordine AS ordine_specifica,
            pv.id_parametro,
            psv.descrizione AS descrizione_parametro,
            (((COALESCE(sv.descr_breve, sv.descrizione))::text || ' - '::text) || (COALESCE(psv.descr_breve, psv.descrizione))::text) AS descr_breve_parametro,
            pv.ordine AS ordine_parametro,
            pv.flag_fittizio,
            pv.id_parametro_valut,
                CASE
                    WHEN ((sv.tipo_specifica)::text = 'PEN'::text) THEN (pv.punteggio * ('-1'::integer)::numeric)
                    ELSE pv.punteggio
                END AS punteggio_parametro,
            NULL::numeric AS punteggio_assegnato
           FROM (((((((((((findom_os.shell_t_domande d
             JOIN findom_os.findom_d_stato_istruttoria si ON (((si.id_stato_istr = d.id_stato_istr) AND (si.flag_stato_finale IS NOT NULL))))
             JOIN findom_os.findom_t_sportelli_bandi sb ON ((sb.id_sportello_bando = d.id_sportello_bando)))
             JOIN findom_os.findom_t_bandi b ON ((b.id_bando = sb.id_bando)))
             JOIN findom_os.findom_r_bandi_specifiche_valut bsv ON ((bsv.id_bando = b.id_bando)))
             JOIN findom_os.findom_d_specifiche_valut sv ON ((sv.id_specifica = bsv.id_specifica)))
             JOIN findom_os.findom_d_criteri_valut cv ON ((cv.id_criterio = sv.id_criterio)))
             JOIN findom_os.findom_r_bandi_criteri_valut bcv ON (((bcv.id_bando = bsv.id_bando) AND (bcv.id_criterio = sv.id_criterio))))
             LEFT JOIN findom_os.findom_d_tipol_interventi ti ON ((ti.id_tipol_intervento = bcv.id_tipol_intervento)))
             JOIN findom_os.findom_t_parametri_valut pv ON (((pv.id_bando = bsv.id_bando) AND (pv.id_specifica = bsv.id_specifica))))
             JOIN findom_os.findom_d_parametri_specifiche_valut psv ON ((psv.id_parametro = pv.id_parametro)))
             LEFT JOIN findom_os.shell_t_valut_domande vd ON (((vd.id_domanda = d.id_domanda) AND (vd.stato_valut <> 'D'::bpchar))))
          WHERE (NOT (EXISTS ( SELECT NULL::unknown AS unknown
                   FROM cte_valutaz
                  WHERE ((cte_valutaz.id_domanda = d.id_domanda) AND (cte_valutaz.stato_valut = COALESCE(vd.stato_valut, 'P'::bpchar)) AND (cte_valutaz.id_criterio = cv.id_criterio) AND (cte_valutaz.id_specifica = bsv.id_specifica) AND (cte_valutaz.id_parametro = pv.id_parametro)))))) x
  ORDER BY x.id_bando, x.id_domanda DESC, x.stato_valut, x.ordine_criterio, x.ordine_specifica, x.ordine_parametro;


ALTER TABLE findom_os.findom_v_domande_istruite_parametri OWNER TO findom_os;

--
-- TOC entry 16301 (class 1259 OID 31176127)
-- Name: findom_v_domande_istruite_specifiche; Type: VIEW; Schema: findom_os; Owner: findom_os
--

CREATE VIEW findom_os.findom_v_domande_istruite_specifiche AS
 WITH cte_valutaz AS (
         SELECT x_1.id_bando,
            x_1.descr_breve_bando,
            x_1.id_domanda,
            x_1.id_tipol_intervento,
            x_1.descrizione_tipol_intervento,
            x_1.stato_valut,
            x_1.cod_stato_istruttoria,
            x_1.stato_istruttoria,
            x_1.id_criterio,
            x_1.descr_breve_criterio,
            x_1.ordine_criterio,
            x_1.id_specifica,
            x_1.descrizione_specifica,
            x_1.ordine_specifica,
            x_1.tipo_specifica,
            x_1.tipo_campo,
            x_1.corpo_regola,
            x_1.punteggio_min,
            x_1.punteggio_max,
            sum(x_1.punteggio) AS punteggio,
                CASE
                    WHEN (sum(x_1.punteggio) < (x_1.punteggio_min)::numeric) THEN 1
                    ELSE NULL::integer
                END AS tipo_errore,
            x_1.tot_punteggio_domanda
           FROM ( SELECT b.id_bando,
                    b.descr_breve AS descr_breve_bando,
                    vd.id_domanda,
                    ti.id_tipol_intervento,
                    ti.descrizione AS descrizione_tipol_intervento,
                    vd.stato_valut,
                    si.codice AS cod_stato_istruttoria,
                    si.descrizione AS stato_istruttoria,
                    cv.id_criterio,
                    cv.descr_breve AS descr_breve_criterio,
                    bcv.ordine AS ordine_criterio,
                    bsv.id_specifica,
                    sv.descrizione AS descrizione_specifica,
                    sv.ordine AS ordine_specifica,
                    sv.tipo_specifica,
                    bsv.tipo_campo,
                    r.corpo_regola,
                    bsv.punteggio_min,
                    bsv.punteggio_max,
                    vd.punteggio,
                    sum(vd.punteggio) OVER (PARTITION BY vd.id_domanda, vd.stato_valut) AS tot_punteggio_domanda
                   FROM (((((((((((findom_os.findom_r_bandi_specifiche_valut bsv
                     JOIN findom_os.findom_d_specifiche_valut sv ON ((sv.id_specifica = bsv.id_specifica)))
                     JOIN findom_os.findom_r_bandi_criteri_valut bcv ON (((bcv.id_bando = bsv.id_bando) AND (bcv.id_criterio = sv.id_criterio))))
                     LEFT JOIN findom_os.findom_d_tipol_interventi ti ON ((ti.id_tipol_intervento = bcv.id_tipol_intervento)))
                     JOIN findom_os.findom_t_parametri_valut pv ON (((pv.id_bando = bsv.id_bando) AND (pv.id_specifica = bsv.id_specifica))))
                     JOIN findom_os.shell_t_valut_domande vd ON (((vd.id_parametro_valut = pv.id_parametro_valut) AND (vd.stato_valut <> 'D'::bpchar))))
                     JOIN findom_os.shell_t_domande d ON ((d.id_domanda = vd.id_domanda)))
                     JOIN findom_os.findom_t_sportelli_bandi sb ON (((sb.id_sportello_bando = d.id_sportello_bando) AND (sb.id_bando = bsv.id_bando))))
                     JOIN findom_os.findom_d_stato_istruttoria si ON (((si.id_stato_istr = d.id_stato_istr) AND (si.flag_stato_finale IS NOT NULL))))
                     JOIN findom_os.findom_t_bandi b ON ((b.id_bando = bsv.id_bando)))
                     JOIN findom_os.findom_d_criteri_valut cv ON ((cv.id_criterio = sv.id_criterio)))
                     LEFT JOIN findom_os.findom_d_regole r ON ((r.id_regola = bsv.id_regola)))) x_1
          GROUP BY x_1.id_bando, x_1.descr_breve_bando, x_1.id_domanda, x_1.id_tipol_intervento, x_1.descrizione_tipol_intervento, x_1.stato_valut, x_1.cod_stato_istruttoria, x_1.stato_istruttoria, x_1.id_specifica, x_1.descrizione_specifica, x_1.tipo_campo, x_1.corpo_regola, x_1.punteggio_min, x_1.punteggio_max, x_1.tot_punteggio_domanda, x_1.ordine_specifica, x_1.tipo_specifica, x_1.id_criterio, x_1.descr_breve_criterio, x_1.ordine_criterio
        )
 SELECT x.id_bando,
    x.descr_breve_bando,
    x.id_domanda,
    x.id_tipol_intervento,
    x.descrizione_tipol_intervento,
    x.stato_valut,
    x.cod_stato_istruttoria,
    x.stato_istruttoria,
    x.id_criterio,
    x.descr_breve_criterio,
    x.ordine_criterio,
    x.id_specifica,
    x.descrizione_specifica,
    x.ordine_specifica,
    x.tipo_specifica,
    x.tipo_campo,
    x.corpo_regola,
    x.punteggio_min,
    x.punteggio_max,
    x.punteggio,
    x.tipo_errore,
    x.tot_punteggio_domanda
   FROM ( SELECT cte_valutaz.id_bando,
            cte_valutaz.descr_breve_bando,
            cte_valutaz.id_domanda,
            cte_valutaz.id_tipol_intervento,
            cte_valutaz.descrizione_tipol_intervento,
            cte_valutaz.stato_valut,
            cte_valutaz.cod_stato_istruttoria,
            cte_valutaz.stato_istruttoria,
            cte_valutaz.id_criterio,
            cte_valutaz.descr_breve_criterio,
            cte_valutaz.ordine_criterio,
            cte_valutaz.id_specifica,
            cte_valutaz.descrizione_specifica,
            cte_valutaz.ordine_specifica,
            cte_valutaz.tipo_specifica,
            cte_valutaz.tipo_campo,
            cte_valutaz.corpo_regola,
            cte_valutaz.punteggio_min,
            cte_valutaz.punteggio_max,
            cte_valutaz.punteggio,
            cte_valutaz.tipo_errore,
            cte_valutaz.tot_punteggio_domanda
           FROM (((cte_valutaz
             JOIN findom_os.shell_t_dett_graduatoria a ON ((a.id_domanda = cte_valutaz.id_domanda)))
             JOIN findom_os.shell_t_dett_criteri_graduatoria b ON (((b.id_dett_graduatoria = a.id_dett_graduatoria) AND (b.id_criterio = cte_valutaz.id_criterio))))
             JOIN findom_os.shell_t_graduatoria c ON (((c.id_graduatoria = a.id_graduatoria) AND (c.dt_chiusura_graduatoria IS NOT NULL))))
        UNION ALL
         SELECT DISTINCT b.id_bando,
            b.descr_breve AS descr_breve_bando,
            d.id_domanda,
            ti.id_tipol_intervento,
            ti.descrizione AS descrizione_tipol_intervento,
            (COALESCE(vd.stato_valut, 'P'::bpchar))::character(1) AS stato_valut,
            si.codice AS cod_stato_istruttoria,
            si.descrizione AS stato_istruttoria,
            bcv.id_criterio,
            cv.descr_breve AS descr_breve_criterio,
            bcv.ordine AS ordine_criterio,
            bsv.id_specifica,
            sv.descrizione AS descrizione_specifica,
            sv.ordine AS ordine_specifica,
            sv.tipo_specifica,
            bsv.tipo_campo,
            r.corpo_regola,
            bsv.punteggio_min,
            bsv.punteggio_max,
            NULL::numeric AS punteggio,
            NULL::numeric AS tipo_errore,
            ( SELECT sum(shell_t_valut_domande.punteggio) AS sum
                   FROM findom_os.shell_t_valut_domande
                  WHERE ((shell_t_valut_domande.id_domanda = d.id_domanda) AND (shell_t_valut_domande.stato_valut = COALESCE(vd.stato_valut, 'P'::bpchar)))) AS tot_punteggio_domanda
           FROM ((((((((((findom_os.shell_t_domande d
             JOIN findom_os.findom_d_stato_istruttoria si ON (((si.id_stato_istr = d.id_stato_istr) AND (si.flag_stato_finale IS NOT NULL))))
             JOIN findom_os.findom_t_sportelli_bandi sb ON ((sb.id_sportello_bando = d.id_sportello_bando)))
             JOIN findom_os.findom_t_bandi b ON ((b.id_bando = sb.id_bando)))
             JOIN findom_os.findom_r_bandi_specifiche_valut bsv ON ((bsv.id_bando = b.id_bando)))
             JOIN findom_os.findom_d_specifiche_valut sv ON ((sv.id_specifica = bsv.id_specifica)))
             JOIN findom_os.findom_d_criteri_valut cv ON ((cv.id_criterio = sv.id_criterio)))
             JOIN findom_os.findom_r_bandi_criteri_valut bcv ON (((bcv.id_bando = bsv.id_bando) AND (bcv.id_criterio = sv.id_criterio))))
             LEFT JOIN findom_os.findom_d_tipol_interventi ti ON ((ti.id_tipol_intervento = bcv.id_tipol_intervento)))
             LEFT JOIN findom_os.shell_t_valut_domande vd ON (((vd.id_domanda = d.id_domanda) AND (vd.stato_valut <> 'D'::bpchar))))
             LEFT JOIN findom_os.findom_d_regole r ON ((r.id_regola = bsv.id_regola)))
          WHERE (NOT (EXISTS ( SELECT NULL::unknown AS unknown
                   FROM cte_valutaz
                  WHERE ((cte_valutaz.id_domanda = d.id_domanda) AND (cte_valutaz.stato_valut = COALESCE(vd.stato_valut, 'P'::bpchar)) AND (cte_valutaz.id_criterio = cv.id_criterio) AND (cte_valutaz.id_specifica = bsv.id_specifica)))))) x
  ORDER BY x.id_bando, x.id_domanda DESC, x.stato_valut, x.ordine_criterio, x.ordine_specifica;


ALTER TABLE findom_os.findom_v_domande_istruite_specifiche OWNER TO findom_os;

--
-- TOC entry 16302 (class 1259 OID 31176132)
-- Name: findom_v_domande_nuova_gestione; Type: VIEW; Schema: findom_os; Owner: findom_os
--

CREATE VIEW findom_os.findom_v_domande_nuova_gestione AS
 SELECT d.id_domanda,
    ms.model_state AS cod_stato_domanda,
    ms.model_state_descr AS stato_domanda,
    sis.codice AS cod_stato_istruttoria_new,
    sis.descrizione AS stato_istruttoria_new,
    ims.model_state AS cod_stato_istruttoria,
    ims.model_state_descr AS stato_istruttoria,
    funz.id_funzionario AS id_istruttore_amm,
    funz.cod_fiscale AS codice_fiscale_istruttore_amm,
    funz.cognome AS cognome_istruttore_amm,
    funz.nome AS nome_istruttore_amm,
    to_char((d.dt_rimodulazione_istruttore)::timestamp with time zone, 'DD/MM/YYYY HH24:MI'::text) AS data_rimodulazione_istruttore,
    decis.id_funzionario AS id_decisore,
    decis.cod_fiscale AS codice_fiscale_decisore,
    decis.cognome AS cognome_decisore,
    decis.nome AS nome_decisore,
    to_char((d.dt_rimodulazione_decisore)::timestamp with time zone, 'DD/MM/YYYY HH24:MI'::text) AS data_rimodulazione_decisore,
    dp.num_protocollo AS numero_protocollo,
    to_char(dp.dt_protocollo, 'DD/MM/YYYY HH24:MI'::text) AS data_protocollo,
    dp.classificazione_acta,
    to_char(dp.dt_classificazione, 'DD/MM/YYYY HH24:MI'::text) AS data_classificazione,
    tb.id_tipol_beneficiario,
    tb.descrizione AS descrizione_tipol_beneficiario,
    tb.codice AS codice_tipol_beneficiario,
        CASE
            WHEN (tb.flag_pubblico_privato = (1)::numeric) THEN 'Privato'::text
            WHEN (tb.flag_pubblico_privato = (2)::numeric) THEN 'Pubblico'::text
            ELSE NULL::text
        END AS tipo_ente_beneficiario,
    tb.cod_stereotipo,
    st.descr_stereotipo,
    tb.flag_pubblico_privato,
    d.id_soggetto_creatore,
    sc.cognome AS cognome_soggetto_creatore,
    sc.nome AS nome_soggetto_creatore,
    to_char(d.dt_creazione, 'DD/MM/YYYY HH24:MI'::text) AS dt_creazione_domanda,
    d.id_soggetto_conclusione,
    sl.cognome AS cognome_soggetto_conclusione,
    sl.nome AS nome_soggetto_conclusione,
    to_char(d.dt_conclusione, 'DD/MM/YYYY HH24:MI'::text) AS dt_conclusione,
    d.id_soggetto_invio,
    si.cognome AS cognome_soggetto_invio,
    si.nome AS nome_soggetto_invio,
    to_char(d.dt_invio_domanda, 'DD/MM/YYYY HH24:MI'::text) AS dt_invio_domanda,
    d.id_soggetto_beneficiario,
    sb.denominazione AS denominazione_soggetto_beneficiario,
    sb.cod_fiscale AS cod_fiscale_beneficiario,
    sb.sigla_nazione,
    sp.id_sportello_bando,
    sp.num_atto,
    sp.dt_atto,
    to_char(sp.dt_apertura, 'DD/MM/YYYY HH24:MI'::text) AS dt_apertura_sportello,
    to_char(sp.dt_chiusura, 'DD/MM/YYYY HH24:MI'::text) AS dt_chiusura_sportello,
    sp.id_bando,
    b.flag_demat,
    b.tipo_firma,
    b.descrizione AS descr_bando,
    b.flag_progetti_comuni,
    (((az.codice)::text || ' - '::text) || (b.descr_breve)::text) AS descr_breve_bando,
    b.id_ente_destinatario AS id_ente,
    n.id_normativa,
    n.descr_breve AS normativa,
    ap.id_classificazione AS id_classificazione_asse_prioritario,
    ap.codice AS codice_asse_prioritario,
    ap.descrizione AS descrizione_asse_prioritario,
    pi.id_classificazione AS id_classificazione_priorita_investimento,
    pi.codice AS codice_priorita_investimento,
    pi.descrizione AS descrizione_priorita_investimento,
    os.id_classificazione AS id_classificazione_misura,
    os.codice AS codice_misura,
    os.descrizione AS descrizione_misura,
    az.id_classificazione AS id_classificazione_azione,
    az.codice AS codice_azione,
    az.descrizione AS descrizione_azione,
        CASE
            WHEN ((e.dest_file_domanda)::text = 'REGIONE'::text) THEN 'REGIONE PIEMONTE'::character varying
            WHEN ((e.dest_file_domanda)::text = 'FINPIEMONTE'::text) THEN 'FINPIEMONTE S.p.A.'::character varying
            ELSE e.dest_file_domanda
        END AS destinatario_descrizione,
        CASE
            WHEN ((e.dest_file_domanda)::text = 'FINPIEMONTE'::text) THEN NULL::character varying
            ELSE e.descrizione
        END AS destinatario_direzione,
    e.indirizzo AS destinatario_indirizzo,
    e.cap AS destinatario_cap,
    e.descr_comune AS destinatario_citta,
    e.sigla_prov AS destinatario_provincia,
    e.pec AS destinatario_pec,
    (((((((n.descr_breve)::text || ' '::text) || (ap.codice)::text) || ' '::text) || (os.codice)::text) || '-'::text) || (b.descr_breve)::text) AS norma_incentivazione,
    ( SELECT string_agg((x.codice)::text, '-'::text) AS string_agg
           FROM ( SELECT b_1.id_bando,
                    a.codice
                   FROM findom_os.findom_d_tipol_interventi a,
                    findom_os.findom_r_bandi_tipol_interventi b_1
                  WHERE ((a.id_tipol_intervento = b_1.id_tipol_intervento) AND (b_1.id_bando = sp.id_bando))
                  ORDER BY a.codice) x
          GROUP BY x.id_bando) AS codice_intervento,
    ( SELECT string_agg(x.descrizione, ' - '::text) AS string_agg
           FROM ( SELECT b_1.id_bando,
                    a.descrizione
                   FROM findom_os.findom_d_tipol_interventi a,
                    findom_os.findom_r_bandi_tipol_interventi b_1
                  WHERE ((a.id_tipol_intervento = b_1.id_tipol_intervento) AND (b_1.id_bando = sp.id_bando))
                  ORDER BY a.codice) x
          GROUP BY x.id_bando) AS descrizione_intervento,
    at.id_area_tematica,
    at.descrizione AS descrizione_area_tematica
   FROM ((((((((((((((((((((((((findom_os.shell_t_domande d
     JOIN findom_os.aggr_t_model m ON ((m.model_id = d.id_domanda)))
     JOIN findom_os.aggr_d_model_state ms ON (((ms.model_state)::text = (m.model_state_fk)::text)))
     LEFT JOIN findom_os.istr_t_model i ON ((i.model_id = d.id_domanda)))
     LEFT JOIN findom_os.findom_d_stato_istruttoria sis ON (((sis.id_stato_istr)::text = (d.id_stato_istr)::text)))
     LEFT JOIN findom_os.istr_d_model_state ims ON (((ims.model_state)::text = (i.model_state_fk)::text)))
     LEFT JOIN findom_os.findom_d_funzionari funz ON ((funz.id_funzionario = d.id_istruttore_amm)))
     LEFT JOIN findom_os.findom_d_funzionari decis ON ((decis.id_funzionario = d.id_decisore)))
     JOIN findom_os.findom_d_tipol_beneficiari tb ON ((tb.id_tipol_beneficiario = d.id_tipol_beneficiario)))
     JOIN findom_os.findom_d_stereotipi st ON (((st.cod_stereotipo)::text = (tb.cod_stereotipo)::text)))
     JOIN findom_os.shell_t_soggetti sc ON ((sc.id_soggetto = d.id_soggetto_creatore)))
     JOIN findom_os.shell_t_soggetti sb ON ((sb.id_soggetto = d.id_soggetto_beneficiario)))
     LEFT JOIN findom_os.shell_t_soggetti si ON ((si.id_soggetto = d.id_soggetto_invio)))
     LEFT JOIN findom_os.shell_t_soggetti sl ON ((sl.id_soggetto = d.id_soggetto_conclusione)))
     LEFT JOIN findom_os.shell_t_documento_index di ON (((di.id_domanda = d.id_domanda) AND (di.id_allegato IS NULL))))
     LEFT JOIN findom_os.shell_t_documento_prot dp ON ((dp.id_documento_index = di.id_documento_index)))
     JOIN findom_os.findom_t_sportelli_bandi sp ON ((sp.id_sportello_bando = d.id_sportello_bando)))
     JOIN findom_os.findom_t_bandi b ON (((b.id_bando = sp.id_bando) AND (b.flag_nuova_gestione = true))))
     LEFT JOIN findom_os.findom_d_area_tematica at ON ((at.id_area_tematica = b.id_area_tematica)))
     JOIN findom_os.findom_d_enti e ON ((e.id_ente = b.id_ente_destinatario)))
     JOIN findom_os.findom_d_classif_bandi az ON (((az.id_classificazione = b.id_classificazione) AND (az.id_tipo_suddivisione = 5))))
     JOIN findom_os.findom_d_classif_bandi os ON (((az.id_classificazione_padre = os.id_classificazione) AND (os.id_tipo_suddivisione = 4))))
     JOIN findom_os.findom_d_classif_bandi pi ON (((os.id_classificazione_padre = pi.id_classificazione) AND (pi.id_tipo_suddivisione = 3))))
     JOIN findom_os.findom_d_classif_bandi ap ON (((pi.id_classificazione_padre = ap.id_classificazione) AND (ap.id_tipo_suddivisione = 1))))
     JOIN findom_os.findom_d_normative n ON ((n.id_normativa = ap.id_normativa)))
UNION ALL
 SELECT d.id_domanda,
    ms.model_state AS cod_stato_domanda,
    ms.model_state_descr AS stato_domanda,
    sis.codice AS cod_stato_istruttoria_new,
    sis.descrizione AS stato_istruttoria_new,
    ims.model_state AS cod_stato_istruttoria,
    ims.model_state_descr AS stato_istruttoria,
    funz.id_funzionario AS id_istruttore_amm,
    funz.cod_fiscale AS codice_fiscale_istruttore_amm,
    funz.cognome AS cognome_istruttore_amm,
    funz.nome AS nome_istruttore_amm,
    to_char((d.dt_rimodulazione_istruttore)::timestamp with time zone, 'DD/MM/YYYY HH24:MI'::text) AS data_rimodulazione_istruttore,
    decis.id_funzionario AS id_decisore,
    decis.cod_fiscale AS codice_fiscale_decisore,
    decis.cognome AS cognome_decisore,
    decis.nome AS nome_decisore,
    to_char((d.dt_rimodulazione_decisore)::timestamp with time zone, 'DD/MM/YYYY HH24:MI'::text) AS data_rimodulazione_decisore,
    dp.num_protocollo AS numero_protocollo,
    to_char(dp.dt_protocollo, 'DD/MM/YYYY HH24:MI'::text) AS data_protocollo,
    dp.classificazione_acta,
    to_char(dp.dt_classificazione, 'DD/MM/YYYY HH24:MI'::text) AS data_classificazione,
    tb.id_tipol_beneficiario,
    tb.descrizione AS descrizione_tipol_beneficiario,
    tb.codice AS codice_tipol_beneficiario,
        CASE
            WHEN (tb.flag_pubblico_privato = (1)::numeric) THEN 'Privato'::text
            WHEN (tb.flag_pubblico_privato = (2)::numeric) THEN 'Pubblico'::text
            ELSE NULL::text
        END AS tipo_ente_beneficiario,
    tb.cod_stereotipo,
    st.descr_stereotipo,
    tb.flag_pubblico_privato,
    d.id_soggetto_creatore,
    sc.cognome AS cognome_soggetto_creatore,
    sc.nome AS nome_soggetto_creatore,
    to_char(d.dt_creazione, 'DD/MM/YYYY HH24:MI'::text) AS dt_creazione_domanda,
    d.id_soggetto_conclusione,
    sl.cognome AS cognome_soggetto_conclusione,
    sl.nome AS nome_soggetto_conclusione,
    to_char(d.dt_conclusione, 'DD/MM/YYYY HH24:MI'::text) AS dt_conclusione,
    d.id_soggetto_invio,
    si.cognome AS cognome_soggetto_invio,
    si.nome AS nome_soggetto_invio,
    to_char(d.dt_invio_domanda, 'DD/MM/YYYY HH24:MI'::text) AS dt_invio_domanda,
    d.id_soggetto_beneficiario,
    sb.denominazione AS denominazione_soggetto_beneficiario,
    sb.cod_fiscale AS cod_fiscale_beneficiario,
    sb.sigla_nazione,
    sp.id_sportello_bando,
    sp.num_atto,
    sp.dt_atto,
    to_char(sp.dt_apertura, 'DD/MM/YYYY HH24:MI'::text) AS dt_apertura_sportello,
    to_char(sp.dt_chiusura, 'DD/MM/YYYY HH24:MI'::text) AS dt_chiusura_sportello,
    sp.id_bando,
    b.flag_demat,
    b.tipo_firma,
    b.descrizione AS descr_bando,
    b.flag_progetti_comuni,
    (((az.codice)::text || ' - '::text) || (b.descr_breve)::text) AS descr_breve_bando,
    b.id_ente_destinatario AS id_ente,
    n.id_normativa,
    n.descr_breve AS normativa,
    ap.id_classificazione AS id_classificazione_asse_prioritario,
    ap.codice AS codice_asse_prioritario,
    ap.descrizione AS descrizione_asse_prioritario,
    NULL::integer AS id_classificazione_priorita_investimento,
    NULL::character varying AS codice_priorita_investimento,
    NULL::character varying AS descrizione_priorita_investimento,
    os.id_classificazione AS id_classificazione_misura,
    os.codice AS codice_misura,
    os.descrizione AS descrizione_misura,
    az.id_classificazione AS id_classificazione_azione,
    az.codice AS codice_azione,
    az.descrizione AS descrizione_azione,
        CASE
            WHEN ((e.dest_file_domanda)::text = 'REGIONE'::text) THEN 'REGIONE PIEMONTE'::character varying
            WHEN ((e.dest_file_domanda)::text = 'FINPIEMONTE'::text) THEN 'FINPIEMONTE S.p.A.'::character varying
            ELSE e.dest_file_domanda
        END AS destinatario_descrizione,
        CASE
            WHEN ((e.dest_file_domanda)::text = 'FINPIEMONTE'::text) THEN NULL::character varying
            ELSE e.descrizione
        END AS destinatario_direzione,
    e.indirizzo AS destinatario_indirizzo,
    e.cap AS destinatario_cap,
    e.descr_comune AS destinatario_citta,
    e.sigla_prov AS destinatario_provincia,
    e.pec AS destinatario_pec,
    (((((((n.descr_breve)::text || ' '::text) || (ap.codice)::text) || ' '::text) || (os.codice)::text) || '-'::text) || (b.descr_breve)::text) AS norma_incentivazione,
    ( SELECT string_agg((x.codice)::text, '-'::text) AS string_agg
           FROM ( SELECT b_1.id_bando,
                    a.codice
                   FROM findom_os.findom_d_tipol_interventi a,
                    findom_os.findom_r_bandi_tipol_interventi b_1
                  WHERE ((a.id_tipol_intervento = b_1.id_tipol_intervento) AND (b_1.id_bando = sp.id_bando))
                  ORDER BY a.codice) x
          GROUP BY x.id_bando) AS codice_intervento,
    ( SELECT string_agg(x.descrizione, ' - '::text) AS string_agg
           FROM ( SELECT b_1.id_bando,
                    a.descrizione
                   FROM findom_os.findom_d_tipol_interventi a,
                    findom_os.findom_r_bandi_tipol_interventi b_1
                  WHERE ((a.id_tipol_intervento = b_1.id_tipol_intervento) AND (b_1.id_bando = sp.id_bando))
                  ORDER BY a.codice) x
          GROUP BY x.id_bando) AS descrizione_intervento,
    at.id_area_tematica,
    at.descrizione AS descrizione_area_tematica
   FROM (((((((((((((((((((((((findom_os.shell_t_domande d
     JOIN findom_os.aggr_t_model m ON ((m.model_id = d.id_domanda)))
     JOIN findom_os.aggr_d_model_state ms ON (((ms.model_state)::text = (m.model_state_fk)::text)))
     LEFT JOIN findom_os.istr_t_model i ON ((i.model_id = d.id_domanda)))
     LEFT JOIN findom_os.findom_d_stato_istruttoria sis ON (((sis.id_stato_istr)::text = (d.id_stato_istr)::text)))
     LEFT JOIN findom_os.istr_d_model_state ims ON (((ims.model_state)::text = (i.model_state_fk)::text)))
     LEFT JOIN findom_os.findom_d_funzionari funz ON ((funz.id_funzionario = d.id_istruttore_amm)))
     LEFT JOIN findom_os.findom_d_funzionari decis ON ((decis.id_funzionario = d.id_decisore)))
     JOIN findom_os.findom_d_tipol_beneficiari tb ON ((tb.id_tipol_beneficiario = d.id_tipol_beneficiario)))
     JOIN findom_os.findom_d_stereotipi st ON (((st.cod_stereotipo)::text = (tb.cod_stereotipo)::text)))
     JOIN findom_os.shell_t_soggetti sc ON ((sc.id_soggetto = d.id_soggetto_creatore)))
     JOIN findom_os.shell_t_soggetti sb ON ((sb.id_soggetto = d.id_soggetto_beneficiario)))
     LEFT JOIN findom_os.shell_t_soggetti si ON ((si.id_soggetto = d.id_soggetto_invio)))
     LEFT JOIN findom_os.shell_t_soggetti sl ON ((sl.id_soggetto = d.id_soggetto_conclusione)))
     LEFT JOIN findom_os.shell_t_documento_index di ON (((di.id_domanda = d.id_domanda) AND (di.id_allegato IS NULL))))
     LEFT JOIN findom_os.shell_t_documento_prot dp ON ((dp.id_documento_index = di.id_documento_index)))
     JOIN findom_os.findom_t_sportelli_bandi sp ON ((sp.id_sportello_bando = d.id_sportello_bando)))
     JOIN findom_os.findom_t_bandi b ON (((b.id_bando = sp.id_bando) AND (b.flag_nuova_gestione = true))))
     LEFT JOIN findom_os.findom_d_area_tematica at ON ((at.id_area_tematica = b.id_area_tematica)))
     JOIN findom_os.findom_d_enti e ON ((e.id_ente = b.id_ente_destinatario)))
     JOIN findom_os.findom_d_classif_bandi az ON (((az.id_classificazione = b.id_classificazione) AND (az.id_tipo_suddivisione = 5))))
     JOIN findom_os.findom_d_classif_bandi os ON (((az.id_classificazione_padre = os.id_classificazione) AND (os.id_tipo_suddivisione = 4))))
     JOIN findom_os.findom_d_classif_bandi ap ON (((os.id_classificazione_padre = ap.id_classificazione) AND (ap.id_tipo_suddivisione = 1))))
     JOIN findom_os.findom_d_normative n ON ((n.id_normativa = ap.id_normativa)));


ALTER TABLE findom_os.findom_v_domande_nuova_gestione OWNER TO findom_os;

--
-- TOC entry 16303 (class 1259 OID 31176137)
-- Name: findom_v_domande_scheda_progetto_valut; Type: VIEW; Schema: findom_os; Owner: findom_os
--

CREATE VIEW findom_os.findom_v_domande_scheda_progetto_valut AS
 SELECT y.id_domanda,
    y.id_bando,
    y.descr_breve_bando,
    ti.id_tipol_intervento,
    ti.descrizione AS descr_tipol_intervento,
    cv.id_criterio,
    cv.descrizione AS descr_criterio,
    sv.id_specifica,
    sv.descrizione AS descr_specifica,
    psv.id_parametro,
    psv.descrizione AS descr_parametro,
    pv.id_parametro_valut,
    pv.punteggio,
        CASE
            WHEN (y.selezionato = 'checked'::text) THEN 'S'::text
            ELSE 'N'::text
        END AS selezionato
   FROM ((((((( SELECT x.id_domanda,
            b.id_bando,
            b.descr_breve AS descr_breve_bando,
            (unnest(xpath('//descrBreveParametro/text()'::text, x.scheda_progetto)))::text AS descr_breve_parametro_dom,
            (unnest(xpath('//idParametro/text()'::text, x.scheda_progetto)))::text AS id_parametro_dom,
            (unnest(xpath('//idParametroValut/text()'::text, x.scheda_progetto)))::text AS id_parametro_valut,
            (unnest(xpath('//punteggioParametro/text()'::text, x.scheda_progetto)))::text AS punteggio_parametro_dom,
            (unnest(xpath('//checked/text()'::text, x.scheda_progetto)))::text AS selezionato
           FROM (((( SELECT m.model_id AS id_domanda,
                    unnest(xpath('/tree-map/_criteri/map/criteriList/list/map/specificheList/list/map/parametriList/list/map'::text, m.serialized_model)) AS scheda_progetto
                   FROM findom_os.aggr_t_model m) x
             JOIN findom_os.shell_t_domande d ON ((d.id_domanda = x.id_domanda)))
             JOIN findom_os.findom_t_sportelli_bandi sp ON ((sp.id_sportello_bando = d.id_sportello_bando)))
             JOIN findom_os.findom_t_bandi b ON (((b.id_bando = sp.id_bando) AND (b.flag_scheda_progetto = true))))) y
     JOIN findom_os.findom_t_parametri_valut pv ON ((pv.id_parametro_valut = (y.id_parametro_valut)::integer)))
     JOIN findom_os.findom_d_parametri_specifiche_valut psv ON ((psv.id_parametro = pv.id_parametro)))
     JOIN findom_os.findom_d_specifiche_valut sv ON ((sv.id_specifica = pv.id_specifica)))
     JOIN findom_os.findom_d_criteri_valut cv ON ((cv.id_criterio = sv.id_criterio)))
     JOIN findom_os.findom_r_bandi_criteri_valut bsv ON (((bsv.id_bando = pv.id_bando) AND (bsv.id_criterio = cv.id_criterio))))
     LEFT JOIN findom_os.findom_d_tipol_interventi ti ON ((ti.id_tipol_intervento = bsv.id_tipol_intervento)));


ALTER TABLE findom_os.findom_v_domande_scheda_progetto_valut OWNER TO findom_os;

--
-- TOC entry 16304 (class 1259 OID 31176142)
-- Name: findom_v_domande_sedi; Type: VIEW; Schema: findom_os; Owner: findom_os
--

CREATE VIEW findom_os.findom_v_domande_sedi AS
 SELECT y.id_domanda,
    y.cap,
    y.comune,
    y.provincia,
    y.indirizzo,
    y.num_civico,
    y.tipo_sede,
    y.codice_ateco,
    y.descrizione_ateco,
    y.indirizzo_pec
   FROM ( SELECT x.id_domanda,
            (unnest(xpath('//capSede/text()'::text, x.sedi)))::text AS cap,
            (unnest(xpath('//descrComuneSede/text()'::text, x.sedi)))::text AS comune,
            (unnest(xpath('//descrProvinciaSede/text()'::text, x.sedi)))::text AS provincia,
            (unnest(xpath('//indirizzoSede/text()'::text, x.sedi)))::text AS indirizzo,
            (unnest(xpath('//numeroCivicoSede/text()'::text, x.sedi)))::text AS num_civico,
            (unnest(xpath('//descrTipoSede/text()'::text, x.sedi)))::text AS tipo_sede,
            (unnest(xpath('//codAteco2007Sede/text()'::text, x.sedi)))::text AS codice_ateco,
            (unnest(xpath('//descrAteco2007Sede/text()'::text, x.sedi)))::text AS descrizione_ateco,
            (unnest(xpath('//indirizzoPecSede/text()'::text, x.sedi)))::text AS indirizzo_pec
           FROM ( SELECT m.model_id AS id_domanda,
                    unnest(xpath('/tree-map/_sedi/map/sediList/list/map'::text, m.serialized_model)) AS sedi
                   FROM findom_os.aggr_t_model m) x) y;


ALTER TABLE findom_os.findom_v_domande_sedi OWNER TO findom_os;

--
-- TOC entry 16305 (class 1259 OID 31176152)
-- Name: findom_v_domande_voci_entrata; Type: VIEW; Schema: findom_os; Owner: findom_os
--

CREATE VIEW findom_os.findom_v_domande_voci_entrata AS
 SELECT a.id_domanda,
    a.descrizione,
    a.dettaglio,
    a.id_voce_entrata,
    a.importo AS imp_risorse_proprie,
    ve.flag_risorse_proprie
   FROM (( SELECT y.id_domanda,
            y.descrizione,
            y.dettaglio,
            (y.idvoceentrata)::integer AS id_voce_entrata,
            (replace(y.importo, ','::text, '.'::text))::numeric AS importo,
            y.tiporecord
           FROM ( SELECT x.id_domanda,
                        CASE
                            WHEN xpath_exists('//descrizione/text()'::text, x.cat) THEN (unnest(xpath('//descrizione/text()'::text, x.cat)))::text
                            ELSE NULL::text
                        END AS descrizione,
                        CASE
                            WHEN xpath_exists('//dettaglio/text()'::text, x.cat) THEN (unnest(xpath('//dettaglio/text()'::text, x.cat)))::text
                            ELSE NULL::text
                        END AS dettaglio,
                        CASE
                            WHEN xpath_exists('//idVoceEntrata/text()'::text, x.cat) THEN (unnest(xpath('//idVoceEntrata/text()'::text, x.cat)))::text
                            ELSE NULL::text
                        END AS idvoceentrata,
                        CASE
                            WHEN xpath_exists('//importo/text()'::text, x.cat) THEN (unnest(xpath('//importo/text()'::text, x.cat)))::text
                            ELSE NULL::text
                        END AS importo,
                        CASE
                            WHEN xpath_exists('//tipoRecord/text()'::text, x.cat) THEN (unnest(xpath('//tipoRecord/text()'::text, x.cat)))::text
                            ELSE NULL::text
                        END AS tiporecord
                   FROM ( SELECT m.model_id AS id_domanda,
                            unnest(xpath('/tree-map/_vociEntrata/map/vociEntrataRiepilogoList/list/map'::text, m.serialized_model)) AS cat
                           FROM (((findom_os.aggr_t_model m
                             JOIN findom_os.shell_t_domande d ON ((d.id_domanda = m.model_id)))
                             JOIN findom_os.findom_t_sportelli_bandi sb ON ((sb.id_sportello_bando = d.id_sportello_bando)))
                             JOIN findom_os.findom_t_bandi b ON (((b.id_bando = sb.id_bando) AND (b.flag_rimodulazione = true))))
                          WHERE ((m.model_state_fk)::text = 'IN'::text)) x) y
          WHERE (y.tiporecord = 'radice'::text)) a
     JOIN findom_os.findom_d_voci_entrata ve ON ((ve.id_voce_entrata = a.id_voce_entrata)))
  ORDER BY a.id_domanda;


ALTER TABLE findom_os.findom_v_domande_voci_entrata OWNER TO findom_os;

--
-- TOC entry 16306 (class 1259 OID 31176157)
-- Name: findom_v_domande_voci_entrata_dett; Type: VIEW; Schema: findom_os; Owner: findom_os
--

CREATE VIEW findom_os.findom_v_domande_voci_entrata_dett AS
 SELECT a.id_domanda,
    a.descrizione,
    a.dettaglio,
    a.id_voce_entrata,
    a.importo
   FROM ( SELECT y.id_domanda,
            y.descrizione,
            y.dettaglio,
            (y.idvoceentrata)::integer AS id_voce_entrata,
            (replace(y.importo, ','::text, '.'::text))::numeric AS importo
           FROM ( SELECT x.id_domanda,
                        CASE
                            WHEN xpath_exists('//descrizione/text()'::text, x.cat) THEN (unnest(xpath('//descrizione/text()'::text, x.cat)))::text
                            ELSE NULL::text
                        END AS descrizione,
                        CASE
                            WHEN xpath_exists('//dettaglio/text()'::text, x.cat) THEN (unnest(xpath('//dettaglio/text()'::text, x.cat)))::text
                            ELSE NULL::text
                        END AS dettaglio,
                        CASE
                            WHEN xpath_exists('//idVoceEntrata/text()'::text, x.cat) THEN (unnest(xpath('//idVoceEntrata/text()'::text, x.cat)))::text
                            ELSE NULL::text
                        END AS idvoceentrata,
                        CASE
                            WHEN xpath_exists('//importo/text()'::text, x.cat) THEN (unnest(xpath('//importo/text()'::text, x.cat)))::text
                            ELSE NULL::text
                        END AS importo
                   FROM ( SELECT m.model_id AS id_domanda,
                            unnest(xpath('/tree-map/_vociEntrata/map/vociEntrataScelteList/list/map'::text, m.serialized_model)) AS cat
                           FROM (((findom_os.aggr_t_model m
                             JOIN findom_os.shell_t_domande d ON ((d.id_domanda = m.model_id)))
                             JOIN findom_os.findom_t_sportelli_bandi sb ON ((sb.id_sportello_bando = d.id_sportello_bando)))
                             JOIN findom_os.findom_t_bandi b ON (((b.id_bando = sb.id_bando) AND (b.flag_rimodulazione = true))))
                          WHERE ((m.model_state_fk)::text = 'IN'::text)) x) y) a
  ORDER BY a.id_domanda;


ALTER TABLE findom_os.findom_v_domande_voci_entrata_dett OWNER TO findom_os;

--
-- TOC entry 16307 (class 1259 OID 31176162)
-- Name: findom_v_enti_locali_piemontesi; Type: VIEW; Schema: findom_os; Owner: findom_os
--

CREATE VIEW findom_os.findom_v_enti_locali_piemontesi AS
 SELECT ext_d_comuni.comune AS codice_istat,
    (ext_d_comuni.descom)::character varying(100) AS denominazione,
    ext_d_comuni.codice_fiscale,
    ext_d_comuni.classificazione,
    ext_d_comuni.popolazione,
    'COMUNE'::text AS tipo_ente,
    ('Comune di '::text || (ext_d_comuni.descom)::text) AS denominazione_completa
   FROM findom_os.ext_d_comuni
  WHERE ((ext_d_comuni.regione)::text = '01'::text)
UNION ALL
 SELECT ext_d_province.prov AS codice_istat,
    (ext_d_province.desprov)::character varying(100) AS denominazione,
    ext_d_province.codice_fiscale,
    NULL::character varying AS classificazione,
    NULL::numeric AS popolazione,
    'PROVINCIA'::text AS tipo_ente,
    ('Provincia di '::text || (ext_d_province.desprov)::text) AS denominazione_completa
   FROM findom_os.ext_d_province
  WHERE (((ext_d_province.regione)::text = '01'::text) AND (ext_d_province.flag_citta_metro IS NULL))
UNION ALL
 SELECT ext_d_province.prov AS codice_istat,
    (ext_d_province.desprov)::character varying(100) AS denominazione,
    ext_d_province.codice_fiscale,
    NULL::character varying AS classificazione,
    NULL::numeric AS popolazione,
    'CITTA METROPOLITANA'::text AS tipo_ente,
    ('Città Metropolitana di '::text || (ext_d_province.desprov)::text) AS denominazione_completa
   FROM findom_os.ext_d_province
  WHERE (((ext_d_province.regione)::text = '01'::text) AND (ext_d_province.flag_citta_metro = 'S'::bpchar))
UNION ALL
 SELECT NULL::character varying AS codice_istat,
    ext_d_enti_parchi.denominazione,
    ext_d_enti_parchi.codice_fiscale,
    NULL::character varying AS classificazione,
    NULL::numeric AS popolazione,
    'PARCO'::text AS tipo_ente,
    ('Ente di gestione delle '::text || (ext_d_enti_parchi.denominazione)::text) AS denominazione_completa
   FROM findom_os.ext_d_enti_parchi;


ALTER TABLE findom_os.findom_v_enti_locali_piemontesi OWNER TO findom_os;

--
-- TOC entry 16308 (class 1259 OID 31176167)
-- Name: findom_v_funzionari_bandi; Type: VIEW; Schema: findom_os; Owner: findom_os
--

CREATE VIEW findom_os.findom_v_funzionari_bandi AS
 WITH istruttoria_aperta AS (
         SELECT DISTINCT b.id_bando
           FROM (((findom_os.shell_t_domande d
             JOIN findom_os.findom_d_stato_istruttoria si ON (((si.id_stato_istr = d.id_stato_istr) AND (si.flag_stato_finale IS NULL))))
             JOIN findom_os.findom_t_sportelli_bandi sp ON ((sp.id_sportello_bando = d.id_sportello_bando)))
             JOIN findom_os.findom_t_bandi b ON ((b.id_bando = sp.id_bando)))
        )
 SELECT f.id_funzionario,
    b.descr_breve AS descr_breve_bando,
    f.cod_fiscale,
    f.cognome,
    f.nome,
    f.dt_inizio AS dt_inizio_funzionario,
    f.dt_fine AS dt_fine_funzionario,
    d.id_direzione,
    d.codice AS codice_direzione,
    d.descrizione AS descr_direzione,
    fd.dt_inizio AS dt_inizio_assoc,
    fd.dt_fine AS dt_fine_assoc,
    s.id_settore,
    s.codice AS codice_settore,
    s.descrizione AS descr_settore,
    s.dt_inizio AS dt_inizio_settore,
    s.dt_fine AS dt_fine_settore,
    b.id_bando,
    b.descrizione AS descrizione_bando,
    cb.id_normativa,
    cb.normativa,
    ri.id_ruolo,
    ri.codice_ruolo,
    ri.descr_ruolo AS descrizione_ruolo,
        CASE
            WHEN (ia.id_bando IS NOT NULL) THEN 'S'::text
            ELSE 'N'::text
        END AS flag_istruttoria_aperta,
    b.flag_istruttoria_esterna
   FROM (((((((findom_os.findom_d_funzionari f
     JOIN findom_os.findom_r_funzionari_direzioni fd ON ((fd.id_funzionario = f.id_funzionario)))
     JOIN findom_os.findom_d_direzioni d ON ((d.id_direzione = fd.id_direzione)))
     JOIN findom_os.findom_d_settori s ON ((s.id_direzione = d.id_direzione)))
     JOIN findom_os.findom_t_bandi b ON ((b.id_settore = s.id_settore)))
     JOIN findom_os.findom_v_classif_bandi cb ON ((cb.id_azione = b.id_classificazione)))
     JOIN findom_os.findom_d_ruoli_istr ri ON ((ri.id_ruolo = f.id_ruolo)))
     LEFT JOIN istruttoria_aperta ia ON ((ia.id_bando = b.id_bando)))
UNION
 SELECT f.id_funzionario,
    b.descr_breve AS descr_breve_bando,
    f.cod_fiscale,
    f.cognome,
    f.nome,
    f.dt_inizio AS dt_inizio_funzionario,
    f.dt_fine AS dt_fine_funzionario,
    d.id_direzione,
    d.codice AS codice_direzione,
    d.descrizione AS descr_direzione,
    fs.dt_inizio AS dt_inizio_assoc,
    fs.dt_fine AS dt_fine_assoc,
    s.id_settore,
    s.codice AS codice_settore,
    s.descrizione AS descr_settore,
    s.dt_inizio AS dt_inizio_settore,
    s.dt_fine AS dt_fine_settore,
    b.id_bando,
    b.descrizione AS descrizione_bando,
    cb.id_normativa,
    cb.normativa,
    ri.id_ruolo,
    ri.codice_ruolo,
    ri.descr_ruolo AS descrizione_ruolo,
        CASE
            WHEN (ia.id_bando IS NOT NULL) THEN 'S'::text
            ELSE 'N'::text
        END AS flag_istruttoria_aperta,
    b.flag_istruttoria_esterna
   FROM (((((((findom_os.findom_d_funzionari f
     JOIN findom_os.findom_r_funzionari_settori fs ON ((fs.id_funzionario = f.id_funzionario)))
     JOIN findom_os.findom_d_settori s ON ((s.id_settore = fs.id_settore)))
     JOIN findom_os.findom_d_direzioni d ON ((d.id_direzione = s.id_direzione)))
     JOIN findom_os.findom_t_bandi b ON ((b.id_settore = s.id_settore)))
     JOIN findom_os.findom_v_classif_bandi cb ON ((cb.id_azione = b.id_classificazione)))
     JOIN findom_os.findom_d_ruoli_istr ri ON ((ri.id_ruolo = f.id_ruolo)))
     LEFT JOIN istruttoria_aperta ia ON ((ia.id_bando = b.id_bando)))
  ORDER BY 1, 2;


ALTER TABLE findom_os.findom_v_funzionari_bandi OWNER TO findom_os;


--
-- TOC entry 16310 (class 1259 OID 31176176)
-- Name: findom_v_rimod_spese; Type: VIEW; Schema: findom_os; Owner: findom_os
--

CREATE VIEW findom_os.findom_v_rimod_spese AS
 SELECT a.id_bando,
    a.descr_breve_bando,
    a.id_domanda,
    a.id_categ_voce_spesa,
    a.categ_voce_spesa,
    a.id_tipol_voce_spesa,
    a.codice_tipol_voce_spesa,
    a.descrizione_tipol_voce_spesa,
    sum(a.imp_voce_spesa) OVER (PARTITION BY a.id_domanda, a.id_categ_voce_spesa) AS tot_categ_voce_spesa,
    sum(rs_i.importo) OVER (PARTITION BY a.id_domanda, a.id_categ_voce_spesa) AS tot_categ_voce_spesa_rim_istruttore,
    sum(rs_d.importo) OVER (PARTITION BY a.id_domanda, a.id_categ_voce_spesa) AS tot_categ_voce_spesa_rim_decisore,
    a.id_voce_spesa,
    a.voce_spesa,
    a.dettaglio_voce_spesa,
    a.id_tipol_intervento,
    a.tipologia_intervento,
    a.id_dett_intervento,
    a.dettaglio_intervento,
    a.imp_voce_spesa,
    rs_i.importo AS imp_voce_spesa_rim_istruttore,
    rs_d.importo AS imp_voce_spesa_rim_decisore
   FROM ((( SELECT y.id_domanda,
            y.id_bando,
            y.descr_breve_bando,
            ti.id_tipol_intervento,
            ti.descrizione AS tipologia_intervento,
            y.id_dett_intervento,
            y.id_voce_spesa,
            y.dettaglio_voce_spesa,
            cvs.id_categ_voce_spesa,
            vs.descr_breve AS descr_breve_voce_spesa,
            vs.descrizione AS voce_spesa,
            cvs.descrizione AS categ_voce_spesa,
            tvs.id_tipol_voce_spesa,
            tvs.codice AS codice_tipol_voce_spesa,
            tvs.descrizione AS descrizione_tipol_voce_spesa,
            (replace(y.totalevocespesa, ','::text, '.'::text))::numeric AS imp_voce_spesa,
            y.tipo_record,
            dti.descrizione AS dettaglio_intervento
           FROM (((((( SELECT x.id_domanda,
                    x.id_bando,
                    x.descr_breve_bando,
                    ((unnest(xpath('//idTipoIntervento/text()'::text, x.cat)))::text)::integer AS id_tipol_intervento,
                        CASE
                            WHEN xpath_exists('//idDettIntervento/text()'::text, x.cat) THEN ((unnest(xpath('//idDettIntervento/text()'::text, x.cat)))::text)::integer
                            ELSE NULL::integer
                        END AS id_dett_intervento,
                    ((unnest(xpath('//idVoceSpesa/text()'::text, x.cat)))::text)::integer AS id_voce_spesa,
                        CASE
                            WHEN xpath_exists('//dettaglioVoce/text()'::text, x.cat) THEN (unnest(xpath('//dettaglioVoce/text()'::text, x.cat)))::text
                            ELSE NULL::text
                        END AS dettaglio_voce_spesa,
                        CASE
                            WHEN xpath_exists('//totaleVoceSpesa/text()'::text, x.cat) THEN (unnest(xpath('//totaleVoceSpesa/text()'::text, x.cat)))::text
                            ELSE NULL::text
                        END AS totalevocespesa,
                    ((unnest(xpath('//tipoRecord/text()'::text, x.cat)))::text)::integer AS tipo_record
                   FROM ( SELECT m.model_id AS id_domanda,
                            b.id_bando,
                            b.descr_breve AS descr_breve_bando,
                            unnest(xpath('/tree-map/_pianoSpese/map/pianoSpeseList/list/map'::text, m.serialized_model)) AS cat
                           FROM (((findom_os.aggr_t_model m
                             JOIN findom_os.shell_t_domande d ON ((d.id_domanda = m.model_id)))
                             JOIN findom_os.findom_t_sportelli_bandi sb ON ((sb.id_sportello_bando = d.id_sportello_bando)))
                             JOIN findom_os.findom_t_bandi b ON (((b.id_bando = sb.id_bando) AND (b.flag_rimodulazione = true))))
                          WHERE ((m.model_state_fk)::text = 'IN'::text)) x) y
             JOIN findom_os.findom_d_voci_spesa vs ON ((y.id_voce_spesa = vs.id_voce_spesa)))
             LEFT JOIN findom_os.findom_d_categ_voci_spesa cvs ON ((cvs.id_categ_voce_spesa = vs.id_categ_voce_spesa)))
             LEFT JOIN findom_os.findom_d_tipol_voci_spesa tvs USING (id_tipol_voce_spesa))
             LEFT JOIN findom_os.findom_d_dett_tipol_interventi dti ON ((y.id_dett_intervento = dti.id_dett_tipol_intervento)))
             JOIN findom_os.findom_d_tipol_interventi ti ON ((y.id_tipol_intervento = ti.id_tipol_intervento)))
          WHERE (y.tipo_record = 3)) a
     LEFT JOIN findom_os.shell_t_rimod_spese rs_i ON (((a.id_domanda = rs_i.id_domanda) AND (a.id_tipol_intervento = rs_i.id_tipol_intervento) AND (public.nvl(a.id_dett_intervento, 0) = public.nvl(rs_i.id_dett_intervento, 0)) AND (a.id_voce_spesa = rs_i.id_voce_spesa) AND (rs_i.tipo_rimodulazione = 'I'::bpchar))))
     LEFT JOIN findom_os.shell_t_rimod_spese rs_d ON (((a.id_domanda = rs_d.id_domanda) AND (a.id_tipol_intervento = rs_d.id_tipol_intervento) AND (public.nvl(a.id_dett_intervento, 0) = public.nvl(rs_d.id_dett_intervento, 0)) AND (a.id_voce_spesa = rs_d.id_voce_spesa) AND (rs_d.tipo_rimodulazione = 'D'::bpchar))))
  ORDER BY a.id_bando, a.id_domanda, a.id_categ_voce_spesa, a.descr_breve_voce_spesa;


ALTER TABLE findom_os.findom_v_rimod_spese OWNER TO findom_os;

--
-- TOC entry 16311 (class 1259 OID 31176181)
-- Name: findom_v_rimod_agev; Type: VIEW; Schema: findom_os; Owner: findom_os
--

CREATE VIEW findom_os.findom_v_rimod_agev AS
 WITH spesecateg AS (
         SELECT findom_v_rimod_spese.id_domanda,
            findom_v_rimod_spese.id_categ_voce_spesa,
            COALESCE(min(findom_v_rimod_spese.tot_categ_voce_spesa), (0)::numeric) AS imp_spese_categ,
            COALESCE(min(findom_v_rimod_spese.tot_categ_voce_spesa_rim_istruttore), (0)::numeric) AS imp_spese_categ_rim_istruttore,
            COALESCE(min(findom_v_rimod_spese.tot_categ_voce_spesa_rim_decisore), (0)::numeric) AS imp_spese_categ_rim_decisore
           FROM findom_os.findom_v_rimod_spese
          GROUP BY findom_v_rimod_spese.id_domanda, findom_v_rimod_spese.id_categ_voce_spesa
        ), risorseproprie AS (
         SELECT findom_v_domande_voci_entrata.id_domanda,
            COALESCE(sum(findom_v_domande_voci_entrata.imp_risorse_proprie), (0)::numeric) AS imp_risorse_proprie
           FROM findom_os.findom_v_domande_voci_entrata
          WHERE (findom_v_domande_voci_entrata.flag_risorse_proprie = true)
          GROUP BY findom_v_domande_voci_entrata.id_domanda
        )
 SELECT a.id_bando,
    a.descr_breve_bando,
    a.id_domanda,
    a.imp_erogabile,
    ra_i.imp_erogabile AS imp_erogabile_rim_istruttore,
    ra_d.imp_erogabile AS imp_erogabile_rim_decisore,
    a.imp_richiesto,
    ra_i.imp_richiesto AS imp_richiesto_rim_istruttore,
    ra_d.imp_richiesto AS imp_richiesto_rim_decisore,
    COALESCE(a.perc_qp_spese_gen_funz, a.perc_qp) AS perc_qp_spese_gen_funz,
    ra_i.perc_qp_spese_gen_funz AS perc_qp_spese_gen_funz_rim_istruttore,
    ra_d.perc_qp_spese_gen_funz AS perc_qp_spese_gen_funz_rim_decisore,
    sca.imp_spese_categ AS imp_spese_conn_attivita,
    sca.imp_spese_categ_rim_istruttore AS imp_spese_conn_attivita_rim_istruttore,
    sca.imp_spese_categ_rim_decisore AS imp_spese_conn_attivita_rim_decisore,
    sgf.imp_spese_categ AS imp_spese_gen_funz,
    sgf.imp_spese_categ_rim_istruttore AS imp_spese_gen_funz_rim_istruttore,
    sgf.imp_spese_categ_rim_decisore AS imp_spese_gen_funz_rim_decisore,
    ((sgf.imp_spese_categ / (100)::numeric) * COALESCE(a.perc_qp_spese_gen_funz, a.perc_qp)) AS imp_spese_gen_funz_qp,
    ((sgf.imp_spese_categ_rim_istruttore / (100)::numeric) * ra_i.perc_qp_spese_gen_funz) AS imp_spese_gen_funz_qp_rim_istruttore,
    ((sgf.imp_spese_categ_rim_decisore / (100)::numeric) * ra_d.perc_qp_spese_gen_funz) AS imp_spese_gen_funz_qp_rim_decisore,
    rp.imp_risorse_proprie,
    ra_i.imp_risorse_proprie AS imp_risorse_proprie_rim_istruttore,
    ra_d.imp_risorse_proprie AS imp_risorse_proprie_rim_decisore,
    a.imp_tot_entrate,
    (a.imp_tot_entrate - (COALESCE(rp.imp_risorse_proprie, (0)::numeric) - COALESCE(ra_i.imp_risorse_proprie, (0)::numeric))) AS imp_tot_entrate_rim_istruttore,
    (a.imp_tot_entrate - (COALESCE(rp.imp_risorse_proprie, (0)::numeric) - COALESCE(ra_d.imp_risorse_proprie, (0)::numeric))) AS imp_tot_entrate_rim_decisore,
    (sca.imp_spese_categ + ((sgf.imp_spese_categ / (100)::numeric) * COALESCE(a.perc_qp_spese_gen_funz, a.perc_qp))) AS imp_tot_spese_eff,
    (sca.imp_spese_categ_rim_istruttore + ((sgf.imp_spese_categ_rim_istruttore / (100)::numeric) * ra_i.perc_qp_spese_gen_funz)) AS imp_tot_spese_eff_rim_istruttore,
    (sca.imp_spese_categ_rim_decisore + ((sgf.imp_spese_categ_rim_decisore / (100)::numeric) * ra_d.perc_qp_spese_gen_funz)) AS imp_tot_spese_eff_rim_decisore,
    ((sca.imp_spese_categ + ((sgf.imp_spese_categ / (100)::numeric) * COALESCE(a.perc_qp_spese_gen_funz, a.perc_qp))) - a.imp_tot_entrate) AS differenza,
    ((sca.imp_spese_categ_rim_istruttore + ((sgf.imp_spese_categ_rim_istruttore / (100)::numeric) * ra_i.perc_qp_spese_gen_funz)) - (a.imp_tot_entrate - (COALESCE(rp.imp_risorse_proprie, (0)::numeric) - COALESCE(ra_i.imp_risorse_proprie, (0)::numeric)))) AS differenza_rim_istruttore,
    ((sca.imp_spese_categ_rim_decisore + ((sgf.imp_spese_categ_rim_decisore / (100)::numeric) * ra_d.perc_qp_spese_gen_funz)) - (a.imp_tot_entrate - (COALESCE(rp.imp_risorse_proprie, (0)::numeric) - COALESCE(ra_d.imp_risorse_proprie, (0)::numeric)))) AS differenza_rim_decisore,
    ra_i.note AS note_istruttore,
    ra_d.note AS note_decisore
   FROM (((((( SELECT y.id_domanda,
            y.id_bando,
            y.descr_breve_bando,
            (replace(y.imp_erogabile, ','::text, '.'::text))::numeric AS imp_erogabile,
            (replace(y.imp_richiesto, ','::text, '.'::text))::numeric AS imp_richiesto,
            (replace(y.perc_qp_spese_gen_funz, ','::text, '.'::text))::numeric AS perc_qp_spese_gen_funz,
            (replace(y.perc_qp, ','::text, '.'::text))::numeric AS perc_qp,
            (replace(y.imp_tot_entrate, ','::text, '.'::text))::numeric AS imp_tot_entrate
           FROM ( SELECT x.id_domanda,
                    x.id_bando,
                    x.descr_breve_bando,
                        CASE
                            WHEN xpath_exists('//importoErogabile/text()'::text, x.cat) THEN (unnest(xpath('//importoErogabile/text()'::text, x.cat)))::text
                            ELSE NULL::text
                        END AS imp_erogabile,
                        CASE
                            WHEN xpath_exists('//importoRichiesto/text()'::text, x.cat) THEN (unnest(xpath('//importoRichiesto/text()'::text, x.cat)))::text
                            ELSE NULL::text
                        END AS imp_richiesto,
                        CASE
                            WHEN xpath_exists('//percQuotaParteSpeseGenFunz/text()'::text, x.cat) THEN (unnest(xpath('//percQuotaParteSpeseGenFunz/text()'::text, x.cat)))::text
                            ELSE NULL::text
                        END AS perc_qp_spese_gen_funz,
                        CASE
                            WHEN xpath_exists('//percQuotaParte/text()'::text, x.cat) THEN (unnest(xpath('//percQuotaParte/text()'::text, x.cat)))::text
                            ELSE NULL::text
                        END AS perc_qp,
                        CASE
                            WHEN xpath_exists('//totaleEntrate/text()'::text, x.cat) THEN (unnest(xpath('//totaleEntrate/text()'::text, x.cat)))::text
                            ELSE NULL::text
                        END AS imp_tot_entrate
                   FROM ( SELECT m.model_id AS id_domanda,
                            b.id_bando,
                            b.descr_breve AS descr_breve_bando,
                            unnest(xpath('/tree-map/_formaAgevolazione/map'::text, m.serialized_model)) AS cat
                           FROM (((findom_os.aggr_t_model m
                             JOIN findom_os.shell_t_domande d ON ((d.id_domanda = m.model_id)))
                             JOIN findom_os.findom_t_sportelli_bandi sb ON ((sb.id_sportello_bando = d.id_sportello_bando)))
                             JOIN findom_os.findom_t_bandi b ON ((b.id_bando = sb.id_bando)))
                          WHERE ((m.model_state_fk)::text = 'IN'::text)
                        UNION ALL
                         SELECT m.model_id AS id_domanda,
                            b.id_bando,
                            b.descr_breve AS descr_breve_bando,
                            unnest(xpath('/tree-map/_formaAgevolazioneB/map'::text, m.serialized_model)) AS cat
                           FROM (((findom_os.aggr_t_model m
                             JOIN findom_os.shell_t_domande d ON ((d.id_domanda = m.model_id)))
                             JOIN findom_os.findom_t_sportelli_bandi sb ON ((sb.id_sportello_bando = d.id_sportello_bando)))
                             JOIN findom_os.findom_t_bandi b ON ((b.id_bando = sb.id_bando)))
                          WHERE ((m.model_state_fk)::text = 'IN'::text)) x) y) a
     LEFT JOIN findom_os.shell_t_rimod_agev ra_i ON (((a.id_domanda = ra_i.id_domanda) AND (ra_i.tipo_rimodulazione = 'I'::bpchar))))
     LEFT JOIN findom_os.shell_t_rimod_agev ra_d ON (((a.id_domanda = ra_d.id_domanda) AND (ra_d.tipo_rimodulazione = 'D'::bpchar))))
     LEFT JOIN spesecateg sca ON (((a.id_domanda = sca.id_domanda) AND (sca.id_categ_voce_spesa = 1))))
     LEFT JOIN spesecateg sgf ON (((a.id_domanda = sgf.id_domanda) AND (sgf.id_categ_voce_spesa = 2))))
     LEFT JOIN risorseproprie rp ON ((a.id_domanda = rp.id_domanda)))
  ORDER BY a.id_bando, a.id_domanda;


ALTER TABLE findom_os.findom_v_rimod_agev OWNER TO findom_os;


--
-- TOC entry 16313 (class 1259 OID 31176190)
-- Name: findom_v_rimod_entrate; Type: VIEW; Schema: findom_os; Owner: findom_os
--

CREATE VIEW findom_os.findom_v_rimod_entrate AS
 SELECT a.id_bando,
    a.descr_breve_bando,
    a.id_domanda,
    a.id_voce_entrata,
    a.descrizione,
    a.dettaglio,
    a.importo,
    rs_i.importo AS imp_voce_entrata_rim_istruttore,
    rs_d.importo AS imp_voce_entrata_rim_decisore
   FROM ((( SELECT y.id_domanda,
            y.id_bando,
            y.descr_breve_bando,
            y.id_voce_entrata,
            y.descrizione,
            y.dettaglio,
            y.importo
           FROM ( SELECT m.id_domanda,
                    m.descrizione,
                    m.dettaglio,
                    m.id_voce_entrata,
                    m.importo,
                    b.id_bando,
                    b.descr_breve AS descr_breve_bando
                   FROM (((findom_os.findom_v_domande_voci_entrata_dett m
                     JOIN findom_os.shell_t_domande d ON ((d.id_domanda = m.id_domanda)))
                     JOIN findom_os.findom_t_sportelli_bandi sb ON ((sb.id_sportello_bando = d.id_sportello_bando)))
                     JOIN findom_os.findom_t_bandi b ON (((b.id_bando = sb.id_bando) AND (b.flag_rimodulazione = true))))
                  WHERE (d.dt_invio_domanda IS NOT NULL)
                UNION
                 SELECT m.id_domanda,
                    de.descrizione,
                    m.dettaglio,
                    m.id_voce_entrata,
                    NULL::numeric AS importo,
                    b.id_bando,
                    b.descr_breve AS descr_breve_bando
                   FROM (((((findom_os.shell_t_rimod_entrate m
                     JOIN findom_os.shell_t_domande d ON ((d.id_domanda = m.id_domanda)))
                     JOIN findom_os.findom_t_sportelli_bandi sb ON ((sb.id_sportello_bando = d.id_sportello_bando)))
                     JOIN findom_os.findom_t_bandi b ON (((b.id_bando = sb.id_bando) AND (b.flag_rimodulazione = true))))
                     JOIN findom_os.findom_d_voci_entrata de ON ((de.id_voce_entrata = m.id_voce_entrata)))
                     LEFT JOIN findom_os.findom_v_domande_voci_entrata_dett dett ON (((d.id_domanda = dett.id_domanda) AND (m.id_voce_entrata = dett.id_voce_entrata) AND ((COALESCE(m.dettaglio, ''::character varying))::text = COALESCE(dett.dettaglio, ''::text)))))
                  WHERE ((d.dt_invio_domanda IS NOT NULL) AND (dett.id_voce_entrata IS NULL))) y) a
     LEFT JOIN findom_os.shell_t_rimod_entrate rs_i ON (((a.id_domanda = rs_i.id_domanda) AND (a.id_voce_entrata = rs_i.id_voce_entrata) AND ((COALESCE(rs_i.dettaglio, ''::character varying))::text = COALESCE(a.dettaglio, ''::text)) AND (rs_i.tipo_rimodulazione = 'I'::bpchar))))
     LEFT JOIN findom_os.shell_t_rimod_entrate rs_d ON (((a.id_domanda = rs_d.id_domanda) AND (a.id_voce_entrata = rs_d.id_voce_entrata) AND ((COALESCE(rs_d.dettaglio, ''::character varying))::text = COALESCE(a.dettaglio, ''::text)) AND (rs_d.tipo_rimodulazione = 'D'::bpchar))))
  ORDER BY a.id_bando, a.id_domanda, a.descrizione, a.dettaglio;


ALTER TABLE findom_os.findom_v_rimod_entrate OWNER TO findom_os;

--
-- TOC entry 16314 (class 1259 OID 31176195)
-- Name: findom_v_scheda_progetto_valut; Type: VIEW; Schema: findom_os; Owner: findom_os
--

CREATE VIEW findom_os.findom_v_scheda_progetto_valut AS
 WITH cte_valutaz AS (
         SELECT b.id_bando,
            b.descr_breve AS descr_breve_bando,
            ti.id_tipol_intervento,
            ti.descrizione AS descrizione_tipol_intervento,
            cv.id_criterio,
            cv.descrizione AS descrizione_criterio,
            cv.descr_breve AS descr_breve_criterio,
            bcv.ordine AS ordine_criterio,
            bsv.id_specifica,
            sv.descrizione AS descrizione_specifica,
            COALESCE(sv.descr_breve, sv.descrizione) AS descr_breve_specifica,
            bsv.tipo_campo,
            sv.ordine AS ordine_specifica,
            pv.id_parametro,
            psv.descrizione AS descrizione_parametro,
            (((COALESCE(sv.descr_breve, sv.descrizione))::text || ' - '::text) || (COALESCE(psv.descr_breve, psv.descrizione))::text) AS descr_breve_parametro,
            pv.ordine AS ordine_parametro,
            pv.id_parametro_valut,
                CASE
                    WHEN ((sv.tipo_specifica)::text = 'PEN'::text) THEN (pv.punteggio * ('-1'::integer)::numeric)
                    ELSE pv.punteggio
                END AS punteggio_parametro
           FROM (((((((findom_os.findom_r_bandi_specifiche_valut bsv
             JOIN findom_os.findom_d_specifiche_valut sv ON ((sv.id_specifica = bsv.id_specifica)))
             JOIN findom_os.findom_r_bandi_criteri_valut bcv ON (((bcv.id_bando = bsv.id_bando) AND (bcv.id_criterio = sv.id_criterio))))
             LEFT JOIN findom_os.findom_d_tipol_interventi ti ON ((ti.id_tipol_intervento = bcv.id_tipol_intervento)))
             JOIN findom_os.findom_t_parametri_valut pv ON (((pv.id_bando = bsv.id_bando) AND (pv.id_specifica = bsv.id_specifica))))
             JOIN findom_os.findom_d_parametri_specifiche_valut psv ON ((psv.id_parametro = pv.id_parametro)))
             JOIN findom_os.findom_t_bandi b ON (((b.id_bando = bsv.id_bando) AND (b.flag_scheda_progetto IS TRUE))))
             JOIN findom_os.findom_d_criteri_valut cv ON ((cv.id_criterio = sv.id_criterio)))
          WHERE ((bsv.flag_visibile_in_domanda IS TRUE) OR ((bcv.flag_visibile_in_domanda IS TRUE) AND ((bsv.tipo_campo)::text = ANY (ARRAY[('checkbox'::character varying)::text, ('radiobutton'::character varying)::text]))))
        )
 SELECT x.id_bando,
    x.descr_breve_bando,
    x.id_tipol_intervento,
    x.descrizione_tipol_intervento,
    x.id_criterio,
    x.descrizione_criterio,
    x.descr_breve_criterio,
    x.ordine_criterio,
    x.id_specifica,
    x.descrizione_specifica,
    x.descr_breve_specifica,
    x.tipo_campo,
    row_number() OVER (PARTITION BY x.id_bando, x.id_criterio ORDER BY x.ordine_specifica) AS ordine_specifica,
    x.id_parametro,
    x.descrizione_parametro,
    x.descr_breve_parametro,
    x.ordine_parametro,
    x.id_parametro_valut,
    x.punteggio_parametro
   FROM ( SELECT cte_valutaz.id_bando,
            cte_valutaz.descr_breve_bando,
            cte_valutaz.id_tipol_intervento,
            cte_valutaz.descrizione_tipol_intervento,
            cte_valutaz.id_criterio,
            cte_valutaz.descrizione_criterio,
            cte_valutaz.descr_breve_criterio,
            cte_valutaz.ordine_criterio,
            cte_valutaz.id_specifica,
            cte_valutaz.descrizione_specifica,
            cte_valutaz.descr_breve_specifica,
            cte_valutaz.tipo_campo,
            cte_valutaz.ordine_specifica,
            cte_valutaz.id_parametro,
            cte_valutaz.descrizione_parametro,
            cte_valutaz.descr_breve_parametro,
            cte_valutaz.ordine_parametro,
            cte_valutaz.id_parametro_valut,
            cte_valutaz.punteggio_parametro
           FROM cte_valutaz) x
  ORDER BY x.id_bando, x.ordine_criterio, x.ordine_specifica, x.ordine_parametro;


ALTER TABLE findom_os.findom_v_scheda_progetto_valut OWNER TO findom_os;

--
-- TOC entry 16315 (class 1259 OID 31176200)
-- Name: findom_v_situazione_bandi; Type: VIEW; Schema: findom_os; Owner: findom_os
--

CREATE VIEW findom_os.findom_v_situazione_bandi AS
 SELECT x.id_bando,
    x.descrizione_breve_bando,
    x.dt_apertura,
    x.dt_chiusura,
        CASE
            WHEN ((x.dt_apertura_sportello <= now()) AND ((x.dt_chiusura_sportello >= now()) OR (x.dt_chiusura_sportello IS NULL))) THEN 'APERTO'::text
            WHEN (x.dt_apertura_sportello = x.dt_chiusura_sportello) THEN 'BLOCCATO'::text
            ELSE 'CHIUSO'::text
        END AS stato_sportello,
    COALESCE(y.nr_dom_bozza, (0)::bigint) AS nr_dom_bozza,
    COALESCE(z.nr_dom_inviate, (0)::bigint) AS nr_dom_inviate,
        CASE
            WHEN (x.flag_demat = 'S'::bpchar) THEN 'DEMATERIALIZZATO'::text
            ELSE NULL::text
        END AS tipo_bando,
        CASE
            WHEN (x.command_validation_rules IS NULL) THEN 'JAVA'::text
            ELSE 'BEAN SHELL'::text
        END AS tecnologia,
    x.destinatario,
    x.normativa,
    COALESCE(mc.nr_dom_marcate, (0)::bigint) AS nr_dom_marcate,
    COALESCE(cl.nr_dom_classificate, (0)::bigint) AS nr_dom_classificate,
    COALESCE(pr.nr_dom_protocollate, (0)::bigint) AS nr_dom_protocollate
   FROM (((((( SELECT sp.id_sportello_bando,
            to_char(sp.dt_apertura, 'YYYY-MM-DD HH24:MI:SS'::text) AS dt_apertura,
            to_char(sp.dt_chiusura, 'YYYY-MM-DD HH24:MI:SS'::text) AS dt_chiusura,
            sp.dt_apertura AS dt_apertura_sportello,
            sp.dt_chiusura AS dt_chiusura_sportello,
            sp.num_max_domande AS num_max_domande_sportello,
            b.id_bando,
            b.num_max_domande AS num_max_domande_bando,
            b.descrizione AS descrizione_bando,
            b.descr_breve AS descrizione_breve_bando,
            b.flag_nuova_gestione,
            az.codice AS codice_azione,
            n.id_normativa,
            n.descr_breve AS normativa,
            b.flag_demat,
            e.descrizione AS destinatario,
            t.command_validation_rules
           FROM ((((((((findom_os.findom_t_sportelli_bandi sp
             JOIN findom_os.findom_t_bandi b ON ((b.id_bando = sp.id_bando)))
             JOIN findom_os.aggr_t_template t ON ((t.template_id = (b.id_bando)::numeric)))
             JOIN findom_os.findom_d_classif_bandi az ON (((az.id_classificazione = b.id_classificazione) AND (az.id_tipo_suddivisione = 5))))
             JOIN findom_os.findom_d_classif_bandi os ON (((az.id_classificazione_padre = os.id_classificazione) AND (os.id_tipo_suddivisione = 4))))
             JOIN findom_os.findom_d_classif_bandi pi ON (((os.id_classificazione_padre = pi.id_classificazione) AND (pi.id_tipo_suddivisione = 3))))
             JOIN findom_os.findom_d_classif_bandi ap ON (((pi.id_classificazione_padre = ap.id_classificazione) AND (ap.id_tipo_suddivisione = 1))))
             JOIN findom_os.findom_d_normative n ON ((n.id_normativa = ap.id_normativa)))
             JOIN findom_os.findom_d_enti e ON ((e.id_ente = b.id_ente_destinatario)))
        UNION ALL
         SELECT sp.id_sportello_bando,
            to_char(sp.dt_apertura, 'YYYY-MM-DD HH24:MI:SS'::text) AS dt_apertura,
            to_char(sp.dt_chiusura, 'YYYY-MM-DD HH24:MI:SS'::text) AS dt_chiusura,
            sp.dt_apertura AS dt_apertura_sportello,
            sp.dt_chiusura AS dt_chiusura_sportello,
            sp.num_max_domande AS num_max_domande_sportello,
            b.id_bando,
            b.num_max_domande AS num_max_domande_bando,
            b.descrizione AS descrizione_bando,
            b.descr_breve AS descrizione_breve_bando,
            b.flag_nuova_gestione,
            az.codice AS codice_azione,
            n.id_normativa,
            n.descr_breve AS normativa,
            b.flag_demat,
            e.descrizione AS destinatario,
            t.command_validation_rules
           FROM (((((((findom_os.findom_t_sportelli_bandi sp
             JOIN findom_os.findom_t_bandi b ON ((b.id_bando = sp.id_bando)))
             JOIN findom_os.aggr_t_template t ON ((t.template_id = (b.id_bando)::numeric)))
             JOIN findom_os.findom_d_classif_bandi az ON (((az.id_classificazione = b.id_classificazione) AND (az.id_tipo_suddivisione = 5))))
             JOIN findom_os.findom_d_classif_bandi os ON (((az.id_classificazione_padre = os.id_classificazione) AND (os.id_tipo_suddivisione = 4))))
             JOIN findom_os.findom_d_classif_bandi ap ON (((os.id_classificazione_padre = ap.id_classificazione) AND (ap.id_tipo_suddivisione = 1))))
             JOIN findom_os.findom_d_normative n ON ((n.id_normativa = ap.id_normativa)))
             JOIN findom_os.findom_d_enti e ON ((e.id_ente = b.id_ente_destinatario)))) x
     LEFT JOIN ( SELECT findom_v_domande_fast.id_sportello_bando,
            count(*) AS nr_dom_bozza
           FROM findom_os.findom_v_domande_fast
          WHERE ((findom_v_domande_fast.cod_stato_domanda)::text <> 'IN'::text)
          GROUP BY findom_v_domande_fast.id_sportello_bando) y ON ((y.id_sportello_bando = x.id_sportello_bando)))
     LEFT JOIN ( SELECT findom_v_domande_fast.id_sportello_bando,
            count(*) AS nr_dom_inviate
           FROM findom_os.findom_v_domande_fast
          WHERE ((findom_v_domande_fast.cod_stato_domanda)::text = 'IN'::text)
          GROUP BY findom_v_domande_fast.id_sportello_bando) z ON ((z.id_sportello_bando = x.id_sportello_bando)))
     LEFT JOIN ( SELECT b.id_sportello_bando,
            count(*) AS nr_dom_marcate
           FROM findom_os.findom_v_doc_demat_batch a,
            findom_os.shell_t_domande b
          WHERE (((a.tipo_allegato)::text = 'DOMANDA'::text) AND (a.data_marca_temporale IS NOT NULL) AND (a.id_domanda = b.id_domanda))
          GROUP BY b.id_sportello_bando) mc ON ((mc.id_sportello_bando = x.id_sportello_bando)))
     LEFT JOIN ( SELECT b.id_sportello_bando,
            count(*) AS nr_dom_classificate
           FROM findom_os.findom_v_doc_demat_batch a,
            findom_os.shell_t_domande b
          WHERE (((a.tipo_allegato)::text = 'DOMANDA'::text) AND (a.data_classificazione IS NOT NULL) AND (a.id_domanda = b.id_domanda))
          GROUP BY b.id_sportello_bando) cl ON ((cl.id_sportello_bando = x.id_sportello_bando)))
     LEFT JOIN ( SELECT b.id_sportello_bando,
            count(*) AS nr_dom_protocollate
           FROM findom_os.findom_v_doc_demat_batch a,
            findom_os.shell_t_domande b
          WHERE (((a.tipo_allegato)::text = 'DOMANDA'::text) AND (a.data_protocollo IS NOT NULL) AND (a.id_domanda = b.id_domanda))
          GROUP BY b.id_sportello_bando) pr ON ((pr.id_sportello_bando = x.id_sportello_bando)))
  ORDER BY x.id_bando, x.dt_apertura;


ALTER TABLE findom_os.findom_v_situazione_bandi OWNER TO findom_os;

--
-- TOC entry 16316 (class 1259 OID 31176205)
-- Name: findom_v_sportelli_attivi; Type: VIEW; Schema: findom_os; Owner: findom_os
--

CREATE VIEW findom_os.findom_v_sportelli_attivi AS
 SELECT sp.id_sportello_bando,
    to_char(sp.dt_apertura, 'YYYY-MM-DD HH24:MI:SS'::text) AS dt_apertura,
    to_char(sp.dt_chiusura, 'YYYY-MM-DD HH24:MI:SS'::text) AS dt_chiusura,
    sp.num_max_domande AS num_max_domande_sportello,
    b.id_bando,
    b.num_max_domande AS num_max_domande_bando,
    b.descrizione AS descrizione_bando,
    b.descr_breve AS descrizione_breve_bando,
    az.codice AS codice_azione,
    n.id_normativa,
    n.descr_breve AS normativa,
    b.flag_amm_aziende_estere,
    at.id_area_tematica,
    at.descrizione AS descrizione_area_tematica
   FROM (((((((findom_os.findom_t_sportelli_bandi sp
     JOIN findom_os.findom_t_bandi b ON (((b.id_bando = sp.id_bando) AND (b.flag_nuova_gestione = false))))
     JOIN findom_os.findom_d_classif_bandi az ON (((az.id_classificazione = b.id_classificazione) AND (az.id_tipo_suddivisione = 5))))
     JOIN findom_os.findom_d_classif_bandi os ON (((az.id_classificazione_padre = os.id_classificazione) AND (os.id_tipo_suddivisione = 4))))
     JOIN findom_os.findom_d_classif_bandi pi ON (((os.id_classificazione_padre = pi.id_classificazione) AND (pi.id_tipo_suddivisione = 3))))
     JOIN findom_os.findom_d_classif_bandi ap ON (((pi.id_classificazione_padre = ap.id_classificazione) AND (ap.id_tipo_suddivisione = 1))))
     JOIN findom_os.findom_d_normative n ON ((n.id_normativa = ap.id_normativa)))
     LEFT JOIN findom_os.findom_d_area_tematica at ON ((at.id_area_tematica = b.id_area_tematica)))
  WHERE ((sp.dt_apertura <= now()) AND ((sp.dt_chiusura >= now()) OR (sp.dt_chiusura IS NULL)))
UNION ALL
 SELECT sp.id_sportello_bando,
    to_char(sp.dt_apertura, 'YYYY-MM-DD HH24:MI:SS'::text) AS dt_apertura,
    to_char(sp.dt_chiusura, 'YYYY-MM-DD HH24:MI:SS'::text) AS dt_chiusura,
    sp.num_max_domande AS num_max_domande_sportello,
    b.id_bando,
    b.num_max_domande AS num_max_domande_bando,
    b.descrizione AS descrizione_bando,
    b.descr_breve AS descrizione_breve_bando,
    az.codice AS codice_azione,
    n.id_normativa,
    n.descr_breve AS normativa,
    b.flag_amm_aziende_estere,
    at.id_area_tematica,
    at.descrizione AS descrizione_area_tematica
   FROM ((((((findom_os.findom_t_sportelli_bandi sp
     JOIN findom_os.findom_t_bandi b ON (((b.id_bando = sp.id_bando) AND (b.flag_nuova_gestione = false))))
     JOIN findom_os.findom_d_classif_bandi az ON (((az.id_classificazione = b.id_classificazione) AND (az.id_tipo_suddivisione = 5))))
     JOIN findom_os.findom_d_classif_bandi os ON (((az.id_classificazione_padre = os.id_classificazione) AND (os.id_tipo_suddivisione = 4))))
     JOIN findom_os.findom_d_classif_bandi ap ON (((os.id_classificazione_padre = ap.id_classificazione) AND (ap.id_tipo_suddivisione = 1))))
     JOIN findom_os.findom_d_normative n ON ((n.id_normativa = ap.id_normativa)))
     LEFT JOIN findom_os.findom_d_area_tematica at ON ((at.id_area_tematica = b.id_area_tematica)))
  WHERE ((sp.dt_apertura <= now()) AND ((sp.dt_chiusura >= now()) OR (sp.dt_chiusura IS NULL)));


ALTER TABLE findom_os.findom_v_sportelli_attivi OWNER TO findom_os;

--
-- TOC entry 16317 (class 1259 OID 31176210)
-- Name: findom_v_sportelli_attivi_istr; Type: VIEW; Schema: findom_os; Owner: findom_os
--

CREATE VIEW findom_os.findom_v_sportelli_attivi_istr AS
 SELECT sp.id_sportello_bando,
    to_char(sp.dt_apertura, 'YYYY-MM-DD HH24:MI:SS'::text) AS dt_apertura,
    to_char(sp.dt_chiusura, 'YYYY-MM-DD HH24:MI:SS'::text) AS dt_chiusura,
    sp.num_max_domande AS num_max_domande_sportello,
    b.id_bando,
    b.num_max_domande AS num_max_domande_bando,
    b.descrizione AS descrizione_bando,
    b.descr_breve AS descrizione_breve_bando,
    az.codice AS codice_azione,
    n.id_normativa,
    n.descr_breve AS normativa,
    b.flag_amm_aziende_estere,
    at.id_area_tematica,
    at.descrizione AS descrizione_area_tematica
   FROM (((((((findom_os.findom_t_sportelli_bandi sp
     JOIN findom_os.findom_t_bandi b ON ((b.id_bando = sp.id_bando)))
     JOIN findom_os.findom_d_classif_bandi az ON (((az.id_classificazione = b.id_classificazione) AND (az.id_tipo_suddivisione = 5))))
     JOIN findom_os.findom_d_classif_bandi os ON (((az.id_classificazione_padre = os.id_classificazione) AND (os.id_tipo_suddivisione = 4))))
     JOIN findom_os.findom_d_classif_bandi pi ON (((os.id_classificazione_padre = pi.id_classificazione) AND (pi.id_tipo_suddivisione = 3))))
     JOIN findom_os.findom_d_classif_bandi ap ON (((pi.id_classificazione_padre = ap.id_classificazione) AND (ap.id_tipo_suddivisione = 1))))
     JOIN findom_os.findom_d_normative n ON ((n.id_normativa = ap.id_normativa)))
     LEFT JOIN findom_os.findom_d_area_tematica at ON ((at.id_area_tematica = b.id_area_tematica)))
  WHERE ((sp.dt_apertura <= now()) AND ((sp.dt_chiusura >= now()) OR (sp.dt_chiusura IS NULL)))
UNION ALL
 SELECT sp.id_sportello_bando,
    to_char(sp.dt_apertura, 'YYYY-MM-DD HH24:MI:SS'::text) AS dt_apertura,
    to_char(sp.dt_chiusura, 'YYYY-MM-DD HH24:MI:SS'::text) AS dt_chiusura,
    sp.num_max_domande AS num_max_domande_sportello,
    b.id_bando,
    b.num_max_domande AS num_max_domande_bando,
    b.descrizione AS descrizione_bando,
    b.descr_breve AS descrizione_breve_bando,
    az.codice AS codice_azione,
    n.id_normativa,
    n.descr_breve AS normativa,
    b.flag_amm_aziende_estere,
    at.id_area_tematica,
    at.descrizione AS descrizione_area_tematica
   FROM ((((((findom_os.findom_t_sportelli_bandi sp
     JOIN findom_os.findom_t_bandi b ON ((b.id_bando = sp.id_bando)))
     JOIN findom_os.findom_d_classif_bandi az ON (((az.id_classificazione = b.id_classificazione) AND (az.id_tipo_suddivisione = 5))))
     JOIN findom_os.findom_d_classif_bandi os ON (((az.id_classificazione_padre = os.id_classificazione) AND (os.id_tipo_suddivisione = 4))))
     JOIN findom_os.findom_d_classif_bandi ap ON (((os.id_classificazione_padre = ap.id_classificazione) AND (ap.id_tipo_suddivisione = 1))))
     JOIN findom_os.findom_d_normative n ON ((n.id_normativa = ap.id_normativa)))
     LEFT JOIN findom_os.findom_d_area_tematica at ON ((at.id_area_tematica = b.id_area_tematica)))
  WHERE ((sp.dt_apertura <= now()) AND ((sp.dt_chiusura >= now()) OR (sp.dt_chiusura IS NULL)));


ALTER TABLE findom_os.findom_v_sportelli_attivi_istr OWNER TO findom_os;

--
-- TOC entry 16318 (class 1259 OID 31176215)
-- Name: findom_v_sportelli_attivi_nuova_gestione; Type: VIEW; Schema: findom_os; Owner: findom_os
--

CREATE VIEW findom_os.findom_v_sportelli_attivi_nuova_gestione AS
 SELECT sp.id_sportello_bando,
    to_char(sp.dt_apertura, 'YYYY-MM-DD HH24:MI:SS'::text) AS dt_apertura,
    to_char(sp.dt_chiusura, 'YYYY-MM-DD HH24:MI:SS'::text) AS dt_chiusura,
    sp.num_max_domande AS num_max_domande_sportello,
    b.id_bando,
    b.num_max_domande AS num_max_domande_bando,
    b.descrizione AS descrizione_bando,
    b.descr_breve AS descrizione_breve_bando,
    az.codice AS codice_azione,
    n.id_normativa,
    n.descr_breve AS normativa,
    b.flag_amm_aziende_estere,
    at.id_area_tematica,
    at.descrizione AS descrizione_area_tematica
   FROM (((((((findom_os.findom_t_sportelli_bandi sp
     JOIN findom_os.findom_t_bandi b ON (((b.id_bando = sp.id_bando) AND (b.flag_nuova_gestione = true))))
     JOIN findom_os.findom_d_classif_bandi az ON (((az.id_classificazione = b.id_classificazione) AND (az.id_tipo_suddivisione = 5))))
     JOIN findom_os.findom_d_classif_bandi os ON (((az.id_classificazione_padre = os.id_classificazione) AND (os.id_tipo_suddivisione = 4))))
     JOIN findom_os.findom_d_classif_bandi pi ON (((os.id_classificazione_padre = pi.id_classificazione) AND (pi.id_tipo_suddivisione = 3))))
     JOIN findom_os.findom_d_classif_bandi ap ON (((pi.id_classificazione_padre = ap.id_classificazione) AND (ap.id_tipo_suddivisione = 1))))
     JOIN findom_os.findom_d_normative n ON ((n.id_normativa = ap.id_normativa)))
     LEFT JOIN findom_os.findom_d_area_tematica at ON ((at.id_area_tematica = b.id_area_tematica)))
  WHERE ((sp.dt_apertura <= now()) AND ((sp.dt_chiusura >= now()) OR (sp.dt_chiusura IS NULL)))
UNION ALL
 SELECT sp.id_sportello_bando,
    to_char(sp.dt_apertura, 'YYYY-MM-DD HH24:MI:SS'::text) AS dt_apertura,
    to_char(sp.dt_chiusura, 'YYYY-MM-DD HH24:MI:SS'::text) AS dt_chiusura,
    sp.num_max_domande AS num_max_domande_sportello,
    b.id_bando,
    b.num_max_domande AS num_max_domande_bando,
    b.descrizione AS descrizione_bando,
    b.descr_breve AS descrizione_breve_bando,
    az.codice AS codice_azione,
    n.id_normativa,
    n.descr_breve AS normativa,
    b.flag_amm_aziende_estere,
    at.id_area_tematica,
    at.descrizione AS descrizione_area_tematica
   FROM ((((((findom_os.findom_t_sportelli_bandi sp
     JOIN findom_os.findom_t_bandi b ON (((b.id_bando = sp.id_bando) AND (b.flag_nuova_gestione = true))))
     JOIN findom_os.findom_d_classif_bandi az ON (((az.id_classificazione = b.id_classificazione) AND (az.id_tipo_suddivisione = 5))))
     JOIN findom_os.findom_d_classif_bandi os ON (((az.id_classificazione_padre = os.id_classificazione) AND (os.id_tipo_suddivisione = 4))))
     JOIN findom_os.findom_d_classif_bandi ap ON (((os.id_classificazione_padre = ap.id_classificazione) AND (ap.id_tipo_suddivisione = 1))))
     JOIN findom_os.findom_d_normative n ON ((n.id_normativa = ap.id_normativa)))
     LEFT JOIN findom_os.findom_d_area_tematica at ON ((at.id_area_tematica = b.id_area_tematica)))
  WHERE ((sp.dt_apertura <= now()) AND ((sp.dt_chiusura >= now()) OR (sp.dt_chiusura IS NULL)));


ALTER TABLE findom_os.findom_v_sportelli_attivi_nuova_gestione OWNER TO findom_os;

--
-- TOC entry 16319 (class 1259 OID 31176220)
-- Name: findom_v_tipol_aiuti; Type: VIEW; Schema: findom_os; Owner: findom_os
--

CREATE VIEW findom_os.findom_v_tipol_aiuti AS
 SELECT DISTINCT b.id_bando,
    ta.id_tipol_aiuto,
    ta.codice AS cod_tipol_aiuto,
    ta.descrizione AS descrizione_tipol_aiuto,
    rbdta.dt_inizio,
    rbdta.dt_fine
   FROM (((findom_os.findom_t_bandi b
     JOIN findom_os.findom_r_bandi_dett_tipol_aiuti rbdta USING (id_bando))
     JOIN findom_os.findom_d_dett_tipol_aiuti dta USING (id_dett_tipol_aiuti))
     JOIN findom_os.findom_d_tipol_aiuti ta USING (id_tipol_aiuto))
  ORDER BY b.id_bando, ta.codice;


ALTER TABLE findom_os.findom_v_tipol_aiuti OWNER TO findom_os;

--
-- TOC entry 16320 (class 1259 OID 31176225)
-- Name: findom_v_ula_tipol_beneficiari_bandi; Type: VIEW; Schema: findom_os; Owner: findom_os
--

CREATE VIEW findom_os.findom_v_ula_tipol_beneficiari_bandi AS
 SELECT utbb.id_bando,
    b.descr_breve AS descr_breve_bando,
    utbb.id_tipol_beneficiario,
    tb.descrizione AS descr_tipol_beneficiario,
    utbb.id_ula,
    u.descrizione AS descr_ula
   FROM ((((findom_os.findom_r_ula_tipol_beneficiari_bandi utbb
     JOIN findom_os.findom_d_ula u ON ((u.id_ula = utbb.id_ula)))
     JOIN findom_os.findom_r_tipol_beneficiari_bandi tbb ON (((tbb.id_tipol_beneficiario = utbb.id_tipol_beneficiario) AND (tbb.id_bando = utbb.id_bando))))
     JOIN findom_os.findom_t_bandi b ON ((b.id_bando = tbb.id_bando)))
     JOIN findom_os.findom_d_tipol_beneficiari tb ON ((tb.id_tipol_beneficiario = tbb.id_tipol_beneficiario)))
  WHERE ((tbb.dt_inizio <= (now())::date) AND ((tbb.dt_fine >= (now())::date) OR (tbb.dt_fine IS NULL)) AND (utbb.dt_inizio <= (now())::date) AND ((utbb.dt_fine >= (now())::date) OR (utbb.dt_fine IS NULL)))
  ORDER BY utbb.id_bando, utbb.id_tipol_beneficiario, utbb.ordine;


ALTER TABLE findom_os.findom_v_ula_tipol_beneficiari_bandi OWNER TO findom_os;

--
-- TOC entry 16321 (class 1259 OID 31176230)
-- Name: findom_v_ultima_inviata_beneficiario; Type: VIEW; Schema: findom_os; Owner: findom_os
--

CREATE VIEW findom_os.findom_v_ultima_inviata_beneficiario AS
 SELECT y.id_domanda,
    y.dt_invio_domanda,
    y.id_soggetto_beneficiario,
    y.cod_fiscale,
    y.denominazione
   FROM ( SELECT x.id_domanda,
            x.dt_invio_domanda,
            x.id_soggetto_beneficiario,
            x.cod_fiscale,
            x.denominazione
           FROM ( SELECT d.id_domanda,
                    max(d.dt_invio_domanda) OVER (PARTITION BY d.id_soggetto_beneficiario) AS dt_invio_domanda_max,
                    d.dt_invio_domanda,
                    d.id_soggetto_beneficiario,
                    s.cod_fiscale,
                    s.denominazione
                   FROM (findom_os.shell_t_domande d
                     JOIN findom_os.shell_t_soggetti s ON ((s.id_soggetto = d.id_soggetto_beneficiario)))
                  WHERE (d.dt_invio_domanda IS NOT NULL)) x
          WHERE (x.dt_invio_domanda_max = x.dt_invio_domanda)) y;


ALTER TABLE findom_os.findom_v_ultima_inviata_beneficiario OWNER TO findom_os;

--
-- TOC entry 16322 (class 1259 OID 31176235)
-- Name: findom_v_voci_spesa; Type: VIEW; Schema: findom_os; Owner: findom_os
--

CREATE VIEW findom_os.findom_v_voci_spesa AS
 SELECT b.id_bando,
    ti.id_tipol_intervento,
    ti.codice AS cod_tipol_intervento,
    ti.descrizione AS descrizione_tipol_intervento,
    NULL::integer AS id_dett_tipol_intervento,
    NULL::character varying AS cod_dett_tipol_intervento,
    NULL::character varying AS descrizione_dett_tipol_intervento,
    ti.id_campo_intervento,
    ci.cod_campo_intervento,
    ci.descrizione AS descrizione_campo_intervento,
    rbti.dt_inizio AS dt_inizio_intervento,
    rbti.dt_fine AS dt_fine_intervento,
    vs.id_voce_spesa,
    vs.descr_breve AS cod_voce_spesa,
    (concat(rtivs.pref_descr_voce, vs.descrizione))::character varying(1000) AS descrizione_voce_spesa,
    vs.flag_specificaz,
    cvs.id_categ_voce_spesa,
    cvs.descrizione AS descrizione_categ_voce_spesa,
    tvs.id_tipol_voce_spesa,
    tvs.codice AS codice_tipol_voce_spesa,
    tvs.descrizione AS descrizione_tipol_voce_spesa,
    rtivs.dt_inizio AS dt_inizio_voce_spesa,
    rtivs.dt_fine AS dt_fine_voce_spesa
   FROM (((((((findom_os.findom_t_bandi b
     JOIN findom_os.findom_r_bandi_tipol_interventi rbti USING (id_bando))
     JOIN findom_os.findom_d_tipol_interventi ti USING (id_tipol_intervento))
     LEFT JOIN findom_os.findom_d_campi_intervento ci USING (id_campo_intervento))
     JOIN findom_os.findom_r_tipol_interventi_voci_spesa rtivs USING (id_tipol_intervento))
     JOIN findom_os.findom_d_voci_spesa vs USING (id_voce_spesa))
     LEFT JOIN findom_os.findom_d_categ_voci_spesa cvs USING (id_categ_voce_spesa))
     LEFT JOIN findom_os.findom_d_tipol_voci_spesa tvs USING (id_tipol_voce_spesa))
UNION ALL
 SELECT b.id_bando,
    ti.id_tipol_intervento,
    ti.codice AS cod_tipol_intervento,
    ti.descrizione AS descrizione_tipol_intervento,
    dti.id_dett_tipol_intervento,
    dti.codice AS cod_dett_tipol_intervento,
    dti.descrizione AS descrizione_dett_tipol_intervento,
    ti.id_campo_intervento,
    ci.cod_campo_intervento,
    ci.descrizione AS descrizione_campo_intervento,
    rbti.dt_inizio AS dt_inizio_intervento,
    rbti.dt_fine AS dt_fine_intervento,
    vs.id_voce_spesa,
    vs.descr_breve AS cod_voce_spesa,
    (concat(rdtivs.pref_descr_voce, vs.descrizione))::character varying(1000) AS descrizione_voce_spesa,
    vs.flag_specificaz,
    cvs.id_categ_voce_spesa,
    cvs.descrizione AS descrizione_categ_voce_spesa,
    tvs.id_tipol_voce_spesa,
    tvs.codice AS codice_tipol_voce_spesa,
    tvs.descrizione AS descrizione_tipol_voce_spesa,
    rdtivs.dt_inizio AS dt_inizio_voce_spesa,
    rdtivs.dt_fine AS dt_fine_voce_spesa
   FROM ((((((((findom_os.findom_t_bandi b
     JOIN findom_os.findom_r_bandi_tipol_interventi rbti USING (id_bando))
     JOIN findom_os.findom_d_tipol_interventi ti USING (id_tipol_intervento))
     LEFT JOIN findom_os.findom_d_campi_intervento ci USING (id_campo_intervento))
     LEFT JOIN findom_os.findom_d_dett_tipol_interventi dti USING (id_tipol_intervento))
     JOIN findom_os.findom_r_dett_tipol_interventi_voci_spesa rdtivs USING (id_dett_tipol_intervento))
     JOIN findom_os.findom_d_voci_spesa vs USING (id_voce_spesa))
     LEFT JOIN findom_os.findom_d_categ_voci_spesa cvs USING (id_categ_voce_spesa))
     LEFT JOIN findom_os.findom_d_tipol_voci_spesa tvs USING (id_tipol_voce_spesa));


ALTER TABLE findom_os.findom_v_voci_spesa OWNER TO findom_os;

--
-- TOC entry 16323 (class 1259 OID 31176240)
-- Name: findom_v_xml_dom_ben_anag; Type: VIEW; Schema: findom_os; Owner: findom_os
--

CREATE VIEW findom_os.findom_v_xml_dom_ben_anag AS
 SELECT z.id_domanda_x AS id_domanda,
    z.cod_fiscale,
    z.denominazione,
    z.id_forma_giuridica,
    z.cod_forma_giuridica,
    z.descr_forma_giuridica,
    z.partita_iva,
    z.indirizzo_pec,
    z.id_ateco,
    z.codice_ateco,
    z.descrizione_ateco,
    z.id_attivita_economica,
    z.cod_attivita_economica,
    z.descr_attivita_economica,
    z.dt_costituzione_impresa,
    z.sigla_provincia,
    z.descrizione_provincia,
    z.cod_fiscale_rappr_leg,
    z.cognome_rappr_leg,
    z.nome_rappr_leg,
    z.genere_rappr_leg,
    z.luogo_nascita_rappr_leg,
    z.cod_provincia_nascita_rappr_leg,
    z.sigla_provincia_nascita_rappr_leg,
    z.descr_provincia_nascita_rappr_leg,
    z.cod_comune_nascita_rappr_leg,
    z.descr_comune_nascita_rappr_leg,
    z.descr_luogo_nascita_rappr_leg,
    z.cod_stato_estero_nascita_rappr_leg,
    z.descr_stato_estero_nascita_rappr_leg,
    z.data_nascita_rappr_leg,
    z.id_tipo_doc_riconoscimento_rappr_leg,
    z.descr_tipo_doc_riconoscimento_rappr_leg,
    z.num_doc_riconoscimento_rappr_leg,
    z.num_doc_rilasciato_da_rappr_leg,
    z.data_rilascio_doc_rappr_leg,
    z.descr_luogo_residenza_rappr_leg,
    z.sigla_provincia_residenza_rappr_leg,
    z.cod_provincia_residenza_rappr_leg,
    z.descr_provincia_residenza_rappr_leg,
    z.cod_comune_residenza_rappr_leg,
    z.descr_comune_residenza_rappr_leg,
    z.cod_stato_estero_residenza_rappr_leg,
    z.descr_stato_estero_residenza_rappr_leg,
    z.descr_citta_estera_residenza_rappr_leg,
    z.cod_cap_residenza_rappr_leg,
    z.descr_indirizzo_residenza_rappr_leg,
    z.num_civico_residenza_rappr_leg,
    z.cod_stato_sede_legale,
    z.cod_provincia_sede_legale,
    z.sigla_provincia_sede_legale,
    z.descr_provincia_sede_legale,
    z.cod_comune_sede_legale,
    z.descr_comune_sede_legale,
    z.cod_stato_estero_sede_legale,
    z.descr_stato_estero_sede_legale,
    z.descr_citta_estera_sede_legale,
    z.cod_cap_sede_legale,
    z.descr_indirizzo_sede_legale,
    z.num_civico_sede_legale,
    z.num_telefono_sede_legale,
    z.pec_sede_legale,
    z.persona_rif_sede_legale,
    z.email_sede_legale,
    z.num_cellulare_sede_legale,
    z.id_stato,
    z.descr_stato,
    z.id_stato_cost_impresa,
    z.descr_stato_cost_impresa
   FROM (((( SELECT x.id_domanda AS id_domanda_x,
                CASE
                    WHEN xpath_exists('//codiceFiscale/text()'::text, x._operatorepresentatore) THEN (unnest(xpath('//codiceFiscale/text()'::text, x._operatorepresentatore)))::text
                    ELSE ''::text
                END AS cod_fiscale,
                CASE
                    WHEN xpath_exists('//denominazione/text()'::text, x._operatorepresentatore) THEN (unnest(xpath('//denominazione/text()'::text, x._operatorepresentatore)))::text
                    ELSE ''::text
                END AS denominazione,
                CASE
                    WHEN xpath_exists('//idFormaGiuridica/text()'::text, x._operatorepresentatore) THEN (unnest(xpath('//idFormaGiuridica/text()'::text, x._operatorepresentatore)))::text
                    ELSE ''::text
                END AS id_forma_giuridica,
                CASE
                    WHEN xpath_exists('//codiceFormaGiuridica/text()'::text, x._operatorepresentatore) THEN (unnest(xpath('//codiceFormaGiuridica/text()'::text, x._operatorepresentatore)))::text
                    ELSE ''::text
                END AS cod_forma_giuridica,
                CASE
                    WHEN xpath_exists('//descrizioneFormaGiuridica/text()'::text, x._operatorepresentatore) THEN (unnest(xpath('//descrizioneFormaGiuridica/text()'::text, x._operatorepresentatore)))::text
                    ELSE ''::text
                END AS descr_forma_giuridica,
                CASE
                    WHEN xpath_exists('//partitaIva/text()'::text, x._operatorepresentatore) THEN (unnest(xpath('//partitaIva/text()'::text, x._operatorepresentatore)))::text
                    ELSE ''::text
                END AS partita_iva,
                CASE
                    WHEN xpath_exists('//indirizzoPec/text()'::text, x._operatorepresentatore) THEN (unnest(xpath('//indirizzoPec/text()'::text, x._operatorepresentatore)))::text
                    ELSE ''::text
                END AS indirizzo_pec,
                CASE
                    WHEN xpath_exists('//idAteco2007/text()'::text, x._operatorepresentatore) THEN (unnest(xpath('//idAteco2007/text()'::text, x._operatorepresentatore)))::text
                    ELSE ''::text
                END AS id_ateco,
                CASE
                    WHEN xpath_exists('//codicePrevalenteAteco2007/text()'::text, x._operatorepresentatore) THEN (unnest(xpath('//codicePrevalenteAteco2007/text()'::text, x._operatorepresentatore)))::text
                    ELSE ''::text
                END AS codice_ateco,
                CASE
                    WHEN xpath_exists('//descrizioneAteco2007/text()'::text, x._operatorepresentatore) THEN (unnest(xpath('//descrizioneAteco2007/text()'::text, x._operatorepresentatore)))::text
                    ELSE ''::text
                END AS descrizione_ateco,
                CASE
                    WHEN xpath_exists('//idAttivitaEconomica/text()'::text, x._operatorepresentatore) THEN (unnest(xpath('//idAttivitaEconomica/text()'::text, x._operatorepresentatore)))::text
                    ELSE ''::text
                END AS id_attivita_economica,
                CASE
                    WHEN xpath_exists('//codiceAttivitaEconomica/text()'::text, x._operatorepresentatore) THEN (unnest(xpath('//codiceAttivitaEconomica/text()'::text, x._operatorepresentatore)))::text
                    ELSE ''::text
                END AS cod_attivita_economica,
                CASE
                    WHEN xpath_exists('//descrizioneAttivitaEconomica/text()'::text, x._operatorepresentatore) THEN (unnest(xpath('//descrizioneAttivitaEconomica/text()'::text, x._operatorepresentatore)))::text
                    ELSE ''::text
                END AS descr_attivita_economica,
                CASE
                    WHEN xpath_exists('//idStato/text()'::text, x._operatorepresentatore) THEN (unnest(xpath('//idStato/text()'::text, x._operatorepresentatore)))::text
                    ELSE ''::text
                END AS id_stato,
                CASE
                    WHEN xpath_exists('//descrStato /text()'::text, x._operatorepresentatore) THEN (unnest(xpath('//descrStato /text()'::text, x._operatorepresentatore)))::text
                    ELSE ''::text
                END AS descr_stato
           FROM ( SELECT d.id_domanda,
                    unnest(xpath('/tree-map/_operatorePresentatore/map'::text, m.serialized_model)) AS _operatorepresentatore
                   FROM (findom_os.shell_t_domande d
                     JOIN findom_os.aggr_t_model m ON ((m.model_id = d.id_domanda)))
                  WHERE (d.dt_invio_domanda IS NOT NULL)) x) y
     LEFT JOIN ( SELECT x1.id_domanda AS id_domanda_x1,
                CASE
                    WHEN xpath_exists('//dataCostituzioneImpresa/text()'::text, x1._costituzioneimpresa) THEN (unnest(xpath('//dataCostituzioneImpresa/text()'::text, x1._costituzioneimpresa)))::text
                    ELSE ''::text
                END AS dt_costituzione_impresa,
                CASE
                    WHEN xpath_exists('//provincia/text()'::text, x1._costituzioneimpresa) THEN (unnest(xpath('//provincia/text()'::text, x1._costituzioneimpresa)))::text
                    ELSE ''::text
                END AS sigla_provincia,
                CASE
                    WHEN xpath_exists('//provinciaDescrizione/text()'::text, x1._costituzioneimpresa) THEN (unnest(xpath('//provinciaDescrizione/text()'::text, x1._costituzioneimpresa)))::text
                    ELSE ''::text
                END AS descrizione_provincia,
                CASE
                    WHEN xpath_exists('//idStatoCostImpresa/text()'::text, x1._costituzioneimpresa) THEN (unnest(xpath('//idStatoCostImpresa/text()'::text, x1._costituzioneimpresa)))::text
                    ELSE ''::text
                END AS id_stato_cost_impresa,
                CASE
                    WHEN xpath_exists('//descrStatoCostImpresa/text()'::text, x1._costituzioneimpresa) THEN (unnest(xpath('//descrStatoCostImpresa/text()'::text, x1._costituzioneimpresa)))::text
                    ELSE ''::text
                END AS descr_stato_cost_impresa
           FROM ( SELECT d.id_domanda,
                    unnest(xpath('/tree-map/_costituzioneImpresa/map'::text, m.serialized_model)) AS _costituzioneimpresa
                   FROM (findom_os.shell_t_domande d
                     JOIN findom_os.aggr_t_model m ON ((m.model_id = d.id_domanda)))
                  WHERE (d.dt_invio_domanda IS NOT NULL)) x1) y1 ON ((y1.id_domanda_x1 = y.id_domanda_x)))
     LEFT JOIN ( SELECT x2.id_domanda AS id_domanda_x2,
                CASE
                    WHEN xpath_exists('//codiceFiscale/text()'::text, x2._legalerappresentante) THEN (unnest(xpath('//codiceFiscale/text()'::text, x2._legalerappresentante)))::text
                    ELSE ''::text
                END AS cod_fiscale_rappr_leg,
                CASE
                    WHEN xpath_exists('//cognome/text()'::text, x2._legalerappresentante) THEN (unnest(xpath('//cognome/text()'::text, x2._legalerappresentante)))::text
                    ELSE ''::text
                END AS cognome_rappr_leg,
                CASE
                    WHEN xpath_exists('//nome/text()'::text, x2._legalerappresentante) THEN (unnest(xpath('//nome/text()'::text, x2._legalerappresentante)))::text
                    ELSE ''::text
                END AS nome_rappr_leg,
                CASE
                    WHEN xpath_exists('//genere/text()'::text, x2._legalerappresentante) THEN (unnest(xpath('//genere/text()'::text, x2._legalerappresentante)))::text
                    ELSE ''::text
                END AS genere_rappr_leg,
                CASE
                    WHEN xpath_exists('//luogoNascita/text()'::text, x2._legalerappresentante) THEN (unnest(xpath('//luogoNascita/text()'::text, x2._legalerappresentante)))::text
                    ELSE ''::text
                END AS luogo_nascita_rappr_leg,
                CASE
                    WHEN xpath_exists('//provinciaNascita/text()'::text, x2._legalerappresentante) THEN (unnest(xpath('//provinciaNascita/text()'::text, x2._legalerappresentante)))::text
                    ELSE ''::text
                END AS cod_provincia_nascita_rappr_leg,
                CASE
                    WHEN xpath_exists('//siglaProvinciaNascita/text()'::text, x2._legalerappresentante) THEN (unnest(xpath('//siglaProvinciaNascita/text()'::text, x2._legalerappresentante)))::text
                    ELSE ''::text
                END AS sigla_provincia_nascita_rappr_leg,
                CASE
                    WHEN xpath_exists('//provinciaNascitaDescrizione/text()'::text, x2._legalerappresentante) THEN (unnest(xpath('//provinciaNascitaDescrizione/text()'::text, x2._legalerappresentante)))::text
                    ELSE ''::text
                END AS descr_provincia_nascita_rappr_leg,
                CASE
                    WHEN xpath_exists('//comuneNascita/text()'::text, x2._legalerappresentante) THEN (unnest(xpath('//comuneNascita/text()'::text, x2._legalerappresentante)))::text
                    ELSE ''::text
                END AS cod_comune_nascita_rappr_leg,
                CASE
                    WHEN xpath_exists('//comuneNascitaDescrizione/text()'::text, x2._legalerappresentante) THEN (unnest(xpath('//comuneNascitaDescrizione/text()'::text, x2._legalerappresentante)))::text
                    ELSE ''::text
                END AS descr_comune_nascita_rappr_leg,
                CASE
                    WHEN xpath_exists('//luogoNascita/text()'::text, x2._legalerappresentante) THEN (unnest(xpath('//luogoNascita/text()'::text, x2._legalerappresentante)))::text
                    ELSE ''::text
                END AS descr_luogo_nascita_rappr_leg,
                CASE
                    WHEN xpath_exists('//statoEsteroNascita/text()'::text, x2._legalerappresentante) THEN (unnest(xpath('//statoEsteroNascita/text()'::text, x2._legalerappresentante)))::text
                    ELSE ''::text
                END AS cod_stato_estero_nascita_rappr_leg,
                CASE
                    WHEN xpath_exists('//statoEsteroNascitaDescrizione/text()'::text, x2._legalerappresentante) THEN (unnest(xpath('//statoEsteroNascitaDescrizione/text()'::text, x2._legalerappresentante)))::text
                    ELSE ''::text
                END AS descr_stato_estero_nascita_rappr_leg,
                CASE
                    WHEN xpath_exists('//dataNascita/text()'::text, x2._legalerappresentante) THEN (unnest(xpath('//dataNascita/text()'::text, x2._legalerappresentante)))::text
                    ELSE ''::text
                END AS data_nascita_rappr_leg,
                CASE
                    WHEN xpath_exists('//documento/map/idTipoDocRiconoscimento/text()'::text, x2._legalerappresentante) THEN (unnest(xpath('//documento/map/idTipoDocRiconoscimento/text()'::text, x2._legalerappresentante)))::text
                    ELSE ''::text
                END AS id_tipo_doc_riconoscimento_rappr_leg,
                CASE
                    WHEN xpath_exists('//documento/map/descrizioneTipoDocRiconoscimento/text()'::text, x2._legalerappresentante) THEN (unnest(xpath('//documento/map/descrizioneTipoDocRiconoscimento/text()'::text, x2._legalerappresentante)))::text
                    ELSE ''::text
                END AS descr_tipo_doc_riconoscimento_rappr_leg,
                CASE
                    WHEN xpath_exists('//documento/map/numDocumentoRiconoscimento/text()'::text, x2._legalerappresentante) THEN (unnest(xpath('//documento/map/numDocumentoRiconoscimento/text()'::text, x2._legalerappresentante)))::text
                    ELSE ''::text
                END AS num_doc_riconoscimento_rappr_leg,
                CASE
                    WHEN xpath_exists('//documento/map/docRilasciatoDa/text()'::text, x2._legalerappresentante) THEN (unnest(xpath('//documento/map/docRilasciatoDa/text()'::text, x2._legalerappresentante)))::text
                    ELSE ''::text
                END AS num_doc_rilasciato_da_rappr_leg,
                CASE
                    WHEN xpath_exists('//documento/map/dataRilascioDoc/text()'::text, x2._legalerappresentante) THEN (unnest(xpath('//documento/map/dataRilascioDoc/text()'::text, x2._legalerappresentante)))::text
                    ELSE ''::text
                END AS data_rilascio_doc_rappr_leg,
                CASE
                    WHEN xpath_exists('//luogoResidenza/text()'::text, x2._legalerappresentante) THEN (unnest(xpath('//luogoResidenza/text()'::text, x2._legalerappresentante)))::text
                    ELSE ''::text
                END AS descr_luogo_residenza_rappr_leg,
                CASE
                    WHEN xpath_exists('//siglaProvinciaResidenza/text()'::text, x2._legalerappresentante) THEN (unnest(xpath('//siglaProvinciaResidenza/text()'::text, x2._legalerappresentante)))::text
                    ELSE ''::text
                END AS sigla_provincia_residenza_rappr_leg,
                CASE
                    WHEN xpath_exists('//provinciaResidenza/text()'::text, x2._legalerappresentante) THEN (unnest(xpath('//provinciaResidenza/text()'::text, x2._legalerappresentante)))::text
                    ELSE ''::text
                END AS cod_provincia_residenza_rappr_leg,
                CASE
                    WHEN xpath_exists('//provinciaResidenzaDescrizione/text()'::text, x2._legalerappresentante) THEN (unnest(xpath('//provinciaResidenzaDescrizione/text()'::text, x2._legalerappresentante)))::text
                    ELSE ''::text
                END AS descr_provincia_residenza_rappr_leg,
                CASE
                    WHEN xpath_exists('//comuneResidenza/text()'::text, x2._legalerappresentante) THEN (unnest(xpath('//comuneResidenza/text()'::text, x2._legalerappresentante)))::text
                    ELSE ''::text
                END AS cod_comune_residenza_rappr_leg,
                CASE
                    WHEN xpath_exists('//comuneResidenzaDescrizione/text()'::text, x2._legalerappresentante) THEN (unnest(xpath('//comuneResidenzaDescrizione/text()'::text, x2._legalerappresentante)))::text
                    ELSE ''::text
                END AS descr_comune_residenza_rappr_leg,
                CASE
                    WHEN xpath_exists('//statoEsteroResidenza/text()'::text, x2._legalerappresentante) THEN (unnest(xpath('//statoEsteroResidenza/text()'::text, x2._legalerappresentante)))::text
                    ELSE ''::text
                END AS cod_stato_estero_residenza_rappr_leg,
                CASE
                    WHEN xpath_exists('//statoEsteroResidenzaDescrizione/text()'::text, x2._legalerappresentante) THEN (unnest(xpath('//statoEsteroResidenzaDescrizione/text()'::text, x2._legalerappresentante)))::text
                    ELSE ''::text
                END AS descr_stato_estero_residenza_rappr_leg,
                CASE
                    WHEN xpath_exists('//cittaEsteraResidenza/text()'::text, x2._legalerappresentante) THEN (unnest(xpath('//cittaEsteraResidenza/text()'::text, x2._legalerappresentante)))::text
                    ELSE ''::text
                END AS descr_citta_estera_residenza_rappr_leg,
                CASE
                    WHEN xpath_exists('//cap/text()'::text, x2._legalerappresentante) THEN (unnest(xpath('//cap/text()'::text, x2._legalerappresentante)))::text
                    ELSE ''::text
                END AS cod_cap_residenza_rappr_leg,
                CASE
                    WHEN xpath_exists('//indirizzo/text()'::text, x2._legalerappresentante) THEN (unnest(xpath('//indirizzo/text()'::text, x2._legalerappresentante)))::text
                    ELSE ''::text
                END AS descr_indirizzo_residenza_rappr_leg,
                CASE
                    WHEN xpath_exists('//numCivico/text()'::text, x2._legalerappresentante) THEN (unnest(xpath('//numCivico/text()'::text, x2._legalerappresentante)))::text
                    ELSE ''::text
                END AS num_civico_residenza_rappr_leg
           FROM ( SELECT d.id_domanda,
                    unnest(xpath('/tree-map/_legaleRappresentante/map'::text, m.serialized_model)) AS _legalerappresentante
                   FROM (findom_os.shell_t_domande d
                     JOIN findom_os.aggr_t_model m ON ((m.model_id = d.id_domanda)))
                  WHERE (d.dt_invio_domanda IS NOT NULL)) x2) y2 ON ((y2.id_domanda_x2 = y.id_domanda_x)))
     LEFT JOIN ( SELECT x3.id_domanda AS id_domanda_x3,
                CASE
                    WHEN xpath_exists('//stato/text()'::text, x3._sedelegale) THEN (unnest(xpath('//stato/text()'::text, x3._sedelegale)))::text
                    ELSE ''::text
                END AS cod_stato_sede_legale,
                CASE
                    WHEN xpath_exists('//provincia/text()'::text, x3._sedelegale) THEN (unnest(xpath('//provincia/text()'::text, x3._sedelegale)))::text
                    ELSE ''::text
                END AS cod_provincia_sede_legale,
                CASE
                    WHEN xpath_exists('//provinciaSigla/text()'::text, x3._sedelegale) THEN (unnest(xpath('//provinciaSigla/text()'::text, x3._sedelegale)))::text
                    ELSE ''::text
                END AS sigla_provincia_sede_legale,
                CASE
                    WHEN xpath_exists('//provinciaDescrizione/text()'::text, x3._sedelegale) THEN (unnest(xpath('//provinciaDescrizione/text()'::text, x3._sedelegale)))::text
                    ELSE ''::text
                END AS descr_provincia_sede_legale,
                CASE
                    WHEN xpath_exists('//comune/text()'::text, x3._sedelegale) THEN (unnest(xpath('//comune/text()'::text, x3._sedelegale)))::text
                    ELSE ''::text
                END AS cod_comune_sede_legale,
                CASE
                    WHEN xpath_exists('//comuneDescrizione/text()'::text, x3._sedelegale) THEN (unnest(xpath('//comuneDescrizione/text()'::text, x3._sedelegale)))::text
                    ELSE ''::text
                END AS descr_comune_sede_legale,
                CASE
                    WHEN xpath_exists('//statoEstero/text()'::text, x3._sedelegale) THEN (unnest(xpath('//statoEstero/text()'::text, x3._sedelegale)))::text
                    ELSE ''::text
                END AS cod_stato_estero_sede_legale,
                CASE
                    WHEN xpath_exists('//statoEsteroDescrizione/text()'::text, x3._sedelegale) THEN (unnest(xpath('//statoEsteroDescrizione/text()'::text, x3._sedelegale)))::text
                    ELSE ''::text
                END AS descr_stato_estero_sede_legale,
                CASE
                    WHEN xpath_exists('//cittaEstera/text()'::text, x3._sedelegale) THEN (unnest(xpath('//cittaEstera/text()'::text, x3._sedelegale)))::text
                    ELSE ''::text
                END AS descr_citta_estera_sede_legale,
                CASE
                    WHEN xpath_exists('//cap/text()'::text, x3._sedelegale) THEN (unnest(xpath('//cap/text()'::text, x3._sedelegale)))::text
                    ELSE ''::text
                END AS cod_cap_sede_legale,
                CASE
                    WHEN xpath_exists('//indirizzo/text()'::text, x3._sedelegale) THEN (unnest(xpath('//indirizzo/text()'::text, x3._sedelegale)))::text
                    ELSE ''::text
                END AS descr_indirizzo_sede_legale,
                CASE
                    WHEN xpath_exists('//numCivico/text()'::text, x3._sedelegale) THEN (unnest(xpath('//numCivico/text()'::text, x3._sedelegale)))::text
                    ELSE ''::text
                END AS num_civico_sede_legale,
                CASE
                    WHEN xpath_exists('//telefono/text()'::text, x3._sedelegale) THEN (unnest(xpath('//telefono/text()'::text, x3._sedelegale)))::text
                    ELSE ''::text
                END AS num_telefono_sede_legale,
                CASE
                    WHEN xpath_exists('//pec/text()'::text, x3._sedelegale) THEN (unnest(xpath('//pec/text()'::text, x3._sedelegale)))::text
                    ELSE ''::text
                END AS pec_sede_legale,
                CASE
                    WHEN xpath_exists('//personaRifSL/text()'::text, x3._sedelegale) THEN (unnest(xpath('//personaRifSL/text()'::text, x3._sedelegale)))::text
                    ELSE ''::text
                END AS persona_rif_sede_legale,
                CASE
                    WHEN xpath_exists('//email/text()'::text, x3._sedelegale) THEN (unnest(xpath('//email/text()'::text, x3._sedelegale)))::text
                    ELSE ''::text
                END AS email_sede_legale,
                CASE
                    WHEN xpath_exists('//cellulare/text()'::text, x3._sedelegale) THEN (unnest(xpath('//cellulare/text()'::text, x3._sedelegale)))::text
                    ELSE ''::text
                END AS num_cellulare_sede_legale
           FROM ( SELECT d.id_domanda,
                    unnest(xpath('/tree-map/_sedeLegale/map'::text, m.serialized_model)) AS _sedelegale
                   FROM (findom_os.shell_t_domande d
                     JOIN findom_os.aggr_t_model m ON ((m.model_id = d.id_domanda)))
                  WHERE (d.dt_invio_domanda IS NOT NULL)) x3) y3 ON ((y3.id_domanda_x3 = y.id_domanda_x))) z;


ALTER TABLE findom_os.findom_v_xml_dom_ben_anag OWNER TO findom_os;


--
-- TOC entry 16341 (class 1259 OID 31176340)
-- Name: shell_r_parametro_regola; Type: VIEW; Schema: findom_os; Owner: findom_os
--

CREATE VIEW findom_os.shell_r_parametro_regola AS
 SELECT a.id_bando AS template_id,
    d.descr_breve AS descr_breve_bando,
    c.cod_regola,
    b.codice AS cod_parametro,
    a.valore_parametro
   FROM (((findom_os.findom_r_bandi_parametri_regole a
     JOIN findom_os.findom_d_parametri b ON ((b.id_parametro = a.id_parametro)))
     JOIN findom_os.findom_d_regole c ON ((c.id_regola = a.id_regola)))
     JOIN findom_os.findom_t_bandi d ON ((d.id_bando = a.id_bando)))
  WHERE ((a.dt_inizio <= now()) AND ((a.dt_fine >= now()) OR (a.dt_fine IS NULL)));


ALTER TABLE findom_os.shell_r_parametro_regola OWNER TO findom_os;

--
-- TOC entry 64379 (class 0 OID 0)
-- Dependencies: 16341
-- Name: VIEW shell_r_parametro_regola; Type: COMMENT; Schema: findom_os; Owner: findom_os
--

COMMENT ON VIEW findom_os.shell_r_parametro_regola IS 'Vista utile a riuso di codice applicativo Flaidom per la gestione dei parametri-regole per bando';


