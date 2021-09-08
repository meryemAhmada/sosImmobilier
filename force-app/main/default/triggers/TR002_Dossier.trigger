trigger TR002_Dossier on Dossier__c (before insert, before update, after update) {

  List<Dossier__c> dossiers = new List<Dossier__c>();
  Map<Id, Dossier__c> oldDossiers = new Map<Id, Dossier__c>();
  Date today = Date.Today();

  if (Trigger.isBefore && Trigger.isUpdate) {

    for (Dossier__c dossier : Trigger.New) {
      dossiers.add(dossier);
      oldDossiers.put(dossier.Id, Trigger.oldMap.get(dossier.Id));
    }
    //TREATMENT
    for (Dossier__c dossier : dossiers) {
      Dossier__c oldDossier = oldDossiers.get(dossier.Id);

      //DOSSIER CONSTITUE P1
      if (dossier.Dossier_Constitue_P1__c != oldDossier.Dossier_Constitue_P1__c && dossier.Dossier_Constitue_P1__c) {
        dossier.Dte_Dossier_Constitue_P1__c = today;
      }

      //Confirmation Envoi à l'analyse
      if (dossier.Confirmation_Envoi_l_analyse__c != oldDossier.Confirmation_Envoi_l_analyse__c && dossier.Confirmation_Envoi_l_analyse__c) {
        dossier.D_Confirmation_Envoi_l_analyse__c = today;
      }

      //Pièces manquantes P1
      if (dossier.Pieces_manquantes_P1__c != oldDossier.Pieces_manquantes_P1__c && dossier.Pieces_manquantes_P1__c) {
        dossier.D_Pieces_manquantes_P1__c = today;
      }

      //Dossier complet P1
      if (dossier.Dossier_Complet__c != oldDossier.Dossier_Complet__c && dossier.Dossier_Complet__c) {
        dossier.Date_Compl_tude_Dossier__c = today;
      }

      //Expertise du bien non requise
      if (dossier.Expertise_du_bien_non_requise__c != oldDossier.Expertise_du_bien_non_requise__c && dossier.Expertise_du_bien_non_requise__c) {
        dossier.D_Expertise_du_bien_non_requise__c = today;
      }

      //Expertise du bien requise
      if (dossier.Expertise_du_bien_requise__c != oldDossier.Expertise_du_bien_requise__c && dossier.Expertise_du_bien_requise__c) {
        dossier.D_Expertise_du_bien_requise__c = today;
      }

      //Expertise du bien réalisée
      if (dossier.Expertise_du_bien_realisee__c != oldDossier.Expertise_du_bien_realisee__c && dossier.Expertise_du_bien_realisee__c) {
        dossier.D_Expertise_du_bien_realisee__c = today;
      }

      //Dossier accordé
      if (dossier.Transmettre_Dossier_l_agence__c != oldDossier.Transmettre_Dossier_l_agence__c && dossier.Transmettre_Dossier_l_agence__c) {
        dossier.Date_accord_dossier__c = today;
      }

      //Envoi des conditions 1 au client
      if (dossier.Envoi_des_conditions1_au_client__c != oldDossier.Envoi_des_conditions1_au_client__c && dossier.Envoi_des_conditions1_au_client__c) {
        dossier.D_Envoi_des_conditions1_au_client__c = today;
      }

      //Retour à charges
      if (dossier.Retour_a_charges__c != oldDossier.Retour_a_charges__c && dossier.Retour_a_charges__c) {
        dossier.D_Retour_a_charges__c = today;
      }

      //Decision banque re- Retour à charges
      if (dossier.Decision_banque_re_Retour_charges__c != oldDossier.Decision_banque_re_Retour_charges__c && dossier.Decision_banque_re_Retour_charges__c) {
        dossier.D_Decision_banque_re_Retour_charges__c = today;
      }

      //Envoi des conditions 2 au client
      if (dossier.Envoi_des_conditions2_au_client__c != oldDossier.Envoi_des_conditions2_au_client__c && dossier.Envoi_des_conditions2_au_client__c) {
        dossier.D_Envoi_des_conditions2_au_client__c = today;
      }

      //Accord client sur conditions et reserves
      if (dossier.Accord_client_sur_conditions_reserves__c != oldDossier.Accord_client_sur_conditions_reserves__c && dossier.Accord_client_sur_conditions_reserves__c) {
        dossier.D_Accord_client_sur_conditions_reserves__c = today;
      }

      //RDV Ouverture de compte programmé
      if (dossier.RDV_Ouverture_de_compte_programme__c != oldDossier.RDV_Ouverture_de_compte_programme__c && dossier.RDV_Ouverture_de_compte_programme__c) {
        dossier.D_RDV_Ouverture_de_compte_programme__c = today;
      }

      //Signature de l'OPC
      if (dossier.Signature_de_OPC__c != oldDossier.Signature_de_OPC__c && dossier.Signature_de_OPC__c) {
        dossier.D_Signature_de_OPC__c = today;
      }

      //Signature Assurances
      if (dossier.Signature_Assurances__c != oldDossier.Signature_Assurances__c && dossier.Signature_Assurances__c) {
        dossier.D_Signature_Assurances__c = today;
      }

      //Exemplaires de docs envoyés au client
      if (dossier.Exemplaires_docs_envoyes_au_client__c != oldDossier.Exemplaires_docs_envoyes_au_client__c && dossier.Exemplaires_docs_envoyes_au_client__c) {
        dossier.D_Exemplaires_docs_envoyes_au_client__c = today;
      }

      //RDV pris visite medicale
      if (dossier.RDV_pris_visite_medicale__c != oldDossier.RDV_pris_visite_medicale__c && dossier.RDV_pris_visite_medicale__c) {
        dossier.D_RDV_pris_visite_medicale__c = today;
      }

      //Lettre d'accompagnement fourni au client
      if (dossier.Lettre_accompagnement_fourni_client__c != oldDossier.Lettre_accompagnement_fourni_client__c && dossier.Lettre_accompagnement_fourni_client__c) {
        dossier.D_Lettre_accompagnement_fourni_client__c = today;
      }

      //Réponse assurance reçue
      if (dossier.Reponse_assurance_recue__c != oldDossier.Reponse_assurance_recue__c && dossier.Reponse_assurance_recue__c) {
        dossier.D_Reponse_assurance_recue__c = today;
      }

      //Dossier Constitué P2et3
      if (dossier.Dossier_Constitue_P2_3__c != oldDossier.Dossier_Constitue_P2_3__c && dossier.Dossier_Constitue_P2_3__c) {
        dossier.D_Dossier_Constitue_P2_3__c = today;
      }

      //Dépôt Banque P2et3
      if (dossier.Depot_Banque_P2_3__c != oldDossier.Depot_Banque_P2_3__c && dossier.Depot_Banque_P2_3__c) {
        dossier.D_Depot_Banque_P2_3__c = today;
      }

      //Pièces manquantes P2et3
      if (dossier.Pieces_manquantes_P2_3__c != oldDossier.Pieces_manquantes_P2_3__c && dossier.Pieces_manquantes_P2_3__c) {
        dossier.D_Pieces_manquantes_P2_3__c = today;
      }

      //Dossier complet P2et3
      if (dossier.Dossier_complet_P2_3__c != oldDossier.Dossier_complet_P2_3__c && dossier.Dossier_complet_P2_3__c) {
        dossier.D_Dossier_complet_P2_3__c = today;
      }

      //VIREMENT DU PREMIER SALAIRE DOMICILE
      if (dossier.Virement_du_premier_salaire_domicile__c != oldDossier.Virement_du_premier_salaire_domicile__c && dossier.Virement_du_premier_salaire_domicile__c) {
        dossier.Dte_Virement_du_premier_salaire_domicile__c = today;
      }

      //Env de l'acc sign cach ou l'OPC au not
      if (dossier.Env_acc_sign_cach_ou_OPC_not__c != oldDossier.Env_acc_sign_cach_ou_OPC_not__c && dossier.Env_acc_sign_cach_ou_OPC_not__c) {
        dossier.D_Env_acc_sign_cach_ou_OPC_not__c = today;
      }

      //VEFA caution bq remise par bq du prom
      if (dossier.VEFA_caution_bq_remise_bq_prom__c != oldDossier.VEFA_caution_bq_remise_bq_prom__c && dossier.VEFA_caution_bq_remise_bq_prom__c) {
        dossier.D_VEFA_caution_bq_remise_bq_prom__c = today;
      }

      //Levée des reserves
      if (dossier.Levee_des_reserves__c != oldDossier.Levee_des_reserves__c && dossier.Levee_des_reserves__c) {
        dossier.D_Levee_des_reserves__c = today;
      }

      //Env des contr de prêt signés leg à la bq
      if (dossier.Env_contr_pret_signes_leg_bq__c != oldDossier.Env_contr_pret_signes_leg_bq__c && dossier.Env_contr_pret_signes_leg_bq__c) {
        dossier.D_Env_contr_pret_signes_leg_bq__c = today;
      }

      //Env copie contr au not pour l'éd de min
      if (dossier.Env_cp_contr_not_pour_ed_min__c != oldDossier.Env_cp_contr_not_pour_ed_min__c && dossier.Env_cp_contr_not_pour_ed_min__c) {
        dossier.D_Env_contr_pret_signes_leg_bq__c = today;
      }

      //Env min au serv jur(via ag)pour val
      if (dossier.Env_min_serv_jur_via_ag_pour_val__c != oldDossier.Env_min_serv_jur_via_ag_pour_val__c && dossier.Env_min_serv_jur_via_ag_pour_val__c) {
        dossier.D_Env_min_serv_jur_via_ag_pour_val__c = today;
      }

      //Minute validée par le service juridique1
      if (dossier.Minute_validee_par_service_juridique__c != oldDossier.Minute_validee_par_service_juridique__c && dossier.Minute_validee_par_service_juridique__c) {
        dossier.D_Minute_validee_par_service_juridique__c = today;
      }


      //Min renv au not par le serv jur
      if (dossier.Min_renv_not_par_serv_jur__c != oldDossier.Min_renv_not_par_serv_jur__c && dossier.Min_renv_not_par_serv_jur__c) {
        dossier.D_Min_renv_not_par_serv_jur__c = today;
      }

      //Dossier débloqué système banque
      if (dossier.Dossier_debloque_systeme_banque__c != oldDossier.Dossier_debloque_systeme_banque__c && dossier.Dossier_debloque_systeme_banque__c) {
        dossier.D_Dossier_debloque_systeme_banque__c = today;
      }


      //Sign min par la bq le vend l'ach dev not
      if (dossier.Sign_min_par_bq_vend_ach_dev_not__c != oldDossier.Sign_min_par_bq_vend_ach_dev_not__c && dossier.Sign_min_par_bq_vend_ach_dev_not__c) {
        dossier.D_Sign_min_par_bq_vend_ach_dev_not__c = today;
      }

      //Dossier débloqué
      if (dossier.Dossier_d_bloqu__c != oldDossier.Dossier_d_bloqu__c && dossier.Dossier_d_bloqu__c) {
        dossier.Date_deblocage__c = today;
      }

      //Facture déposée
      if (dossier.Facture_deposee__c != oldDossier.Facture_deposee__c && dossier.Facture_deposee__c) {
        dossier.Date_d_p_t_facture__c = today;
      }

      //Facture validée
      if (dossier.Facture_validee__c != oldDossier.Facture_validee__c && dossier.Facture_validee__c) {
        dossier.D_Facture_validee__c = today;
      }

      //Facture avancée
      if (dossier.Facture_avancee__c != oldDossier.Facture_avancee__c && dossier.Facture_avancee__c) {
        dossier.D_Facture_avancee__c = today;
      }

      //Facture Payée
      if (dossier.Facture_Payee_global__c != oldDossier.Facture_Payee_global__c && dossier.Facture_Payee_global__c) {
        dossier.D_Facture_Payee_global__c = today;
      }

      //Facture payée en totalité
      if (dossier.Facture_Payee__c != oldDossier.Facture_Payee__c && dossier.Facture_Payee__c) {
        dossier.Date_Paiement_Facture__c = today;
      }

      //Facture payée en partie
      if (dossier.Facture_payee_en_partie__c != oldDossier.Facture_payee_en_partie__c && dossier.Facture_payee_en_partie__c) {
        dossier.D_Facture_payee_en_partie__c = today;
      }

      /* NEW FIELDS */


      //Ouverture de compte réalisée
      if (dossier.Compte_Bancaire_Ouvert__c != oldDossier.Compte_Bancaire_Ouvert__c && dossier.Compte_Bancaire_Ouvert__c) {
        dossier.D_Ouverture_de_cmpt_realisee__c = today;
      }

      //Visite médicale effectuée
      if (dossier.RDV_Visite_M_dicale__c != oldDossier.RDV_Visite_M_dicale__c && dossier.RDV_Visite_M_dicale__c) {
        dossier.D_visite_medicale_effectuee__c = today;
      }

      //Lettre d'engagement notaire chez Banque
      if (dossier.Lettre_d_engagement_notaire_chez_Banque__c != oldDossier.Lettre_d_engagement_notaire_chez_Banque__c && dossier.Lettre_d_engagement_notaire_chez_Banque__c) {
        dossier.D_lettre_engagement_notaire_chez_banque__c = today;
      }

      //Edition des contrats de prêt
      if (dossier.Edition_du_contrat_de_pr_t__c != oldDossier.Edition_du_contrat_de_pr_t__c && dossier.Edition_du_contrat_de_pr_t__c) {
        dossier.Dte_edition_des_contrats_de_pret__c = today;
      }

      //Contrat légalisé transmis par client
      if (dossier.Contrat_l_galis_transmis_par_client__c != oldDossier.Contrat_l_galis_transmis_par_client__c && dossier.Contrat_l_galis_transmis_par_client__c) {
        dossier.Dte_contrat_legalise_remis_pr_client__c = today;
      }

      //Minute établie par le notaire
      if (dossier.Minute_tablie_par_le_notaire__c != oldDossier.Minute_tablie_par_le_notaire__c && dossier.Minute_tablie_par_le_notaire__c) {
        dossier.Dte_min_etablie_par_le_notaire__c = today;
      }

      //Cheque Banque remis au notaire
      if (dossier.Cheque_Banque_remis_au_notaire__c != oldDossier.Cheque_Banque_remis_au_notaire__c && dossier.Cheque_Banque_remis_au_notaire__c) {
        dossier.Dte_cheque_banque_remis_au_notaire__c = today;
      }

      //Dossier Perdu
      if (dossier.Dossier_Perdu__c != oldDossier.Dossier_Perdu__c && dossier.Dossier_Perdu__c) {
        dossier.Dte_dossier_perdu__c = today;
      }


      //RDV Ouverture de compte
      if (dossier.RDV_Ouverture_de_compte__c != oldDossier.RDV_Ouverture_de_compte__c && dossier.RDV_Ouverture_de_compte__c) {
        dossier.Dte_RDV_Ouverture_de_compte__c = today;
      }
    }
  }

  if (Trigger.isAfter && Trigger.isUpdate) {
    Notifications__c notifEmailParam = Notifications__c.getOrgDefaults();
    if (notifEmailParam != null && notifEmailParam.Activee__c) {
      List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();

      for (Dossier__c dossier : [SELECT Name, Apporteur_Dossier__c, Apporteur_Dossier__r.Email__c, Contact__c, Contact__r.Owner.Name, Contact__r.Owner.Email, Contact__r.Owner.MobilePhone, Contact__r.Owner.Phone,
                                 Contact__r.Firstname, Contact__r.Lastname, Contact__r.Email,
                                 Contact__r.Nom_du_co_emprunteur__r.Email, Super_banquier__r.Email__c,
                                 Banquier__r.Email__c, Notaire__r.Email, Parrain_Dossier__r.Email__c,
                                 Super_apporteur_Dossier__r.Email__c, Apporteur__r.Email,
                                 Dossier_Constitue_P1__c, Depot_Banque__c, Confirmation_Envoi_l_analyse__c,
                                 Pieces_manquantes_P1__c, Dossier_Complet__c, Expertise_du_bien_non_requise__c,
                                 Expertise_du_bien_requise__c, Expertise_du_bien_realisee__c, Decision_Banque__c,
                                 Transmettre_Dossier_l_agence__c, Envoi_des_conditions1_au_client__c,
                                 Retour_a_charges__c, Decision_banque_re_Retour_charges__c, Envoi_des_conditions2_au_client__c,
                                 Accord_client_sur_conditions_reserves__c, RDV_Ouverture_de_compte_programme__c,
                                 RDV_Ouverture_de_compte__c, Compte_Bancaire_Ouvert__c, Signature_de_OPC__c,
                                 Signature_Assurances__c, Exemplaires_docs_envoyes_au_client__c,
                                 RDV_pris_visite_medicale__c, Lettre_accompagnement_fourni_client__c,
                                 RDV_Visite_M_dicale__c, Reponse_assurance_recue__c,
                                 Dossier_Constitue_P2_3__c, Depot_Banque_P2_3__c, Pieces_manquantes_P2_3__c,
                                 Dossier_complet_P2_3__c, Virement_du_premier_salaire_domicile__c, Env_acc_sign_cach_ou_OPC_not__c,
                                 VEFA_caution_bq_remise_bq_prom__c, Lettre_d_engagement_notaire_chez_Banque__c,
                                 Levee_des_reserves__c, Edition_du_contrat_de_pr_t__c, Contrat_l_galis_transmis_par_client__c,
                                 Env_contr_pret_signes_leg_bq__c, Env_cp_contr_not_pour_ed_min__c, Minute_tablie_par_le_notaire__c,
                                 Env_min_serv_jur_via_ag_pour_val__c, Minute_validee_par_service_juridique__c,
                                 Min_renv_not_par_serv_jur__c, Dossier_debloque_systeme_banque__c, Cheque_Banque_remis_au_notaire__c,
                                 Sign_min_par_bq_vend_ach_dev_not__c, Dossier_d_bloqu__c, Dossier_Perdu__c, Facture_deposee__c,
                                 Facture_validee__c, Facture_avancee__c, Facture_payee_en_partie__c, Facture_Payee_global__c, Facture_Payee__c,
                                 Date_estim_accord__c, Date_Estim_D_blocage__c, D_Retour_a_charges__c, Date_accord_dossier__c,
                                 D_RDV_Ouverture_de_compte_programme__c, Date_depot_dossier__c
                                 FROM Dossier__c
                                 WHERE Id IN : Trigger.new]) {
        mails.addAll(DossierTriggerMethods.notificationEmail(dossier, Trigger.oldMap.get(dossier.Id)));
      }

      try {
        if (!mails.isEmpty()) Messaging.sendEmail(mails,false);
      } catch (System.EmailException emailExp) {
        //msg error
      }
    }
  }

    if (Trigger.isBefore){
        
        TR002_DossierHandler.documentRequisStatusAndDateUpdate(Trigger.New , Trigger.isInsert , Trigger.oldMap);
    }
  
    
  if(Trigger.isAfter){
    Set<Id> dossierIds = new set<Id>();
    for(Dossier__c dossier :Trigger.new){
      dossierIds.add(dossier.Id);
    }
    WS_PushDossiersToWebsite.ws_PushDataDossiersToWebsite(dossierIds);
  }
}