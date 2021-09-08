@RestResource(urlMapping = '/restUpdateSimulation')global without sharing class WS_updateSimulation {
	@HttpPost
	global static void pushToSF() {
		RestResponse response = RestContext.response;
		try {
            
            
			System.debug('**** PUSH TO SF ****');

			Data data = (Data) JSON.deserialize(RestContext.request.requestBody.toString(), Data.class);
			System.debug('** DATA : ' + data);
			API_Calls_Monitor__c apiCall = new API_Calls_Monitor__c();
			apiCall.JSON_File__c = String.valueOf(data);
			insert apiCall;

            Id ownerId;
            SYSTEM.debug(data.simulation.MCI_SIM_ID);
            //Update Simulation
            if(!String.isEmpty(data.simulation.MCI_SIM_ID )){
            		List<Simulation__c> simulations = [SELECT Id , Lead__c , Contact__c  , MCI_Sim_ID__c FROM Simulation__c where MCI_Sim_ID__c = :data.simulation.MCI_SIM_ID];
					system.debug(simulations.size());
                    if(simulations.size() > 0) {
						Simulation__c sim = new Simulation__c();
                        sim.Id = simulations[0].Id;
                        sim.Type_de_cr_dit__c =  data.simulation.type_credit;

                        if(!String.isEmpty(data.simulation.date_debut_activite_pro))  sim.Date_debut_d_activit__c = date.newInstance(integer.valueOf(data.simulation.date_debut_activite_pro.split('/', 3)[2]),integer.valueOf(data.simulation.date_debut_activite_pro.split('/', 3)[1]),integer.valueOf(data.simulation.date_debut_activite_pro.split('/', 3)[0])) ;
                        else sim.Date_debut_d_activit__c = null;
                        
                        if(!String.isEmpty(data.simulation.date_preparation_two_annees_bilan))  sim.Date_des_2_annees_de_bilan_rempli__c = date.newInstance(integer.valueOf(data.simulation.date_preparation_two_annees_bilan.split('/', 3)[2]),integer.valueOf(data.simulation.date_preparation_two_annees_bilan.split('/', 3)[1]),integer.valueOf(data.simulation.date_preparation_two_annees_bilan.split('/', 3)[0]));
                        else sim.Date_des_2_annees_de_bilan_rempli__c = null;
                        
                        if(!String.isEmpty(data.simulation.date_de_titularisation))  sim.Date_de_titularisation_rempli__c =  date.newInstance(integer.valueOf(data.simulation.date_de_titularisation.split('/', 3)[2]),integer.valueOf(data.simulation.date_de_titularisation.split('/', 3)[1]),integer.valueOf(data.simulation.date_de_titularisation.split('/', 3)[0]));
                        else sim.Date_de_titularisation_rempli__c = null;
                        
                        if(!String.isEmpty(data.simulation.date_promise_reception_fond_dossier))  sim.Date_promise_de_reception_de_FDD__c = date.newInstance(integer.valueOf(data.simulation.date_promise_reception_fond_dossier.split('/', 3)[2]),integer.valueOf(data.simulation.date_promise_reception_fond_dossier.split('/', 3)[1]),integer.valueOf(data.simulation.date_promise_reception_fond_dossier.split('/', 3)[0])) ;
                        else sim.Date_promise_de_reception_de_FDD__c = null;
                        
                        sim.Type_de_Bien__c =  data.simulation.estate_type;
                        
                        if(!String.isEmpty(data.simulation.delai_de_concretistion))  sim.D_lai_de_concr_tisation__c =  data.simulation.delai_de_concretistion.replace(',',';');
                        else sim.D_lai_de_concr_tisation__c =  null;

                        sim.Nature_du_bien__c =  data.simulation.etat_du_bien_immobililer_objet_du_financement;

                        if(!String.isEmpty(data.simulation.date_declatement_du_titre))  sim.date_d_eclatement__c =  date.newInstance(integer.valueOf(data.simulation.date_declatement_du_titre.split('/', 3)[2]),integer.valueOf(data.simulation.date_declatement_du_titre.split('/', 3)[1]),integer.valueOf(data.simulation.date_declatement_du_titre.split('/', 3)[0]));
                        else sim.date_d_eclatement__c = null;

                        sim.Type_d_usage_du_bien_immobilier__c =  data.simulation.usage_type;
                        if(!String.isEmpty(data.simulation.filter_client_bank)) sim.Client_actuel_de_s_banque_s__c =  data.simulation.filter_client_bank.replace(',',';');
                        else sim.Client_actuel_de_s_banque_s__c = null;

                        if(data.simulation.trouve_bien!= null) sim.Trouv_le_bien__c =  data.simulation.trouve_bien;
                        else sim.Trouv_le_bien__c = false;

                        sim.Montant_du_cr_dit__c =  data.simulation.montant_credit;

                        sim.Total_des_revenus__c =  data.simulation.total_revenus;
                        sim.Cap_d_endettement_maximal__c =  data.simulation.cap_endettement;
                        sim.Total_credits_en_cours__c =  data.simulation.total_credits_encours;
                        sim.Anciennet_activit_pro_X__c =  data.simulation.anciennete_activite_pro;
                        
                        if(data.simulation.etre_accompagne_par_muwabawb!= null) sim.Souhaite_tre_rapp_par_Mbwb_T__c =  data.simulation.etre_accompagne_par_muwabawb;
                        else sim.Souhaite_tre_rapp_par_Mbwb_T__c = false;

                        sim.Prix_du_terrain__c =  data.simulation.estate_price;
                        sim.Cout_devis_de_la_construction__c =  data.simulation.construction_price;
                        if(data.simulation.has_co_emprunt!= null) sim.CO_emprunt__c =  data.simulation.has_co_emprunt;
                        else sim.CO_emprunt__c = false;

                        sim.Montant_co_emprunteur__c =  data.simulation.co_emprunt_amount;
                        //Update Of 30/08/2021
                        if(!String.isEmpty(data.simulation.date_send_recap))  sim.date_gen_pap__c = date.newInstance(integer.valueOf(data.simulation.date_send_recap.split('/', 3)[2]),integer.valueOf(data.simulation.date_send_recap.split('/', 3)[1]),integer.valueOf(data.simulation.date_send_recap.split('/', 3)[0])) ;
                        else sim.date_gen_pap__c = null;

                        if(data.simulation.recap_envoye!= null) sim.Recap_envoye__c =  data.simulation.recap_envoye; 
                        else sim.Recap_envoye__c = false;

                        if(data.simulation.is_rentier != null) sim.tes_vous_rentier__c = data.simulation.is_rentier;
                        else sim.tes_vous_rentier__c = false;

                        if(!String.isEmpty(data.simulation.sent_email_ma)) {
                            List<User> conseilleres = [Select Id , email From User Where email = :data.simulation.sent_email_ma];
                            if(conseilleres.size()>0) sim.Conseill_re__c  = conseilleres.get(0).Id;
                        }
                        else sim.Conseill_re__c  = null;
                        
                        sim.Type_de_taux__c =  data.simulation.sim_selected_taux_type;
                        sim.Modalit_de_paiement_de_l_ADI__c =  data.simulation.sim_selected_type_adis;
                        sim.NB_Conditions_demand_es__c =  data.simulation.autres_conditions_demandees_par_le_client;
                        sim.Offre_selection_e_propos_e_par__C =  data.simulation.sim_selected_bank_name;
                        sim.Type_de_taux_OC__c =  data.simulation.oc_type_taux;
                        sim.Autres_conditions_propos_es_au_client__c =  data.simulation.oc_autres_conditions_proposees_au_client;
                        sim.Banque_concurrente__c =  data.simulation.oc_bank_name;
                        sim.Projet_conventionn_taux_sp_cial__c =  data.simulation.projets_conventionne;
                        
                        sim.Apport_hors_FDN__c =  data.simulation.apport_en_fonds_propres_requis;
                        sim.Quotit_de_financement_X__c =  data.simulation.quotite_de_financement;
                        sim.CD_Dur_e_en_Ann_es__c =  data.simulation.sim_selected_year;
                        sim.CD_Taux_HT__c =  data.simulation.sim_selected_taux_ht;
                        sim.CD_Taux_assurance__c =  data.simulation.sim_selected_taux_as_mensualise;
                        sim.Taux_de_l_ADI_en_prime_unique__c =  data.simulation.sim_selected_taux_as_prime_unique;
                        sim.Frais_de_dossier_de_l_offre_selectionn_e__c =  data.simulation.sim_selected_frais_de_dossier;
                        sim.Taux_annuel_effectif_global_TAEG_X__c =  data.simulation.sim_selected_taeg;
                        sim.Mensualit_aux_conditions_demand_es_X__c =  data.simulation.sim_selected_echeance_mensuelle;
                        sim.Cout_du_cr_dit_aux_condition_demand_es_X__c =  data.simulation.sim_selected_cout_credit;
                        sim.Economies_r_aliser_X__c =  data.simulation.sim_selected_economies;
                        sim.Diff_rence_de_mensualit_X__c =  data.simulation.sim_selected_difference_de_mensualite;
                        sim.Taux_d_endettement_inc_Ech_X__c =  data.simulation.sim_selected_taux_dendettementinc_ech;
                        sim.OC_Montant_emprunter__c =  data.simulation.oc_montant_credit;
                        sim.OC_Dur_e_du_cr_dit_en_Ann_es__c	 =  data.simulation.oc_duree_credit_nbr_dannees;
                        sim.OC_Taux_HT__c =  data.simulation.oc_taux_ht_credit;
                        sim.OC_Taux_assurance__c =  data.simulation.oc_taux_de_lassurance_deces_invalidite_m;
                        sim.OC_Ass_prime_unique_FP__c =  data.simulation.oc_taux_de_lassurance_deces_invalidite_pu;
                        sim.Frais_de_dossier_OC__c =  data.simulation.oc_frais_de_dossier;
                        sim.TAEG_2_EFFECTIF_OC__c =  data.simulation.oc_taeg_effectif_two;
                        sim.Frais_de_notaire_et_d_enregistrement_X__c =  data.simulation.total_des_frais_de_notaire;
                        sim.Montant_des_Frais_de_notaire_enregi_X__c =  data.simulation.montant_frais_notaire_inclus_credit_bancaire ;
                        sim.Montant_des_frais_d_am_nagement_inclus_X__c =  data.simulation.montant_frais_amenagement_inclus_credit_bancaire;
                        
                        if(data.simulation.oc_has_offre_prealable_signee_cachetee != null) sim.OPC_banque_concurrente_dispo__c = data.simulation.oc_has_offre_prealable_signee_cachetee;
                        else sim.OPC_banque_concurrente_dispo__c = false;

                        sim.Modalit_de_paiement_de_l_ADI_OC__c = data.simulation.oc_modalite_paiement_assurance_deces_invalidite;
                        sim.OC_Mensualit_estim_e_X__c = data.simulation.oc_echeance_mensuelle;
						update sim;
                        

                        if(! String.isEmpty(simulations[0].Contact__c)){
                            List<Contact> contacts = [Select Id, OwnerId from Contact where Id = :simulations[0].Contact__c];
                            system.debug(contacts.size());
                            if(contacts.size() > 0){
                                ownerId = (Id)contacts[0].ownerId;
                                
                                Contact contact = new Contact();
                                contact.Id = contacts[0].Id;

                                contact.put('Email', data.email);

                                if(data.email != null)
                                contact.put('Registered__c', data.registered);

                                contact.put('Profession__c', data.profession);


                                contact.put('Sexe__c', data.sexe);

                                contact.put('Nationalite__c', data.nationality);

                                contact.put('Pays_de_r_sidence__c', data.country);

                                contact.put('Ville_de_r_sidence_si_Maroc__c', data.ville_naissance);
                                
                                if(! String.isEmpty(data.date_naissance))
                                contact.put('Date_de_naissance__c', date.newInstance(integer.valueOf(data.date_naissance.split('/', 3)[2]),integer.valueOf(data.date_naissance.split('/', 3)[1]),integer.valueOf(data.date_naissance.split('/', 3)[0])));
                                else contact.put('Date_de_naissance__c', null);

                                contact.put('Niveau_acad_mique__c', data.niveau_academique);

                                contact.put('Age_remplis_par_le_client_X__c', data.age);
                                
                                contact.put('Age_calcul_EFD_date_de_naissance_X__c', data.client_age);
                                
                                //Update of 31/08/2021
                                //Si sent_email_client la valeur email sera ecrasé et prendra comme valeur sent_email_client
                                if(!String.isEmpty(data.sent_email_client)) contact.put('Email', data.sent_email_client);
                                
                                update contact;
                            }
                        }   
                        else if(! String.isEmpty(simulations[0].Lead__c)){
                            system.debug(sim.Lead__c);
                            List<Lead> leads = [Select Id  , ownerId from Lead where Id = :simulations[0].Lead__C];
                            system.debug(leads.size());
                            if(leads.size() > 0){
                                ownerId = (Id)leads[0].ownerId;
                                
                                Lead lead = new Lead();
                                lead.Id = leads[0].Id;
                                
                                lead.LastName =  data.name;
                                lead.Email = data.email;
                                if(!String.isEmpty(data.email)) lead.company = (data.email).contains('@mubawab.com') ? 'Mubawab' : 'MeilleurCreditImmo.ma';
                               //else lead.company = null;

                                lead.MobilePhone  = data.phone;
                                lead.utm_source__c  = data.utm_source;
                                lead.utm_campaign__c  = data.utm_campaign;
                                lead.utm_ciblage__c  = data.utm_ciblage;
                                if(!String.isEmpty(data.utm_creadate)) lead.utm_creadate__c  = date.newInstance(integer.valueOf(data.utm_creadate.split('/', 3)[2]),integer.valueOf(data.utm_creadate.split('/', 3)[1]),integer.valueOf(data.utm_creadate.split('/', 3)[0]));
                                else lead.utm_creadate__c  = null;

                                lead.utm_format__c  =  data.utm_format;
                                lead.utm_lang__c  =  data.utm_lang;
                                lead.utm_product__c  =  data.utm_product;
                                lead.utm_var__c  =  data.utm_var;
                                lead.utm_medium__c  =  data.utm_medium;
                                lead.utm_term__c  =  data.utm_term;
                                lead.utm_content__c  =  data.utm_content;
                                lead.utm_apporteur__c  =  data.utm_apporteur;
                                lead.Profession__c  =  data.profession;
                                lead.First_call_to_action__c  =  data.first_call_to_action;
                                lead.Sexe__c  =  data.sexe ;
                                lead.Nationalite__c  =  data.nationality ;
                                lead.Pays_de_r_sidence__c  =  data.country ;
                                lead.Ville_de_r_sidence_si_Maroc__c  =  data.ville_naissance ;
                                if(!String.isEmpty(data.date_naissance)) lead.Date_de_naissance__c  =  date.newInstance(integer.valueOf(data.date_naissance.split('/', 3)[2]),integer.valueOf(data.date_naissance.split('/', 3)[1]),integer.valueOf(data.date_naissance.split('/', 3)[0]));
                                else lead.Date_de_naissance__c  =  null;

                                lead.Niveau_acad_mique__c  =  data.niveau_academique ;
                                
                                if( data.registered!= null) lead.Registered__c  =  data.registered;
                                else lead.Registered__c = false;
                                lead.Age_remplis_par_le_client_X__c  =  data.age ;
                                lead.Age_calcul_EFD_date_de_naissance_X__c  =  data.client_age;
								
                                //Update of 31/08/2021
                                //Si sent_email_client la valeur email sera ecrasé et prendra comme valeur sent_email_client
                                if(!String.isEmpty(data.sent_email_client)) lead.Email = data.sent_email_client;
                                
                                update lead;
                                
                            }
                        }
					}
            }
            
           
                system.debug(ownerId);
                User InsertLeadAdvisor = [SELECT Name, Email, Phone, MobilePhone, Id FROM User WHERE Id = :ownerId];
                String responseJSON = '{\"Advisor_name\":\"' + InsertLeadAdvisor.Name +
                    '\",\"Advisor_Email\":\"' + InsertLeadAdvisor.Email +
                    '\",\"Advisor_Phone\":\"' + InsertLeadAdvisor.Phone +
                    '\",\"Advisor_MobilePhone\":\"' + InsertLeadAdvisor.MobilePhone + '\"}';
                if(!Test.isRunningTest()) {
                    response.responseBody = Blob.valueOf(responseJSON);
                    response.statusCode = 200;
                }

			}catch(Exception e) {
                system.debug('Error msg : ' + e.getMessage());
                if(!Test.isRunningTest()) {
                    response.statusCode = 500;
                    response.responseBody = Blob.valueOf('Error msg : ' + e.getMessage());
                }
            }

	}


	public class Data {
		public String name;
		public String phone;
		public String email;
		public String apporteur_ID;
		public String utm_source;
		public String utm_campaign;
		public String utm_medium;
		public String utm_term;
		public String utm_content;
		public String utm_apporteur;
		public String utm_ciblage;
		public String utm_creadate;
		public String utm_format;
		public String utm_lang;
		public String utm_product;
		public String utm_var;
		public String profession;
		public String first_call_to_action;
		public Boolean registered;
        public String Sexe;
        public String nationality;
        public String country;
        public String ville_naissance;
        public String date_naissance;
		public String niveau_academique;
        public Decimal age;
        public Decimal client_age;
        
        //Update Of 31/08/2021
        public String sent_email_client;

        public Simulation simulation;
	}

	public class Simulation {
		public String MCI_SIM_ID;
		public String type_credit;
		public Boolean trouve_bien;
		public Decimal montant_credit;
		public Decimal total_revenus;
		public Decimal cap_endettement;
		public Decimal total_credits_encours;
		//Update of 20/07/2021
		public String date_debut_activite_pro;
		public Decimal anciennete_activite_pro;
		public String date_preparation_two_annees_bilan;
		public String date_de_titularisation;
		public String estate_type;
		public String delai_de_concretistion;
		public Boolean etre_accompagne_par_muwabawb;
		public String etat_du_bien_immobililer_objet_du_financement;
		public String date_declatement_du_titre;
		public Decimal estate_price;
		public Decimal construction_price;
		public String usage_type;
		public Boolean has_co_emprunt;
		public Decimal co_emprunt_amount;
        public String filter_client_bank;
        
        //Update of 03/08/2021
        public Boolean recap_envoye;
        public Decimal apport_en_fonds_propres_requis;
        public Decimal quotite_de_financement;
        public Decimal sim_selected_year;
        public String sim_selected_taux_type;
        public Decimal sim_selected_taux_ht;
        public String sim_selected_type_adis;
        public Decimal sim_selected_taux_as_mensualise;
        public Decimal sim_selected_taux_as_prime_unique;
        public Decimal sim_selected_frais_de_dossier;
        public Decimal sim_selected_taeg;
        public Decimal sim_selected_echeance_mensuelle;
        public String autres_conditions_demandees_par_le_client;
        public Decimal sim_selected_cout_credit;
        public Decimal sim_selected_economies;
        public Decimal sim_selected_difference_de_mensualite;
        public Decimal sim_selected_taux_dendettementinc_ech;
        public String sim_selected_bank_name;
        public Boolean oc_has_offre_prealable_signee_cachetee;
        public Decimal oc_montant_credit;
        public Decimal oc_duree_credit_nbr_dannees;
        public String oc_type_taux;
        public Decimal oc_taux_ht_credit;
        public String oc_modalite_paiement_assurance_deces_invalidite;
        public Decimal oc_taux_de_lassurance_deces_invalidite_m;
        public Decimal oc_echeance_mensuelle;
        public Decimal oc_taux_de_lassurance_deces_invalidite_pu;
        public Decimal oc_frais_de_dossier;
        public Decimal oc_taeg_effectif_two;
        public String oc_autres_conditions_proposees_au_client;
        public String oc_bank_name;
        public Decimal total_des_frais_de_notaire;
        public Decimal montant_frais_notaire_inclus_credit_bancaire ;
        public Decimal montant_frais_amenagement_inclus_credit_bancaire;
        public String date_promise_reception_fond_dossier;
        public String projets_conventionne;
        //Update of 30/08/2021
        public Boolean is_rentier;
        public String sent_email_ma;
        public String date_send_recap;
	}



}