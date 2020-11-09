----------------------------------------------------------------------------
-- Copyright Regione Piemonte - 2020
-- SPDX-License-Identifier: EUPL-1.2-or-later
----------------------------------------------------------------------------
--
-- TOC entry 18779 (class 1255 OID 31175335)
-- Name: findom_r_bandi_specifiche_valut(); Type: FUNCTION; Schema: findom_os; Owner: findom_os
--

CREATE FUNCTION findom_os.findom_r_bandi_specifiche_valut() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
		-- Controllo che se il il TIPO_CAMPO = 'calcolato' allora ID_REGOLA è obbligatorio
		--  Altrimenti ID_REGOLA deve essere NULL
		
		IF NEW.tipo_campo = 'calcolato' THEN
		   IF NEW.id_regola IS NOT NULL THEN
		      RAISE EXCEPTION 'IMPOSTARE ID_REGOLA';
		   END IF;
		ELSE
		   IF NEW.id_regola IS NOT NULL THEN
		      RAISE EXCEPTION 'ID_REGOLA DEVE ESSERE NULL';
		   END IF;
		END IF;
        RETURN NEW;
    END;
$$;


ALTER FUNCTION findom_os.findom_r_bandi_specifiche_valut() OWNER TO findom_os;

--
-- TOC entry 18780 (class 1255 OID 31175336)
-- Name: fn_findom_get_param(integer); Type: FUNCTION; Schema: findom_os; Owner: findom_os
--

CREATE FUNCTION findom_os.fn_findom_get_param(p_id_domanda integer) RETURNS TABLE(t_importo_minimo_erogabile numeric, t_importo_massimo_erogabile numeric, t_budget_disponibile numeric, t_perc_max_contributo_erogabile numeric, t_totale_spese_minimo numeric, t_totale_spese_massimo numeric)
    LANGUAGE plpgsql
    AS $$
 DECLARE
    cur_param RECORD;
	rec_tipol_intervento RECORD;
    c1 refcursor;
    v_id_sportello integer;
    v_id_tipol_intervento   integer;
    v_id_tipol_beneficiario integer;
    v_flag_pubblico_privato numeric(1);
	v_count_tipol_intervento integer := 0;
	v_id  integer;
	
	cur_tipol_intervento CURSOR (c_id_domanda INTEGER) FOR
	  SELECT y.id_tipol_intervento
		FROM (SELECT x.id_domanda,
				unnest(xpath('//idTipoIntervento/text()', x.cat))::text::integer AS id_tipol_intervento,
				unnest(xpath('//checked/text()', x.cat))::text::boolean AS checked
				FROM (SELECT m.model_id AS id_domanda,
						unnest(xpath('/tree-map/_caratteristicheProgetto/map/tipologiaInterventoList/list/map', m.serialized_model)) AS cat
						FROM aggr_t_model m) x) y
						WHERE y.id_domanda = c_id_domanda and y.checked = true;	
	
	cur_valori CURSOR (c_id_sportello INTEGER,
	                   c_id_tipol_intervento INTEGER) FOR
			    SELECT id
				  FROM findom_t_valori_sportello
				 WHERE id_sportello_bando = c_id_sportello
				   AND id_tipol_intervento = c_id_tipol_intervento;
	
	
 BEGIN
    EXECUTE 'SELECT id_sportello_bando FROM shell_t_domande WHERE id_domanda = '||p_id_domanda INTO v_id_sportello;
	RAISE NOTICE 'v_id_sportello %',v_id_sportello;

    -- Recupero la tipologia di intervento dalla domanda e calcolo se esiste più di una tipologia di intervento configurata nella tabella findom_t_valori_sportello
    OPEN cur_tipol_intervento (p_id_domanda);
	LOOP
	FETCH cur_tipol_intervento INTO rec_tipol_intervento;
	EXIT WHEN NOT FOUND;
	  v_id_tipol_intervento := rec_tipol_intervento.id_tipol_intervento;
	  OPEN cur_valori (v_id_sportello,v_id_tipol_intervento);
	  FETCH cur_valori into v_id;
	  IF FOUND THEN
	  	  v_count_tipol_intervento := v_count_tipol_intervento + 1;
      END IF;
	  CLOSE cur_valori;
	END LOOP;
	CLOSE cur_tipol_intervento;
	
	-- Se la domanda contempla più  tipologie di intervento configurati i parametri non sono calcolati
	IF v_count_tipol_intervento > 1 THEN
      RAISE NOTICE 'La domanda contempla più di una tipologia di intervento configurata nella tabella findom_t_valori_sportello';
	END IF;

	
    EXECUTE 'SELECT a.id_tipol_beneficiario,
                    b.flag_pubblico_privato
               FROM shell_t_domande a
               JOIN findom_d_tipol_beneficiari b ON b.id_tipol_beneficiario = a.id_tipol_beneficiario
              WHERE id_domanda = '||p_id_domanda INTO v_id_tipol_beneficiario,v_flag_pubblico_privato;
			  
--RAISE NOTICE 'v_id_tipol_beneficiario %',v_id_tipol_beneficiario;
--RAISE NOTICE 'v_flag_pubblico_privato %',v_flag_pubblico_privato;

    
    FOR cur_param IN SELECT * from
						(
						SELECT case when id_tipol_beneficiario is not null then 4
						            when id_tipol_intervento is not null and flag_pubblico_privato is not null then 3
									when id_tipol_intervento is not null then 2
						            when flag_pubblico_privato is not null then 1
									else 0
							   end ordine,id_tipol_intervento,
													flag_pubblico_privato,
													id_tipol_beneficiario,
													importo_minimo_erogabile,
													importo_massimo_erogabile,
													budget_disponibile,
													perc_max_contributo_erogabile,
													totale_spese_minimo,
													totale_spese_massimo
											   FROM findom_t_valori_sportello
											  WHERE id_sportello_bando = v_id_sportello) x
						 order by ordine
     LOOP
  
		  IF t_importo_minimo_erogabile IS NULL THEN
			 t_importo_minimo_erogabile := coalesce(cur_param.importo_minimo_erogabile,t_importo_minimo_erogabile);
		  END IF;
		  IF t_importo_massimo_erogabile IS NULL THEN
			 t_importo_massimo_erogabile := coalesce(cur_param.importo_massimo_erogabile,t_importo_massimo_erogabile);
		  END IF;
		  IF t_budget_disponibile IS NULL THEN
			 t_budget_disponibile := coalesce(cur_param.budget_disponibile,t_budget_disponibile);
		  END IF;
		  IF t_perc_max_contributo_erogabile IS NULL THEN
			 t_perc_max_contributo_erogabile := coalesce(cur_param.perc_max_contributo_erogabile,t_perc_max_contributo_erogabile);
		  END IF;
		  IF t_totale_spese_minimo IS NULL THEN
			 t_totale_spese_minimo := coalesce(cur_param.totale_spese_minimo,t_totale_spese_minimo);
		  END IF;
		  IF t_totale_spese_massimo IS NULL THEN
			 t_totale_spese_massimo := coalesce(cur_param.totale_spese_massimo,t_totale_spese_massimo);
		  END IF;
	     -- RAISE NOTICE '1-t_importo_minimo_erogabile %',t_importo_minimo_erogabile;
	 
         IF cur_param.flag_pubblico_privato = v_flag_pubblico_privato and cur_param.id_tipol_intervento IS NULL THEN
			 t_importo_minimo_erogabile := coalesce(cur_param.importo_minimo_erogabile,t_importo_minimo_erogabile);
			 t_importo_massimo_erogabile := coalesce(cur_param.importo_massimo_erogabile,t_importo_massimo_erogabile);
			 t_budget_disponibile := coalesce(cur_param.budget_disponibile,t_budget_disponibile);
			 t_perc_max_contributo_erogabile := coalesce(cur_param.perc_max_contributo_erogabile,t_perc_max_contributo_erogabile);
			 t_totale_spese_minimo := coalesce(cur_param.totale_spese_minimo,t_totale_spese_minimo);
			 t_totale_spese_massimo := coalesce(cur_param.totale_spese_massimo,t_totale_spese_massimo);
	     --RAISE NOTICE '2-t_importo_minimo_erogabile %',t_importo_minimo_erogabile;
         END IF;
		 
         IF cur_param.id_tipol_intervento = v_id_tipol_intervento and cur_param.flag_pubblico_privato IS NULL THEN
			 t_importo_minimo_erogabile := coalesce(cur_param.importo_minimo_erogabile,t_importo_minimo_erogabile);
			 t_importo_massimo_erogabile := coalesce(cur_param.importo_massimo_erogabile,t_importo_massimo_erogabile);
			 t_budget_disponibile := coalesce(cur_param.budget_disponibile,t_budget_disponibile);
			 t_perc_max_contributo_erogabile := coalesce(cur_param.perc_max_contributo_erogabile,t_perc_max_contributo_erogabile);
			 t_totale_spese_minimo := coalesce(cur_param.totale_spese_minimo,t_totale_spese_minimo);
			 t_totale_spese_massimo := coalesce(cur_param.totale_spese_massimo,t_totale_spese_massimo);
	    -- RAISE NOTICE '2-t_importo_minimo_erogabile %',t_importo_minimo_erogabile;
         END IF;
		 
         IF cur_param.id_tipol_intervento = v_id_tipol_intervento and cur_param.flag_pubblico_privato = v_flag_pubblico_privato THEN
			 t_importo_minimo_erogabile := coalesce(cur_param.importo_minimo_erogabile,t_importo_minimo_erogabile);
			 t_importo_massimo_erogabile := coalesce(cur_param.importo_massimo_erogabile,t_importo_massimo_erogabile);
			 t_budget_disponibile := coalesce(cur_param.budget_disponibile,t_budget_disponibile);
			 t_perc_max_contributo_erogabile := coalesce(cur_param.perc_max_contributo_erogabile,t_perc_max_contributo_erogabile);
			 t_totale_spese_minimo := coalesce(cur_param.totale_spese_minimo,t_totale_spese_minimo);
			 t_totale_spese_massimo := coalesce(cur_param.totale_spese_massimo,t_totale_spese_massimo);
	    -- RAISE NOTICE '2-t_importo_minimo_erogabile %',t_importo_minimo_erogabile;
         END IF;
		 
         IF cur_param.id_tipol_beneficiario = v_id_tipol_beneficiario THEN
			 t_importo_minimo_erogabile := coalesce(cur_param.importo_minimo_erogabile,t_importo_minimo_erogabile);
			 t_importo_massimo_erogabile := coalesce(cur_param.importo_massimo_erogabile,t_importo_massimo_erogabile);
			 t_budget_disponibile := coalesce(cur_param.budget_disponibile,t_budget_disponibile);
			 t_perc_max_contributo_erogabile := coalesce(cur_param.perc_max_contributo_erogabile,t_perc_max_contributo_erogabile);
			 t_totale_spese_minimo := coalesce(cur_param.totale_spese_minimo,t_totale_spese_minimo);
			 t_totale_spese_massimo := coalesce(cur_param.totale_spese_massimo,t_totale_spese_massimo);
	     --RAISE NOTICE '3-t_importo_minimo_erogabile %',t_importo_minimo_erogabile;
         END IF;
		 
     END LOOP;
     RETURN NEXT;
 END;
 $$;


ALTER FUNCTION findom_os.fn_findom_get_param(p_id_domanda integer) OWNER TO findom_os;

--
-- TOC entry 18781 (class 1255 OID 31175339)
-- Name: fn_findom_get_param_istruttoria(integer, integer, integer); Type: FUNCTION; Schema: findom_os; Owner: findom_os
--

CREATE FUNCTION findom_os.fn_findom_get_param_istruttoria(p_id_sportello integer, p_id_tipol_intervento integer DEFAULT NULL::integer, p_flag_pubblico_privato integer DEFAULT NULL::integer) RETURNS TABLE(t_importo_minimo_erogabile numeric, t_importo_massimo_erogabile numeric, t_budget_disponibile numeric, t_perc_max_contributo_erogabile numeric, t_cod_tipo_graduatoria character varying)
    LANGUAGE plpgsql
    AS $$
DECLARE
    cur_param RECORD;
	rec_tipol_intervento RECORD;
    c1 refcursor;
    v_id_sportello integer;
    v_id_tipol_intervento   integer;
    v_flag_pubblico_privato numeric(1);
	
	
 BEGIN
	v_id_sportello := p_id_sportello;
	
	v_id_tipol_intervento := p_id_tipol_intervento;
	
    v_flag_pubblico_privato := p_flag_pubblico_privato;

    
    FOR cur_param IN SELECT * from
						(
						SELECT case when id_tipol_intervento is not null and flag_pubblico_privato is not null then 3
									when id_tipol_intervento is not null then 2
						            when flag_pubblico_privato is not null then 1
									else 0
							   end ordine,id_tipol_intervento,
													flag_pubblico_privato,
													id_tipol_beneficiario,
													importo_minimo_erogabile,
													importo_massimo_erogabile,
													budget_disponibile,
													perc_max_contributo_erogabile,
													cod_tipo_graduatoria
											   FROM findom_t_valori_sportello a
											   LEFT JOIN findom_d_tipo_graduatoria b ON b.id_tipo_graduatoria = a.id_tipo_graduatoria
											  WHERE id_sportello_bando = v_id_sportello
											    AND id_tipol_beneficiario IS NULL) x
						 order by ordine
     LOOP
	 
	    IF cur_param.id_tipol_intervento IS NULL AND cur_param.flag_pubblico_privato IS NULL THEN
	          --RAISE NOTICE '0-cur_param.id_tipol_intervento %',cur_param.id_tipol_intervento;
	         -- RAISE NOTICE '0-cur_param.flag_pubblico_privato %',cur_param.flag_pubblico_privato;

			  IF t_importo_minimo_erogabile IS NULL THEN
				 t_importo_minimo_erogabile := coalesce(cur_param.importo_minimo_erogabile,t_importo_minimo_erogabile);
			  END IF;
			  IF t_importo_massimo_erogabile IS NULL THEN
				 t_importo_massimo_erogabile := coalesce(cur_param.importo_massimo_erogabile,t_importo_massimo_erogabile);
			  END IF;
			  IF t_budget_disponibile IS NULL THEN
				 t_budget_disponibile := coalesce(cur_param.budget_disponibile,t_budget_disponibile);
			  END IF;
			  IF t_perc_max_contributo_erogabile IS NULL THEN
				 t_perc_max_contributo_erogabile := coalesce(cur_param.perc_max_contributo_erogabile,t_perc_max_contributo_erogabile);
			  END IF;
			  IF t_cod_tipo_graduatoria IS NULL THEN
			     t_cod_tipo_graduatoria := coalesce(cur_param.cod_tipo_graduatoria,t_cod_tipo_graduatoria);
			  END IF;
		  
		 END IF;
	     -- RAISE NOTICE '1-t_importo_minimo_erogabile %',t_importo_minimo_erogabile;
	     IF v_flag_pubblico_privato IS NOT NULL THEN
			 IF cur_param.flag_pubblico_privato = v_flag_pubblico_privato and cur_param.id_tipol_intervento IS NULL THEN
				 t_importo_minimo_erogabile := coalesce(cur_param.importo_minimo_erogabile,t_importo_minimo_erogabile);
				 t_importo_massimo_erogabile := coalesce(cur_param.importo_massimo_erogabile,t_importo_massimo_erogabile);
				 t_budget_disponibile := coalesce(cur_param.budget_disponibile,t_budget_disponibile);
				 t_perc_max_contributo_erogabile := coalesce(cur_param.perc_max_contributo_erogabile,t_perc_max_contributo_erogabile);
				 t_cod_tipo_graduatoria := coalesce(cur_param.cod_tipo_graduatoria,t_cod_tipo_graduatoria);
			 --RAISE NOTICE '2-t_importo_minimo_erogabile %',t_importo_minimo_erogabile;
			 END IF;
		 END IF;
		 
	     IF v_id_tipol_intervento IS NOT NULL THEN
			 IF cur_param.id_tipol_intervento = v_id_tipol_intervento and cur_param.flag_pubblico_privato IS NULL THEN
				 t_importo_minimo_erogabile := coalesce(cur_param.importo_minimo_erogabile,t_importo_minimo_erogabile);
				 t_importo_massimo_erogabile := coalesce(cur_param.importo_massimo_erogabile,t_importo_massimo_erogabile);
				 t_budget_disponibile := coalesce(cur_param.budget_disponibile,t_budget_disponibile);
				 t_perc_max_contributo_erogabile := coalesce(cur_param.perc_max_contributo_erogabile,t_perc_max_contributo_erogabile);
				 t_cod_tipo_graduatoria := coalesce(cur_param.cod_tipo_graduatoria,t_cod_tipo_graduatoria);
			-- RAISE NOTICE '2-t_importo_minimo_erogabile %',t_importo_minimo_erogabile;
			 END IF;
		 END IF;
		 
	     IF v_id_tipol_intervento IS NOT NULL THEN
			 IF cur_param.id_tipol_intervento = v_id_tipol_intervento and cur_param.flag_pubblico_privato = v_flag_pubblico_privato THEN
				 t_importo_minimo_erogabile := coalesce(cur_param.importo_minimo_erogabile,t_importo_minimo_erogabile);
				 t_importo_massimo_erogabile := coalesce(cur_param.importo_massimo_erogabile,t_importo_massimo_erogabile);
				 t_budget_disponibile := coalesce(cur_param.budget_disponibile,t_budget_disponibile);
				 t_perc_max_contributo_erogabile := coalesce(cur_param.perc_max_contributo_erogabile,t_perc_max_contributo_erogabile);
				 t_cod_tipo_graduatoria := coalesce(cur_param.cod_tipo_graduatoria,t_cod_tipo_graduatoria);
			-- RAISE NOTICE '2-t_importo_minimo_erogabile %',t_importo_minimo_erogabile;
			 END IF;
         END IF;
		 
		 
     END LOOP;
     RETURN NEXT;
 END;
$$;


ALTER FUNCTION findom_os.fn_findom_get_param_istruttoria(p_id_sportello integer, p_id_tipol_intervento integer, p_flag_pubblico_privato integer) OWNER TO findom_os;

--
-- TOC entry 18782 (class 1255 OID 31175340)
-- Name: fn_findom_r_bandi_specifiche_valut(); Type: FUNCTION; Schema: findom_os; Owner: findom_os
--

CREATE FUNCTION findom_os.fn_findom_r_bandi_specifiche_valut() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
		-- Controllo che se il il TIPO_CAMPO = 'calcolato' allora ID_REGOLA è obbligatorio
		--  Altrimenti ID_REGOLA deve essere NULL
		
		IF NEW.tipo_campo = 'calcolato' THEN
		   IF NEW.id_regola IS NULL THEN
		      RAISE EXCEPTION 'IMPOSTARE ID_REGOLA';
		   END IF;
		ELSE
		   IF NEW.id_regola IS NOT NULL  THEN
		      RAISE EXCEPTION 'ID_REGOLA DEVE ESSERE NULL';
		   END IF;
		END IF;
		
		-- Controllo che se visibile in domanda il tipo campo deve essere solo "checkbox" e "radiobutton"
		IF NEW.flag_visibile_in_domanda IS TRUE THEN 
		   IF NEW.tipo_campo  NOT IN ('checkbox','radiobutton') THEN 
			  RAISE EXCEPTION 'Se visibile in domanda il tipo campo deve essere solo "checkbox" e "radiobutton"';
		   END IF;
		END IF;
		
        RETURN NEW;
    END;
$$;


ALTER FUNCTION findom_os.fn_findom_r_bandi_specifiche_valut() OWNER TO findom_os;

--
-- TOC entry 18783 (class 1255 OID 31175341)
-- Name: fn_findom_t_allegati_sportello(); Type: FUNCTION; Schema: findom_os; Owner: findom_os
--

CREATE FUNCTION findom_os.fn_findom_t_allegati_sportello() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
	   v_id_bando_sportello integer;
	   v_id_bando_intervento integer;
	   v_id_bando_beneficiario integer;
	   v_match_bando  numeric(1) := 0;
	   c1 refcursor;
 BEGIN
		
		v_id_bando_sportello = (select id_bando
		                          from findom_t_sportelli_bandi
					             where id_sportello_bando = NEW.id_sportello_bando);

	
		-- Controllo che la tipologia di beneficiario  sia associato al bando dello sportello
		IF NEW.id_tipol_beneficiario IS NOT NULL THEN
						
			OPEN c1 FOR EXECUTE 'select id_bando
								from  findom_r_tipol_beneficiari_bandi
								WHERE id_tipol_beneficiario = '|| NEW.id_tipol_beneficiario;

			  loop 
				fetch c1 into  v_id_bando_beneficiario;
				if not found then
				   exit;
				else
				  if v_id_bando_beneficiario = v_id_bando_sportello then
					 v_match_bando := 1;
					 exit;
				  end if;
				end if;

			   end loop;
			close c1;
		ELSE
		  v_match_bando := 1; -- Viene forzato il match se id_tipol_beneficiario IS NULL
		END IF;

		IF v_match_bando = 0  THEN
		   RAISE EXCEPTION 'La tipologia di beneficiario deve essere associato al bando a cui lo sportello si riferisce';
		END IF;

        RETURN NEW;
    END;
$$;


ALTER FUNCTION findom_os.fn_findom_t_allegati_sportello() OWNER TO findom_os;

--
-- TOC entry 18784 (class 1255 OID 31175342)
-- Name: fn_findom_t_bandi(); Type: FUNCTION; Schema: findom_os; Owner: findom_os
--

CREATE FUNCTION findom_os.fn_findom_t_bandi() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
	   v_id_tipo_suddivisione integer;
    BEGIN
	    -- Controllo che se FLAG_DEMAT = 'S' allora il TIPO_FIRMA deve essere settato = (D,S)
		-- Controllo che se il FLAG_DEMAT è nullo allora anche il TIPO_FIRMA deve essere nullo
		
		IF NEW.flag_demat IS NULL THEN  --NO DEMATERIALIZZAZIONE
		   IF NEW.tipo_firma IS NOT NULL THEN
		      RAISE EXCEPTION 'Bando non soggetto a dematerializzazione. Non impostare il tipo di firma';
		   END IF;
		ELSE  -- DEMATERIALIZZAZIONE
		   IF NEW.tipo_firma IS NULL THEN 
		      RAISE EXCEPTION 'Bando  soggetto a dematerializzazione. Impostare il tipo di firma (F=Firma digitale,S=Scansione)';
		   END IF;
		END IF;
        -- Controllo che l'ID_TEMPLATE coincida con ID_BANDO
        IF NEW.template_id != NEW.id_bando THEN
            RAISE EXCEPTION 'Il bando deve avere lo stesso id del template';
        END IF;
		
		v_id_tipo_suddivisione = (select id_tipo_suddivisione
		                            from findom_d_classif_bandi
								    where id_classificazione = NEW.id_classificazione);
		-- Controllo che la classificazione appartenga alla suddivisione id_suddivisione = 5 (Azione)
		IF v_id_tipo_suddivisione != 5 THEN
		   RAISE EXCEPTION 'Il bando deve essere referenziato alla classificazione con id_suddivisione=5 (Azione)';
		END IF;
        RETURN NEW;
    END;
$$;


ALTER FUNCTION findom_os.fn_findom_t_bandi() OWNER TO findom_os;

--
-- TOC entry 18785 (class 1255 OID 31175343)
-- Name: fn_findom_t_param_sportelli_bandi(); Type: FUNCTION; Schema: findom_os; Owner: findom_os
--

CREATE FUNCTION findom_os.fn_findom_t_param_sportelli_bandi() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
	   v_id_bando_sportello integer;
	   v_id_bando_intervento integer;
	   v_match_bando  numeric(1) := 0;
	   c1 refcursor;
 BEGIN
		
		v_id_bando_sportello = (select id_bando
		                          from findom_t_sportelli_bandi
					             where id_sportello_bando = NEW.id_sportello_bando);
						
		OPEN c1 FOR EXECUTE 'select id_bando
							from  findom_r_bandi_tipol_interventi
						    WHERE id_tipol_intervento = '|| NEW.id_tipol_intervento;

		  loop 
			fetch c1 into  v_id_bando_intervento;
			if not found then
			   exit;
			else
			  if v_id_bando_intervento = v_id_bando_sportello then
			     v_match_bando := 1;
				 exit;
			  end if;
			end if;

		   end loop;
		close c1;

		-- Controllo che la classificazione appartenga alla suddivisione id_suddivisione = 5 (Azione)
		IF v_match_bando = 0  THEN
		   RAISE EXCEPTION 'La tipologia di intervento deve essere associato al bando a cui lo sportello si riferisce';
		END IF;
        RETURN NEW;
    END;
$$;


ALTER FUNCTION findom_os.fn_findom_t_param_sportelli_bandi() OWNER TO findom_os;

--
-- TOC entry 18786 (class 1255 OID 31175344)
-- Name: fn_findom_t_valori_sportello(); Type: FUNCTION; Schema: findom_os; Owner: findom_os
--

CREATE FUNCTION findom_os.fn_findom_t_valori_sportello() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
	   v_id_bando_sportello integer;
	   v_id_bando_intervento integer;
	   v_id_bando_beneficiario integer;
	   v_match_bando  numeric(1) := 0;
	   c1 refcursor;
 BEGIN
		
		v_id_bando_sportello = (select id_bando
		                          from findom_t_sportelli_bandi
					             where id_sportello_bando = NEW.id_sportello_bando);

		-- Controllo che la tipologia di intervento  sia associato al bando dello sportello
		IF NEW.id_tipol_intervento IS NOT NULL THEN
						
			OPEN c1 FOR EXECUTE 'select id_bando
								from  findom_r_bandi_tipol_interventi
								WHERE id_tipol_intervento = '|| NEW.id_tipol_intervento;

			  loop 
				fetch c1 into  v_id_bando_intervento;
				if not found then
				   exit;
				else
				  if v_id_bando_intervento = v_id_bando_sportello then
					 v_match_bando := 1;
					 exit;
				  end if;
				end if;

			   end loop;
			close c1;
		ELSE
		  v_match_bando := 1; -- Viene forzato il match se id_tipol_intervento IS NULL
		END IF;

		IF v_match_bando = 0  THEN
		   RAISE EXCEPTION 'La tipologia di intervento deve essere associato al bando a cui lo sportello si riferisce';
		END IF;
		
		-- Controllo che la tipologia di beneficiario  sia associato al bando dello sportello
		IF NEW.id_tipol_beneficiario IS NOT NULL THEN
						
			OPEN c1 FOR EXECUTE 'select id_bando
								from  findom_r_tipol_beneficiari_bandi
								WHERE id_tipol_beneficiario = '|| NEW.id_tipol_beneficiario;

			  loop 
				fetch c1 into  v_id_bando_beneficiario;
				if not found then
				   exit;
				else
				  if v_id_bando_beneficiario = v_id_bando_sportello then
					 v_match_bando := 1;
					 exit;
				  end if;
				end if;

			   end loop;
			close c1;
		ELSE
		  v_match_bando := 1; -- Viene forzato il match se id_tipol_beneficiario IS NULL
		END IF;

		IF v_match_bando = 0  THEN
		   RAISE EXCEPTION 'La tipologia di beneficiario deve essere associato al bando a cui lo sportello si riferisce';
		END IF;

        RETURN NEW;
    END;
$$;


ALTER FUNCTION findom_os.fn_findom_t_valori_sportello() OWNER TO findom_os;

--
-- TOC entry 18787 (class 1255 OID 31175345)
-- Name: fnc_allinea_istruttoria(); Type: FUNCTION; Schema: findom_os; Owner: findom_os
--

CREATE FUNCTION findom_os.fnc_allinea_istruttoria() RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
f integer;
r boolean;

cur_domande_inviate RECORD;

c0 refcursor;
c1 refcursor;

v_num_domande integer := 0;



v_pg_exception_context text;
v_pg_exception_detail text;
v_pg_exception_hint text;

 
BEGIN
------------------------------------------------------------------------------------------------
--           Ribaltamento da AGGR_T_MODEL,AGGR_T_MODEL_INDEX a ISTR_T_MODEL,ISTR_T_MODEL_INDEX
--           delle domande inviate
------------------------------------------------------------------------------------------------

FOR cur_domande_inviate IN select * from aggr_t_model a
									where a.model_state_fk = 'IN'
									and not exists
									(select null
									from istr_t_model
									where model_id = a.model_id)
LOOP
   
   insert into istr_t_model 
    (model_id,
     template_code_fk,
     model_progr,
     user_id,
     serialized_model,
     model_state_fk,
     model_name,
     model_last_update)
	 values
	 (cur_domande_inviate.model_id,
     cur_domande_inviate.template_code_fk,
     cur_domande_inviate.model_progr,
     cur_domande_inviate.user_id,
     cur_domande_inviate.serialized_model,
     'RI', --Ricevuta
     cur_domande_inviate.model_name,
     cur_domande_inviate.model_last_update);
	 
	 insert into istr_t_model_index
	 select * 
	   from aggr_t_model_index
	   where model_id = cur_domande_inviate.model_id;
	 
   v_num_domande := v_num_domande+1;
END LOOP;

    RAISE NOTICE 'Numero domande ribaltate in istruttoria % ' ,v_num_domande;


--==========================================================================

RETURN 0;

EXCEPTION
    WHEN OTHERS THEN
	 GET STACKED DIAGNOSTICS v_pg_exception_context = PG_EXCEPTION_CONTEXT,
                          v_pg_exception_detail = PG_EXCEPTION_DETAIL,
                          v_pg_exception_hint = PG_EXCEPTION_HINT;

    RAISE NOTICE 'Codice errore % messaggio errore %  PG_EXCEPTION_CONTEXT %',
                SQLSTATE, SQLERRM,v_pg_exception_context; 
    RETURN 1;
END;
$$;


ALTER FUNCTION findom_os.fnc_allinea_istruttoria() OWNER TO findom_os;

--
-- TOC entry 18788 (class 1255 OID 31175346)
-- Name: fnc_cancella_graduatoria_chiusa(integer); Type: FUNCTION; Schema: findom_os; Owner: findom_os
--

CREATE FUNCTION findom_os.fnc_cancella_graduatoria_chiusa(p_id_graduatoria integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE

v_ritorno  integer;

v_dt_chiusura_graduatoria date;
v_id_graduatoria_rif integer;


v_pg_exception_context text;
v_pg_exception_detail text;
v_pg_exception_hint text;

c1 refcursor;
v_dummy  integer;
 
BEGIN
	
	SELECT dt_chiusura_graduatoria,
		   id_graduatoria_rif
     INTO v_dt_chiusura_graduatoria,
	       v_id_graduatoria_rif
     FROM shell_t_graduatoria
    WHERE id_graduatoria = p_id_graduatoria;
	
									
	IF NOT FOUND THEN
		RAISE EXCEPTION 'Graduatoria % not found', p_id_graduatoria;
	END IF;


    IF v_dt_chiusura_graduatoria is  null THEN
      RAISE EXCEPTION 'Graduatoria % ancora aperta', p_id_graduatoria;
    END IF;

    IF v_id_graduatoria_rif is not null THEN
      RAISE EXCEPTION 'La graduatoria % è una rifinanziata della graduatoria %', p_id_graduatoria, v_id_graduatoria_rif;
    END IF;
	
	OPEN c1 FOR EXECUTE 'select 1
						from  shell_t_graduatoria
						WHERE id_graduatoria_rif = '|| p_id_graduatoria;

		FETCH c1 INTO  v_dummy;
		IF  FOUND THEN
           RAISE EXCEPTION 'La graduatoria % è già stata rifinanziata', p_id_graduatoria;
		END IF;

	CLOSE c1;
	
	update shell_t_graduatoria
	set dt_chiusura_graduatoria = null
	where id_graduatoria = p_id_graduatoria;

   -- Aggiorno lo stato istruttoria nelle domande in graduatoria
	update shell_t_domande
	   set id_stato_istr = 15 -- Chiusa valutazione
	where id_stato_istr not in (13,18)
	and id_domanda in
	(select id_domanda from shell_t_dett_graduatoria
	  where id_graduatoria = p_id_graduatoria);
	  
	update shell_t_domande
	   set id_stato_istr = 3 -- Non ammissibile
	where id_stato_istr = 13 -- Non ammessa
	and id_domanda in
	(select id_domanda from shell_t_dett_graduatoria
	  where id_graduatoria = p_id_graduatoria);
	  
	-- Per i bandi con valutazione esterna
	update shell_t_domande
	   set id_stato_istr = 2 -- Ammissibile
	where id_stato_istr = 18 -- Ammessa
	and id_domanda in
	(select id_domanda from shell_t_dett_graduatoria
	  where id_graduatoria = p_id_graduatoria);
	  
	  
	SELECT fnc_pulisci_graduatoria(p_id_graduatoria)
	  INTO v_ritorno;
	  
	IF v_ritorno != 0 THEN
		RAISE EXCEPTION 'Errore in pulisci graduatoria %', p_id_graduatoria;
	END IF;


--==========================================================================

RETURN 0;

EXCEPTION
    WHEN OTHERS THEN
	 GET STACKED DIAGNOSTICS v_pg_exception_context = PG_EXCEPTION_CONTEXT,
                          v_pg_exception_detail = PG_EXCEPTION_DETAIL,
                          v_pg_exception_hint = PG_EXCEPTION_HINT;

    RAISE NOTICE 'Codice errore % messaggio errore %  PG_EXCEPTION_CONTEXT %',
                SQLSTATE, SQLERRM,v_pg_exception_context; 
    RETURN 1;
END;
$$;


ALTER FUNCTION findom_os.fnc_cancella_graduatoria_chiusa(p_id_graduatoria integer) OWNER TO findom_os;

--
-- TOC entry 18789 (class 1255 OID 31175347)
-- Name: fnc_crea_scheda_progetto(integer); Type: FUNCTION; Schema: findom_os; Owner: findom_os
--

CREATE FUNCTION findom_os.fnc_crea_scheda_progetto(p_id_domanda integer) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
DECLARE


cur_scheda_progetto RECORD;

v_dt_invio_domanda date;
v_dummy  integer;



v_pg_exception_context text;
v_pg_exception_detail text;
v_pg_exception_hint text;

 
BEGIN
------------------------------------------------------------------------------------------------
-- Creazione scheda progetto
-- Funzione inserimento valutazioni in domanda
-- Inserimento dei parametri di valutazione selezionati dal beneficiario  (shell_t_valut_domande)
------------------------------------------------------------------------------------------------

	SELECT dt_invio_domanda
     INTO v_dt_invio_domanda
     FROM shell_t_domande
    WHERE id_domanda = p_id_domanda;
									
	IF NOT FOUND THEN
		RAISE EXCEPTION 'Domanda % not found', p_id_domanda;
	END IF;

    IF v_dt_invio_domanda is  null THEN
      RAISE EXCEPTION 'Domanda % non ancora inviata', p_id_domanda;
    END IF;
	
	-- Pulizia di eventuali parametri già inseriti (Domanda già inviata ritornata in stato di bozza)
	DELETE from shell_t_valut_domande
	WHERE id_domanda = p_id_domanda
	AND stato_valut = 'D';
									
	FOR cur_scheda_progetto IN select * from findom_v_domande_scheda_progetto_valut
									where id_domanda = p_id_domanda
									  and selezionato = 'S'

	LOOP
   
		insert into shell_t_valut_domande
		(
		 id_domanda,
		 id_parametro_valut,
		 dt_valutazione,
		 punteggio,
		 stato_valut
		)
		values
		(
		 cur_scheda_progetto.id_domanda,
		 cur_scheda_progetto.id_parametro_valut,
		 'now'::date,
		 cur_scheda_progetto.punteggio,
		 'D'
		);

	END LOOP;

--==========================================================================

RETURN 0;

EXCEPTION
    WHEN OTHERS THEN
	 GET STACKED DIAGNOSTICS v_pg_exception_context = PG_EXCEPTION_CONTEXT,
                          v_pg_exception_detail = PG_EXCEPTION_DETAIL,
                          v_pg_exception_hint = PG_EXCEPTION_HINT;

    RAISE NOTICE 'Codice errore % messaggio errore %  PG_EXCEPTION_CONTEXT %',
                SQLSTATE, SQLERRM,v_pg_exception_context; 
				
    RETURN 'Codice errore '||SQLSTATE|| ' messaggio errore '||SQLERRM||' PG_EXCEPTION_CONTEXT '|| v_pg_exception_context;
END;
$$;


ALTER FUNCTION findom_os.fnc_crea_scheda_progetto(p_id_domanda integer) OWNER TO findom_os;

--
-- TOC entry 18790 (class 1255 OID 31175348)
-- Name: fnc_pif_aggiorna_data_scarico(); Type: FUNCTION; Schema: findom_os; Owner: findom_os
--

CREATE FUNCTION findom_os.fnc_pif_aggiorna_data_scarico() RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE



v_pg_exception_context text;
v_pg_exception_detail text;
v_pg_exception_hint text;

v_count   integer;
 
BEGIN
---------------------------------------------------------------------------------------------------
-- Aggiorno la data di scarico excel
---------------------------------------------------------------------------------------------------
SELECT INTO v_count count(*) FROM findom_w_domande_pif;

IF v_count >0 THEN
	 
	UPDATE findom_w_pif_excel_ult_invio a
	  set  dt_invio = (select max(sh.dt_invio_domanda)
						 from findom_w_domande_pif dp
						 join shell_t_domande  sh on (sh.id_domanda = dp.id_domanda));
	 
	EXECUTE 'TRUNCATE TABLE findom_w_domande_pif';

END IF;

--COMMIT;
--==========================================================================

--==========================================================================

RETURN 0;

EXCEPTION
    WHEN OTHERS THEN
	 GET STACKED DIAGNOSTICS v_pg_exception_context = PG_EXCEPTION_CONTEXT,
                          v_pg_exception_detail = PG_EXCEPTION_DETAIL,
                          v_pg_exception_hint = PG_EXCEPTION_HINT;

    RAISE NOTICE 'Codice errore % messaggio errore %  PG_EXCEPTION_CONTEXT %',
                SQLSTATE, SQLERRM,v_pg_exception_context; 
    RETURN 1;
END;
$$;


ALTER FUNCTION findom_os.fnc_pif_aggiorna_data_scarico() OWNER TO findom_os;

--
-- TOC entry 18791 (class 1255 OID 31175349)
-- Name: fnc_pulisci_graduatoria(integer); Type: FUNCTION; Schema: findom_os; Owner: findom_os
--

CREATE FUNCTION findom_os.fnc_pulisci_graduatoria(p_id_graduatoria integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE


cur_graduatoria RECORD;
c1 refcursor;


v_dt_chiusura_graduatoria date;
v_id_graduatoria_rif integer;
v_dummy  integer;



v_pg_exception_context text;
v_pg_exception_detail text;
v_pg_exception_hint text;

 
BEGIN
------------------------------------------------------------------------------------------------
-- Pulizia tabelle Graduatoria 
--      shell_t_graduatoria,shell_t_dett_graduatoria,shell_t_dett_criteri_graduatoria
------------------------------------------------------------------------------------------------

/*
  v_dt_chiusura_graduatoria = (select dt_chiusura_graduatoria
		                            from shell_t_graduatoria
								    where id_graduatoria = p_id_graduatoria);
*/
	SELECT dt_chiusura_graduatoria,
		   id_graduatoria_rif
     INTO v_dt_chiusura_graduatoria,
	       v_id_graduatoria_rif
     FROM shell_t_graduatoria
    WHERE id_graduatoria = p_id_graduatoria;
									
	IF NOT FOUND THEN
		RAISE EXCEPTION 'Graduatoria % not found', p_id_graduatoria;
	END IF;


    IF v_dt_chiusura_graduatoria is not null THEN
      RAISE EXCEPTION 'Graduatoria % chiusa', p_id_graduatoria;
    END IF;
	
									
	FOR cur_graduatoria IN select * from shell_t_dett_graduatoria
									where id_graduatoria = p_id_graduatoria

	LOOP
   
		delete from shell_t_dett_criteri_graduatoria
		  where id_dett_graduatoria = cur_graduatoria.id_dett_graduatoria;

	END LOOP;

	DELETE from shell_t_dett_graduatoria
	WHERE id_graduatoria = p_id_graduatoria;
	
	DELETE from shell_t_graduatoria
	WHERE id_graduatoria = p_id_graduatoria;



--==========================================================================

RETURN 0;

EXCEPTION
    WHEN OTHERS THEN
	 GET STACKED DIAGNOSTICS v_pg_exception_context = PG_EXCEPTION_CONTEXT,
                          v_pg_exception_detail = PG_EXCEPTION_DETAIL,
                          v_pg_exception_hint = PG_EXCEPTION_HINT;

    RAISE NOTICE 'Codice errore % messaggio errore %  PG_EXCEPTION_CONTEXT %',
                SQLSTATE, SQLERRM,v_pg_exception_context; 
    RETURN 1;
END;
$$;


ALTER FUNCTION findom_os.fnc_pulisci_graduatoria(p_id_graduatoria integer) OWNER TO findom_os;

--
-- TOC entry 18792 (class 1255 OID 31175350)
-- Name: fnc_valutaz_automatica(integer, integer); Type: FUNCTION; Schema: findom_os; Owner: findom_os
--

CREATE FUNCTION findom_os.fnc_valutaz_automatica(p_id_bando integer, p_id_funzionario integer) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
DECLARE


cur_valut RECORD;

v_id_bando integer;
v_id_funzionario integer;
v_dummy  integer;



v_pg_exception_context text;
v_pg_exception_detail text;
v_pg_exception_hint text;

 
BEGIN
------------------------------------------------------------------------------------------------
-- Valutazione automatica domande
-- Imposta lo stato istruttoria a 'In pre-valutazione' (shell_t_domande.id_stato_istr = 5)
-- la valutazione completata => shell_t_domande.flag_valutazione_completata = true
-- l'id istruttore amm => parametro p_id_funzionario
------------------------------------------------------------------------------------------------

	SELECT null
     INTO v_dummy
     FROM findom_t_bandi
    WHERE id_bando = p_id_bando;
									
	IF NOT FOUND THEN
		RAISE EXCEPTION 'Bando % not found', p_id_bando;
	END IF;

	SELECT null
     INTO v_dummy
     FROM findom_d_funzionari
    WHERE id_funzionario = p_id_funzionario;
									
	IF NOT FOUND THEN
		RAISE EXCEPTION 'Funzionario % not found', p_id_funzionario;
	END IF;
	
									
	FOR cur_valut IN select *
                                 from shell_t_domande d
								 join findom_t_sportelli_bandi s on s.id_sportello_bando = d.id_sportello_bando and s.id_bando = p_id_bando
								 where d.id_stato_istr = 1

	LOOP
	
	    update shell_t_domande
		   set id_stato_istr = 5, --Pre valutazione
		       flag_valutazione_completata = true,
			   id_istruttore_amm = p_id_funzionario
		 where id_domanda = cur_valut.id_domanda;
   
		insert into shell_t_valut_domande
		(
		 id_domanda,
		 id_parametro_valut,
		 dt_valutazione,
		 punteggio,
		 stato_valut
		)
		select id_domanda,
		       id_parametro_valut,
		       'now'::date,
		       punteggio,
		       'P'
		  from shell_t_valut_domande
		  where id_domanda = cur_valut.id_domanda
		    and stato_valut = 'D';

	END LOOP;

--==========================================================================

RETURN 0;

EXCEPTION
    WHEN OTHERS THEN
	 GET STACKED DIAGNOSTICS v_pg_exception_context = PG_EXCEPTION_CONTEXT,
                          v_pg_exception_detail = PG_EXCEPTION_DETAIL,
                          v_pg_exception_hint = PG_EXCEPTION_HINT;

    RAISE NOTICE 'Codice errore % messaggio errore %  PG_EXCEPTION_CONTEXT %',
                SQLSTATE, SQLERRM,v_pg_exception_context; 
				
    RETURN 'Codice errore '||SQLSTATE|| ' messaggio errore '||SQLERRM||' PG_EXCEPTION_CONTEXT '|| v_pg_exception_context;
END;
$$;


ALTER FUNCTION findom_os.fnc_valutaz_automatica(p_id_bando integer, p_id_funzionario integer) OWNER TO findom_os;

--
-- TOC entry 18793 (class 1255 OID 31175351)
-- Name: get_data(); Type: FUNCTION; Schema: findom_os; Owner: findom_os
--

CREATE FUNCTION findom_os.get_data() RETURNS character varying
    LANGUAGE plpgsql
    AS $$
DECLARE
v_data varchar(200);
BEGIN
--out_name := 'pippo';
select now() INTO v_data;
RETURN v_data;
END;
$$;


ALTER FUNCTION findom_os.get_data() OWNER TO findom_os;


--
-- TOC entry 64007 (class 2618 OID 31182269)
-- Name: findom_v_ateco_config ru_del_v_ateco_config; Type: RULE; Schema: findom_os; Owner: findom_os
--

CREATE RULE ru_del_v_ateco_config AS
    ON DELETE TO findom_os.findom_v_ateco_config DO INSTEAD  DELETE FROM findom_os.findom_r_bandi_ateco
  WHERE ((findom_r_bandi_ateco.id_bando = old.id_bando) AND (findom_r_bandi_ateco.id_ateco = ( SELECT ext_d_ateco.id_ateco
           FROM findom_os.ext_d_ateco
          WHERE ((ext_d_ateco.cod_ateco_norm)::text = (old.cod_ateco_norm)::text))));


--
-- TOC entry 64008 (class 2618 OID 31182270)
-- Name: findom_v_ateco_escl_config ru_del_v_ateco_escl_config; Type: RULE; Schema: findom_os; Owner: findom_os
--

CREATE RULE ru_del_v_ateco_escl_config AS
    ON DELETE TO findom_os.findom_v_ateco_escl_config DO INSTEAD  DELETE FROM findom_os.findom_r_bandi_ateco_escl
  WHERE ((findom_r_bandi_ateco_escl.id_bando = old.id_bando) AND (findom_r_bandi_ateco_escl.id_ateco = ( SELECT ext_d_ateco.id_ateco
           FROM findom_os.ext_d_ateco
          WHERE ((ext_d_ateco.cod_ateco_norm)::text = (old.cod_ateco_norm)::text))));


--
-- TOC entry 64009 (class 2618 OID 31182271)
-- Name: findom_v_ateco_config ru_ins_v_ateco_config; Type: RULE; Schema: findom_os; Owner: findom_os
--

CREATE RULE ru_ins_v_ateco_config AS
    ON INSERT TO findom_os.findom_v_ateco_config DO INSTEAD  INSERT INTO findom_os.findom_r_bandi_ateco (id_bando, id_ateco)
  VALUES (new.id_bando, ( SELECT ext_d_ateco.id_ateco
           FROM findom_os.ext_d_ateco
          WHERE ((ext_d_ateco.cod_ateco_norm)::text = (new.cod_ateco_norm)::text)));


--
-- TOC entry 64010 (class 2618 OID 31182272)
-- Name: findom_v_ateco_escl_config ru_ins_v_ateco_escl_config; Type: RULE; Schema: findom_os; Owner: findom_os
--

CREATE RULE ru_ins_v_ateco_escl_config AS
    ON INSERT TO findom_os.findom_v_ateco_escl_config DO INSTEAD  INSERT INTO findom_os.findom_r_bandi_ateco_escl (id_bando, id_ateco)
  VALUES (new.id_bando, ( SELECT ext_d_ateco.id_ateco
           FROM findom_os.ext_d_ateco
          WHERE ((ext_d_ateco.cod_ateco_norm)::text = (new.cod_ateco_norm)::text)));


--
-- TOC entry 64011 (class 2618 OID 31182273)
-- Name: findom_v_ateco_config ru_upd_v_ateco_config; Type: RULE; Schema: findom_os; Owner: findom_os
--

CREATE RULE ru_upd_v_ateco_config AS
    ON UPDATE TO findom_os.findom_v_ateco_config DO INSTEAD  UPDATE findom_os.findom_r_bandi_ateco SET id_ateco = ( SELECT ext_d_ateco.id_ateco
           FROM findom_os.ext_d_ateco
          WHERE ((ext_d_ateco.cod_ateco_norm)::text = (new.cod_ateco_norm)::text))
  WHERE ((findom_r_bandi_ateco.id_bando = old.id_bando) AND (findom_r_bandi_ateco.id_ateco = ( SELECT ext_d_ateco.id_ateco
           FROM findom_os.ext_d_ateco
          WHERE ((ext_d_ateco.cod_ateco_norm)::text = (old.cod_ateco_norm)::text))));


--
-- TOC entry 64012 (class 2618 OID 31182274)
-- Name: findom_v_ateco_escl_config ru_upd_v_ateco_escl_config; Type: RULE; Schema: findom_os; Owner: findom_os
--

CREATE RULE ru_upd_v_ateco_escl_config AS
    ON UPDATE TO findom_os.findom_v_ateco_escl_config DO INSTEAD  UPDATE findom_os.findom_r_bandi_ateco_escl SET id_ateco = ( SELECT ext_d_ateco.id_ateco
           FROM findom_os.ext_d_ateco
          WHERE ((ext_d_ateco.cod_ateco_norm)::text = (new.cod_ateco_norm)::text))
  WHERE ((findom_r_bandi_ateco_escl.id_bando = old.id_bando) AND (findom_r_bandi_ateco_escl.id_ateco = ( SELECT ext_d_ateco.id_ateco
           FROM findom_os.ext_d_ateco
          WHERE ((ext_d_ateco.cod_ateco_norm)::text = (old.cod_ateco_norm)::text))));


--
-- TOC entry 57330 (class 2620 OID 31182275)
-- Name: findom_r_bandi_specifiche_valut tg_findom_r_bandi_specifiche_valut_bi; Type: TRIGGER; Schema: findom_os; Owner: findom_os
--

CREATE TRIGGER tg_findom_r_bandi_specifiche_valut_bi BEFORE INSERT OR UPDATE ON findom_os.findom_r_bandi_specifiche_valut FOR EACH ROW EXECUTE PROCEDURE findom_os.fn_findom_r_bandi_specifiche_valut();


--
-- TOC entry 57331 (class 2620 OID 31182276)
-- Name: findom_t_allegati_sportello tg_findom_t_allegati_sportello_bi; Type: TRIGGER; Schema: findom_os; Owner: findom_os
--

CREATE TRIGGER tg_findom_t_allegati_sportello_bi BEFORE INSERT OR UPDATE ON findom_os.findom_t_allegati_sportello FOR EACH ROW EXECUTE PROCEDURE findom_os.fn_findom_t_allegati_sportello();


--
-- TOC entry 57332 (class 2620 OID 31182277)
-- Name: findom_t_bandi tg_findom_t_bandi_bi; Type: TRIGGER; Schema: findom_os; Owner: findom_os
--

CREATE TRIGGER tg_findom_t_bandi_bi BEFORE INSERT OR UPDATE ON findom_os.findom_t_bandi FOR EACH ROW EXECUTE PROCEDURE findom_os.fn_findom_t_bandi();


--
-- TOC entry 57333 (class 2620 OID 31182278)
-- Name: findom_t_param_sportelli_bandi tg_findom_t_param_sportelli_bandi_bi; Type: TRIGGER; Schema: findom_os; Owner: findom_os
--

CREATE TRIGGER tg_findom_t_param_sportelli_bandi_bi BEFORE INSERT OR UPDATE ON findom_os.findom_t_param_sportelli_bandi FOR EACH ROW EXECUTE PROCEDURE findom_os.fn_findom_t_param_sportelli_bandi();


--
-- TOC entry 57334 (class 2620 OID 31182279)
-- Name: findom_t_valori_sportello tg_findom_t_valori_sportello_bi; Type: TRIGGER; Schema: findom_os; Owner: findom_os
--

CREATE TRIGGER tg_findom_t_valori_sportello_bi BEFORE INSERT OR UPDATE ON findom_os.findom_t_valori_sportello FOR EACH ROW EXECUTE PROCEDURE findom_os.fn_findom_t_valori_sportello();


