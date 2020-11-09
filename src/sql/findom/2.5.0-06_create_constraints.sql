----------------------------------------------------------------------------
-- Copyright Regione Piemonte - 2020
-- SPDX-License-Identifier: EUPL-1.2-or-later
----------------------------------------------------------------------------

--
-- TOC entry 56651 (class 2606 OID 31181763)
-- Name: aggr_t_model ak_aggr_t_model_1; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.aggr_t_model
    ADD CONSTRAINT ak_aggr_t_model_1 UNIQUE (template_code_fk, model_progr, user_id);


--
-- TOC entry 56659 (class 2606 OID 31181765)
-- Name: aggr_t_submodel ak_aggr_t_submodel_01; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.aggr_t_submodel
    ADD CONSTRAINT ak_aggr_t_submodel_01 UNIQUE (model_id, posizione, xml_type);


--
-- TOC entry 56663 (class 2606 OID 31181767)
-- Name: aggr_t_template ak_aggr_t_template_1; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.aggr_t_template
    ADD CONSTRAINT ak_aggr_t_template_1 UNIQUE (template_code);


--
-- TOC entry 56667 (class 2606 OID 31181769)
-- Name: aggr_t_template_index ak_aggr_t_template_index_1; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.aggr_t_template_index
    ADD CONSTRAINT ak_aggr_t_template_index_1 UNIQUE (template_fk, xpath_id);


--
-- TOC entry 56681 (class 2606 OID 31181771)
-- Name: ext_d_forme_giuridiche ak_ext_d_forme_giuridiche_1; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.ext_d_forme_giuridiche
    ADD CONSTRAINT ak_ext_d_forme_giuridiche_1 UNIQUE (cod_forma_giuridica);


--
-- TOC entry 56690 (class 2606 OID 31181773)
-- Name: findom_d_alimentazione_veicoli ak_findom_d_aliment_veicoli; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_d_alimentazione_veicoli
    ADD CONSTRAINT ak_findom_d_aliment_veicoli UNIQUE (descr_breve);


--
-- TOC entry 56700 (class 2606 OID 31181775)
-- Name: findom_d_campi_intervento ak_findom_d_campi_intervento_1; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_d_campi_intervento
    ADD CONSTRAINT ak_findom_d_campi_intervento_1 UNIQUE (cod_campo_intervento);


--
-- TOC entry 56704 (class 2606 OID 31181777)
-- Name: findom_d_categ_veicoli ak_findom_d_categ_veicoli; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_d_categ_veicoli
    ADD CONSTRAINT ak_findom_d_categ_veicoli UNIQUE (descr_breve);


--
-- TOC entry 56710 (class 2606 OID 31181779)
-- Name: findom_d_classif_bandi ak_findom_d_classif_bandi_1; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_d_classif_bandi
    ADD CONSTRAINT ak_findom_d_classif_bandi_1 UNIQUE (codice, id_classificazione_padre);


--
-- TOC entry 56721 (class 2606 OID 31181781)
-- Name: findom_d_covid_testi ak_findom_d_covid_testi_1; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_d_covid_testi
    ADD CONSTRAINT ak_findom_d_covid_testi_1 UNIQUE (codice_testo);


--
-- TOC entry 56727 (class 2606 OID 31181783)
-- Name: findom_d_dett_tipol_aiuti ak_findom_d_dett_tipol_aiuti_1; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_d_dett_tipol_aiuti
    ADD CONSTRAINT ak_findom_d_dett_tipol_aiuti_1 UNIQUE (codice);


--
-- TOC entry 56732 (class 2606 OID 31181785)
-- Name: findom_d_dett_tipol_interventi ak_findom_d_dett_tipol_interventi_1; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_d_dett_tipol_interventi
    ADD CONSTRAINT ak_findom_d_dett_tipol_interventi_1 UNIQUE (codice);


--
-- TOC entry 56740 (class 2606 OID 31181787)
-- Name: findom_d_dipartimenti ak_findom_d_dipartimenti_1; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_d_dipartimenti
    ADD CONSTRAINT ak_findom_d_dipartimenti_1 UNIQUE (id_ente_strutt, codice);


--
-- TOC entry 56750 (class 2606 OID 31181789)
-- Name: findom_d_enti ak_findom_d_enti_1; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_d_enti
    ADD CONSTRAINT ak_findom_d_enti_1 UNIQUE (descr_breve);


--
-- TOC entry 56754 (class 2606 OID 31181791)
-- Name: findom_d_enti_strutturati ak_findom_d_enti_strutturati_1; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_d_enti_strutturati
    ADD CONSTRAINT ak_findom_d_enti_strutturati_1 UNIQUE (codice);


--
-- TOC entry 56756 (class 2606 OID 31181793)
-- Name: findom_d_enti_strutturati ak_findom_d_enti_strutturati_2; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_d_enti_strutturati
    ADD CONSTRAINT ak_findom_d_enti_strutturati_2 UNIQUE (cod_fiscale);


--
-- TOC entry 56760 (class 2606 OID 31181795)
-- Name: findom_d_forme_finanziamenti ak_findom_d_forme_finanziamenti_1; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_d_forme_finanziamenti
    ADD CONSTRAINT ak_findom_d_forme_finanziamenti_1 UNIQUE (cod_forma_finanziamento);


--
-- TOC entry 56764 (class 2606 OID 31181797)
-- Name: findom_d_funzionari ak_findom_d_funzionari_1; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_d_funzionari
    ADD CONSTRAINT ak_findom_d_funzionari_1 UNIQUE (cod_fiscale);


--
-- TOC entry 56771 (class 2606 OID 31181799)
-- Name: findom_d_indicatori ak_findom_d_indicatori_1; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_d_indicatori
    ADD CONSTRAINT ak_findom_d_indicatori_1 UNIQUE (codice);


--
-- TOC entry 56778 (class 2606 OID 31181801)
-- Name: findom_d_normative ak_findom_d_normative_1; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_d_normative
    ADD CONSTRAINT ak_findom_d_normative_1 UNIQUE (descr_breve);


--
-- TOC entry 56804 (class 2606 OID 31181803)
-- Name: findom_d_specifiche_valut ak_findom_d_specifiche_valut_1; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_d_specifiche_valut
    ADD CONSTRAINT ak_findom_d_specifiche_valut_1 UNIQUE (id_specifica, ordine);


--
-- TOC entry 56810 (class 2606 OID 31181805)
-- Name: findom_d_stato_istruttoria ak_findom_d_stato_istruttoria_1; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_d_stato_istruttoria
    ADD CONSTRAINT ak_findom_d_stato_istruttoria_1 UNIQUE (codice);


--
-- TOC entry 56822 (class 2606 OID 31181807)
-- Name: findom_d_tipi_suddivisione ak_findom_d_tipi_suddivisione_1; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_d_tipi_suddivisione
    ADD CONSTRAINT ak_findom_d_tipi_suddivisione_1 UNIQUE (descr_breve);


--
-- TOC entry 56826 (class 2606 OID 31181809)
-- Name: findom_d_tipo_graduatoria ak_findom_d_tipo_graduatoria_1; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_d_tipo_graduatoria
    ADD CONSTRAINT ak_findom_d_tipo_graduatoria_1 UNIQUE (cod_tipo_graduatoria);


--
-- TOC entry 56830 (class 2606 OID 31181811)
-- Name: findom_d_tipol_aiuti ak_findom_d_tipol_aiuti_1; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_d_tipol_aiuti
    ADD CONSTRAINT ak_findom_d_tipol_aiuti_1 UNIQUE (codice);


--
-- TOC entry 56839 (class 2606 OID 31181813)
-- Name: findom_d_tipol_interventi ak_findom_d_tipol_interventi_1; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_d_tipol_interventi
    ADD CONSTRAINT ak_findom_d_tipol_interventi_1 UNIQUE (codice);


--
-- TOC entry 56844 (class 2606 OID 31181815)
-- Name: findom_d_tipol_voci_spesa ak_findom_d_tipol_voci_spesa_1; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_d_tipol_voci_spesa
    ADD CONSTRAINT ak_findom_d_tipol_voci_spesa_1 UNIQUE (codice);


--
-- TOC entry 56856 (class 2606 OID 31181817)
-- Name: findom_d_voci_spesa ak_findom_d_voci_spesa_1; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_d_voci_spesa
    ADD CONSTRAINT ak_findom_d_voci_spesa_1 UNIQUE (descr_breve);


--
-- TOC entry 56947 (class 2606 OID 31181819)
-- Name: findom_t_amministratori ak_findom_t_amministratori_1; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_t_amministratori
    ADD CONSTRAINT ak_findom_t_amministratori_1 UNIQUE (cod_fiscale);


--
-- TOC entry 56952 (class 2606 OID 31181821)
-- Name: findom_t_bandi ak_findom_t_bandi_1; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_t_bandi
    ADD CONSTRAINT ak_findom_t_bandi_1 UNIQUE (descr_breve);


--
-- TOC entry 56959 (class 2606 OID 31181823)
-- Name: findom_t_bonus_turismo ak_findom_t_bonus_turismo_1; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_t_bonus_turismo
    ADD CONSTRAINT ak_findom_t_bonus_turismo_1 UNIQUE (cod_regionale);


--
-- TOC entry 56976 (class 2606 OID 31181825)
-- Name: findom_t_dich_presa_visione ak_findom_t_dich_presa_visione_1; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_t_dich_presa_visione
    ADD CONSTRAINT ak_findom_t_dich_presa_visione_1 UNIQUE (id_documento_comm, id_commissario);


--
-- TOC entry 56989 (class 2606 OID 31181827)
-- Name: findom_t_parametri_valut ak_findom_t_parametri_valut_1; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_t_parametri_valut
    ADD CONSTRAINT ak_findom_t_parametri_valut_1 UNIQUE (id_bando, id_specifica, id_parametro);


--
-- TOC entry 56997 (class 2606 OID 31181829)
-- Name: findom_t_soggetti_bonus_covid ak_findom_t_soggetti_bonus_covid_1; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_t_soggetti_bonus_covid
    ADD CONSTRAINT ak_findom_t_soggetti_bonus_covid_1 UNIQUE (cod_fiscale);


--
-- TOC entry 56999 (class 2606 OID 31181831)
-- Name: findom_t_soggetti_bonus_covid ak_findom_t_soggetti_bonus_covid_2; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_t_soggetti_bonus_covid
    ADD CONSTRAINT ak_findom_t_soggetti_bonus_covid_2 UNIQUE (partita_iva);


--
-- TOC entry 57008 (class 2606 OID 31181833)
-- Name: findom_t_sportelli_bandi ak_findom_t_sportelli_bandi_1; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_t_sportelli_bandi
    ADD CONSTRAINT ak_findom_t_sportelli_bandi_1 UNIQUE (id_bando, dt_chiusura);


--
-- TOC entry 57067 (class 2606 OID 31181835)
-- Name: istr_t_model ak_istr_t_model_1; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.istr_t_model
    ADD CONSTRAINT ak_istr_t_model_1 UNIQUE (template_code_fk, model_progr, user_id);


--
-- TOC entry 57108 (class 2606 OID 31181837)
-- Name: istr_t_submodel ak_istr_t_submodel_01; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.istr_t_submodel
    ADD CONSTRAINT ak_istr_t_submodel_01 UNIQUE (model_id, posizione, xml_type);


--
-- TOC entry 57112 (class 2606 OID 31181839)
-- Name: istr_t_template ak_istr_t_template_1; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.istr_t_template
    ADD CONSTRAINT ak_istr_t_template_1 UNIQUE (template_code);


--
-- TOC entry 57116 (class 2606 OID 31181841)
-- Name: istr_t_template_index ak_istr_t_template_index_1; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.istr_t_template_index
    ADD CONSTRAINT ak_istr_t_template_index_1 UNIQUE (template_fk, xpath_id);


--
-- TOC entry 57059 (class 2606 OID 31181843)
-- Name: shell_t_file_domande ak_shell_t_file_domande_1; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.shell_t_file_domande
    ADD CONSTRAINT ak_shell_t_file_domande_1 UNIQUE (id_domanda);


--
-- TOC entry 57098 (class 2606 OID 31181845)
-- Name: shell_t_rimod_entrate ak_shell_t_rimod_entrate; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.shell_t_rimod_entrate
    ADD CONSTRAINT ak_shell_t_rimod_entrate UNIQUE (id_domanda, id_voce_entrata, dettaglio, tipo_rimodulazione);


--
-- TOC entry 57093 (class 2606 OID 31181847)
-- Name: shell_t_rimod_spese ak_shell_t_rimod_spese_1; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.shell_t_rimod_spese
    ADD CONSTRAINT ak_shell_t_rimod_spese_1 UNIQUE (id_domanda, id_tipol_intervento, id_dett_intervento, id_voce_spesa, tipo_rimodulazione);


--
-- TOC entry 57052 (class 2606 OID 31181849)
-- Name: shell_t_soggetti ak_shell_t_soggetti_1; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.shell_t_soggetti
    ADD CONSTRAINT ak_shell_t_soggetti_1 UNIQUE (cod_fiscale, cod_ufficio);


--
-- TOC entry 57071 (class 2606 OID 31181851)
-- Name: shell_t_valut_domande ak_shell_t_valut_domande_1; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.shell_t_valut_domande
    ADD CONSTRAINT ak_shell_t_valut_domande_1 UNIQUE (id_domanda, id_parametro_valut, stato_valut);


--
-- TOC entry 57148 (class 2606 OID 31181853)
-- Name: utl_t_regola_routing ak_utl_t_regola_routing_01; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.utl_t_regola_routing
    ADD CONSTRAINT ak_utl_t_regola_routing_01 UNIQUE (id_sportello_bando, cod_fase);


--
-- TOC entry 56784 (class 2606 OID 31181855)
-- Name: findom_d_parametri_specifiche_valut findom_d_parametri_specifiche_valut_pkey; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_d_parametri_specifiche_valut
    ADD CONSTRAINT findom_d_parametri_specifiche_valut_pkey PRIMARY KEY (id_parametro);


--
-- TOC entry 56788 (class 2606 OID 31181857)
-- Name: findom_d_range_graduatoria findom_d_range_graduatoria_pkey; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_d_range_graduatoria
    ADD CONSTRAINT findom_d_range_graduatoria_pkey PRIMARY KEY (id_range);


--
-- TOC entry 56649 (class 2606 OID 31181859)
-- Name: aggr_d_model_state pk_aggr_d_model_state; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.aggr_d_model_state
    ADD CONSTRAINT pk_aggr_d_model_state PRIMARY KEY (model_state);


--
-- TOC entry 56653 (class 2606 OID 31181861)
-- Name: aggr_t_model pk_aggr_t_model; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.aggr_t_model
    ADD CONSTRAINT pk_aggr_t_model PRIMARY KEY (model_id);


--
-- TOC entry 56655 (class 2606 OID 31181863)
-- Name: aggr_t_model_index pk_aggr_t_model_index; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.aggr_t_model_index
    ADD CONSTRAINT pk_aggr_t_model_index PRIMARY KEY (model_id, index_id);


--
-- TOC entry 56657 (class 2606 OID 31181865)
-- Name: aggr_t_rule pk_aggr_t_rule; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.aggr_t_rule
    ADD CONSTRAINT pk_aggr_t_rule PRIMARY KEY (rule_id);


--
-- TOC entry 56661 (class 2606 OID 31181867)
-- Name: aggr_t_submodel pk_aggr_t_submodel; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.aggr_t_submodel
    ADD CONSTRAINT pk_aggr_t_submodel PRIMARY KEY (submodel_id);


--
-- TOC entry 56665 (class 2606 OID 31181869)
-- Name: aggr_t_template pk_aggr_t_template; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.aggr_t_template
    ADD CONSTRAINT pk_aggr_t_template PRIMARY KEY (template_id);


--
-- TOC entry 56669 (class 2606 OID 31181871)
-- Name: aggr_t_template_index pk_aggr_t_template_index; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.aggr_t_template_index
    ADD CONSTRAINT pk_aggr_t_template_index PRIMARY KEY (index_id);


--
-- TOC entry 56894 (class 2606 OID 31181873)
-- Name: findom_r_bandi_soggetti_abilitati pk_bandi_soggetti_abilitati; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_r_bandi_soggetti_abilitati
    ADD CONSTRAINT pk_bandi_soggetti_abilitati PRIMARY KEY (id_sogg_abil, id_bando);


--
-- TOC entry 56671 (class 2606 OID 31181875)
-- Name: csi_log_audit pk_csi_log_audit; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.csi_log_audit
    ADD CONSTRAINT pk_csi_log_audit PRIMARY KEY (id_traccia);


--
-- TOC entry 56675 (class 2606 OID 31181877)
-- Name: ext_d_ateco pk_ext_d_ateco; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.ext_d_ateco
    ADD CONSTRAINT pk_ext_d_ateco PRIMARY KEY (id_ateco);


--
-- TOC entry 56677 (class 2606 OID 31181879)
-- Name: ext_d_comuni pk_ext_d_comuni; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.ext_d_comuni
    ADD CONSTRAINT pk_ext_d_comuni PRIMARY KEY (prov, comune);


--
-- TOC entry 56679 (class 2606 OID 31181881)
-- Name: ext_d_enti_parchi pk_ext_d_enti_parchi; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.ext_d_enti_parchi
    ADD CONSTRAINT pk_ext_d_enti_parchi PRIMARY KEY (id);


--
-- TOC entry 56684 (class 2606 OID 31181883)
-- Name: ext_d_forme_giuridiche pk_ext_d_forme_giuridiche; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.ext_d_forme_giuridiche
    ADD CONSTRAINT pk_ext_d_forme_giuridiche PRIMARY KEY (id_forma_giuridica);


--
-- TOC entry 56686 (class 2606 OID 31181885)
-- Name: ext_d_province pk_ext_d_province; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.ext_d_province
    ADD CONSTRAINT pk_ext_d_province PRIMARY KEY (prov);


--
-- TOC entry 56688 (class 2606 OID 31181887)
-- Name: ext_d_stati_esteri pk_ext_d_stati_esteri; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.ext_d_stati_esteri
    ADD CONSTRAINT pk_ext_d_stati_esteri PRIMARY KEY (cod_stato);


--
-- TOC entry 56692 (class 2606 OID 31181889)
-- Name: findom_d_alimentazione_veicoli pk_findom_d_aliment_veicoli; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_d_alimentazione_veicoli
    ADD CONSTRAINT pk_findom_d_aliment_veicoli PRIMARY KEY (id_aliment_veicolo);


--
-- TOC entry 56694 (class 2606 OID 31181891)
-- Name: findom_d_allegati pk_findom_d_allegati; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_d_allegati
    ADD CONSTRAINT pk_findom_d_allegati PRIMARY KEY (id_allegato);


--
-- TOC entry 56696 (class 2606 OID 31181893)
-- Name: findom_d_area_tematica pk_findom_d_area_tematica; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_d_area_tematica
    ADD CONSTRAINT pk_findom_d_area_tematica PRIMARY KEY (id_area_tematica);


--
-- TOC entry 56698 (class 2606 OID 31181895)
-- Name: findom_d_azioni_istruttoria pk_findom_d_azioni_istruttoria; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_d_azioni_istruttoria
    ADD CONSTRAINT pk_findom_d_azioni_istruttoria PRIMARY KEY (id_azione);


--
-- TOC entry 56702 (class 2606 OID 31181897)
-- Name: findom_d_campi_intervento pk_findom_d_campi_intervento; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_d_campi_intervento
    ADD CONSTRAINT pk_findom_d_campi_intervento PRIMARY KEY (id_campo_intervento);


--
-- TOC entry 56706 (class 2606 OID 31181899)
-- Name: findom_d_categ_veicoli pk_findom_d_categ_veicoli; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_d_categ_veicoli
    ADD CONSTRAINT pk_findom_d_categ_veicoli PRIMARY KEY (id_categ_veicolo);


--
-- TOC entry 56708 (class 2606 OID 31181901)
-- Name: findom_d_categ_voci_spesa pk_findom_d_categ_voci_spesa; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_d_categ_voci_spesa
    ADD CONSTRAINT pk_findom_d_categ_voci_spesa PRIMARY KEY (id_categ_voce_spesa);


--
-- TOC entry 56715 (class 2606 OID 31181903)
-- Name: findom_d_classif_bandi pk_findom_d_classif_bandi; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_d_classif_bandi
    ADD CONSTRAINT pk_findom_d_classif_bandi PRIMARY KEY (id_classificazione);


--
-- TOC entry 56717 (class 2606 OID 31181905)
-- Name: findom_d_covid_message pk_findom_d_covid_message; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_d_covid_message
    ADD CONSTRAINT pk_findom_d_covid_message PRIMARY KEY (id_message);


--
-- TOC entry 56723 (class 2606 OID 31181907)
-- Name: findom_d_covid_testi pk_findom_d_covid_testi; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_d_covid_testi
    ADD CONSTRAINT pk_findom_d_covid_testi PRIMARY KEY (id_testo);


--
-- TOC entry 56725 (class 2606 OID 31181909)
-- Name: findom_d_criteri_valut pk_findom_d_criteri_valut; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_d_criteri_valut
    ADD CONSTRAINT pk_findom_d_criteri_valut PRIMARY KEY (id_criterio);


--
-- TOC entry 56730 (class 2606 OID 31181911)
-- Name: findom_d_dett_tipol_aiuti pk_findom_d_dett_tipol_aiuti; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_d_dett_tipol_aiuti
    ADD CONSTRAINT pk_findom_d_dett_tipol_aiuti PRIMARY KEY (id_dett_tipol_aiuti);


--
-- TOC entry 56736 (class 2606 OID 31181913)
-- Name: findom_d_dett_tipol_interventi pk_findom_d_dett_tipol_interventi; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_d_dett_tipol_interventi
    ADD CONSTRAINT pk_findom_d_dett_tipol_interventi PRIMARY KEY (id_dett_tipol_intervento);


--
-- TOC entry 56738 (class 2606 OID 31181915)
-- Name: findom_d_dimensioni_imprese pk_findom_d_dimensioni_imprese; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_d_dimensioni_imprese
    ADD CONSTRAINT pk_findom_d_dimensioni_imprese PRIMARY KEY (id_dimensione);


--
-- TOC entry 56742 (class 2606 OID 31181917)
-- Name: findom_d_dipartimenti pk_findom_d_dipartimenti; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_d_dipartimenti
    ADD CONSTRAINT pk_findom_d_dipartimenti PRIMARY KEY (id_dipartimento);


--
-- TOC entry 56744 (class 2606 OID 31181919)
-- Name: findom_d_direzioni pk_findom_d_direzioni; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_d_direzioni
    ADD CONSTRAINT pk_findom_d_direzioni PRIMARY KEY (id_direzione);


--
-- TOC entry 56746 (class 2606 OID 31181921)
-- Name: findom_d_documenti_istruttoria pk_findom_d_documenti_istruttoria; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_d_documenti_istruttoria
    ADD CONSTRAINT pk_findom_d_documenti_istruttoria PRIMARY KEY (id_documento_istr);


--
-- TOC entry 56748 (class 2606 OID 31181923)
-- Name: findom_d_emissioni_veicoli pk_findom_d_emissioni_veicoli; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_d_emissioni_veicoli
    ADD CONSTRAINT pk_findom_d_emissioni_veicoli PRIMARY KEY (id_emissione);


--
-- TOC entry 56752 (class 2606 OID 31181925)
-- Name: findom_d_enti pk_findom_d_enti; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_d_enti
    ADD CONSTRAINT pk_findom_d_enti PRIMARY KEY (id_ente);


--
-- TOC entry 56758 (class 2606 OID 31181927)
-- Name: findom_d_enti_strutturati pk_findom_d_enti_strutturati; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_d_enti_strutturati
    ADD CONSTRAINT pk_findom_d_enti_strutturati PRIMARY KEY (id_ente_strutt);


--
-- TOC entry 56762 (class 2606 OID 31181929)
-- Name: findom_d_forme_finanziamenti pk_findom_d_forme_finanziamenti; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_d_forme_finanziamenti
    ADD CONSTRAINT pk_findom_d_forme_finanziamenti PRIMARY KEY (id_forma_finanziamento);


--
-- TOC entry 56767 (class 2606 OID 31181931)
-- Name: findom_d_funzionari pk_findom_d_funzionari; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_d_funzionari
    ADD CONSTRAINT pk_findom_d_funzionari PRIMARY KEY (id_funzionario);


--
-- TOC entry 56769 (class 2606 OID 31181933)
-- Name: findom_d_incarichi pk_findom_d_incarichi; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_d_incarichi
    ADD CONSTRAINT pk_findom_d_incarichi PRIMARY KEY (id_incarico);


--
-- TOC entry 56774 (class 2606 OID 31181935)
-- Name: findom_d_indicatori pk_findom_d_indicatori; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_d_indicatori
    ADD CONSTRAINT pk_findom_d_indicatori PRIMARY KEY (id_indicatore);


--
-- TOC entry 56776 (class 2606 OID 31181937)
-- Name: findom_d_motivazione_esito pk_findom_d_motivazione_esito; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_d_motivazione_esito
    ADD CONSTRAINT pk_findom_d_motivazione_esito PRIMARY KEY (id_motivazione_esito);


--
-- TOC entry 56780 (class 2606 OID 31181939)
-- Name: findom_d_normative pk_findom_d_normative; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_d_normative
    ADD CONSTRAINT pk_findom_d_normative PRIMARY KEY (id_normativa);


--
-- TOC entry 56782 (class 2606 OID 31181941)
-- Name: findom_d_parametri pk_findom_d_parametri; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_d_parametri
    ADD CONSTRAINT pk_findom_d_parametri PRIMARY KEY (id_parametro);


--
-- TOC entry 56786 (class 2606 OID 31181943)
-- Name: findom_d_premialita pk_findom_d_premialita; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_d_premialita
    ADD CONSTRAINT pk_findom_d_premialita PRIMARY KEY (id_premialita);


--
-- TOC entry 56791 (class 2606 OID 31181945)
-- Name: findom_d_regole pk_findom_d_regole; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_d_regole
    ADD CONSTRAINT pk_findom_d_regole PRIMARY KEY (id_regola);


--
-- TOC entry 56793 (class 2606 OID 31181947)
-- Name: findom_d_risorse_umane pk_findom_d_risorse_umane; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_d_risorse_umane
    ADD CONSTRAINT pk_findom_d_risorse_umane PRIMARY KEY (id_risorsa);


--
-- TOC entry 56795 (class 2606 OID 31181949)
-- Name: findom_d_ruoli_istr pk_findom_d_ruoli_istr; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_d_ruoli_istr
    ADD CONSTRAINT pk_findom_d_ruoli_istr PRIMARY KEY (id_ruolo);


--
-- TOC entry 56797 (class 2606 OID 31181951)
-- Name: findom_d_settore_attivita pk_findom_d_settore_attivita; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_d_settore_attivita
    ADD CONSTRAINT pk_findom_d_settore_attivita PRIMARY KEY (id_settore_attivita);


--
-- TOC entry 56800 (class 2606 OID 31181953)
-- Name: findom_d_settori pk_findom_d_settori; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_d_settori
    ADD CONSTRAINT pk_findom_d_settori PRIMARY KEY (id_settore);


--
-- TOC entry 56802 (class 2606 OID 31181955)
-- Name: findom_d_sistema_protocollo pk_findom_d_sistema_protocollo; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_d_sistema_protocollo
    ADD CONSTRAINT pk_findom_d_sistema_protocollo PRIMARY KEY (id_sistema_prot);


--
-- TOC entry 56806 (class 2606 OID 31181957)
-- Name: findom_d_specifiche_valut pk_findom_d_specifiche_valut; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_d_specifiche_valut
    ADD CONSTRAINT pk_findom_d_specifiche_valut PRIMARY KEY (id_specifica);


--
-- TOC entry 56808 (class 2606 OID 31181959)
-- Name: findom_d_stato_documento_index pk_findom_d_stato_documento_index; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_d_stato_documento_index
    ADD CONSTRAINT pk_findom_d_stato_documento_index PRIMARY KEY (id_stato_documento_index);


--
-- TOC entry 56812 (class 2606 OID 31181961)
-- Name: findom_d_stato_istruttoria pk_findom_d_stato_istruttoria; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_d_stato_istruttoria
    ADD CONSTRAINT pk_findom_d_stato_istruttoria PRIMARY KEY (id_stato_istr);


--
-- TOC entry 56814 (class 2606 OID 31181963)
-- Name: findom_d_stereotipi pk_findom_d_stereotipi; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_d_stereotipi
    ADD CONSTRAINT pk_findom_d_stereotipi PRIMARY KEY (cod_stereotipo);


--
-- TOC entry 56816 (class 2606 OID 31181965)
-- Name: findom_d_tipi_indicatori pk_findom_d_tipi_indicatori; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_d_tipi_indicatori
    ADD CONSTRAINT pk_findom_d_tipi_indicatori PRIMARY KEY (id_tipo_indicatore);


--
-- TOC entry 56818 (class 2606 OID 31181967)
-- Name: findom_d_tipi_regole pk_findom_d_tipi_regole; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_d_tipi_regole
    ADD CONSTRAINT pk_findom_d_tipi_regole PRIMARY KEY (id_tipo_regola);


--
-- TOC entry 56820 (class 2606 OID 31181969)
-- Name: findom_d_tipi_rottamazione pk_findom_d_tipi_rottamazione; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_d_tipi_rottamazione
    ADD CONSTRAINT pk_findom_d_tipi_rottamazione PRIMARY KEY (id_tipo_rottamazione);


--
-- TOC entry 56824 (class 2606 OID 31181971)
-- Name: findom_d_tipi_suddivisione pk_findom_d_tipi_suddivisione; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_d_tipi_suddivisione
    ADD CONSTRAINT pk_findom_d_tipi_suddivisione PRIMARY KEY (id_tipo_suddivisione);


--
-- TOC entry 56828 (class 2606 OID 31181973)
-- Name: findom_d_tipo_graduatoria pk_findom_d_tipo_graduatoria; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_d_tipo_graduatoria
    ADD CONSTRAINT pk_findom_d_tipo_graduatoria PRIMARY KEY (id_tipo_graduatoria);


--
-- TOC entry 56832 (class 2606 OID 31181975)
-- Name: findom_d_tipol_aiuti pk_findom_d_tipol_aiuti; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_d_tipol_aiuti
    ADD CONSTRAINT pk_findom_d_tipol_aiuti PRIMARY KEY (id_tipol_aiuto);


--
-- TOC entry 56835 (class 2606 OID 31181977)
-- Name: findom_d_tipol_beneficiari pk_findom_d_tipol_beneficiari; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_d_tipol_beneficiari
    ADD CONSTRAINT pk_findom_d_tipol_beneficiari PRIMARY KEY (id_tipol_beneficiario);


--
-- TOC entry 56842 (class 2606 OID 31181979)
-- Name: findom_d_tipol_interventi pk_findom_d_tipol_interventi; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_d_tipol_interventi
    ADD CONSTRAINT pk_findom_d_tipol_interventi PRIMARY KEY (id_tipol_intervento);


--
-- TOC entry 56846 (class 2606 OID 31181981)
-- Name: findom_d_tipol_voci_spesa pk_findom_d_tipol_voci_spesa; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_d_tipol_voci_spesa
    ADD CONSTRAINT pk_findom_d_tipol_voci_spesa PRIMARY KEY (id_tipol_voce_spesa);


--
-- TOC entry 56848 (class 2606 OID 31181983)
-- Name: findom_d_tipologie_documenti pk_findom_d_tipologie_documenti; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_d_tipologie_documenti
    ADD CONSTRAINT pk_findom_d_tipologie_documenti PRIMARY KEY (id_tipologia);


--
-- TOC entry 56850 (class 2606 OID 31181985)
-- Name: findom_d_ula pk_findom_d_ula; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_d_ula
    ADD CONSTRAINT pk_findom_d_ula PRIMARY KEY (id_ula);


--
-- TOC entry 56852 (class 2606 OID 31181987)
-- Name: findom_d_valoriz_econom pk_findom_d_valoriz_econom; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_d_valoriz_econom
    ADD CONSTRAINT pk_findom_d_valoriz_econom PRIMARY KEY (id_valoriz_econom);


--
-- TOC entry 56854 (class 2606 OID 31181989)
-- Name: findom_d_voci_entrata pk_findom_d_voci_entrata; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_d_voci_entrata
    ADD CONSTRAINT pk_findom_d_voci_entrata PRIMARY KEY (id_voce_entrata);


--
-- TOC entry 56858 (class 2606 OID 31181991)
-- Name: findom_d_voci_spesa pk_findom_d_voci_spesa; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_d_voci_spesa
    ADD CONSTRAINT pk_findom_d_voci_spesa PRIMARY KEY (id_voce_spesa);


--
-- TOC entry 56861 (class 2606 OID 31181993)
-- Name: findom_r_bandi_allegati pk_findom_r_bandi_allegati; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_r_bandi_allegati
    ADD CONSTRAINT pk_findom_r_bandi_allegati PRIMARY KEY (id_bando, id_allegato);


--
-- TOC entry 56864 (class 2606 OID 31181995)
-- Name: findom_r_bandi_ateco pk_findom_r_bandi_ateco; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_r_bandi_ateco
    ADD CONSTRAINT pk_findom_r_bandi_ateco PRIMARY KEY (id_bando, id_ateco);


--
-- TOC entry 56867 (class 2606 OID 31181997)
-- Name: findom_r_bandi_ateco_escl pk_findom_r_bandi_ateco_escl; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_r_bandi_ateco_escl
    ADD CONSTRAINT pk_findom_r_bandi_ateco_escl PRIMARY KEY (id_bando, id_ateco);


--
-- TOC entry 56871 (class 2606 OID 31181999)
-- Name: findom_r_bandi_criteri_valut pk_findom_r_bandi_criteri_valut; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_r_bandi_criteri_valut
    ADD CONSTRAINT pk_findom_r_bandi_criteri_valut PRIMARY KEY (id_bando, id_criterio);


--
-- TOC entry 56874 (class 2606 OID 31182001)
-- Name: findom_r_bandi_dett_tipol_aiuti pk_findom_r_bandi_dett_tipol_aiuti; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_r_bandi_dett_tipol_aiuti
    ADD CONSTRAINT pk_findom_r_bandi_dett_tipol_aiuti PRIMARY KEY (id_bando, id_dett_tipol_aiuti);


--
-- TOC entry 56877 (class 2606 OID 31182003)
-- Name: findom_r_bandi_forme_finanziamenti pk_findom_r_bandi_forme_finanziamenti; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_r_bandi_forme_finanziamenti
    ADD CONSTRAINT pk_findom_r_bandi_forme_finanziamenti PRIMARY KEY (id_bando, id_forma_finanziamento);


--
-- TOC entry 56880 (class 2606 OID 31182005)
-- Name: findom_r_bandi_indicatori pk_findom_r_bandi_indicatori; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_r_bandi_indicatori
    ADD CONSTRAINT pk_findom_r_bandi_indicatori PRIMARY KEY (id_bando, id_indicatore);


--
-- TOC entry 56882 (class 2606 OID 31182007)
-- Name: findom_r_bandi_motivazioni_esito pk_findom_r_bandi_motivazioni_esito; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_r_bandi_motivazioni_esito
    ADD CONSTRAINT pk_findom_r_bandi_motivazioni_esito PRIMARY KEY (id_bando, id_motivazione_esito);


--
-- TOC entry 56886 (class 2606 OID 31182009)
-- Name: findom_r_bandi_parametri_regole pk_findom_r_bandi_parametri_regole; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_r_bandi_parametri_regole
    ADD CONSTRAINT pk_findom_r_bandi_parametri_regole PRIMARY KEY (id_bando, id_parametro, id_regola);


--
-- TOC entry 56889 (class 2606 OID 31182011)
-- Name: findom_r_bandi_premialita pk_findom_r_bandi_premialita; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_r_bandi_premialita
    ADD CONSTRAINT pk_findom_r_bandi_premialita PRIMARY KEY (id_bando, id_premialita);


--
-- TOC entry 56891 (class 2606 OID 31182013)
-- Name: findom_r_bandi_regole pk_findom_r_bandi_regole; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_r_bandi_regole
    ADD CONSTRAINT pk_findom_r_bandi_regole PRIMARY KEY (id_bando, id_regola);


--
-- TOC entry 56897 (class 2606 OID 31182015)
-- Name: findom_r_bandi_specifiche_valut pk_findom_r_bandi_specifiche_valut; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_r_bandi_specifiche_valut
    ADD CONSTRAINT pk_findom_r_bandi_specifiche_valut PRIMARY KEY (id_bando, id_specifica);


--
-- TOC entry 56902 (class 2606 OID 31182017)
-- Name: findom_r_bandi_tipol_interventi pk_findom_r_bandi_tipol_interventi; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_r_bandi_tipol_interventi
    ADD CONSTRAINT pk_findom_r_bandi_tipol_interventi PRIMARY KEY (id_bando, id_tipol_intervento);


--
-- TOC entry 56905 (class 2606 OID 31182019)
-- Name: findom_r_bandi_valoriz_econom pk_findom_r_bandi_valoriz_econom; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_r_bandi_valoriz_econom
    ADD CONSTRAINT pk_findom_r_bandi_valoriz_econom PRIMARY KEY (id_bando, id_valoriz_econom);


--
-- TOC entry 56908 (class 2606 OID 31182021)
-- Name: findom_r_bandi_voci_entrata pk_findom_r_bandi_voci_entrata; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_r_bandi_voci_entrata
    ADD CONSTRAINT pk_findom_r_bandi_voci_entrata PRIMARY KEY (id_bando, id_voce_entrata);


--
-- TOC entry 56911 (class 2606 OID 31182023)
-- Name: findom_r_commissioni_commissari pk_findom_r_commissioni_commissari; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_r_commissioni_commissari
    ADD CONSTRAINT pk_findom_r_commissioni_commissari PRIMARY KEY (id_commissione, id_commissario);


--
-- TOC entry 56914 (class 2606 OID 31182025)
-- Name: findom_r_dett_tipol_interventi_voci_spesa pk_findom_r_dett_tipol_interventi_voci_spesa; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_r_dett_tipol_interventi_voci_spesa
    ADD CONSTRAINT pk_findom_r_dett_tipol_interventi_voci_spesa PRIMARY KEY (id_dett_tipol_intervento, id_voce_spesa);


--
-- TOC entry 56917 (class 2606 OID 31182027)
-- Name: findom_r_funzionari_direzioni pk_findom_r_funzionari_direzioni; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_r_funzionari_direzioni
    ADD CONSTRAINT pk_findom_r_funzionari_direzioni PRIMARY KEY (id_funzionario, id_direzione);


--
-- TOC entry 56919 (class 2606 OID 31182029)
-- Name: findom_r_funzionari_settori pk_findom_r_funzionari_settori; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_r_funzionari_settori
    ADD CONSTRAINT pk_findom_r_funzionari_settori PRIMARY KEY (id_funzionario, id_settore);


--
-- TOC entry 56921 (class 2606 OID 31182031)
-- Name: findom_r_sportelli_bandi_commissioni pk_findom_r_sportelli_bandi_commissioni; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_r_sportelli_bandi_commissioni
    ADD CONSTRAINT pk_findom_r_sportelli_bandi_commissioni PRIMARY KEY (id_sportello_bando, id_commissione);


--
-- TOC entry 56924 (class 2606 OID 31182033)
-- Name: findom_r_stato_azioni_istruttoria pk_findom_r_stato_azioni_istruttoria; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_r_stato_azioni_istruttoria
    ADD CONSTRAINT pk_findom_r_stato_azioni_istruttoria PRIMARY KEY (id_stato_istr, id_azione);


--
-- TOC entry 56928 (class 2606 OID 31182035)
-- Name: findom_r_tipi_rottamaz_alimentaz_veicoli pk_findom_r_tipi_rottamaz_alimentaz_veicoli; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_r_tipi_rottamaz_alimentaz_veicoli
    ADD CONSTRAINT pk_findom_r_tipi_rottamaz_alimentaz_veicoli PRIMARY KEY (id_sportello_bando, id_aliment_veicolo, id_tipo_rottamazione);


--
-- TOC entry 56932 (class 2606 OID 31182037)
-- Name: findom_r_tipi_rottamaz_categ_veicoli pk_findom_r_tipi_rottamaz_categ_veicoli; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_r_tipi_rottamaz_categ_veicoli
    ADD CONSTRAINT pk_findom_r_tipi_rottamaz_categ_veicoli PRIMARY KEY (id_sportello_bando, id_categ_veicolo, id_tipo_rottamazione);


--
-- TOC entry 56935 (class 2606 OID 31182039)
-- Name: findom_r_tipol_beneficiari_bandi pk_findom_r_tipol_beneficiari_bandi; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_r_tipol_beneficiari_bandi
    ADD CONSTRAINT pk_findom_r_tipol_beneficiari_bandi PRIMARY KEY (id_tipol_beneficiario, id_bando);


--
-- TOC entry 56938 (class 2606 OID 31182041)
-- Name: findom_r_tipol_interventi_voci_spesa pk_findom_r_tipol_interventi_voci_spesa; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_r_tipol_interventi_voci_spesa
    ADD CONSTRAINT pk_findom_r_tipol_interventi_voci_spesa PRIMARY KEY (id_tipol_intervento, id_voce_spesa);


--
-- TOC entry 56941 (class 2606 OID 31182043)
-- Name: findom_r_ula_tipol_beneficiari_bandi pk_findom_r_ula_tipol_beneficiari_bandi; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_r_ula_tipol_beneficiari_bandi
    ADD CONSTRAINT pk_findom_r_ula_tipol_beneficiari_bandi PRIMARY KEY (id_ula, id_tipol_beneficiario, id_bando);


--
-- TOC entry 56943 (class 2606 OID 31182045)
-- Name: findom_t_allegati_sportello pk_findom_t_allegati_sportello; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_t_allegati_sportello
    ADD CONSTRAINT pk_findom_t_allegati_sportello PRIMARY KEY (id);


--
-- TOC entry 56950 (class 2606 OID 31182047)
-- Name: findom_t_amministratori pk_findom_t_amministratori; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_t_amministratori
    ADD CONSTRAINT pk_findom_t_amministratori PRIMARY KEY (id_amministratore);


--
-- TOC entry 56957 (class 2606 OID 31182049)
-- Name: findom_t_bandi pk_findom_t_bandi; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_t_bandi
    ADD CONSTRAINT pk_findom_t_bandi PRIMARY KEY (id_bando);


--
-- TOC entry 56961 (class 2606 OID 31182051)
-- Name: findom_t_bonus_turismo pk_findom_t_bonus_turismo; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_t_bonus_turismo
    ADD CONSTRAINT pk_findom_t_bonus_turismo PRIMARY KEY (id_bonus_turismo);


--
-- TOC entry 56964 (class 2606 OID 31182053)
-- Name: findom_t_commissari pk_findom_t_commissari; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_t_commissari
    ADD CONSTRAINT pk_findom_t_commissari PRIMARY KEY (id_commissario);


--
-- TOC entry 56966 (class 2606 OID 31182055)
-- Name: findom_t_commissioni pk_findom_t_commissioni; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_t_commissioni
    ADD CONSTRAINT pk_findom_t_commissioni PRIMARY KEY (id_commissione);


--
-- TOC entry 56968 (class 2606 OID 31182057)
-- Name: findom_t_config_metadati pk_findom_t_config_metadati; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_t_config_metadati
    ADD CONSTRAINT pk_findom_t_config_metadati PRIMARY KEY (id_tipo_metadati);


--
-- TOC entry 56974 (class 2606 OID 31182059)
-- Name: findom_t_contrib_acq_veicoli pk_findom_t_contrib_acq_veicoli; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_t_contrib_acq_veicoli
    ADD CONSTRAINT pk_findom_t_contrib_acq_veicoli PRIMARY KEY (id_contrib_acq_veicoli);


--
-- TOC entry 56978 (class 2606 OID 31182061)
-- Name: findom_t_dich_presa_visione pk_findom_t_dich_presa_visione; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_t_dich_presa_visione
    ADD CONSTRAINT pk_findom_t_dich_presa_visione PRIMARY KEY (id_dich_presa_visione);


--
-- TOC entry 56982 (class 2606 OID 31182063)
-- Name: findom_t_documenti_commissione pk_findom_t_documenti_commissione; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_t_documenti_commissione
    ADD CONSTRAINT pk_findom_t_documenti_commissione PRIMARY KEY (id_documento_comm);


--
-- TOC entry 56985 (class 2606 OID 31182065)
-- Name: findom_t_param_sportelli_bandi pk_findom_t_param_sportelli_bandi; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_t_param_sportelli_bandi
    ADD CONSTRAINT pk_findom_t_param_sportelli_bandi PRIMARY KEY (id_param);


--
-- TOC entry 56993 (class 2606 OID 31182067)
-- Name: findom_t_parametri_valut pk_findom_t_parametri_valut; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_t_parametri_valut
    ADD CONSTRAINT pk_findom_t_parametri_valut PRIMARY KEY (id_parametro_valut);


--
-- TOC entry 56995 (class 2606 OID 31182069)
-- Name: findom_t_soggetti_abilitati pk_findom_t_soggetti_abilitati; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_t_soggetti_abilitati
    ADD CONSTRAINT pk_findom_t_soggetti_abilitati PRIMARY KEY (id_sogg_abil);


--
-- TOC entry 57002 (class 2606 OID 31182071)
-- Name: findom_t_soggetti_bonus_covid pk_findom_t_soggetti_bonus_covid; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_t_soggetti_bonus_covid
    ADD CONSTRAINT pk_findom_t_soggetti_bonus_covid PRIMARY KEY (id_soggetto_bonus_covid);


--
-- TOC entry 57006 (class 2606 OID 31182073)
-- Name: findom_t_soggetti_bonus_covid_dett pk_findom_t_soggetti_bonus_covid_dett; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_t_soggetti_bonus_covid_dett
    ADD CONSTRAINT pk_findom_t_soggetti_bonus_covid_dett PRIMARY KEY (id_soggetto_bonus_covid_dett);


--
-- TOC entry 57011 (class 2606 OID 31182075)
-- Name: findom_t_sportelli_bandi pk_findom_t_sportelli_bandi; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_t_sportelli_bandi
    ADD CONSTRAINT pk_findom_t_sportelli_bandi PRIMARY KEY (id_sportello_bando);


--
-- TOC entry 57013 (class 2606 OID 31182077)
-- Name: findom_t_sportelli_regole_param pk_findom_t_sportelli_regole_param; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_t_sportelli_regole_param
    ADD CONSTRAINT pk_findom_t_sportelli_regole_param PRIMARY KEY (id_srp);


--
-- TOC entry 57022 (class 2606 OID 31182079)
-- Name: findom_t_valori_sportello pk_findom_t_valori_sportello; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_t_valori_sportello
    ADD CONSTRAINT pk_findom_t_valori_sportello PRIMARY KEY (id);


--
-- TOC entry 57065 (class 2606 OID 31182081)
-- Name: istr_d_model_state pk_istr_d_model_state; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.istr_d_model_state
    ADD CONSTRAINT pk_istr_d_model_state PRIMARY KEY (model_state);


--
-- TOC entry 57069 (class 2606 OID 31182083)
-- Name: istr_t_model pk_istr_t_model; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.istr_t_model
    ADD CONSTRAINT pk_istr_t_model PRIMARY KEY (model_id);


--
-- TOC entry 57104 (class 2606 OID 31182085)
-- Name: istr_t_model_index pk_istr_t_model_index; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.istr_t_model_index
    ADD CONSTRAINT pk_istr_t_model_index PRIMARY KEY (model_id, index_id);


--
-- TOC entry 57106 (class 2606 OID 31182087)
-- Name: istr_t_rule pk_istr_t_rule; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.istr_t_rule
    ADD CONSTRAINT pk_istr_t_rule PRIMARY KEY (rule_id);


--
-- TOC entry 57110 (class 2606 OID 31182089)
-- Name: istr_t_submodel pk_istr_t_submodel; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.istr_t_submodel
    ADD CONSTRAINT pk_istr_t_submodel PRIMARY KEY (submodel_id);


--
-- TOC entry 57114 (class 2606 OID 31182091)
-- Name: istr_t_template pk_istr_t_template; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.istr_t_template
    ADD CONSTRAINT pk_istr_t_template PRIMARY KEY (template_id);


--
-- TOC entry 57118 (class 2606 OID 31182093)
-- Name: istr_t_template_index pk_istr_t_template_index; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.istr_t_template_index
    ADD CONSTRAINT pk_istr_t_template_index PRIMARY KEY (index_id);


--
-- TOC entry 57121 (class 2606 OID 31182095)
-- Name: log_t_batch pk_log_t_batch; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.log_t_batch
    ADD CONSTRAINT pk_log_t_batch PRIMARY KEY (id_log_batch);


--
-- TOC entry 57123 (class 2606 OID 31182097)
-- Name: log_t_firma_digitale pk_log_t_firma_digitale; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.log_t_firma_digitale
    ADD CONSTRAINT pk_log_t_firma_digitale PRIMARY KEY (id_log_firma);


--
-- TOC entry 57125 (class 2606 OID 31182099)
-- Name: log_t_protocollo pk_log_t_protocollo; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.log_t_protocollo
    ADD CONSTRAINT pk_log_t_protocollo PRIMARY KEY (id_log_protocollo);


--
-- TOC entry 57127 (class 2606 OID 31182103)
-- Name: shell_d_motivazione_esito pk_shell_d_motivazione_esito; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.shell_d_motivazione_esito
    ADD CONSTRAINT pk_shell_d_motivazione_esito PRIMARY KEY (id_motivazione_esito);


--
-- TOC entry 57129 (class 2606 OID 31182105)
-- Name: shell_r_capofila_acronimo_partner pk_shell_r_capofila_acronimo_partner; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.shell_r_capofila_acronimo_partner
    ADD CONSTRAINT pk_shell_r_capofila_acronimo_partner PRIMARY KEY (id_capofila_acronimo, id_partner);


--
-- TOC entry 57131 (class 2606 OID 31182107)
-- Name: shell_t_acronimo_bandi pk_shell_t_acronimo_bandi; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.shell_t_acronimo_bandi
    ADD CONSTRAINT pk_shell_t_acronimo_bandi PRIMARY KEY (id_acronimo_bando);


--
-- TOC entry 57136 (class 2606 OID 31182109)
-- Name: shell_t_capofila_acronimo pk_shell_t_capofila_acronimo; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.shell_t_capofila_acronimo
    ADD CONSTRAINT pk_shell_t_capofila_acronimo PRIMARY KEY (id_capofila_acronimo);


--
-- TOC entry 57091 (class 2606 OID 31182111)
-- Name: shell_t_dett_criteri_graduatoria pk_shell_t_dett_criteri_graduatoria; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.shell_t_dett_criteri_graduatoria
    ADD CONSTRAINT pk_shell_t_dett_criteri_graduatoria PRIMARY KEY (id_dett_criteri_graduatoria);


--
-- TOC entry 57081 (class 2606 OID 31182113)
-- Name: shell_t_dett_graduatoria pk_shell_t_dett_graduatoria; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.shell_t_dett_graduatoria
    ADD CONSTRAINT pk_shell_t_dett_graduatoria PRIMARY KEY (id_dett_graduatoria);


--
-- TOC entry 57050 (class 2606 OID 31182115)
-- Name: shell_t_documento_index pk_shell_t_documento_index; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.shell_t_documento_index
    ADD CONSTRAINT pk_shell_t_documento_index PRIMARY KEY (id_documento_index);


--
-- TOC entry 57057 (class 2606 OID 31182117)
-- Name: shell_t_documento_prot pk_shell_t_documento_prot; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.shell_t_documento_prot
    ADD CONSTRAINT pk_shell_t_documento_prot PRIMARY KEY (id_documento_index);


--
-- TOC entry 57037 (class 2606 OID 31182119)
-- Name: shell_t_domande pk_shell_t_domande; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.shell_t_domande
    ADD CONSTRAINT pk_shell_t_domande PRIMARY KEY (id_domanda);


--
-- TOC entry 57063 (class 2606 OID 31182121)
-- Name: shell_t_file_domande pk_shell_t_file_domande; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.shell_t_file_domande
    ADD CONSTRAINT pk_shell_t_file_domande PRIMARY KEY (id_file_domanda);


--
-- TOC entry 57044 (class 2606 OID 31182123)
-- Name: shell_t_graduatoria pk_shell_t_graduatoria; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.shell_t_graduatoria
    ADD CONSTRAINT pk_shell_t_graduatoria PRIMARY KEY (id_graduatoria);


--
-- TOC entry 57140 (class 2606 OID 31182125)
-- Name: shell_t_lock_graduatoria pk_shell_t_lock_graduatoria; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.shell_t_lock_graduatoria
    ADD CONSTRAINT pk_shell_t_lock_graduatoria PRIMARY KEY (id_lock);


--
-- TOC entry 57142 (class 2606 OID 31182127)
-- Name: shell_t_partner pk_shell_t_partner; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.shell_t_partner
    ADD CONSTRAINT pk_shell_t_partner PRIMARY KEY (id_partner);


--
-- TOC entry 57087 (class 2606 OID 31182129)
-- Name: shell_t_rimod_agev pk_shell_t_rimod_agev; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.shell_t_rimod_agev
    ADD CONSTRAINT pk_shell_t_rimod_agev PRIMARY KEY (id_domanda, tipo_rimodulazione);


--
-- TOC entry 57102 (class 2606 OID 31182131)
-- Name: shell_t_rimod_entrate pk_shell_t_rimod_entrate; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.shell_t_rimod_entrate
    ADD CONSTRAINT pk_shell_t_rimod_entrate PRIMARY KEY (id_rimod_entrate);


--
-- TOC entry 57096 (class 2606 OID 31182133)
-- Name: shell_t_rimod_spese pk_shell_t_rimod_spese; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.shell_t_rimod_spese
    ADD CONSTRAINT pk_shell_t_rimod_spese PRIMARY KEY (id_rimod_spese);


--
-- TOC entry 57055 (class 2606 OID 31182135)
-- Name: shell_t_soggetti pk_shell_t_soggetti; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.shell_t_soggetti
    ADD CONSTRAINT pk_shell_t_soggetti PRIMARY KEY (id_soggetto);


--
-- TOC entry 57074 (class 2606 OID 31182137)
-- Name: shell_t_valut_domande pk_shell_t_valut_domande; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.shell_t_valut_domande
    ADD CONSTRAINT pk_shell_t_valut_domande PRIMARY KEY (id_valutazione);


--
-- TOC entry 57144 (class 2606 OID 31182139)
-- Name: utl_d_fase pk_utl_d_fase; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.utl_d_fase
    ADD CONSTRAINT pk_utl_d_fase PRIMARY KEY (cod_fase);


--
-- TOC entry 57146 (class 2606 OID 31182141)
-- Name: utl_d_istanza pk_utl_d_istanza; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.utl_d_istanza
    ADD CONSTRAINT pk_utl_d_istanza PRIMARY KEY (id_utl_d_istanza);


--
-- TOC entry 57150 (class 2606 OID 31182143)
-- Name: utl_t_regola_routing pk_utl_t_regola_routing; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.utl_t_regola_routing
    ADD CONSTRAINT pk_utl_t_regola_routing PRIMARY KEY (it_utl_t_regola_routing);


--
-- TOC entry 56899 (class 2606 OID 31182147)
-- Name: findom_r_bandi_specifiche_valut tuc_findom_r_bandi_specifiche_valut_1; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_r_bandi_specifiche_valut
    ADD CONSTRAINT tuc_findom_r_bandi_specifiche_valut_1 UNIQUE (id_bando, id_regola);


--
-- TOC entry 56945 (class 2606 OID 31182149)
-- Name: findom_t_allegati_sportello tuc_findom_t_allegati_sportello_1; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_t_allegati_sportello
    ADD CONSTRAINT tuc_findom_t_allegati_sportello_1 UNIQUE (id_sportello_bando, id_tipol_beneficiario, id_allegato);


--
-- TOC entry 56987 (class 2606 OID 31182151)
-- Name: findom_t_param_sportelli_bandi tuc_findom_t_param_sportelli_bandi_1; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_t_param_sportelli_bandi
    ADD CONSTRAINT tuc_findom_t_param_sportelli_bandi_1 UNIQUE (id_sportello_bando, id_tipol_intervento, flag_pubblico_privato);


--
-- TOC entry 57015 (class 2606 OID 31182153)
-- Name: findom_t_sportelli_regole_param tuc_findom_t_sportelli_regole_param_1; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_t_sportelli_regole_param
    ADD CONSTRAINT tuc_findom_t_sportelli_regole_param_1 UNIQUE (id_sportello_bando, id_regola, id_parametro);


--
-- TOC entry 57024 (class 2606 OID 31182155)
-- Name: findom_t_valori_sportello tuc_findom_t_valori_sportello_1; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_t_valori_sportello
    ADD CONSTRAINT tuc_findom_t_valori_sportello_1 UNIQUE (id_sportello_bando, id_tipol_intervento, flag_pubblico_privato, id_tipol_beneficiario);


--
-- TOC entry 57133 (class 2606 OID 31182157)
-- Name: shell_t_acronimo_bandi tuc_shell_t_acronimo_bandi_1; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.shell_t_acronimo_bandi
    ADD CONSTRAINT tuc_shell_t_acronimo_bandi_1 UNIQUE (id_bando, acronimo_progetto, dt_disattivazione);


--
-- TOC entry 57138 (class 2606 OID 31182159)
-- Name: shell_t_capofila_acronimo tuc_shell_t_capofila_acronimo_1; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.shell_t_capofila_acronimo
    ADD CONSTRAINT tuc_shell_t_capofila_acronimo_1 UNIQUE (id_domanda, id_acronimo_bando);


--
-- TOC entry 56837 (class 2606 OID 31182161)
-- Name: findom_d_tipol_beneficiari uk_findom_d_tipol_beneficiari_1; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_d_tipol_beneficiari
    ADD CONSTRAINT uk_findom_d_tipol_beneficiari_1 UNIQUE (codice);


--
-- TOC entry 57083 (class 2606 OID 31182163)
-- Name: shell_t_dett_graduatoria uk_shell_t_dett_graduatoria_1; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.shell_t_dett_graduatoria
    ADD CONSTRAINT uk_shell_t_dett_graduatoria_1 UNIQUE (id_graduatoria, posizione);


--
-- TOC entry 57085 (class 2606 OID 31182165)
-- Name: shell_t_dett_graduatoria uk_shell_t_dett_graduatoria_2; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.shell_t_dett_graduatoria
    ADD CONSTRAINT uk_shell_t_dett_graduatoria_2 UNIQUE (id_domanda, id_graduatoria);


--
-- TOC entry 56719 (class 2606 OID 31182167)
-- Name: findom_d_covid_message uq_findom_d_covid_message_message_code; Type: CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_d_covid_message
    ADD CONSTRAINT uq_findom_d_covid_message_message_code UNIQUE (message_code);

-- TOC entry 57188 (class 2606 OID 31182280)
-- Name: findom_r_bandi_forme_finanziamenti findom_d_forme_finanziamenti_1; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_r_bandi_forme_finanziamenti
    ADD CONSTRAINT findom_d_forme_finanziamenti_1 FOREIGN KEY (id_forma_finanziamento) REFERENCES findom_os.findom_d_forme_finanziamenti(id_forma_finanziamento);


--
-- TOC entry 57286 (class 2606 OID 31182285)
-- Name: shell_t_graduatoria findom_t_sportelli_bandi_shell_t_graduatoria; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.shell_t_graduatoria
    ADD CONSTRAINT findom_t_sportelli_bandi_shell_t_graduatoria FOREIGN KEY (id_sportello_bando) REFERENCES findom_os.findom_t_sportelli_bandi(id_sportello_bando);


--
-- TOC entry 57152 (class 2606 OID 31182290)
-- Name: aggr_t_model fk_aggr_d_model_state_01; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.aggr_t_model
    ADD CONSTRAINT fk_aggr_d_model_state_01 FOREIGN KEY (model_state_fk) REFERENCES findom_os.aggr_d_model_state(model_state);


--
-- TOC entry 57157 (class 2606 OID 31182295)
-- Name: aggr_t_submodel fk_aggr_t_model_01; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.aggr_t_submodel
    ADD CONSTRAINT fk_aggr_t_model_01 FOREIGN KEY (model_id) REFERENCES findom_os.aggr_t_model(model_id);


--
-- TOC entry 57280 (class 2606 OID 31182300)
-- Name: shell_t_domande fk_aggr_t_model_1; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.shell_t_domande
    ADD CONSTRAINT fk_aggr_t_model_1 FOREIGN KEY (id_domanda) REFERENCES findom_os.aggr_t_model(model_id);


--
-- TOC entry 57154 (class 2606 OID 31182305)
-- Name: aggr_t_model_index fk_aggr_t_model_2; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.aggr_t_model_index
    ADD CONSTRAINT fk_aggr_t_model_2 FOREIGN KEY (model_id) REFERENCES findom_os.aggr_t_model(model_id);


--
-- TOC entry 57156 (class 2606 OID 31182310)
-- Name: aggr_t_submodel fk_aggr_t_template_01; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.aggr_t_submodel
    ADD CONSTRAINT fk_aggr_t_template_01 FOREIGN KEY (template_code_fk) REFERENCES findom_os.aggr_t_template(template_code);


--
-- TOC entry 57158 (class 2606 OID 31182315)
-- Name: aggr_t_template_index fk_aggr_t_template_1; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.aggr_t_template_index
    ADD CONSTRAINT fk_aggr_t_template_1 FOREIGN KEY (template_fk) REFERENCES findom_os.aggr_t_template(template_id);


--
-- TOC entry 57151 (class 2606 OID 31182320)
-- Name: aggr_t_model fk_aggr_t_template_2; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.aggr_t_model
    ADD CONSTRAINT fk_aggr_t_template_2 FOREIGN KEY (template_code_fk) REFERENCES findom_os.aggr_t_template(template_code);


--
-- TOC entry 57243 (class 2606 OID 31182325)
-- Name: findom_t_bandi fk_aggr_t_template_3; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_t_bandi
    ADD CONSTRAINT fk_aggr_t_template_3 FOREIGN KEY (template_id) REFERENCES findom_os.aggr_t_template(template_id);


--
-- TOC entry 57155 (class 2606 OID 31182330)
-- Name: aggr_t_rule fk_aggr_t_template_4; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.aggr_t_rule
    ADD CONSTRAINT fk_aggr_t_template_4 FOREIGN KEY (template_code_fk) REFERENCES findom_os.aggr_t_template(template_code);


--
-- TOC entry 57153 (class 2606 OID 31182335)
-- Name: aggr_t_model_index fk_aggr_t_template_index_01; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.aggr_t_model_index
    ADD CONSTRAINT fk_aggr_t_template_index_01 FOREIGN KEY (index_id) REFERENCES findom_os.aggr_t_template_index(index_id);


--
-- TOC entry 57179 (class 2606 OID 31182340)
-- Name: findom_r_bandi_ateco fk_ext_d_ateco_1; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_r_bandi_ateco
    ADD CONSTRAINT fk_ext_d_ateco_1 FOREIGN KEY (id_ateco) REFERENCES findom_os.ext_d_ateco(id_ateco);


--
-- TOC entry 57181 (class 2606 OID 31182345)
-- Name: findom_r_bandi_ateco_escl fk_ext_d_ateco_2; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_r_bandi_ateco_escl
    ADD CONSTRAINT fk_ext_d_ateco_2 FOREIGN KEY (id_ateco) REFERENCES findom_os.ext_d_ateco(id_ateco);


--
-- TOC entry 57291 (class 2606 OID 31182350)
-- Name: shell_t_soggetti fk_ext_d_forme_giuridiche_1; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.shell_t_soggetti
    ADD CONSTRAINT fk_ext_d_forme_giuridiche_1 FOREIGN KEY (id_forma_giuridica) REFERENCES findom_os.ext_d_forme_giuridiche(id_forma_giuridica);


--
-- TOC entry 57226 (class 2606 OID 31182355)
-- Name: findom_r_tipi_rottamaz_alimentaz_veicoli fk_findom_d_alimentazione_veicoli_1; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_r_tipi_rottamaz_alimentaz_veicoli
    ADD CONSTRAINT fk_findom_d_alimentazione_veicoli_1 FOREIGN KEY (id_aliment_veicolo) REFERENCES findom_os.findom_d_alimentazione_veicoli(id_aliment_veicolo);


--
-- TOC entry 57177 (class 2606 OID 31182360)
-- Name: findom_r_bandi_allegati fk_findom_d_allegati_1; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_r_bandi_allegati
    ADD CONSTRAINT fk_findom_d_allegati_1 FOREIGN KEY (id_allegato) REFERENCES findom_os.findom_d_allegati(id_allegato);


--
-- TOC entry 57290 (class 2606 OID 31182365)
-- Name: shell_t_documento_index fk_findom_d_allegati_1; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.shell_t_documento_index
    ADD CONSTRAINT fk_findom_d_allegati_1 FOREIGN KEY (id_allegato) REFERENCES findom_os.findom_d_allegati(id_allegato);


--
-- TOC entry 57242 (class 2606 OID 31182370)
-- Name: findom_t_bandi fk_findom_d_area_tematica_1; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_t_bandi
    ADD CONSTRAINT fk_findom_d_area_tematica_1 FOREIGN KEY (id_area_tematica) REFERENCES findom_os.findom_d_area_tematica(id_area_tematica);


--
-- TOC entry 57223 (class 2606 OID 31182375)
-- Name: findom_r_stato_azioni_istruttoria fk_findom_d_azioni_istruttoria_1; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_r_stato_azioni_istruttoria
    ADD CONSTRAINT fk_findom_d_azioni_istruttoria_1 FOREIGN KEY (id_azione) REFERENCES findom_os.findom_d_azioni_istruttoria(id_azione);


--
-- TOC entry 57164 (class 2606 OID 31182380)
-- Name: findom_d_dett_tipol_interventi fk_findom_d_campi_intervento_1; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_d_dett_tipol_interventi
    ADD CONSTRAINT fk_findom_d_campi_intervento_1 FOREIGN KEY (id_campo_intervento) REFERENCES findom_os.findom_d_campi_intervento(id_campo_intervento);


--
-- TOC entry 57173 (class 2606 OID 31182385)
-- Name: findom_d_tipol_interventi fk_findom_d_campi_intervento_2; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_d_tipol_interventi
    ADD CONSTRAINT fk_findom_d_campi_intervento_2 FOREIGN KEY (id_campo_intervento) REFERENCES findom_os.findom_d_campi_intervento(id_campo_intervento);


--
-- TOC entry 57248 (class 2606 OID 31182390)
-- Name: findom_t_contrib_acq_veicoli fk_findom_d_categ_veicoli_1; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_t_contrib_acq_veicoli
    ADD CONSTRAINT fk_findom_d_categ_veicoli_1 FOREIGN KEY (id_categ_veicolo) REFERENCES findom_os.findom_d_categ_veicoli(id_categ_veicolo);


--
-- TOC entry 57229 (class 2606 OID 31182395)
-- Name: findom_r_tipi_rottamaz_categ_veicoli fk_findom_d_categ_veicoli_2; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_r_tipi_rottamaz_categ_veicoli
    ADD CONSTRAINT fk_findom_d_categ_veicoli_2 FOREIGN KEY (id_categ_veicolo) REFERENCES findom_os.findom_d_categ_veicoli(id_categ_veicolo);


--
-- TOC entry 57175 (class 2606 OID 31182400)
-- Name: findom_d_voci_spesa fk_findom_d_categ_voci_spesa_1; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_d_voci_spesa
    ADD CONSTRAINT fk_findom_d_categ_voci_spesa_1 FOREIGN KEY (id_categ_voce_spesa) REFERENCES findom_os.findom_d_categ_voci_spesa(id_categ_voce_spesa);


--
-- TOC entry 57241 (class 2606 OID 31182405)
-- Name: findom_t_bandi fk_findom_d_classif_bandi_1; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_t_bandi
    ADD CONSTRAINT fk_findom_d_classif_bandi_1 FOREIGN KEY (id_classificazione) REFERENCES findom_os.findom_d_classif_bandi(id_classificazione);


--
-- TOC entry 57161 (class 2606 OID 31182410)
-- Name: findom_d_classif_bandi fk_findom_d_classif_bandi_3; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_d_classif_bandi
    ADD CONSTRAINT fk_findom_d_classif_bandi_3 FOREIGN KEY (id_classificazione_padre) REFERENCES findom_os.findom_d_classif_bandi(id_classificazione);


--
-- TOC entry 57259 (class 2606 OID 31182415)
-- Name: findom_t_soggetti_bonus_covid_dett fk_findom_d_covid_testi_1; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_t_soggetti_bonus_covid_dett
    ADD CONSTRAINT fk_findom_d_covid_testi_1 FOREIGN KEY (id_testo_tratt_dati) REFERENCES findom_os.findom_d_covid_testi(id_testo);


--
-- TOC entry 57171 (class 2606 OID 31182420)
-- Name: findom_d_specifiche_valut fk_findom_d_criteri_valut_1; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_d_specifiche_valut
    ADD CONSTRAINT fk_findom_d_criteri_valut_1 FOREIGN KEY (id_criterio) REFERENCES findom_os.findom_d_criteri_valut(id_criterio);


--
-- TOC entry 57184 (class 2606 OID 31182425)
-- Name: findom_r_bandi_criteri_valut fk_findom_d_criteri_valut_2; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_r_bandi_criteri_valut
    ADD CONSTRAINT fk_findom_d_criteri_valut_2 FOREIGN KEY (id_criterio) REFERENCES findom_os.findom_d_criteri_valut(id_criterio);


--
-- TOC entry 57305 (class 2606 OID 31182435)
-- Name: shell_t_dett_criteri_graduatoria fk_findom_d_criteri_valut_3; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.shell_t_dett_criteri_graduatoria
    ADD CONSTRAINT fk_findom_d_criteri_valut_3 FOREIGN KEY (id_criterio) REFERENCES findom_os.findom_d_criteri_valut(id_criterio);


--
-- TOC entry 57186 (class 2606 OID 31182440)
-- Name: findom_r_bandi_dett_tipol_aiuti fk_findom_d_dett_tipol_aiuti_1; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_r_bandi_dett_tipol_aiuti
    ADD CONSTRAINT fk_findom_d_dett_tipol_aiuti_1 FOREIGN KEY (id_dett_tipol_aiuti) REFERENCES findom_os.findom_d_dett_tipol_aiuti(id_dett_tipol_aiuti);


--
-- TOC entry 57215 (class 2606 OID 31182445)
-- Name: findom_r_dett_tipol_interventi_voci_spesa fk_findom_d_dett_tipol_interventi_1; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_r_dett_tipol_interventi_voci_spesa
    ADD CONSTRAINT fk_findom_d_dett_tipol_interventi_1 FOREIGN KEY (id_dett_tipol_intervento) REFERENCES findom_os.findom_d_dett_tipol_interventi(id_dett_tipol_intervento);


--
-- TOC entry 57217 (class 2606 OID 31182450)
-- Name: findom_r_funzionari_direzioni fk_findom_d_direzioni_1; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_r_funzionari_direzioni
    ADD CONSTRAINT fk_findom_d_direzioni_1 FOREIGN KEY (id_direzione) REFERENCES findom_os.findom_d_direzioni(id_direzione);


--
-- TOC entry 57170 (class 2606 OID 31182455)
-- Name: findom_d_settori fk_findom_d_direzioni_2; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_d_settori
    ADD CONSTRAINT fk_findom_d_direzioni_2 FOREIGN KEY (id_direzione) REFERENCES findom_os.findom_d_direzioni(id_direzione);


--
-- TOC entry 57253 (class 2606 OID 31182460)
-- Name: findom_t_documenti_commissione fk_findom_d_documenti_istruttoria_1; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_t_documenti_commissione
    ADD CONSTRAINT fk_findom_d_documenti_istruttoria_1 FOREIGN KEY (id_documento_istr) REFERENCES findom_os.findom_d_documenti_istruttoria(id_documento_istr);


--
-- TOC entry 57247 (class 2606 OID 31182465)
-- Name: findom_t_contrib_acq_veicoli fk_findom_d_emissioni_veicoli_1; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_t_contrib_acq_veicoli
    ADD CONSTRAINT fk_findom_d_emissioni_veicoli_1 FOREIGN KEY (id_emissione) REFERENCES findom_os.findom_d_emissioni_veicoli(id_emissione);


--
-- TOC entry 57240 (class 2606 OID 31182470)
-- Name: findom_t_bandi fk_findom_d_enti_1; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_t_bandi
    ADD CONSTRAINT fk_findom_d_enti_1 FOREIGN KEY (id_ente_destinatario) REFERENCES findom_os.findom_d_enti(id_ente);


--
-- TOC entry 57237 (class 2606 OID 31182475)
-- Name: findom_t_amministratori fk_findom_d_enti_2; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_t_amministratori
    ADD CONSTRAINT fk_findom_d_enti_2 FOREIGN KEY (id_ente_appartenenza) REFERENCES findom_os.findom_d_enti(id_ente);


--
-- TOC entry 57165 (class 2606 OID 31182480)
-- Name: findom_d_dipartimenti fk_findom_d_enti_strutturati_1; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_d_dipartimenti
    ADD CONSTRAINT fk_findom_d_enti_strutturati_1 FOREIGN KEY (id_ente_strutt) REFERENCES findom_os.findom_d_enti_strutturati(id_ente_strutt);


--
-- TOC entry 57216 (class 2606 OID 31182485)
-- Name: findom_r_funzionari_direzioni fk_findom_d_funzionari_1; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_r_funzionari_direzioni
    ADD CONSTRAINT fk_findom_d_funzionari_1 FOREIGN KEY (id_funzionario) REFERENCES findom_os.findom_d_funzionari(id_funzionario);


--
-- TOC entry 57244 (class 2606 OID 31182490)
-- Name: findom_t_commissari fk_findom_d_funzionari_1; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_t_commissari
    ADD CONSTRAINT fk_findom_d_funzionari_1 FOREIGN KEY (id_funzionario) REFERENCES findom_os.findom_d_funzionari(id_funzionario);


--
-- TOC entry 57219 (class 2606 OID 31182495)
-- Name: findom_r_funzionari_settori fk_findom_d_funzionari_2; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_r_funzionari_settori
    ADD CONSTRAINT fk_findom_d_funzionari_2 FOREIGN KEY (id_funzionario) REFERENCES findom_os.findom_d_funzionari(id_funzionario);


--
-- TOC entry 57279 (class 2606 OID 31182500)
-- Name: shell_t_domande fk_findom_d_funzionari_3; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.shell_t_domande
    ADD CONSTRAINT fk_findom_d_funzionari_3 FOREIGN KEY (id_istruttore_amm) REFERENCES findom_os.findom_d_funzionari(id_funzionario);


--
-- TOC entry 57278 (class 2606 OID 31182505)
-- Name: shell_t_domande fk_findom_d_funzionari_4; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.shell_t_domande
    ADD CONSTRAINT fk_findom_d_funzionari_4 FOREIGN KEY (id_decisore) REFERENCES findom_os.findom_d_funzionari(id_funzionario);


--
-- TOC entry 57285 (class 2606 OID 31182510)
-- Name: shell_t_graduatoria fk_findom_d_funzionari_5; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.shell_t_graduatoria
    ADD CONSTRAINT fk_findom_d_funzionari_5 FOREIGN KEY (id_funzionario) REFERENCES findom_os.findom_d_funzionari(id_funzionario);


--
-- TOC entry 57277 (class 2606 OID 31182515)
-- Name: shell_t_domande fk_findom_d_funzionari_5; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.shell_t_domande
    ADD CONSTRAINT fk_findom_d_funzionari_5 FOREIGN KEY (id_funzionario_integrazione) REFERENCES findom_os.findom_d_funzionari(id_funzionario);


--
-- TOC entry 57213 (class 2606 OID 31182520)
-- Name: findom_r_commissioni_commissari fk_findom_d_incarichi_1; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_r_commissioni_commissari
    ADD CONSTRAINT fk_findom_d_incarichi_1 FOREIGN KEY (id_incarico) REFERENCES findom_os.findom_d_incarichi(id_incarico);


--
-- TOC entry 57190 (class 2606 OID 31182525)
-- Name: findom_r_bandi_indicatori fk_findom_d_indicatori_1; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_r_bandi_indicatori
    ADD CONSTRAINT fk_findom_d_indicatori_1 FOREIGN KEY (id_indicatore) REFERENCES findom_os.findom_d_indicatori(id_indicatore);


--
-- TOC entry 57192 (class 2606 OID 31182530)
-- Name: findom_r_bandi_motivazioni_esito fk_findom_d_motivazione_esito_1; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_r_bandi_motivazioni_esito
    ADD CONSTRAINT fk_findom_d_motivazione_esito_1 FOREIGN KEY (id_motivazione_esito) REFERENCES findom_os.findom_d_motivazione_esito(id_motivazione_esito);


--
-- TOC entry 57303 (class 2606 OID 31182535)
-- Name: shell_t_dett_graduatoria fk_findom_d_motivazione_esito_2; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.shell_t_dett_graduatoria
    ADD CONSTRAINT fk_findom_d_motivazione_esito_2 FOREIGN KEY (id_motivazione_esito) REFERENCES findom_os.findom_d_motivazione_esito(id_motivazione_esito);


--
-- TOC entry 57276 (class 2606 OID 31182540)
-- Name: shell_t_domande fk_findom_d_motivazione_esito_3; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.shell_t_domande
    ADD CONSTRAINT fk_findom_d_motivazione_esito_3 FOREIGN KEY (id_motivazione_esito) REFERENCES findom_os.findom_d_motivazione_esito(id_motivazione_esito);


--
-- TOC entry 57160 (class 2606 OID 31182545)
-- Name: findom_d_classif_bandi fk_findom_d_normative_1; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_d_classif_bandi
    ADD CONSTRAINT fk_findom_d_normative_1 FOREIGN KEY (id_normativa) REFERENCES findom_os.findom_d_normative(id_normativa);


--
-- TOC entry 57195 (class 2606 OID 31182550)
-- Name: findom_r_bandi_parametri_regole fk_findom_d_parametri_1; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_r_bandi_parametri_regole
    ADD CONSTRAINT fk_findom_d_parametri_1 FOREIGN KEY (id_parametro) REFERENCES findom_os.findom_d_parametri(id_parametro);


--
-- TOC entry 57263 (class 2606 OID 31182555)
-- Name: findom_t_sportelli_regole_param fk_findom_d_parametri_2; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_t_sportelli_regole_param
    ADD CONSTRAINT fk_findom_d_parametri_2 FOREIGN KEY (id_parametro) REFERENCES findom_os.findom_d_parametri(id_parametro);


--
-- TOC entry 57257 (class 2606 OID 31182560)
-- Name: findom_t_parametri_valut fk_findom_d_parametri_specifiche_valut_1; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_t_parametri_valut
    ADD CONSTRAINT fk_findom_d_parametri_specifiche_valut_1 FOREIGN KEY (id_parametro) REFERENCES findom_os.findom_d_parametri_specifiche_valut(id_parametro);


--
-- TOC entry 57197 (class 2606 OID 31182570)
-- Name: findom_r_bandi_premialita fk_findom_d_premialita_1; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_r_bandi_premialita
    ADD CONSTRAINT fk_findom_d_premialita_1 FOREIGN KEY (id_premialita) REFERENCES findom_os.findom_d_premialita(id_premialita);


--
-- TOC entry 57194 (class 2606 OID 31182575)
-- Name: findom_r_bandi_parametri_regole fk_findom_d_regole_1; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_r_bandi_parametri_regole
    ADD CONSTRAINT fk_findom_d_regole_1 FOREIGN KEY (id_regola) REFERENCES findom_os.findom_d_regole(id_regola);


--
-- TOC entry 57199 (class 2606 OID 31182580)
-- Name: findom_r_bandi_regole fk_findom_d_regole_2; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_r_bandi_regole
    ADD CONSTRAINT fk_findom_d_regole_2 FOREIGN KEY (id_regola) REFERENCES findom_os.findom_d_regole(id_regola);


--
-- TOC entry 57262 (class 2606 OID 31182585)
-- Name: findom_t_sportelli_regole_param fk_findom_d_regole_2; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_t_sportelli_regole_param
    ADD CONSTRAINT fk_findom_d_regole_2 FOREIGN KEY (id_regola) REFERENCES findom_os.findom_d_regole(id_regola);


--
-- TOC entry 57204 (class 2606 OID 31182590)
-- Name: findom_r_bandi_specifiche_valut fk_findom_d_regole_3; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_r_bandi_specifiche_valut
    ADD CONSTRAINT fk_findom_d_regole_3 FOREIGN KEY (id_regola) REFERENCES findom_os.findom_d_regole(id_regola);


--
-- TOC entry 57166 (class 2606 OID 31182600)
-- Name: findom_d_funzionari fk_findom_d_ruoli_istr_1; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_d_funzionari
    ADD CONSTRAINT fk_findom_d_ruoli_istr_1 FOREIGN KEY (id_ruolo) REFERENCES findom_os.findom_d_ruoli_istr(id_ruolo);


--
-- TOC entry 57239 (class 2606 OID 31182605)
-- Name: findom_t_bandi fk_findom_d_settori_1; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_t_bandi
    ADD CONSTRAINT fk_findom_d_settori_1 FOREIGN KEY (id_settore) REFERENCES findom_os.findom_d_settori(id_settore);


--
-- TOC entry 57218 (class 2606 OID 31182610)
-- Name: findom_r_funzionari_settori fk_findom_d_settori_2; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_r_funzionari_settori
    ADD CONSTRAINT fk_findom_d_settori_2 FOREIGN KEY (id_settore) REFERENCES findom_os.findom_d_settori(id_settore);


--
-- TOC entry 57293 (class 2606 OID 31182615)
-- Name: shell_t_documento_prot fk_findom_d_sistema_protocollo_1; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.shell_t_documento_prot
    ADD CONSTRAINT fk_findom_d_sistema_protocollo_1 FOREIGN KEY (id_sistema_prot) REFERENCES findom_os.findom_d_sistema_protocollo(id_sistema_prot);


--
-- TOC entry 57203 (class 2606 OID 31182620)
-- Name: findom_r_bandi_specifiche_valut fk_findom_d_specifiche_valut_1; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_r_bandi_specifiche_valut
    ADD CONSTRAINT fk_findom_d_specifiche_valut_1 FOREIGN KEY (id_specifica) REFERENCES findom_os.findom_d_specifiche_valut(id_specifica);


--
-- TOC entry 57289 (class 2606 OID 31182630)
-- Name: shell_t_documento_index fk_findom_d_stato_documento_index_1; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.shell_t_documento_index
    ADD CONSTRAINT fk_findom_d_stato_documento_index_1 FOREIGN KEY (id_stato_documento_index) REFERENCES findom_os.findom_d_stato_documento_index(id_stato_documento_index);


--
-- TOC entry 57275 (class 2606 OID 31182635)
-- Name: shell_t_domande fk_findom_d_stato_istruttoria_1; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.shell_t_domande
    ADD CONSTRAINT fk_findom_d_stato_istruttoria_1 FOREIGN KEY (id_stato_istr) REFERENCES findom_os.findom_d_stato_istruttoria(id_stato_istr);


--
-- TOC entry 57222 (class 2606 OID 31182640)
-- Name: findom_r_stato_azioni_istruttoria fk_findom_d_stato_istruttoria_2; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_r_stato_azioni_istruttoria
    ADD CONSTRAINT fk_findom_d_stato_istruttoria_2 FOREIGN KEY (id_stato_istr) REFERENCES findom_os.findom_d_stato_istruttoria(id_stato_istr);


--
-- TOC entry 57302 (class 2606 OID 31182645)
-- Name: shell_t_dett_graduatoria fk_findom_d_stato_istruttoria_3; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.shell_t_dett_graduatoria
    ADD CONSTRAINT fk_findom_d_stato_istruttoria_3 FOREIGN KEY (id_stato_istr) REFERENCES findom_os.findom_d_stato_istruttoria(id_stato_istr);


--
-- TOC entry 57172 (class 2606 OID 31182650)
-- Name: findom_d_tipol_beneficiari fk_findom_d_stereotipi_1; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_d_tipol_beneficiari
    ADD CONSTRAINT fk_findom_d_stereotipi_1 FOREIGN KEY (cod_stereotipo) REFERENCES findom_os.findom_d_stereotipi(cod_stereotipo);


--
-- TOC entry 57167 (class 2606 OID 31182655)
-- Name: findom_d_indicatori fk_findom_d_tipi_indicatori_1; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_d_indicatori
    ADD CONSTRAINT fk_findom_d_tipi_indicatori_1 FOREIGN KEY (id_tipo_indicatore) REFERENCES findom_os.findom_d_tipi_indicatori(id_tipo_indicatore);


--
-- TOC entry 57169 (class 2606 OID 31182660)
-- Name: findom_d_regole fk_findom_d_tipi_regole_1; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_d_regole
    ADD CONSTRAINT fk_findom_d_tipi_regole_1 FOREIGN KEY (id_tipo_regola) REFERENCES findom_os.findom_d_tipi_regole(id_tipo_regola);


--
-- TOC entry 57228 (class 2606 OID 31182665)
-- Name: findom_r_tipi_rottamaz_categ_veicoli fk_findom_d_tipi_rottamazione_1; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_r_tipi_rottamaz_categ_veicoli
    ADD CONSTRAINT fk_findom_d_tipi_rottamazione_1 FOREIGN KEY (id_tipo_rottamazione) REFERENCES findom_os.findom_d_tipi_rottamazione(id_tipo_rottamazione);


--
-- TOC entry 57225 (class 2606 OID 31182670)
-- Name: findom_r_tipi_rottamaz_alimentaz_veicoli fk_findom_d_tipi_rottamazione_1; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_r_tipi_rottamaz_alimentaz_veicoli
    ADD CONSTRAINT fk_findom_d_tipi_rottamazione_1 FOREIGN KEY (id_tipo_rottamazione) REFERENCES findom_os.findom_d_tipi_rottamazione(id_tipo_rottamazione);


--
-- TOC entry 57159 (class 2606 OID 31182675)
-- Name: findom_d_classif_bandi fk_findom_d_tipi_suddivisione_1; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_d_classif_bandi
    ADD CONSTRAINT fk_findom_d_tipi_suddivisione_1 FOREIGN KEY (id_tipo_suddivisione) REFERENCES findom_os.findom_d_tipi_suddivisione(id_tipo_suddivisione);


--
-- TOC entry 57268 (class 2606 OID 31182680)
-- Name: findom_t_valori_sportello fk_findom_d_tipo_graduatoria_1; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_t_valori_sportello
    ADD CONSTRAINT fk_findom_d_tipo_graduatoria_1 FOREIGN KEY (id_tipo_graduatoria) REFERENCES findom_os.findom_d_tipo_graduatoria(id_tipo_graduatoria);


--
-- TOC entry 57162 (class 2606 OID 31182685)
-- Name: findom_d_dett_tipol_aiuti fk_findom_d_tipol_aiuti_2; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_d_dett_tipol_aiuti
    ADD CONSTRAINT fk_findom_d_tipol_aiuti_2 FOREIGN KEY (id_tipol_aiuto) REFERENCES findom_os.findom_d_tipol_aiuti(id_tipol_aiuto);


--
-- TOC entry 57231 (class 2606 OID 31182690)
-- Name: findom_r_tipol_beneficiari_bandi fk_findom_d_tipol_beneficiari_1; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_r_tipol_beneficiari_bandi
    ADD CONSTRAINT fk_findom_d_tipol_beneficiari_1 FOREIGN KEY (id_tipol_beneficiario) REFERENCES findom_os.findom_d_tipol_beneficiari(id_tipol_beneficiario);


--
-- TOC entry 57274 (class 2606 OID 31182695)
-- Name: shell_t_domande fk_findom_d_tipol_beneficiari_2; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.shell_t_domande
    ADD CONSTRAINT fk_findom_d_tipol_beneficiari_2 FOREIGN KEY (id_tipol_beneficiario) REFERENCES findom_os.findom_d_tipol_beneficiari(id_tipol_beneficiario);


--
-- TOC entry 57284 (class 2606 OID 31182700)
-- Name: shell_t_graduatoria fk_findom_d_tipol_beneficiari_3; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.shell_t_graduatoria
    ADD CONSTRAINT fk_findom_d_tipol_beneficiari_3 FOREIGN KEY (id_tipol_beneficiario) REFERENCES findom_os.findom_d_tipol_beneficiari(id_tipol_beneficiario);


--
-- TOC entry 57267 (class 2606 OID 31182705)
-- Name: findom_t_valori_sportello fk_findom_d_tipol_beneficiari_4; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_t_valori_sportello
    ADD CONSTRAINT fk_findom_d_tipol_beneficiari_4 FOREIGN KEY (id_tipol_beneficiario) REFERENCES findom_os.findom_d_tipol_beneficiari(id_tipol_beneficiario);


--
-- TOC entry 57266 (class 2606 OID 31182710)
-- Name: findom_t_valori_sportello fk_findom_d_tipol_beneficiari_5; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_t_valori_sportello
    ADD CONSTRAINT fk_findom_d_tipol_beneficiari_5 FOREIGN KEY (id_tipol_beneficiario) REFERENCES findom_os.findom_d_tipol_beneficiari(id_tipol_beneficiario);


--
-- TOC entry 57255 (class 2606 OID 31182715)
-- Name: findom_t_param_sportelli_bandi fk_findom_d_tipol_interventi_2; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_t_param_sportelli_bandi
    ADD CONSTRAINT fk_findom_d_tipol_interventi_2 FOREIGN KEY (id_tipol_intervento) REFERENCES findom_os.findom_d_tipol_interventi(id_tipol_intervento);


--
-- TOC entry 57265 (class 2606 OID 31182720)
-- Name: findom_t_valori_sportello fk_findom_d_tipol_interventi_2; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_t_valori_sportello
    ADD CONSTRAINT fk_findom_d_tipol_interventi_2 FOREIGN KEY (id_tipol_intervento) REFERENCES findom_os.findom_d_tipol_interventi(id_tipol_intervento);


--
-- TOC entry 57233 (class 2606 OID 31182725)
-- Name: findom_r_tipol_interventi_voci_spesa fk_findom_d_tipol_interventi_3; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_r_tipol_interventi_voci_spesa
    ADD CONSTRAINT fk_findom_d_tipol_interventi_3 FOREIGN KEY (id_tipol_intervento) REFERENCES findom_os.findom_d_tipol_interventi(id_tipol_intervento);


--
-- TOC entry 57206 (class 2606 OID 31182730)
-- Name: findom_r_bandi_tipol_interventi fk_findom_d_tipol_interventi_4; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_r_bandi_tipol_interventi
    ADD CONSTRAINT fk_findom_d_tipol_interventi_4 FOREIGN KEY (id_tipol_intervento) REFERENCES findom_os.findom_d_tipol_interventi(id_tipol_intervento);


--
-- TOC entry 57163 (class 2606 OID 31182735)
-- Name: findom_d_dett_tipol_interventi fk_findom_d_tipol_interventi_5; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_d_dett_tipol_interventi
    ADD CONSTRAINT fk_findom_d_tipol_interventi_5 FOREIGN KEY (id_tipol_intervento) REFERENCES findom_os.findom_d_tipol_interventi(id_tipol_intervento);


--
-- TOC entry 57283 (class 2606 OID 31182740)
-- Name: shell_t_graduatoria fk_findom_d_tipol_interventi_6; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.shell_t_graduatoria
    ADD CONSTRAINT fk_findom_d_tipol_interventi_6 FOREIGN KEY (id_tipol_intervento) REFERENCES findom_os.findom_d_tipol_interventi(id_tipol_intervento);


--
-- TOC entry 57183 (class 2606 OID 31182745)
-- Name: findom_r_bandi_criteri_valut fk_findom_d_tipol_interventi_7; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_r_bandi_criteri_valut
    ADD CONSTRAINT fk_findom_d_tipol_interventi_7 FOREIGN KEY (id_tipol_intervento) REFERENCES findom_os.findom_d_tipol_interventi(id_tipol_intervento);


--
-- TOC entry 57174 (class 2606 OID 31182755)
-- Name: findom_d_voci_spesa fk_findom_d_tipol_voci_spesa_1; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_d_voci_spesa
    ADD CONSTRAINT fk_findom_d_tipol_voci_spesa_1 FOREIGN KEY (id_tipol_voce_spesa) REFERENCES findom_os.findom_d_tipol_voci_spesa(id_tipol_voce_spesa);


--
-- TOC entry 57235 (class 2606 OID 31182760)
-- Name: findom_r_ula_tipol_beneficiari_bandi fk_findom_d_ula_1; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_r_ula_tipol_beneficiari_bandi
    ADD CONSTRAINT fk_findom_d_ula_1 FOREIGN KEY (id_ula) REFERENCES findom_os.findom_d_ula(id_ula);


--
-- TOC entry 57208 (class 2606 OID 31182765)
-- Name: findom_r_bandi_valoriz_econom fk_findom_d_valoriz_econom_1; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_r_bandi_valoriz_econom
    ADD CONSTRAINT fk_findom_d_valoriz_econom_1 FOREIGN KEY (id_valoriz_econom) REFERENCES findom_os.findom_d_valoriz_econom(id_valoriz_econom);


--
-- TOC entry 57210 (class 2606 OID 31182770)
-- Name: findom_r_bandi_voci_entrata fk_findom_d_voci_entrata_1; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_r_bandi_voci_entrata
    ADD CONSTRAINT fk_findom_d_voci_entrata_1 FOREIGN KEY (id_voce_entrata) REFERENCES findom_os.findom_d_voci_entrata(id_voce_entrata);


--
-- TOC entry 57310 (class 2606 OID 31182775)
-- Name: shell_t_rimod_entrate fk_findom_d_voci_entrata_2; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.shell_t_rimod_entrate
    ADD CONSTRAINT fk_findom_d_voci_entrata_2 FOREIGN KEY (id_voce_entrata) REFERENCES findom_os.findom_d_voci_entrata(id_voce_entrata);


--
-- TOC entry 57214 (class 2606 OID 31182780)
-- Name: findom_r_dett_tipol_interventi_voci_spesa fk_findom_d_voci_spesa_1; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_r_dett_tipol_interventi_voci_spesa
    ADD CONSTRAINT fk_findom_d_voci_spesa_1 FOREIGN KEY (id_voce_spesa) REFERENCES findom_os.findom_d_voci_spesa(id_voce_spesa);


--
-- TOC entry 57232 (class 2606 OID 31182785)
-- Name: findom_r_tipol_interventi_voci_spesa fk_findom_d_voci_spesa_2; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_r_tipol_interventi_voci_spesa
    ADD CONSTRAINT fk_findom_d_voci_spesa_2 FOREIGN KEY (id_voce_spesa) REFERENCES findom_os.findom_d_voci_spesa(id_voce_spesa);


--
-- TOC entry 57246 (class 2606 OID 31182790)
-- Name: findom_t_contrib_acq_veicoli fk_findom_d_voci_spesa_3; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_t_contrib_acq_veicoli
    ADD CONSTRAINT fk_findom_d_voci_spesa_3 FOREIGN KEY (id_voce_spesa) REFERENCES findom_os.findom_d_voci_spesa(id_voce_spesa);


--
-- TOC entry 57256 (class 2606 OID 31182795)
-- Name: findom_t_parametri_valut fk_findom_r_bandi_specifiche_valut_1; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_t_parametri_valut
    ADD CONSTRAINT fk_findom_r_bandi_specifiche_valut_1 FOREIGN KEY (id_bando, id_specifica) REFERENCES findom_os.findom_r_bandi_specifiche_valut(id_bando, id_specifica);


--
-- TOC entry 57308 (class 2606 OID 31182800)
-- Name: shell_t_rimod_spese fk_findom_r_dett_tipol_interventi_voci_spesa_1; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.shell_t_rimod_spese
    ADD CONSTRAINT fk_findom_r_dett_tipol_interventi_voci_spesa_1 FOREIGN KEY (id_dett_intervento, id_voce_spesa) REFERENCES findom_os.findom_r_dett_tipol_interventi_voci_spesa(id_dett_tipol_intervento, id_voce_spesa);


--
-- TOC entry 57234 (class 2606 OID 31182805)
-- Name: findom_r_ula_tipol_beneficiari_bandi fk_findom_r_tipol_beneficiari_bandi_1; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_r_ula_tipol_beneficiari_bandi
    ADD CONSTRAINT fk_findom_r_tipol_beneficiari_bandi_1 FOREIGN KEY (id_tipol_beneficiario, id_bando) REFERENCES findom_os.findom_r_tipol_beneficiari_bandi(id_tipol_beneficiario, id_bando);


--
-- TOC entry 57307 (class 2606 OID 31182810)
-- Name: shell_t_rimod_spese fk_findom_r_tipol_interventi_voci_spesa_1; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.shell_t_rimod_spese
    ADD CONSTRAINT fk_findom_r_tipol_interventi_voci_spesa_1 FOREIGN KEY (id_tipol_intervento, id_voce_spesa) REFERENCES findom_os.findom_r_tipol_interventi_voci_spesa(id_tipol_intervento, id_voce_spesa);


--
-- TOC entry 57196 (class 2606 OID 31182815)
-- Name: findom_r_bandi_premialita fk_findom_t_bandi_1; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_r_bandi_premialita
    ADD CONSTRAINT fk_findom_t_bandi_1 FOREIGN KEY (id_bando) REFERENCES findom_os.findom_t_bandi(id_bando);


--
-- TOC entry 57180 (class 2606 OID 31182820)
-- Name: findom_r_bandi_ateco_escl fk_findom_t_bandi_10; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_r_bandi_ateco_escl
    ADD CONSTRAINT fk_findom_t_bandi_10 FOREIGN KEY (id_bando) REFERENCES findom_os.findom_t_bandi(id_bando);


--
-- TOC entry 57209 (class 2606 OID 31182825)
-- Name: findom_r_bandi_voci_entrata fk_findom_t_bandi_11; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_r_bandi_voci_entrata
    ADD CONSTRAINT fk_findom_t_bandi_11 FOREIGN KEY (id_bando) REFERENCES findom_os.findom_t_bandi(id_bando);


--
-- TOC entry 57207 (class 2606 OID 31182830)
-- Name: findom_r_bandi_valoriz_econom fk_findom_t_bandi_12; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_r_bandi_valoriz_econom
    ADD CONSTRAINT fk_findom_t_bandi_12 FOREIGN KEY (id_bando) REFERENCES findom_os.findom_t_bandi(id_bando);


--
-- TOC entry 57202 (class 2606 OID 31182835)
-- Name: findom_r_bandi_specifiche_valut fk_findom_t_bandi_13; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_r_bandi_specifiche_valut
    ADD CONSTRAINT fk_findom_t_bandi_13 FOREIGN KEY (id_bando) REFERENCES findom_os.findom_t_bandi(id_bando);


--
-- TOC entry 57182 (class 2606 OID 31182840)
-- Name: findom_r_bandi_criteri_valut fk_findom_t_bandi_14; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_r_bandi_criteri_valut
    ADD CONSTRAINT fk_findom_t_bandi_14 FOREIGN KEY (id_bando) REFERENCES findom_os.findom_t_bandi(id_bando);


--
-- TOC entry 57193 (class 2606 OID 31182850)
-- Name: findom_r_bandi_parametri_regole fk_findom_t_bandi_15; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_r_bandi_parametri_regole
    ADD CONSTRAINT fk_findom_t_bandi_15 FOREIGN KEY (id_bando) REFERENCES findom_os.findom_t_bandi(id_bando);


--
-- TOC entry 57198 (class 2606 OID 31182855)
-- Name: findom_r_bandi_regole fk_findom_t_bandi_16; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_r_bandi_regole
    ADD CONSTRAINT fk_findom_t_bandi_16 FOREIGN KEY (id_bando) REFERENCES findom_os.findom_t_bandi(id_bando);


--
-- TOC entry 57168 (class 2606 OID 31182860)
-- Name: findom_d_range_graduatoria fk_findom_t_bandi_17; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_d_range_graduatoria
    ADD CONSTRAINT fk_findom_t_bandi_17 FOREIGN KEY (id_bando) REFERENCES findom_os.findom_t_bandi(id_bando);


--
-- TOC entry 57191 (class 2606 OID 31182865)
-- Name: findom_r_bandi_motivazioni_esito fk_findom_t_bandi_18; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_r_bandi_motivazioni_esito
    ADD CONSTRAINT fk_findom_t_bandi_18 FOREIGN KEY (id_bando) REFERENCES findom_os.findom_t_bandi(id_bando);


--
-- TOC entry 57326 (class 2606 OID 31182870)
-- Name: shell_t_lock_graduatoria fk_findom_t_bandi_19; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.shell_t_lock_graduatoria
    ADD CONSTRAINT fk_findom_t_bandi_19 FOREIGN KEY (id_bando) REFERENCES findom_os.findom_t_bandi(id_bando);


--
-- TOC entry 57205 (class 2606 OID 31182875)
-- Name: findom_r_bandi_tipol_interventi fk_findom_t_bandi_2; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_r_bandi_tipol_interventi
    ADD CONSTRAINT fk_findom_t_bandi_2 FOREIGN KEY (id_bando) REFERENCES findom_os.findom_t_bandi(id_bando);


--
-- TOC entry 57323 (class 2606 OID 31182880)
-- Name: shell_t_acronimo_bandi fk_findom_t_bandi_20; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.shell_t_acronimo_bandi
    ADD CONSTRAINT fk_findom_t_bandi_20 FOREIGN KEY (id_bando) REFERENCES findom_os.findom_t_bandi(id_bando);


--
-- TOC entry 57201 (class 2606 OID 31182885)
-- Name: findom_r_bandi_soggetti_abilitati fk_findom_t_bandi_20; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_r_bandi_soggetti_abilitati
    ADD CONSTRAINT fk_findom_t_bandi_20 FOREIGN KEY (id_bando) REFERENCES findom_os.findom_t_bandi(id_bando);


--
-- TOC entry 57185 (class 2606 OID 31182890)
-- Name: findom_r_bandi_dett_tipol_aiuti fk_findom_t_bandi_3; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_r_bandi_dett_tipol_aiuti
    ADD CONSTRAINT fk_findom_t_bandi_3 FOREIGN KEY (id_bando) REFERENCES findom_os.findom_t_bandi(id_bando);


--
-- TOC entry 57187 (class 2606 OID 31182895)
-- Name: findom_r_bandi_forme_finanziamenti fk_findom_t_bandi_4; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_r_bandi_forme_finanziamenti
    ADD CONSTRAINT fk_findom_t_bandi_4 FOREIGN KEY (id_bando) REFERENCES findom_os.findom_t_bandi(id_bando);


--
-- TOC entry 57260 (class 2606 OID 31182900)
-- Name: findom_t_sportelli_bandi fk_findom_t_bandi_5; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_t_sportelli_bandi
    ADD CONSTRAINT fk_findom_t_bandi_5 FOREIGN KEY (id_bando) REFERENCES findom_os.findom_t_bandi(id_bando);


--
-- TOC entry 57230 (class 2606 OID 31182905)
-- Name: findom_r_tipol_beneficiari_bandi fk_findom_t_bandi_6; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_r_tipol_beneficiari_bandi
    ADD CONSTRAINT fk_findom_t_bandi_6 FOREIGN KEY (id_bando) REFERENCES findom_os.findom_t_bandi(id_bando);


--
-- TOC entry 57189 (class 2606 OID 31182910)
-- Name: findom_r_bandi_indicatori fk_findom_t_bandi_7; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_r_bandi_indicatori
    ADD CONSTRAINT fk_findom_t_bandi_7 FOREIGN KEY (id_bando) REFERENCES findom_os.findom_t_bandi(id_bando);


--
-- TOC entry 57176 (class 2606 OID 31182915)
-- Name: findom_r_bandi_allegati fk_findom_t_bandi_8; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_r_bandi_allegati
    ADD CONSTRAINT fk_findom_t_bandi_8 FOREIGN KEY (id_bando) REFERENCES findom_os.findom_t_bandi(id_bando);


--
-- TOC entry 57178 (class 2606 OID 31182920)
-- Name: findom_r_bandi_ateco fk_findom_t_bandi_9; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_r_bandi_ateco
    ADD CONSTRAINT fk_findom_t_bandi_9 FOREIGN KEY (id_bando) REFERENCES findom_os.findom_t_bandi(id_bando);


--
-- TOC entry 57212 (class 2606 OID 31182925)
-- Name: findom_r_commissioni_commissari fk_findom_t_commissari_1; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_r_commissioni_commissari
    ADD CONSTRAINT fk_findom_t_commissari_1 FOREIGN KEY (id_commissario) REFERENCES findom_os.findom_t_commissari(id_commissario);


--
-- TOC entry 57250 (class 2606 OID 31182930)
-- Name: findom_t_dich_presa_visione fk_findom_t_commissari_2; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_t_dich_presa_visione
    ADD CONSTRAINT fk_findom_t_commissari_2 FOREIGN KEY (id_commissario) REFERENCES findom_os.findom_t_commissari(id_commissario);


--
-- TOC entry 57211 (class 2606 OID 31182935)
-- Name: findom_r_commissioni_commissari fk_findom_t_commissioni_1; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_r_commissioni_commissari
    ADD CONSTRAINT fk_findom_t_commissioni_1 FOREIGN KEY (id_commissione) REFERENCES findom_os.findom_t_commissioni(id_commissione);


--
-- TOC entry 57221 (class 2606 OID 31182940)
-- Name: findom_r_sportelli_bandi_commissioni fk_findom_t_commissioni_2; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_r_sportelli_bandi_commissioni
    ADD CONSTRAINT fk_findom_t_commissioni_2 FOREIGN KEY (id_commissione) REFERENCES findom_os.findom_t_commissioni(id_commissione);


--
-- TOC entry 57252 (class 2606 OID 31182945)
-- Name: findom_t_documenti_commissione fk_findom_t_commissioni_3; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_t_documenti_commissione
    ADD CONSTRAINT fk_findom_t_commissioni_3 FOREIGN KEY (id_commissione) REFERENCES findom_os.findom_t_commissioni(id_commissione);


--
-- TOC entry 57238 (class 2606 OID 31182950)
-- Name: findom_t_bandi fk_findom_t_config_metadati_1; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_t_bandi
    ADD CONSTRAINT fk_findom_t_config_metadati_1 FOREIGN KEY (id_tipo_metadati) REFERENCES findom_os.findom_t_config_metadati(id_tipo_metadati);


--
-- TOC entry 57249 (class 2606 OID 31182955)
-- Name: findom_t_dich_presa_visione fk_findom_t_documenti_commissione_1; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_t_dich_presa_visione
    ADD CONSTRAINT fk_findom_t_documenti_commissione_1 FOREIGN KEY (id_documento_comm) REFERENCES findom_os.findom_t_documenti_commissione(id_documento_comm);


--
-- TOC entry 57282 (class 2606 OID 31182960)
-- Name: shell_t_graduatoria fk_findom_t_documenti_commissione_2; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.shell_t_graduatoria
    ADD CONSTRAINT fk_findom_t_documenti_commissione_2 FOREIGN KEY (id_documento_comm) REFERENCES findom_os.findom_t_documenti_commissione(id_documento_comm);


--
-- TOC entry 57298 (class 2606 OID 31182965)
-- Name: shell_t_valut_domande fk_findom_t_parametri_valut_1; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.shell_t_valut_domande
    ADD CONSTRAINT fk_findom_t_parametri_valut_1 FOREIGN KEY (id_parametro_valut) REFERENCES findom_os.findom_t_parametri_valut(id_parametro_valut);


--
-- TOC entry 57200 (class 2606 OID 31182970)
-- Name: findom_r_bandi_soggetti_abilitati fk_findom_t_soggetti_abilitati_1; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_r_bandi_soggetti_abilitati
    ADD CONSTRAINT fk_findom_t_soggetti_abilitati_1 FOREIGN KEY (id_sogg_abil) REFERENCES findom_os.findom_t_soggetti_abilitati(id_sogg_abil);


--
-- TOC entry 57258 (class 2606 OID 31182975)
-- Name: findom_t_soggetti_bonus_covid_dett fk_findom_t_soggetti_bonus_covid_1; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_t_soggetti_bonus_covid_dett
    ADD CONSTRAINT fk_findom_t_soggetti_bonus_covid_1 FOREIGN KEY (id_soggetto_bonus_covid) REFERENCES findom_os.findom_t_soggetti_bonus_covid(id_soggetto_bonus_covid);


--
-- TOC entry 57273 (class 2606 OID 31182980)
-- Name: shell_t_domande fk_findom_t_sportelli_bandi_1; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.shell_t_domande
    ADD CONSTRAINT fk_findom_t_sportelli_bandi_1 FOREIGN KEY (id_sportello_bando) REFERENCES findom_os.findom_t_sportelli_bandi(id_sportello_bando);


--
-- TOC entry 57220 (class 2606 OID 31182985)
-- Name: findom_r_sportelli_bandi_commissioni fk_findom_t_sportelli_bandi_1; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_r_sportelli_bandi_commissioni
    ADD CONSTRAINT fk_findom_t_sportelli_bandi_1 FOREIGN KEY (id_sportello_bando) REFERENCES findom_os.findom_t_sportelli_bandi(id_sportello_bando);


--
-- TOC entry 57329 (class 2606 OID 31182990)
-- Name: utl_t_regola_routing fk_findom_t_sportelli_bandi_2; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.utl_t_regola_routing
    ADD CONSTRAINT fk_findom_t_sportelli_bandi_2 FOREIGN KEY (id_sportello_bando) REFERENCES findom_os.findom_t_sportelli_bandi(id_sportello_bando);


--
-- TOC entry 57254 (class 2606 OID 31182995)
-- Name: findom_t_param_sportelli_bandi fk_findom_t_sportelli_bandi_2; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_t_param_sportelli_bandi
    ADD CONSTRAINT fk_findom_t_sportelli_bandi_2 FOREIGN KEY (id_sportello_bando) REFERENCES findom_os.findom_t_sportelli_bandi(id_sportello_bando);


--
-- TOC entry 57264 (class 2606 OID 31183000)
-- Name: findom_t_valori_sportello fk_findom_t_sportelli_bandi_2; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_t_valori_sportello
    ADD CONSTRAINT fk_findom_t_sportelli_bandi_2 FOREIGN KEY (id_sportello_bando) REFERENCES findom_os.findom_t_sportelli_bandi(id_sportello_bando);


--
-- TOC entry 57261 (class 2606 OID 31183005)
-- Name: findom_t_sportelli_regole_param fk_findom_t_sportelli_bandi_3; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_t_sportelli_regole_param
    ADD CONSTRAINT fk_findom_t_sportelli_bandi_3 FOREIGN KEY (id_sportello_bando) REFERENCES findom_os.findom_t_sportelli_bandi(id_sportello_bando);


--
-- TOC entry 57236 (class 2606 OID 31183010)
-- Name: findom_t_allegati_sportello fk_findom_t_sportelli_bandi_3; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_t_allegati_sportello
    ADD CONSTRAINT fk_findom_t_sportelli_bandi_3 FOREIGN KEY (id_sportello_bando) REFERENCES findom_os.findom_t_sportelli_bandi(id_sportello_bando);


--
-- TOC entry 57245 (class 2606 OID 31183015)
-- Name: findom_t_contrib_acq_veicoli fk_findom_t_sportelli_bandi_4; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_t_contrib_acq_veicoli
    ADD CONSTRAINT fk_findom_t_sportelli_bandi_4 FOREIGN KEY (id_sportello_bando) REFERENCES findom_os.findom_t_sportelli_bandi(id_sportello_bando);


--
-- TOC entry 57227 (class 2606 OID 31183020)
-- Name: findom_r_tipi_rottamaz_categ_veicoli fk_findom_t_sportelli_bandi_5; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_r_tipi_rottamaz_categ_veicoli
    ADD CONSTRAINT fk_findom_t_sportelli_bandi_5 FOREIGN KEY (id_sportello_bando) REFERENCES findom_os.findom_t_sportelli_bandi(id_sportello_bando);


--
-- TOC entry 57224 (class 2606 OID 31183025)
-- Name: findom_r_tipi_rottamaz_alimentaz_veicoli fk_findom_t_sportelli_bandi_6; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_r_tipi_rottamaz_alimentaz_veicoli
    ADD CONSTRAINT fk_findom_t_sportelli_bandi_6 FOREIGN KEY (id_sportello_bando) REFERENCES findom_os.findom_t_sportelli_bandi(id_sportello_bando);


--
-- TOC entry 57296 (class 2606 OID 31183030)
-- Name: istr_t_model fk_istr_d_model_state_01; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.istr_t_model
    ADD CONSTRAINT fk_istr_d_model_state_01 FOREIGN KEY (model_state_fk) REFERENCES findom_os.istr_d_model_state(model_state);


--
-- TOC entry 57315 (class 2606 OID 31183035)
-- Name: istr_t_submodel fk_istr_t_model_01; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.istr_t_submodel
    ADD CONSTRAINT fk_istr_t_model_01 FOREIGN KEY (model_id) REFERENCES findom_os.istr_t_model(model_id);


--
-- TOC entry 57312 (class 2606 OID 31183040)
-- Name: istr_t_model_index fk_istr_t_model_2; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.istr_t_model_index
    ADD CONSTRAINT fk_istr_t_model_2 FOREIGN KEY (model_id) REFERENCES findom_os.istr_t_model(model_id);


--
-- TOC entry 57314 (class 2606 OID 31183045)
-- Name: istr_t_submodel fk_istr_t_template_01; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.istr_t_submodel
    ADD CONSTRAINT fk_istr_t_template_01 FOREIGN KEY (template_code_fk) REFERENCES findom_os.istr_t_template(template_code);


--
-- TOC entry 57316 (class 2606 OID 31183050)
-- Name: istr_t_template_index fk_istr_t_template_1; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.istr_t_template_index
    ADD CONSTRAINT fk_istr_t_template_1 FOREIGN KEY (template_fk) REFERENCES findom_os.istr_t_template(template_id);


--
-- TOC entry 57295 (class 2606 OID 31183055)
-- Name: istr_t_model fk_istr_t_template_2; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.istr_t_model
    ADD CONSTRAINT fk_istr_t_template_2 FOREIGN KEY (template_code_fk) REFERENCES findom_os.istr_t_template(template_code);


--
-- TOC entry 57313 (class 2606 OID 31183060)
-- Name: istr_t_rule fk_istr_t_template_4; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.istr_t_rule
    ADD CONSTRAINT fk_istr_t_template_4 FOREIGN KEY (template_code_fk) REFERENCES findom_os.istr_t_template(template_code);


--
-- TOC entry 57311 (class 2606 OID 31183065)
-- Name: istr_t_model_index fk_istr_t_template_index_01; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.istr_t_model_index
    ADD CONSTRAINT fk_istr_t_template_index_01 FOREIGN KEY (index_id) REFERENCES findom_os.istr_t_template_index(index_id);


--
-- TOC entry 57325 (class 2606 OID 31183070)
-- Name: shell_t_capofila_acronimo fk_shell_t_acronimo_bandi_1; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.shell_t_capofila_acronimo
    ADD CONSTRAINT fk_shell_t_acronimo_bandi_1 FOREIGN KEY (id_acronimo_bando) REFERENCES findom_os.shell_t_acronimo_bandi(id_acronimo_bando);


--
-- TOC entry 57304 (class 2606 OID 31183075)
-- Name: shell_t_dett_criteri_graduatoria fk_shell_t_dett_graduatoria_1; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.shell_t_dett_criteri_graduatoria
    ADD CONSTRAINT fk_shell_t_dett_graduatoria_1 FOREIGN KEY (id_dett_graduatoria) REFERENCES findom_os.shell_t_dett_graduatoria(id_dett_graduatoria);


--
-- TOC entry 57301 (class 2606 OID 31183080)
-- Name: shell_t_dett_graduatoria fk_shell_t_dett_graduatoria_2; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.shell_t_dett_graduatoria
    ADD CONSTRAINT fk_shell_t_dett_graduatoria_2 FOREIGN KEY (id_dett_graduatoria_parz_rif) REFERENCES findom_os.shell_t_dett_graduatoria(id_dett_graduatoria);


--
-- TOC entry 57319 (class 2606 OID 31183085)
-- Name: log_t_protocollo fk_shell_t_documento_index_1; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.log_t_protocollo
    ADD CONSTRAINT fk_shell_t_documento_index_1 FOREIGN KEY (id_documento_index) REFERENCES findom_os.shell_t_documento_index(id_documento_index);


--
-- TOC entry 57292 (class 2606 OID 31183090)
-- Name: shell_t_documento_prot fk_shell_t_documento_index_2; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.shell_t_documento_prot
    ADD CONSTRAINT fk_shell_t_documento_index_2 FOREIGN KEY (id_documento_index) REFERENCES findom_os.shell_t_documento_index(id_documento_index);


--
-- TOC entry 57294 (class 2606 OID 31183095)
-- Name: shell_t_file_domande fk_shell_t_domande_1; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.shell_t_file_domande
    ADD CONSTRAINT fk_shell_t_domande_1 FOREIGN KEY (id_domanda) REFERENCES findom_os.shell_t_domande(id_domanda);


--
-- TOC entry 57288 (class 2606 OID 31183100)
-- Name: shell_t_documento_index fk_shell_t_domande_2; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.shell_t_documento_index
    ADD CONSTRAINT fk_shell_t_domande_2 FOREIGN KEY (id_domanda) REFERENCES findom_os.shell_t_domande(id_domanda);


--
-- TOC entry 57297 (class 2606 OID 31183105)
-- Name: shell_t_valut_domande fk_shell_t_domande_2; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.shell_t_valut_domande
    ADD CONSTRAINT fk_shell_t_domande_2 FOREIGN KEY (id_domanda) REFERENCES findom_os.shell_t_domande(id_domanda);


--
-- TOC entry 57318 (class 2606 OID 31183110)
-- Name: log_t_firma_digitale fk_shell_t_domande_3; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.log_t_firma_digitale
    ADD CONSTRAINT fk_shell_t_domande_3 FOREIGN KEY (id_domanda) REFERENCES findom_os.shell_t_domande(id_domanda);


--
-- TOC entry 57317 (class 2606 OID 31183115)
-- Name: log_t_batch fk_shell_t_domande_4; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.log_t_batch
    ADD CONSTRAINT fk_shell_t_domande_4 FOREIGN KEY (id_domanda) REFERENCES findom_os.shell_t_domande(id_domanda);


--
-- TOC entry 57300 (class 2606 OID 31183120)
-- Name: shell_t_dett_graduatoria fk_shell_t_domande_5; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.shell_t_dett_graduatoria
    ADD CONSTRAINT fk_shell_t_domande_5 FOREIGN KEY (id_domanda) REFERENCES findom_os.shell_t_domande(id_domanda);


--
-- TOC entry 57306 (class 2606 OID 31183125)
-- Name: shell_t_rimod_spese fk_shell_t_domande_6; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.shell_t_rimod_spese
    ADD CONSTRAINT fk_shell_t_domande_6 FOREIGN KEY (id_domanda) REFERENCES findom_os.shell_t_domande(id_domanda);


--
-- TOC entry 57324 (class 2606 OID 31183130)
-- Name: shell_t_capofila_acronimo fk_shell_t_domande_7; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.shell_t_capofila_acronimo
    ADD CONSTRAINT fk_shell_t_domande_7 FOREIGN KEY (id_domanda) REFERENCES findom_os.shell_t_domande(id_domanda);


--
-- TOC entry 57309 (class 2606 OID 31183135)
-- Name: shell_t_rimod_entrate fk_shell_t_domande_7; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.shell_t_rimod_entrate
    ADD CONSTRAINT fk_shell_t_domande_7 FOREIGN KEY (id_domanda) REFERENCES findom_os.shell_t_domande(id_domanda);


--
-- TOC entry 57299 (class 2606 OID 31183140)
-- Name: shell_t_dett_graduatoria fk_shell_t_graduatoria_1; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.shell_t_dett_graduatoria
    ADD CONSTRAINT fk_shell_t_graduatoria_1 FOREIGN KEY (id_graduatoria) REFERENCES findom_os.shell_t_graduatoria(id_graduatoria);


--
-- TOC entry 57281 (class 2606 OID 31183145)
-- Name: shell_t_graduatoria fk_shell_t_graduatoria_2; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.shell_t_graduatoria
    ADD CONSTRAINT fk_shell_t_graduatoria_2 FOREIGN KEY (id_graduatoria_rif) REFERENCES findom_os.shell_t_graduatoria(id_graduatoria);


--
-- TOC entry 57272 (class 2606 OID 31183150)
-- Name: shell_t_domande fk_shell_t_soggetti_1; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.shell_t_domande
    ADD CONSTRAINT fk_shell_t_soggetti_1 FOREIGN KEY (id_soggetto_creatore) REFERENCES findom_os.shell_t_soggetti(id_soggetto);


--
-- TOC entry 57271 (class 2606 OID 31183155)
-- Name: shell_t_domande fk_shell_t_soggetti_2; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.shell_t_domande
    ADD CONSTRAINT fk_shell_t_soggetti_2 FOREIGN KEY (id_soggetto_beneficiario) REFERENCES findom_os.shell_t_soggetti(id_soggetto);


--
-- TOC entry 57270 (class 2606 OID 31183160)
-- Name: shell_t_domande fk_shell_t_soggetti_3; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.shell_t_domande
    ADD CONSTRAINT fk_shell_t_soggetti_3 FOREIGN KEY (id_soggetto_invio) REFERENCES findom_os.shell_t_soggetti(id_soggetto);


--
-- TOC entry 57287 (class 2606 OID 31183165)
-- Name: shell_t_documento_index fk_shell_t_soggetti_4; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.shell_t_documento_index
    ADD CONSTRAINT fk_shell_t_soggetti_4 FOREIGN KEY (id_soggetto) REFERENCES findom_os.shell_t_soggetti(id_soggetto);


--
-- TOC entry 57269 (class 2606 OID 31183170)
-- Name: shell_t_domande fk_shell_t_soggetti_5; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.shell_t_domande
    ADD CONSTRAINT fk_shell_t_soggetti_5 FOREIGN KEY (id_soggetto_conclusione) REFERENCES findom_os.shell_t_soggetti(id_soggetto);


--
-- TOC entry 57328 (class 2606 OID 31183175)
-- Name: utl_t_regola_routing fk_utl_d_fase_01; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.utl_t_regola_routing
    ADD CONSTRAINT fk_utl_d_fase_01 FOREIGN KEY (cod_fase) REFERENCES findom_os.utl_d_fase(cod_fase);


--
-- TOC entry 57327 (class 2606 OID 31183180)
-- Name: utl_t_regola_routing fk_utl_d_istanza_01; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.utl_t_regola_routing
    ADD CONSTRAINT fk_utl_d_istanza_01 FOREIGN KEY (id_utl_d_istanza) REFERENCES findom_os.utl_d_istanza(id_utl_d_istanza);


--
-- TOC entry 57322 (class 2606 OID 31183185)
-- Name: shell_r_capofila_acronimo_partner shell_t_capofila_acronimo_shell_r_capofila_acronimo_partner; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.shell_r_capofila_acronimo_partner
    ADD CONSTRAINT shell_t_capofila_acronimo_shell_r_capofila_acronimo_partner FOREIGN KEY (id_capofila_acronimo) REFERENCES findom_os.shell_t_capofila_acronimo(id_capofila_acronimo);


--
-- TOC entry 57251 (class 2606 OID 31183190)
-- Name: findom_t_documenti_commissione shell_t_documento_index_findom_t_documenti_commissione; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.findom_t_documenti_commissione
    ADD CONSTRAINT shell_t_documento_index_findom_t_documenti_commissione FOREIGN KEY (id_documento_index_comm) REFERENCES findom_os.shell_t_documento_index(id_documento_index);


--
-- TOC entry 57321 (class 2606 OID 31183195)
-- Name: shell_r_capofila_acronimo_partner shell_t_domande_shell_r_capofila_acronimo_partner; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.shell_r_capofila_acronimo_partner
    ADD CONSTRAINT shell_t_domande_shell_r_capofila_acronimo_partner FOREIGN KEY (id_domanda_partner) REFERENCES findom_os.shell_t_domande(id_domanda);


--
-- TOC entry 57320 (class 2606 OID 31183200)
-- Name: shell_r_capofila_acronimo_partner shell_t_partner_shell_r_capofila_acronimo_partner; Type: FK CONSTRAINT; Schema: findom_os; Owner: findom_os
--

ALTER TABLE ONLY findom_os.shell_r_capofila_acronimo_partner
    ADD CONSTRAINT shell_t_partner_shell_r_capofila_acronimo_partner FOREIGN KEY (id_partner) REFERENCES findom_os.shell_t_partner(id_partner);
