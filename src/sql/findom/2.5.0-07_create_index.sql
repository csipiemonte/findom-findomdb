----------------------------------------------------------------------------
-- Copyright Regione Piemonte - 2020
-- SPDX-License-Identifier: EUPL-1.2-or-later
----------------------------------------------------------------------------
--
-- TOC entry 56672 (class 1259 OID 31182168)
-- Name: idx_ext_d_ateco_1; Type: INDEX; Schema: findom_os; Owner: findom_os
--

CREATE INDEX idx_ext_d_ateco_1 ON findom_os.ext_d_ateco USING btree (cod_ateco);


--
-- TOC entry 56673 (class 1259 OID 31182169)
-- Name: idx_ext_d_ateco_2; Type: INDEX; Schema: findom_os; Owner: findom_os
--

CREATE INDEX idx_ext_d_ateco_2 ON findom_os.ext_d_ateco USING btree (cod_ateco_norm);


--
-- TOC entry 56682 (class 1259 OID 31182170)
-- Name: idx_ext_d_forme_giuridiche_1; Type: INDEX; Schema: findom_os; Owner: findom_os
--

CREATE UNIQUE INDEX idx_ext_d_forme_giuridiche_1 ON findom_os.ext_d_forme_giuridiche USING btree (cod_natura_giuridica);


--
-- TOC entry 56711 (class 1259 OID 31182171)
-- Name: idx_findom_d_classif_bandi_1; Type: INDEX; Schema: findom_os; Owner: findom_os
--

CREATE INDEX idx_findom_d_classif_bandi_1 ON findom_os.findom_d_classif_bandi USING btree (id_normativa);


--
-- TOC entry 56712 (class 1259 OID 31182172)
-- Name: idx_findom_d_classif_bandi_2; Type: INDEX; Schema: findom_os; Owner: findom_os
--

CREATE INDEX idx_findom_d_classif_bandi_2 ON findom_os.findom_d_classif_bandi USING btree (id_tipo_suddivisione);


--
-- TOC entry 56713 (class 1259 OID 31182173)
-- Name: idx_findom_d_classif_bandi_3; Type: INDEX; Schema: findom_os; Owner: findom_os
--

CREATE INDEX idx_findom_d_classif_bandi_3 ON findom_os.findom_d_classif_bandi USING btree (id_classificazione_padre);


--
-- TOC entry 56728 (class 1259 OID 31182174)
-- Name: idx_findom_d_dett_tipol_aiuti_1; Type: INDEX; Schema: findom_os; Owner: findom_os
--

CREATE INDEX idx_findom_d_dett_tipol_aiuti_1 ON findom_os.findom_d_dett_tipol_aiuti USING btree (id_tipol_aiuto);


--
-- TOC entry 56733 (class 1259 OID 31182175)
-- Name: idx_findom_d_dett_tipol_interventi_1; Type: INDEX; Schema: findom_os; Owner: findom_os
--

CREATE INDEX idx_findom_d_dett_tipol_interventi_1 ON findom_os.findom_d_dett_tipol_interventi USING btree (id_tipol_intervento);


--
-- TOC entry 56734 (class 1259 OID 31182176)
-- Name: idx_findom_d_dett_tipol_interventi_2; Type: INDEX; Schema: findom_os; Owner: findom_os
--

CREATE INDEX idx_findom_d_dett_tipol_interventi_2 ON findom_os.findom_d_dett_tipol_interventi USING btree (id_campo_intervento);


--
-- TOC entry 56765 (class 1259 OID 31182177)
-- Name: idx_findom_d_funzionari_1; Type: INDEX; Schema: findom_os; Owner: findom_os
--

CREATE INDEX idx_findom_d_funzionari_1 ON findom_os.findom_d_funzionari USING btree (id_ruolo);


--
-- TOC entry 56772 (class 1259 OID 31182178)
-- Name: idx_findom_d_indicatori_1; Type: INDEX; Schema: findom_os; Owner: findom_os
--

CREATE INDEX idx_findom_d_indicatori_1 ON findom_os.findom_d_indicatori USING btree (id_tipo_indicatore);


--
-- TOC entry 56789 (class 1259 OID 31182179)
-- Name: idx_findom_d_range_graduatoria_1; Type: INDEX; Schema: findom_os; Owner: findom_os
--

CREATE INDEX idx_findom_d_range_graduatoria_1 ON findom_os.findom_d_range_graduatoria USING btree (id_bando);


--
-- TOC entry 56798 (class 1259 OID 31182180)
-- Name: idx_findom_d_settori_1; Type: INDEX; Schema: findom_os; Owner: findom_os
--

CREATE INDEX idx_findom_d_settori_1 ON findom_os.findom_d_settori USING btree (id_direzione);


--
-- TOC entry 56833 (class 1259 OID 31182181)
-- Name: idx_findom_d_tipol_beneficiari_1; Type: INDEX; Schema: findom_os; Owner: findom_os
--

CREATE INDEX idx_findom_d_tipol_beneficiari_1 ON findom_os.findom_d_tipol_beneficiari USING btree (cod_stereotipo);


--
-- TOC entry 56840 (class 1259 OID 31182182)
-- Name: idx_findom_d_tipol_interventi_1; Type: INDEX; Schema: findom_os; Owner: findom_os
--

CREATE INDEX idx_findom_d_tipol_interventi_1 ON findom_os.findom_d_tipol_interventi USING btree (id_campo_intervento);


--
-- TOC entry 56859 (class 1259 OID 31182183)
-- Name: idx_findom_r_bandi_allegati_1; Type: INDEX; Schema: findom_os; Owner: findom_os
--

CREATE INDEX idx_findom_r_bandi_allegati_1 ON findom_os.findom_r_bandi_allegati USING btree (id_allegato);


--
-- TOC entry 56862 (class 1259 OID 31182184)
-- Name: idx_findom_r_bandi_ateco_1; Type: INDEX; Schema: findom_os; Owner: findom_os
--

CREATE INDEX idx_findom_r_bandi_ateco_1 ON findom_os.findom_r_bandi_ateco USING btree (id_ateco);


--
-- TOC entry 56865 (class 1259 OID 31182185)
-- Name: idx_findom_r_bandi_ateco_escl_1; Type: INDEX; Schema: findom_os; Owner: findom_os
--

CREATE INDEX idx_findom_r_bandi_ateco_escl_1 ON findom_os.findom_r_bandi_ateco_escl USING btree (id_ateco);


--
-- TOC entry 56868 (class 1259 OID 31182186)
-- Name: idx_findom_r_bandi_criteri_valut_1; Type: INDEX; Schema: findom_os; Owner: findom_os
--

CREATE INDEX idx_findom_r_bandi_criteri_valut_1 ON findom_os.findom_r_bandi_criteri_valut USING btree (id_criterio);


--
-- TOC entry 56869 (class 1259 OID 31182187)
-- Name: idx_findom_r_bandi_criteri_valut_2; Type: INDEX; Schema: findom_os; Owner: findom_os
--

CREATE INDEX idx_findom_r_bandi_criteri_valut_2 ON findom_os.findom_r_bandi_criteri_valut USING btree (id_tipol_intervento);


--
-- TOC entry 56872 (class 1259 OID 31182188)
-- Name: idx_findom_r_bandi_dett_tipol_aiuti_1; Type: INDEX; Schema: findom_os; Owner: findom_os
--

CREATE INDEX idx_findom_r_bandi_dett_tipol_aiuti_1 ON findom_os.findom_r_bandi_dett_tipol_aiuti USING btree (id_dett_tipol_aiuti);


--
-- TOC entry 56875 (class 1259 OID 31182189)
-- Name: idx_findom_r_bandi_forme_finanziamenti_1; Type: INDEX; Schema: findom_os; Owner: findom_os
--

CREATE INDEX idx_findom_r_bandi_forme_finanziamenti_1 ON findom_os.findom_r_bandi_forme_finanziamenti USING btree (id_forma_finanziamento);


--
-- TOC entry 56878 (class 1259 OID 31182190)
-- Name: idx_findom_r_bandi_indicatori_1; Type: INDEX; Schema: findom_os; Owner: findom_os
--

CREATE INDEX idx_findom_r_bandi_indicatori_1 ON findom_os.findom_r_bandi_indicatori USING btree (id_indicatore);


--
-- TOC entry 56883 (class 1259 OID 31182191)
-- Name: idx_findom_r_bandi_parametri_regole_1; Type: INDEX; Schema: findom_os; Owner: findom_os
--

CREATE INDEX idx_findom_r_bandi_parametri_regole_1 ON findom_os.findom_r_bandi_parametri_regole USING btree (id_parametro);


--
-- TOC entry 56884 (class 1259 OID 31182192)
-- Name: idx_findom_r_bandi_parametri_regole_2; Type: INDEX; Schema: findom_os; Owner: findom_os
--

CREATE INDEX idx_findom_r_bandi_parametri_regole_2 ON findom_os.findom_r_bandi_parametri_regole USING btree (id_regola);


--
-- TOC entry 56887 (class 1259 OID 31182193)
-- Name: idx_findom_r_bandi_premialita_1; Type: INDEX; Schema: findom_os; Owner: findom_os
--

CREATE INDEX idx_findom_r_bandi_premialita_1 ON findom_os.findom_r_bandi_premialita USING btree (id_premialita);


--
-- TOC entry 56892 (class 1259 OID 31182194)
-- Name: idx_findom_r_bandi_soggetti_abilitati_1; Type: INDEX; Schema: findom_os; Owner: findom_os
--

CREATE INDEX idx_findom_r_bandi_soggetti_abilitati_1 ON findom_os.findom_r_bandi_soggetti_abilitati USING btree (id_bando);


--
-- TOC entry 56895 (class 1259 OID 31182195)
-- Name: idx_findom_r_bandi_specifiche_valut_1; Type: INDEX; Schema: findom_os; Owner: findom_os
--

CREATE INDEX idx_findom_r_bandi_specifiche_valut_1 ON findom_os.findom_r_bandi_specifiche_valut USING btree (id_specifica);


--
-- TOC entry 56900 (class 1259 OID 31182196)
-- Name: idx_findom_r_bandi_tipol_interventi_1; Type: INDEX; Schema: findom_os; Owner: findom_os
--

CREATE INDEX idx_findom_r_bandi_tipol_interventi_1 ON findom_os.findom_r_bandi_tipol_interventi USING btree (id_tipol_intervento);


--
-- TOC entry 56903 (class 1259 OID 31182197)
-- Name: idx_findom_r_bandi_valoriz_econom_1; Type: INDEX; Schema: findom_os; Owner: findom_os
--

CREATE INDEX idx_findom_r_bandi_valoriz_econom_1 ON findom_os.findom_r_bandi_valoriz_econom USING btree (id_valoriz_econom);


--
-- TOC entry 56906 (class 1259 OID 31182198)
-- Name: idx_findom_r_bandi_voci_entrata_1; Type: INDEX; Schema: findom_os; Owner: findom_os
--

CREATE INDEX idx_findom_r_bandi_voci_entrata_1 ON findom_os.findom_r_bandi_voci_entrata USING btree (id_voce_entrata);


--
-- TOC entry 56909 (class 1259 OID 31182199)
-- Name: idx_findom_r_commissioni_commissari_1; Type: INDEX; Schema: findom_os; Owner: findom_os
--

CREATE INDEX idx_findom_r_commissioni_commissari_1 ON findom_os.findom_r_commissioni_commissari USING btree (id_incarico);


--
-- TOC entry 56912 (class 1259 OID 31182200)
-- Name: idx_findom_r_dett_tipol_interventi_voci_spesa_1; Type: INDEX; Schema: findom_os; Owner: findom_os
--

CREATE INDEX idx_findom_r_dett_tipol_interventi_voci_spesa_1 ON findom_os.findom_r_dett_tipol_interventi_voci_spesa USING btree (id_voce_spesa);


--
-- TOC entry 56915 (class 1259 OID 31182201)
-- Name: idx_findom_r_funzionari_direzioni_1; Type: INDEX; Schema: findom_os; Owner: findom_os
--

CREATE INDEX idx_findom_r_funzionari_direzioni_1 ON findom_os.findom_r_funzionari_direzioni USING btree (id_direzione);


--
-- TOC entry 56922 (class 1259 OID 31182202)
-- Name: idx_findom_r_stato_azioni_istruttoria_1; Type: INDEX; Schema: findom_os; Owner: findom_os
--

CREATE INDEX idx_findom_r_stato_azioni_istruttoria_1 ON findom_os.findom_r_stato_azioni_istruttoria USING btree (id_azione);


--
-- TOC entry 56925 (class 1259 OID 31182203)
-- Name: idx_findom_r_tipi_rottamaz_alimentaz_veicoli_1; Type: INDEX; Schema: findom_os; Owner: findom_os
--

CREATE INDEX idx_findom_r_tipi_rottamaz_alimentaz_veicoli_1 ON findom_os.findom_r_tipi_rottamaz_alimentaz_veicoli USING btree (id_aliment_veicolo);


--
-- TOC entry 56926 (class 1259 OID 31182204)
-- Name: idx_findom_r_tipi_rottamaz_alimentaz_veicoli_2; Type: INDEX; Schema: findom_os; Owner: findom_os
--

CREATE INDEX idx_findom_r_tipi_rottamaz_alimentaz_veicoli_2 ON findom_os.findom_r_tipi_rottamaz_alimentaz_veicoli USING btree (id_tipo_rottamazione);


--
-- TOC entry 56929 (class 1259 OID 31182205)
-- Name: idx_findom_r_tipi_rottamaz_categ_veicoli_1; Type: INDEX; Schema: findom_os; Owner: findom_os
--

CREATE INDEX idx_findom_r_tipi_rottamaz_categ_veicoli_1 ON findom_os.findom_r_tipi_rottamaz_categ_veicoli USING btree (id_categ_veicolo);


--
-- TOC entry 56930 (class 1259 OID 31182206)
-- Name: idx_findom_r_tipi_rottamaz_categ_veicoli_2; Type: INDEX; Schema: findom_os; Owner: findom_os
--

CREATE INDEX idx_findom_r_tipi_rottamaz_categ_veicoli_2 ON findom_os.findom_r_tipi_rottamaz_categ_veicoli USING btree (id_tipo_rottamazione);


--
-- TOC entry 56933 (class 1259 OID 31182207)
-- Name: idx_findom_r_tipol_beneficiari_bandi_1; Type: INDEX; Schema: findom_os; Owner: findom_os
--

CREATE INDEX idx_findom_r_tipol_beneficiari_bandi_1 ON findom_os.findom_r_tipol_beneficiari_bandi USING btree (id_bando);


--
-- TOC entry 56936 (class 1259 OID 31182208)
-- Name: idx_findom_r_tipol_interventi_voci_spesa_1; Type: INDEX; Schema: findom_os; Owner: findom_os
--

CREATE INDEX idx_findom_r_tipol_interventi_voci_spesa_1 ON findom_os.findom_r_tipol_interventi_voci_spesa USING btree (id_voce_spesa);


--
-- TOC entry 56939 (class 1259 OID 31182209)
-- Name: idx_findom_r_ula_tipol_beneficiari_bandi_1; Type: INDEX; Schema: findom_os; Owner: findom_os
--

CREATE INDEX idx_findom_r_ula_tipol_beneficiari_bandi_1 ON findom_os.findom_r_ula_tipol_beneficiari_bandi USING btree (id_tipol_beneficiario, id_bando);


--
-- TOC entry 56948 (class 1259 OID 31182210)
-- Name: idx_findom_t_amministratori_1; Type: INDEX; Schema: findom_os; Owner: findom_os
--

CREATE INDEX idx_findom_t_amministratori_1 ON findom_os.findom_t_amministratori USING btree (id_ente_appartenenza);


--
-- TOC entry 56953 (class 1259 OID 31182211)
-- Name: idx_findom_t_bandi_1; Type: INDEX; Schema: findom_os; Owner: findom_os
--

CREATE INDEX idx_findom_t_bandi_1 ON findom_os.findom_t_bandi USING btree (id_classificazione);


--
-- TOC entry 56954 (class 1259 OID 31182212)
-- Name: idx_findom_t_bandi_2; Type: INDEX; Schema: findom_os; Owner: findom_os
--

CREATE INDEX idx_findom_t_bandi_2 ON findom_os.findom_t_bandi USING btree (template_id);


--
-- TOC entry 56955 (class 1259 OID 31182213)
-- Name: idx_findom_t_bandi_3; Type: INDEX; Schema: findom_os; Owner: findom_os
--

CREATE INDEX idx_findom_t_bandi_3 ON findom_os.findom_t_bandi USING btree (id_area_tematica);


--
-- TOC entry 56962 (class 1259 OID 31182214)
-- Name: idx_findom_t_commissari_1; Type: INDEX; Schema: findom_os; Owner: findom_os
--

CREATE INDEX idx_findom_t_commissari_1 ON findom_os.findom_t_commissari USING btree (id_funzionario);


--
-- TOC entry 56969 (class 1259 OID 31182215)
-- Name: idx_findom_t_contrib_acq_veicoli_1; Type: INDEX; Schema: findom_os; Owner: findom_os
--

CREATE UNIQUE INDEX idx_findom_t_contrib_acq_veicoli_1 ON findom_os.findom_t_contrib_acq_veicoli USING btree (id_voce_spesa, (COALESCE(id_categ_veicolo, 0)));


--
-- TOC entry 56970 (class 1259 OID 31182216)
-- Name: idx_findom_t_contrib_acq_veicoli_2; Type: INDEX; Schema: findom_os; Owner: findom_os
--

CREATE INDEX idx_findom_t_contrib_acq_veicoli_2 ON findom_os.findom_t_contrib_acq_veicoli USING btree (id_categ_veicolo);


--
-- TOC entry 56971 (class 1259 OID 31182217)
-- Name: idx_findom_t_contrib_acq_veicoli_3; Type: INDEX; Schema: findom_os; Owner: findom_os
--

CREATE INDEX idx_findom_t_contrib_acq_veicoli_3 ON findom_os.findom_t_contrib_acq_veicoli USING btree (id_sportello_bando);


--
-- TOC entry 56972 (class 1259 OID 31182218)
-- Name: idx_findom_t_contrib_acq_veicoli_4; Type: INDEX; Schema: findom_os; Owner: findom_os
--

CREATE INDEX idx_findom_t_contrib_acq_veicoli_4 ON findom_os.findom_t_contrib_acq_veicoli USING btree (id_emissione);


--
-- TOC entry 56979 (class 1259 OID 31182219)
-- Name: idx_findom_t_documenti_commissione_1; Type: INDEX; Schema: findom_os; Owner: findom_os
--

CREATE INDEX idx_findom_t_documenti_commissione_1 ON findom_os.findom_t_documenti_commissione USING btree (id_commissione);


--
-- TOC entry 56980 (class 1259 OID 31182220)
-- Name: idx_findom_t_documenti_commissione_2; Type: INDEX; Schema: findom_os; Owner: findom_os
--

CREATE INDEX idx_findom_t_documenti_commissione_2 ON findom_os.findom_t_documenti_commissione USING btree (id_documento_index_comm);


--
-- TOC entry 56983 (class 1259 OID 31182221)
-- Name: idx_findom_t_param_sportelli_bandi_1; Type: INDEX; Schema: findom_os; Owner: findom_os
--

CREATE INDEX idx_findom_t_param_sportelli_bandi_1 ON findom_os.findom_t_param_sportelli_bandi USING btree (id_tipol_intervento);


--
-- TOC entry 56990 (class 1259 OID 31182222)
-- Name: idx_findom_t_parametri_valut_1; Type: INDEX; Schema: findom_os; Owner: findom_os
--

CREATE INDEX idx_findom_t_parametri_valut_1 ON findom_os.findom_t_parametri_valut USING btree (id_specifica);


--
-- TOC entry 56991 (class 1259 OID 31182223)
-- Name: idx_findom_t_parametri_valut_2; Type: INDEX; Schema: findom_os; Owner: findom_os
--

CREATE INDEX idx_findom_t_parametri_valut_2 ON findom_os.findom_t_parametri_valut USING btree (id_parametro);


--
-- TOC entry 57000 (class 1259 OID 31182224)
-- Name: idx_findom_t_soggetti_bonus_covid_1; Type: INDEX; Schema: findom_os; Owner: findom_os
--

CREATE INDEX idx_findom_t_soggetti_bonus_covid_1 ON findom_os.findom_t_soggetti_bonus_covid USING btree (iban);


--
-- TOC entry 57003 (class 1259 OID 31182225)
-- Name: idx_findom_t_soggetti_bonus_covid_dett_1; Type: INDEX; Schema: findom_os; Owner: findom_os
--

CREATE INDEX idx_findom_t_soggetti_bonus_covid_dett_1 ON findom_os.findom_t_soggetti_bonus_covid_dett USING btree (id_soggetto_bonus_covid);


--
-- TOC entry 57004 (class 1259 OID 31182226)
-- Name: idx_findom_t_soggetti_bonus_covid_dett_2; Type: INDEX; Schema: findom_os; Owner: findom_os
--

CREATE INDEX idx_findom_t_soggetti_bonus_covid_dett_2 ON findom_os.findom_t_soggetti_bonus_covid_dett USING btree (id_testo_tratt_dati);


--
-- TOC entry 57009 (class 1259 OID 31182227)
-- Name: idx_findom_t_sportelli_bandi_1; Type: INDEX; Schema: findom_os; Owner: findom_os
--

CREATE INDEX idx_findom_t_sportelli_bandi_1 ON findom_os.findom_t_sportelli_bandi USING btree (id_bando);


--
-- TOC entry 57016 (class 1259 OID 31182228)
-- Name: idx_findom_t_valori_sportello_1; Type: INDEX; Schema: findom_os; Owner: findom_os
--

CREATE INDEX idx_findom_t_valori_sportello_1 ON findom_os.findom_t_valori_sportello USING btree (id_tipol_intervento);


--
-- TOC entry 57017 (class 1259 OID 31182229)
-- Name: idx_findom_t_valori_sportello_2; Type: INDEX; Schema: findom_os; Owner: findom_os
--

CREATE INDEX idx_findom_t_valori_sportello_2 ON findom_os.findom_t_valori_sportello USING btree (id_tipol_beneficiario);


--
-- TOC entry 57018 (class 1259 OID 31182230)
-- Name: idx_findom_t_valori_sportello_3; Type: INDEX; Schema: findom_os; Owner: findom_os
--

CREATE UNIQUE INDEX idx_findom_t_valori_sportello_3 ON findom_os.findom_t_valori_sportello USING btree (id_sportello_bando, (COALESCE(id_tipol_intervento, 0)), (COALESCE(flag_pubblico_privato, (0)::numeric)), (COALESCE(id_tipol_beneficiario, 0)));


--
-- TOC entry 57019 (class 1259 OID 31182231)
-- Name: idx_findom_t_valori_sportello_4; Type: INDEX; Schema: findom_os; Owner: findom_os
--

CREATE INDEX idx_findom_t_valori_sportello_4 ON findom_os.findom_t_valori_sportello USING btree (id_tipol_beneficiario);


--
-- TOC entry 57020 (class 1259 OID 31182232)
-- Name: idx_findom_t_valori_sportello_5; Type: INDEX; Schema: findom_os; Owner: findom_os
--

CREATE INDEX idx_findom_t_valori_sportello_5 ON findom_os.findom_t_valori_sportello USING btree (id_tipo_graduatoria);


--
-- TOC entry 57119 (class 1259 OID 31182233)
-- Name: idx_log_t_batch_1; Type: INDEX; Schema: findom_os; Owner: findom_os
--

CREATE INDEX idx_log_t_batch_1 ON findom_os.log_t_batch USING btree (id_domanda);


--
-- TOC entry 57134 (class 1259 OID 31182234)
-- Name: idx_shell_t_capofila_acronimo_1; Type: INDEX; Schema: findom_os; Owner: findom_os
--

CREATE INDEX idx_shell_t_capofila_acronimo_1 ON findom_os.shell_t_capofila_acronimo USING btree (id_acronimo_bando);


--
-- TOC entry 57088 (class 1259 OID 31182235)
-- Name: idx_shell_t_dett_criteri_graduatoria_1; Type: INDEX; Schema: findom_os; Owner: findom_os
--

CREATE INDEX idx_shell_t_dett_criteri_graduatoria_1 ON findom_os.shell_t_dett_criteri_graduatoria USING btree (id_dett_graduatoria);


--
-- TOC entry 57089 (class 1259 OID 31182236)
-- Name: idx_shell_t_dett_criteri_graduatoria_2; Type: INDEX; Schema: findom_os; Owner: findom_os
--

CREATE INDEX idx_shell_t_dett_criteri_graduatoria_2 ON findom_os.shell_t_dett_criteri_graduatoria USING btree (id_criterio);


--
-- TOC entry 57075 (class 1259 OID 31182237)
-- Name: idx_shell_t_dett_graduatoria_1; Type: INDEX; Schema: findom_os; Owner: findom_os
--

CREATE INDEX idx_shell_t_dett_graduatoria_1 ON findom_os.shell_t_dett_graduatoria USING btree (id_graduatoria);


--
-- TOC entry 57076 (class 1259 OID 31182238)
-- Name: idx_shell_t_dett_graduatoria_2; Type: INDEX; Schema: findom_os; Owner: findom_os
--

CREATE INDEX idx_shell_t_dett_graduatoria_2 ON findom_os.shell_t_dett_graduatoria USING btree (id_domanda);


--
-- TOC entry 57077 (class 1259 OID 31182239)
-- Name: idx_shell_t_dett_graduatoria_3; Type: INDEX; Schema: findom_os; Owner: findom_os
--

CREATE INDEX idx_shell_t_dett_graduatoria_3 ON findom_os.shell_t_dett_graduatoria USING btree (id_motivazione_esito);


--
-- TOC entry 57078 (class 1259 OID 31182240)
-- Name: idx_shell_t_dett_graduatoria_4; Type: INDEX; Schema: findom_os; Owner: findom_os
--

CREATE INDEX idx_shell_t_dett_graduatoria_4 ON findom_os.shell_t_dett_graduatoria USING btree (id_stato_istr);


--
-- TOC entry 57045 (class 1259 OID 31182241)
-- Name: idx_shell_t_documento_index_1; Type: INDEX; Schema: findom_os; Owner: findom_os
--

CREATE INDEX idx_shell_t_documento_index_1 ON findom_os.shell_t_documento_index USING btree (id_domanda);


--
-- TOC entry 57046 (class 1259 OID 31182242)
-- Name: idx_shell_t_documento_index_2; Type: INDEX; Schema: findom_os; Owner: findom_os
--

CREATE INDEX idx_shell_t_documento_index_2 ON findom_os.shell_t_documento_index USING btree (id_stato_documento_index);


--
-- TOC entry 57047 (class 1259 OID 31182243)
-- Name: idx_shell_t_documento_index_3; Type: INDEX; Schema: findom_os; Owner: findom_os
--

CREATE INDEX idx_shell_t_documento_index_3 ON findom_os.shell_t_documento_index USING btree (id_allegato);


--
-- TOC entry 57048 (class 1259 OID 31182244)
-- Name: idx_shell_t_documento_index_4; Type: INDEX; Schema: findom_os; Owner: findom_os
--

CREATE INDEX idx_shell_t_documento_index_4 ON findom_os.shell_t_documento_index USING btree (id_soggetto);


--
-- TOC entry 57025 (class 1259 OID 31182245)
-- Name: idx_shell_t_domande_1; Type: INDEX; Schema: findom_os; Owner: findom_os
--

CREATE INDEX idx_shell_t_domande_1 ON findom_os.shell_t_domande USING btree (id_soggetto_creatore);


--
-- TOC entry 57026 (class 1259 OID 31182246)
-- Name: idx_shell_t_domande_10; Type: INDEX; Schema: findom_os; Owner: findom_os
--

CREATE INDEX idx_shell_t_domande_10 ON findom_os.shell_t_domande USING btree (id_funzionario_integrazione);


--
-- TOC entry 57027 (class 1259 OID 31182247)
-- Name: idx_shell_t_domande_11; Type: INDEX; Schema: findom_os; Owner: findom_os
--

CREATE INDEX idx_shell_t_domande_11 ON findom_os.shell_t_domande USING btree (id_stato_istr);


--
-- TOC entry 57028 (class 1259 OID 31182248)
-- Name: idx_shell_t_domande_2; Type: INDEX; Schema: findom_os; Owner: findom_os
--

CREATE INDEX idx_shell_t_domande_2 ON findom_os.shell_t_domande USING btree (id_soggetto_beneficiario);


--
-- TOC entry 57029 (class 1259 OID 31182249)
-- Name: idx_shell_t_domande_3; Type: INDEX; Schema: findom_os; Owner: findom_os
--

CREATE INDEX idx_shell_t_domande_3 ON findom_os.shell_t_domande USING btree (id_sportello_bando);


--
-- TOC entry 57030 (class 1259 OID 31182250)
-- Name: idx_shell_t_domande_4; Type: INDEX; Schema: findom_os; Owner: findom_os
--

CREATE INDEX idx_shell_t_domande_4 ON findom_os.shell_t_domande USING btree (id_soggetto_invio);


--
-- TOC entry 57031 (class 1259 OID 31182251)
-- Name: idx_shell_t_domande_5; Type: INDEX; Schema: findom_os; Owner: findom_os
--

CREATE INDEX idx_shell_t_domande_5 ON findom_os.shell_t_domande USING btree (id_tipol_beneficiario);


--
-- TOC entry 57032 (class 1259 OID 31182252)
-- Name: idx_shell_t_domande_6; Type: INDEX; Schema: findom_os; Owner: findom_os
--

CREATE INDEX idx_shell_t_domande_6 ON findom_os.shell_t_domande USING btree (id_soggetto_conclusione);


--
-- TOC entry 57033 (class 1259 OID 31182253)
-- Name: idx_shell_t_domande_7; Type: INDEX; Schema: findom_os; Owner: findom_os
--

CREATE INDEX idx_shell_t_domande_7 ON findom_os.shell_t_domande USING btree (id_motivazione_esito);


--
-- TOC entry 57034 (class 1259 OID 31182254)
-- Name: idx_shell_t_domande_8; Type: INDEX; Schema: findom_os; Owner: findom_os
--

CREATE INDEX idx_shell_t_domande_8 ON findom_os.shell_t_domande USING btree (id_istruttore_amm);


--
-- TOC entry 57035 (class 1259 OID 31182255)
-- Name: idx_shell_t_domande_9; Type: INDEX; Schema: findom_os; Owner: findom_os
--

CREATE INDEX idx_shell_t_domande_9 ON findom_os.shell_t_domande USING btree (id_decisore);


--
-- TOC entry 57060 (class 1259 OID 31182256)
-- Name: idx_shell_t_file_domande_1; Type: INDEX; Schema: findom_os; Owner: findom_os
--

CREATE INDEX idx_shell_t_file_domande_1 ON findom_os.shell_t_file_domande USING btree (dt_invio_file);


--
-- TOC entry 57061 (class 1259 OID 31182257)
-- Name: idx_shell_t_file_domande_2; Type: INDEX; Schema: findom_os; Owner: findom_os
--

CREATE INDEX idx_shell_t_file_domande_2 ON findom_os.shell_t_file_domande USING btree (id_domanda);


--
-- TOC entry 57038 (class 1259 OID 31182258)
-- Name: idx_shell_t_graduatoria_1; Type: INDEX; Schema: findom_os; Owner: findom_os
--

CREATE INDEX idx_shell_t_graduatoria_1 ON findom_os.shell_t_graduatoria USING btree (id_bando);


--
-- TOC entry 57039 (class 1259 OID 31182259)
-- Name: idx_shell_t_graduatoria_2; Type: INDEX; Schema: findom_os; Owner: findom_os
--

CREATE INDEX idx_shell_t_graduatoria_2 ON findom_os.shell_t_graduatoria USING btree (id_sportello_bando);


--
-- TOC entry 57040 (class 1259 OID 31182260)
-- Name: idx_shell_t_graduatoria_3; Type: INDEX; Schema: findom_os; Owner: findom_os
--

CREATE INDEX idx_shell_t_graduatoria_3 ON findom_os.shell_t_graduatoria USING btree (id_tipol_intervento);


--
-- TOC entry 57041 (class 1259 OID 31182261)
-- Name: idx_shell_t_graduatoria_4; Type: INDEX; Schema: findom_os; Owner: findom_os
--

CREATE INDEX idx_shell_t_graduatoria_4 ON findom_os.shell_t_graduatoria USING btree (id_funzionario);


--
-- TOC entry 57042 (class 1259 OID 31182262)
-- Name: idx_shell_t_graduatoria_5; Type: INDEX; Schema: findom_os; Owner: findom_os
--

CREATE INDEX idx_shell_t_graduatoria_5 ON findom_os.shell_t_graduatoria USING btree (id_graduatoria_rif);


--
-- TOC entry 57079 (class 1259 OID 31182263)
-- Name: idx_shell_t_graduatoria_dett_5; Type: INDEX; Schema: findom_os; Owner: findom_os
--

CREATE INDEX idx_shell_t_graduatoria_dett_5 ON findom_os.shell_t_dett_graduatoria USING btree (id_dett_graduatoria_parz_rif);


--
-- TOC entry 57099 (class 1259 OID 31182264)
-- Name: idx_shell_t_rimod_entrate_1; Type: INDEX; Schema: findom_os; Owner: findom_os
--

CREATE INDEX idx_shell_t_rimod_entrate_1 ON findom_os.shell_t_rimod_entrate USING btree (id_domanda);


--
-- TOC entry 57100 (class 1259 OID 31182265)
-- Name: idx_shell_t_rimod_entrate_2; Type: INDEX; Schema: findom_os; Owner: findom_os
--

CREATE UNIQUE INDEX idx_shell_t_rimod_entrate_2 ON findom_os.shell_t_rimod_entrate USING btree (id_domanda, id_voce_entrata, (COALESCE(dettaglio, ''::character varying)), tipo_rimodulazione);


--
-- TOC entry 57094 (class 1259 OID 31182266)
-- Name: idx_shell_t_rimod_spese_1; Type: INDEX; Schema: findom_os; Owner: findom_os
--

CREATE INDEX idx_shell_t_rimod_spese_1 ON findom_os.shell_t_rimod_spese USING btree (id_domanda);


--
-- TOC entry 57053 (class 1259 OID 31182267)
-- Name: idx_shell_t_soggetti_1; Type: INDEX; Schema: findom_os; Owner: findom_os
--

CREATE INDEX idx_shell_t_soggetti_1 ON findom_os.shell_t_soggetti USING btree (id_forma_giuridica);


--
-- TOC entry 57072 (class 1259 OID 31182268)
-- Name: idx_shell_t_valut_domande_1; Type: INDEX; Schema: findom_os; Owner: findom_os
--

CREATE INDEX idx_shell_t_valut_domande_1 ON findom_os.shell_t_valut_domande USING btree (id_parametro_valut);


