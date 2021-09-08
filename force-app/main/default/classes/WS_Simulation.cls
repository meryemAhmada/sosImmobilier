@ RestResource(urlMapping = '/restSimulation')global without sharing class WS_Simulation {
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

			/* SEARCH CONTACTS OR LEADS WITH SAME PHONE  */

			System.debug('** PHONE : ' + data.phone);
			List<Id> usersIdsInGroup = new List<Id>();
			String mobilePhone = data.phone.right(9);
			System.debug('** mobilePhone : ' + mobilePhone);
			List<List<sObject>> searchList = [FIND :mobilePhone IN PHONE FIELDS RETURNING Contact(Id, Email, OwnerId LIMIT 1), Lead(Id, Email, OwnerId LIMIT 1)];
			List<GroupMember> groupMembers = [Select Id, group.type, group.id, UserOrGroupId From GroupMember where group.developerName = 'Commerciaux_lead_immo'];

			for(GroupMember gm :groupMembers) {
				usersIdsInGroup.add(gm.UserOrGroupId);
			}


			sObject obj;

			if(!searchList.isEmpty() && searchList.size() > 0) {
				//CONTACT
				if(!searchList [0].isEmpty() && searchList [0].size() > 0) {
					obj = searchList [0] [0];

				}
				//LEAD
				else if(!searchList [1].isEmpty() && searchList [1].size() > 0) {
					obj = searchList [1] [0];
				}
			}

			System.debug('--> OBJECT FOUND : ' + obj);

			/* TREATMENT */

			if(obj != NULL) {
				obj.put('MCI_User_ID__c', data.MCI_User_ID);
				Task task_toInsert = new Task();

				//task_toInsert.WhatId = ;
				task_toInsert.WhoId = obj.id;
				task_toInsert.OwnerId = (Id) obj.get('ownerid');
				task_toInsert.Subject = System.Label.taskobject;
				task_toInsert.priority = 'Normal';
				task_toInsert.description = System.Label.taskdescription;

				insert task_toInsert;

				System.debug('** EMAIL : ' + data.email);


				//UPDATE EMAIL
				System.debug('--> UPDATE EMAIL');
				if(!String.isEmpty(data.email)) 
					obj.put('Email', data.email);
                
                //Update Of 31/08/2021
                //Si sent_email_client est renseigné, on ecrase l'ancienne et on prend la valeur de celle-ci
                if(!String.isEmpty(data.sent_email_client)) 
					obj.put('Email', data.sent_email_client);
                
				//UPDATE Registred
				System.debug('--> UPDATE Registred');
				obj.put('Registered__c', data.registered);
				//UPDATE profession
				System.debug('--> UPDATE profession');
				obj.put('Profession__c', data.profession);

				obj.put('Sexe__c', data.sexe);
				obj.put('Nationalite__c', data.nationality);
				obj.put('Pays_de_r_sidence__c', data.country);
				obj.put('Ville_de_r_sidence_si_Maroc__c', data.ville_naissance);
				
				if(! String.isEmpty(data.date_naissance))
                obj.put('Date_de_naissance__c', date.newInstance(integer.valueOf(data.date_naissance.split('/', 3)[2]),integer.valueOf(data.date_naissance.split('/', 3)[1]),integer.valueOf(data.date_naissance.split('/', 3)[0])));
				obj.put('Niveau_acad_mique__c', data.niveau_academique);
                obj.put('Age_remplis_par_le_client_X__c', data.age);
                obj.put('Age_calcul_EFD_date_de_naissance_X__c', data.client_age);
				
				if(!usersIdsInGroup.contains((Id) obj.get('ownerid'))) {
					LeadContactMethods.assignLeadContact(obj.Id);
				}

				update obj;

				//INSERT NEW SIMULATION
				if(!String.isEmpty(data.simulation.MCI_SIM_ID)) {
					System.debug('--> INSERT NEW SIMULATION');
					List<Simulation__c> simulations = [SELECT Id FROM Simulation__c WHERE MCI_SIM_ID__c = :data.simulation.MCI_SIM_ID];
					system.debug(simulations.size());
                    system.debug((Id)obj.get('ownerid'));
                    if(simulations.size() == 0) {
						Simulation__c sim = new Simulation__c(OwnerId = (Id) Obj.get('OwnerId'), MCI_User_ID__c = data.simulation.MCI_User_ID, MCI_SIM_ID__c = data.simulation.MCI_SIM_ID, recordTypeId = Label.Sim_Immo_RT,
															      Type_de_cr_dit__c = data.simulation.type_credit, Trouv_le_bien__c = data.simulation.trouve_bien == null ? false : data.simulation.trouve_bien, 
															      Montant_du_cr_dit__c = data.simulation.montant_credit, Total_des_revenus__c = data.simulation.total_revenus, 
															      Cap_d_endettement_maximal__c = data.simulation.cap_endettement, 
															      Total_credits_en_cours__c = data.simulation.total_credits_encours,
																  
																    Date_debut_d_activit__c = String.isEmpty(data.simulation.date_debut_activite_pro)? null : date.newInstance(integer.valueOf(data.simulation.date_debut_activite_pro.split('/', 3)[2]),integer.valueOf(data.simulation.date_debut_activite_pro.split('/', 3)[1]),integer.valueOf(data.simulation.date_debut_activite_pro.split('/', 3)[0])) , 
																	Date_des_2_annees_de_bilan_rempli__c = String.isEmpty(data.simulation.date_preparation_two_annees_bilan)? null : date.newInstance(integer.valueOf(data.simulation.date_preparation_two_annees_bilan.split('/', 3)[2]),integer.valueOf(data.simulation.date_preparation_two_annees_bilan.split('/', 3)[1]),integer.valueOf(data.simulation.date_preparation_two_annees_bilan.split('/', 3)[0])) , 
																	Date_de_titularisation_rempli__c = String.isEmpty(data.simulation.date_de_titularisation)? null : date.newInstance(integer.valueOf(data.simulation.date_de_titularisation.split('/', 3)[2]),integer.valueOf(data.simulation.date_de_titularisation.split('/', 3)[1]),integer.valueOf(data.simulation.date_de_titularisation.split('/', 3)[0])),
																	date_d_eclatement__c = String.isEmpty(data.simulation.date_declatement_du_titre)? null : date.newInstance(integer.valueOf(data.simulation.date_declatement_du_titre.split('/', 3)[2]),integer.valueOf(data.simulation.date_declatement_du_titre.split('/', 3)[1]),integer.valueOf(data.simulation.date_declatement_du_titre.split('/', 3)[0])) , 
																	Date_promise_de_reception_de_FDD__c = String.isEmpty(data.simulation.date_promise_reception_fond_dossier)? null : date.newInstance(integer.valueOf(data.simulation.date_promise_reception_fond_dossier.split('/', 3)[2]),integer.valueOf(data.simulation.date_promise_reception_fond_dossier.split('/', 3)[1]),integer.valueOf(data.simulation.date_promise_reception_fond_dossier.split('/', 3)[0])) ,
                                                              
																	Anciennet_activit_pro_X__c = data.simulation.anciennete_activite_pro ,
																	Type_de_Bien__c = data.simulation.estate_type , 
																	D_lai_de_concr_tisation__c = String.isEmpty(data.simulation.delai_de_concretistion) ? null : data.simulation.delai_de_concretistion.replace(',',';') , 
																	Souhaite_tre_rapp_par_Mbwb_T__c = data.simulation.etre_accompagne_par_muwabawb == null ? false : data.simulation.etre_accompagne_par_muwabawb ,
																	Nature_du_bien__c = data.simulation.etat_du_bien_immobililer_objet_du_financement , 
																	Prix_du_terrain__c = data.simulation.estate_price , 
																	Cout_devis_de_la_construction__c = data.simulation.construction_price , 
																	Type_d_usage_du_bien_immobilier__c = data.simulation.usage_type , 
																	CO_emprunt__c = data.simulation.has_co_emprunt == null ? false : data.simulation.has_co_emprunt ,
																	Montant_co_emprunteur__c = data.simulation.co_emprunt_amount,
                                                               		Client_actuel_de_s_banque_s__c = String.isEmpty(data.simulation.filter_client_bank)? null : data.simulation.filter_client_bank.replace(',',';'),
                                                              
                                                              		//Update Of 03/08/2021
                                                              		Apport_hors_FDN__c = data.simulation.apport_en_fonds_propres_requis , 
                                                                    Quotit_de_financement_X__c = data.simulation.quotite_de_financement , 
                                                                    CD_Dur_e_en_Ann_es__c = data.simulation.sim_selected_year , 
                                                                    Type_de_taux__c = data.simulation.sim_selected_taux_type , 
                                                                    CD_Taux_HT__c = data.simulation.sim_selected_taux_ht , 
                                                                    Modalit_de_paiement_de_l_ADI__c = data.simulation.sim_selected_type_adis , 
                                                                    CD_Taux_assurance__c = data.simulation.sim_selected_taux_as_mensualise , 
                                                                    Taux_de_l_ADI_en_prime_unique__c = data.simulation.sim_selected_taux_as_prime_unique , 
                                                                    Frais_de_dossier_de_l_offre_selectionn_e__c = data.simulation.sim_selected_frais_de_dossier , 
                                                                    Taux_annuel_effectif_global_TAEG_X__c = data.simulation.sim_selected_taeg , 
                                                                    Mensualit_aux_conditions_demand_es_X__c = data.simulation.sim_selected_echeance_mensuelle , 
                                                                    NB_Conditions_demand_es__c = data.simulation.autres_conditions_demandees_par_le_client , 
                                                                    Cout_du_cr_dit_aux_condition_demand_es_X__c = data.simulation.sim_selected_cout_credit , 
                                                                    Economies_r_aliser_X__c = data.simulation.sim_selected_economies , 
                                                                    Diff_rence_de_mensualit_X__c = data.simulation.sim_selected_difference_de_mensualite , 
                                                                    Taux_d_endettement_inc_Ech_X__c = data.simulation.sim_selected_taux_dendettementinc_ech ,
                                                                    Offre_selection_e_propos_e_par__C = data.simulation.sim_selected_bank_name , 
                                                              		Projet_conventionn_taux_sp_cial__c  = data.simulation.projets_conventionne,
                                                                    
                                                                    OC_Montant_emprunter__c = data.simulation.oc_montant_credit , 
                                                                    OC_Dur_e_du_cr_dit_en_Ann_es__c	 = data.simulation.oc_duree_credit_nbr_dannees ,
                                                                    Type_de_taux_OC__c = data.simulation.oc_type_taux , 
                                                                    OC_Taux_HT__c = data.simulation.oc_taux_ht_credit , 
                                                                    OC_Taux_assurance__c = data.simulation.oc_taux_de_lassurance_deces_invalidite_m , 
                                                                    OC_Ass_prime_unique_FP__c = data.simulation.oc_taux_de_lassurance_deces_invalidite_pu ,
                                                                    Frais_de_dossier_OC__c = data.simulation.oc_frais_de_dossier , 
                                                                    TAEG_2_EFFECTIF_OC__c = data.simulation.oc_taeg_effectif_two , 
                                                                    Autres_conditions_propos_es_au_client__c = data.simulation.oc_autres_conditions_proposees_au_client , 
                                                                    Banque_concurrente__c = data.simulation.oc_bank_name , 
                                                                    Frais_de_notaire_et_d_enregistrement_X__c = data.simulation.total_des_frais_de_notaire ,
                                                                    Montant_des_Frais_de_notaire_enregi_X__c = data.simulation.montant_frais_notaire_inclus_credit_bancaire  , 
                                                                    Montant_des_frais_d_am_nagement_inclus_X__c = data.simulation.montant_frais_amenagement_inclus_credit_bancaire,
                                                              		
                                                              		OPC_banque_concurrente_dispo__c = data.simulation.oc_has_offre_prealable_signee_cachetee == null ? false : data.simulation.oc_has_offre_prealable_signee_cachetee,
                                                              		Modalit_de_paiement_de_l_ADI_OC__c = data.simulation.oc_modalite_paiement_assurance_deces_invalidite,
                                                              		OC_Mensualit_estim_e_X__c = data.simulation.oc_echeance_mensuelle,
                                                              
                                                                    //Update of 30/08/2021
                                                                    tes_vous_rentier__c = data.simulation.is_rentier == null ? false : data.simulation.is_rentier 
																  );

						if(obj.getsObjectType().getDescribe().getName() == 'Contact')
							sim.Contact__c = obj.Id;
						else if(obj.getsObjectType().getDescribe().getName() == 'Lead')
							sim.Lead__c = obj.Id;
						insert sim;
					}
				}else{
						Simulation__c sim = new Simulation__c(OwnerId = (Id) Obj.get('OwnerId'), MCI_User_ID__c = data.MCI_User_ID,recordTypeId = Label.Sim_Immo_RT);

						if(obj.getsObjectType().getDescribe().getName() == 'Contact')
							sim.Contact__c = obj.Id;
						else if(obj.getsObjectType().getDescribe().getName() == 'Lead')
							sim.Lead__c = obj.Id;
						insert sim;
				}

                system.debug('**ownerid'+(Id)obj.get('ownerid'));
                List<User> users = [SELECT Name, Email, Phone, MobilePhone, Id FROM User WHERE Id = :(Id)obj.get('ownerid')];
                system.debug('***users'+users.size());
				User InsertLeadAdvisor = [SELECT Name, Email, Phone, MobilePhone, Id FROM User WHERE Id = :(Id)obj.get('ownerid')];
				String responseJSON = '{\"Advisor_name\":\"' + InsertLeadAdvisor.Name +
				'\",\"Advisor_Email\":\"' + InsertLeadAdvisor.Email +
				'\",\"Advisor_Phone\":\"' + InsertLeadAdvisor.Phone +
				'\",\"Advisor_MobilePhone\":\"' + InsertLeadAdvisor.MobilePhone + '\"}';
				if(!Test.isRunningTest()) {
					response.responseBody = Blob.valueOf(responseJSON);
					response.statusCode = 200;
				}

			} 
            else {
                //Si sent_email_client est renseigné, on ecrase l'ancienne et on prend la valeur de celle-ci
                //Update Of 31/08/2021
                if(! String.isEmpty(data.sent_email_client)) data.email = data.sent_email_client;
                
				//APPORTEUR
				Id apporteurId;
				Id MCI_parrainId;
                Boolean Do_Not_Reassign = false;

				//Account MubawabAcc = [SELECT id, Name from Account where id =: Label.Mubawab_Account limit 1];

				if(!String.isEmpty(data.apporteur_ID)) {
					List<Contact> contacts = [SELECT Id, AccountId, First_Affiliate_Lead_Owner__c  FROM Contact WHERE MCI_User_ID__c = :data.apporteur_ID LIMIT 1];
					System.debug('--> Contact WITH MCI USER ID == APPORTEUR ID : ' + contacts);

					if(contacts.isEmpty()) {
						List<Lead> leads = [SELECT Company, Name,ownerId FROM Lead WHERE MCI_User_ID__c = :data.apporteur_ID LIMIT 1];
						System.debug('--> LEAD WITH MCI USER ID == APPORTEUR ID : ' + leads);

						if(!leads.isEmpty()) {
							if(!(leads [0].Company).contains('Mubawab')) {
								leads[0].Company = leads [0].Name;
								update leads [0];

							} else {
								//leads[0].Company = MubawabAcc.Name;
							}
							LeadStatus convertStatus = [SELECT Id, MasterLabel FROM LeadStatus WHERE IsConverted = true LIMIT 1];

							Database.LeadConvert lc = new database.LeadConvert();
							lc.setLeadId(leads [0].Id);
							if((data.email) != null && (data.email).contains('@mubawab.com')) 
								lc.setAccountId(Label.Mubawab_Account);
							lc.setDoNotCreateOpportunity(true);
							lc.setConvertedStatus(convertStatus.MasterLabel);

							Database.LeadConvertResult lcr = Database.convertLead(lc);
							System.debug('--> CONVERT LEAD ? ' + lcr.isSuccess());

							apporteurId = lcr.getAccountId();
							MCI_parrainId = lcr.getContactId();


						}
					} else {
						apporteurId = contacts [0].AccountId;
						MCI_parrainId = contacts [0].Id;
                        if(contacts [0].First_Affiliate_Lead_Owner__c != null) Do_Not_Reassign = true;
					}

				}
				System.debug('--> APPORTEUR ID : ' + apporteurId);

				//INSERT NEW LEAD
				System.debug('--> INSERT NEW LEAD');

				Lead lead;
				/*
					public String utm_ciblage;
					public String utm_creadate;
					public String utm_format;
					public String utm_lang;
					public String utm_product;
					public String utm_var;
				
				*/
				if((data.email) != null && (data.email).contains('@mubawab.com')) {
					lead = new Lead(LastName = (data.name != null && data.name != '')? data.name : data.MCI_User_ID,
                                   Company = 'Mubawab', LeadSource = 'Siteweb', MobilePhone = data.phone, Email = data.email, 
								   MCI_User_ID__c = data.MCI_User_ID, utm_source__c = data.utm_source, 
								   utm_campaign__c = (String.isEmpty(data.utm_campaign)) ? '' :data.utm_campaign, 
								   utm_ciblage__c = data.utm_ciblage,
								   utm_creadate__c = (String.isEmpty(data.utm_creadate)) ? null :date.newInstance(integer.valueOf(data.utm_creadate.split('/', 3)[2]),integer.valueOf(data.utm_creadate.split('/', 3)[1]),integer.valueOf(data.utm_creadate.split('/', 3)[0])),
								   utm_format__c = data.utm_format,
								   utm_lang__c = data.utm_lang,
								   utm_product__c = data.utm_product,
								   utm_var__c = data.utm_var,
								   utm_medium__c = data.utm_medium, utm_term__c = data.utm_term, utm_content__c = data.utm_content, 
								   Apporteur__c = apporteurId, MCI_parrain__c = MCI_parrainId, utm_apporteur__c = data.utm_apporteur,
                                   Do_Not_Reassign__c = Do_Not_Reassign,
								   CreatedWithSim__c = (!String.isEmpty(data.simulation.MCI_SIM_ID)) ? true :false, 
								   Profession__c = data.profession, 
                                    First_call_to_action__c = data.first_call_to_action, Registered__c = data.registered,
								   Sexe__c = data.sexe , Nationalite__c = data.nationality , 
                                   Pays_de_r_sidence__c = data.country , 
								   Ville_de_r_sidence_si_Maroc__c = data.ville_naissance , Date_de_naissance__c = (String.isEmpty(data.date_naissance)) ? null : date.newInstance(integer.valueOf(data.date_naissance.split('/', 3)[2]),integer.valueOf(data.date_naissance.split('/', 3)[1]),integer.valueOf(data.date_naissance.split('/', 3)[0])) , 
								   Niveau_acad_mique__c = data.niveau_academique , Age_remplis_par_le_client_X__c = data.age , Age_calcul_EFD_date_de_naissance_X__c = data.client_age 
								   );
					insert lead;

				} else {
					lead = new Lead(LastName = (data.name != null && data.name != '')? data.name : data.MCI_User_ID, 
                                     Company = 'MeilleurCreditImmo.ma', LeadSource = 'Siteweb', MobilePhone = data.phone, Email = data.email, 
									 MCI_User_ID__c = data.MCI_User_ID, utm_source__c = data.utm_source, 
									 utm_ciblage__c = data.utm_ciblage,
								     utm_creadate__c = (String.isEmpty(data.utm_creadate)) ? null :date.newInstance(integer.valueOf(data.utm_creadate.split('/', 3)[2]),integer.valueOf(data.utm_creadate.split('/', 3)[1]),integer.valueOf(data.utm_creadate.split('/', 3)[0])),
								  	 utm_format__c = data.utm_format,
								   	 utm_lang__c = data.utm_lang,
								  	 utm_product__c = data.utm_product,
								   	 utm_var__c = data.utm_var,
								     utm_campaign__c = (String.isEmpty(data.utm_campaign)) ? '' :data.utm_campaign, 
								     utm_medium__c = data.utm_medium, utm_term__c = data.utm_term, utm_content__c = data.utm_content, 
								     Apporteur__c = apporteurId, MCI_parrain__c = MCI_parrainId, utm_apporteur__c = data.utm_apporteur, 
                                     Do_Not_Reassign__c = Do_Not_Reassign,
								     CreatedWithSim__c = (!String.isEmpty(data.simulation.MCI_SIM_ID)) ? true :false, 
								     Profession__c = data.profession, 
                                    First_call_to_action__c = data.first_call_to_action, Registered__c = data.registered,
									 Sexe__c = data.sexe , Nationalite__c = data.nationality , 
                                     Pays_de_r_sidence__c = data.country , 
									Ville_de_r_sidence_si_Maroc__c = data.ville_naissance , Date_de_naissance__c = (String.isEmpty(data.date_naissance)) ? null : date.newInstance(integer.valueOf(data.date_naissance.split('/', 3)[2]),integer.valueOf(data.date_naissance.split('/', 3)[1]),integer.valueOf(data.date_naissance.split('/', 3)[0])) , 
									Niveau_acad_mique__c = data.niveau_academique  , Age_remplis_par_le_client_X__c = data.age , Age_calcul_EFD_date_de_naissance_X__c = data.client_age
                                   );
					insert lead;

				}

				User InsertLeadAdvisor = [SELECT Name, Email, Phone, MobilePhone, Id FROM User WHERE Id IN(select OwnerId from Lead where id = :lead.Id)];
				String responseJSON = '{\"Advisor_name\":\"' + InsertLeadAdvisor.Name +
				'\",\"Advisor_Email\":\"' + InsertLeadAdvisor.Email +
				'\",\"Advisor_Phone\":\"' + InsertLeadAdvisor.Phone +
				'\",\"Advisor_MobilePhone\":\"' + InsertLeadAdvisor.MobilePhone + '\"}';
				if(!Test.isRunningTest()) {
					response.responseBody = Blob.valueOf(responseJSON);
					response.statusCode = 200;
				}
				System.debug('--> LEAD : ' + lead);


				//INSERT NEW SIMULATION
				if(!String.isEmpty(data.simulation.MCI_SIM_ID)) {
					System.debug('--> INSERT NEW SIMULATION');
					//Check for existant simulation with the same MCI ID
					List<Simulation__c> simulations = [SELECT Id FROM Simulation__c WHERE MCI_SIM_ID__c = :data.simulation.MCI_SIM_ID];
					if(simulations.size() == 0) {
						insert new Simulation__c(OwnerId = InsertLeadAdvisor.Id,
												 recordTypeId = Label.Sim_Immo_RT, 
											     Lead__c = lead.Id, 
											     MCI_User_ID__c = data.simulation.MCI_User_ID, MCI_SIM_ID__c = data.simulation.MCI_SIM_ID, 
											     Type_de_cr_dit__c = data.simulation.type_credit, Trouv_le_bien__c = data.simulation.trouve_bien == null ? false:data.simulation.trouve_bien, 
											     Montant_du_cr_dit__c = data.simulation.montant_credit, Total_des_revenus__c = data.simulation.total_revenus, 
											     Cap_d_endettement_maximal__c = data.simulation.cap_endettement, 
											     Total_credits_en_cours__c = data.simulation.total_credits_encours,
												
                                                 Date_debut_d_activit__c = String.isEmpty(data.simulation.date_debut_activite_pro)? null : date.newInstance(integer.valueOf(data.simulation.date_debut_activite_pro.split('/', 3)[2]),integer.valueOf(data.simulation.date_debut_activite_pro.split('/', 3)[1]),integer.valueOf(data.simulation.date_debut_activite_pro.split('/', 3)[0])) , 
                                                 Date_des_2_annees_de_bilan_rempli__c = String.isEmpty(data.simulation.date_preparation_two_annees_bilan)? null : date.newInstance(integer.valueOf(data.simulation.date_preparation_two_annees_bilan.split('/', 3)[2]),integer.valueOf(data.simulation.date_preparation_two_annees_bilan.split('/', 3)[1]),integer.valueOf(data.simulation.date_preparation_two_annees_bilan.split('/', 3)[0])) , 
                                                 Date_de_titularisation_rempli__c = String.isEmpty(data.simulation.date_de_titularisation)? null : date.newInstance(integer.valueOf(data.simulation.date_de_titularisation.split('/', 3)[2]),integer.valueOf(data.simulation.date_de_titularisation.split('/', 3)[1]),integer.valueOf(data.simulation.date_de_titularisation.split('/', 3)[0])),
                                                 date_d_eclatement__c = String.isEmpty(data.simulation.date_declatement_du_titre)? null : date.newInstance(integer.valueOf(data.simulation.date_declatement_du_titre.split('/', 3)[2]),integer.valueOf(data.simulation.date_declatement_du_titre.split('/', 3)[1]),integer.valueOf(data.simulation.date_declatement_du_titre.split('/', 3)[0])) , 
												 Date_promise_de_reception_de_FDD__c = String.isEmpty(data.simulation.date_promise_reception_fond_dossier)? null : date.newInstance(integer.valueOf(data.simulation.date_promise_reception_fond_dossier.split('/', 3)[2]),integer.valueOf(data.simulation.date_promise_reception_fond_dossier.split('/', 3)[1]),integer.valueOf(data.simulation.date_promise_reception_fond_dossier.split('/', 3)[0])) ,

												Anciennet_activit_pro_X__c = data.simulation.anciennete_activite_pro ,
												Type_de_Bien__c = data.simulation.estate_type , 
												D_lai_de_concr_tisation__c = String.isEmpty(data.simulation.delai_de_concretistion)? null : data.simulation.delai_de_concretistion.replace(',',';') , 
												Souhaite_tre_rapp_par_Mbwb_T__c = data.simulation.etre_accompagne_par_muwabawb == null ? false : data.simulation.etre_accompagne_par_muwabawb , 
												Nature_du_bien__c = data.simulation.etat_du_bien_immobililer_objet_du_financement , 
												Prix_du_terrain__c = data.simulation.estate_price , 
												Cout_devis_de_la_construction__c = data.simulation.construction_price , 
												Type_d_usage_du_bien_immobilier__c = data.simulation.usage_type , 
												CO_emprunt__c = data.simulation.has_co_emprunt == null ? false : data.simulation.has_co_emprunt ,
												Montant_co_emprunteur__c = data.simulation.co_emprunt_amount,
												Client_actuel_de_s_banque_s__c = String.isEmpty(data.simulation.filter_client_bank)? null : data.simulation.filter_client_bank.replace(',',';'),
                                                //Update Of 03/08/2021
                                                Apport_hors_FDN__c = data.simulation.apport_en_fonds_propres_requis , 
                                                Quotit_de_financement_X__c = data.simulation.quotite_de_financement , 
                                                CD_Dur_e_en_Ann_es__c = data.simulation.sim_selected_year , 
                                                Type_de_taux__c = data.simulation.sim_selected_taux_type , 
                                                CD_Taux_HT__c = data.simulation.sim_selected_taux_ht , 
                                                Modalit_de_paiement_de_l_ADI__c = data.simulation.sim_selected_type_adis , 
                                                CD_Taux_assurance__c = data.simulation.sim_selected_taux_as_mensualise , 
                                                Taux_de_l_ADI_en_prime_unique__c = data.simulation.sim_selected_taux_as_prime_unique , 
                                                Frais_de_dossier_de_l_offre_selectionn_e__c = data.simulation.sim_selected_frais_de_dossier , 
                                                Taux_annuel_effectif_global_TAEG_X__c = data.simulation.sim_selected_taeg , 
                                                Mensualit_aux_conditions_demand_es_X__c = data.simulation.sim_selected_echeance_mensuelle , 
                                                NB_Conditions_demand_es__c = data.simulation.autres_conditions_demandees_par_le_client , 
                                                Cout_du_cr_dit_aux_condition_demand_es_X__c = data.simulation.sim_selected_cout_credit , 
                                                Economies_r_aliser_X__c = data.simulation.sim_selected_economies , 
                                                Diff_rence_de_mensualit_X__c = data.simulation.sim_selected_difference_de_mensualite , 
                                                Taux_d_endettement_inc_Ech_X__c = data.simulation.sim_selected_taux_dendettementinc_ech ,
                                                Offre_selection_e_propos_e_par__C = data.simulation.sim_selected_bank_name , 
                                                Projet_conventionn_taux_sp_cial__c  = data.simulation.projets_conventionne,
                                                 
                                                OC_Montant_emprunter__c = data.simulation.oc_montant_credit , 
                                                OC_Dur_e_du_cr_dit_en_Ann_es__c	 = data.simulation.oc_duree_credit_nbr_dannees ,
                                                Type_de_taux_OC__c = data.simulation.oc_type_taux , 
                                                OC_Taux_HT__c = data.simulation.oc_taux_ht_credit , 
                                                
                                                OC_Taux_assurance__c = data.simulation.oc_taux_de_lassurance_deces_invalidite_m , 
                                                OC_Ass_prime_unique_FP__c = data.simulation.oc_taux_de_lassurance_deces_invalidite_pu ,
                                                Frais_de_dossier_OC__c = data.simulation.oc_frais_de_dossier , 
                                                TAEG_2_EFFECTIF_OC__c = data.simulation.oc_taeg_effectif_two , 
                                                Autres_conditions_propos_es_au_client__c = data.simulation.oc_autres_conditions_proposees_au_client , 
                                                Banque_concurrente__c = data.simulation.oc_bank_name , 
                                                Frais_de_notaire_et_d_enregistrement_X__c = data.simulation.total_des_frais_de_notaire ,
                                                Montant_des_Frais_de_notaire_enregi_X__c = data.simulation.montant_frais_notaire_inclus_credit_bancaire  , 
                                                Montant_des_frais_d_am_nagement_inclus_X__c = data.simulation.montant_frais_amenagement_inclus_credit_bancaire,
                                                 
                                                 OPC_banque_concurrente_dispo__c = data.simulation.oc_has_offre_prealable_signee_cachetee == null ? false : data.simulation.oc_has_offre_prealable_signee_cachetee,
                                                 Modalit_de_paiement_de_l_ADI_OC__c = data.simulation.oc_modalite_paiement_assurance_deces_invalidite,
                                                 OC_Mensualit_estim_e_X__c = data.simulation.oc_echeance_mensuelle,
                                                 
                                                 //Update of 30/08/2021
                                                 tes_vous_rentier__c = data.simulation.is_rentier == null ? false : data.simulation.is_rentier 
												 );
					}
				}else{
						Simulation__c sim = new Simulation__c(OwnerId = InsertLeadAdvisor.Id, Lead__c = lead.Id, MCI_User_ID__c = data.MCI_User_ID,RecordTypeId = Label.Sim_Immo_RT);
						insert sim;
				}

			}
		} catch(Exception e) {
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
		public String MCI_User_ID;
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
        //Update of 20/07/2021
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
		public String MCI_User_ID;
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

	}



}