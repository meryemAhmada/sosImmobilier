trigger TR002_Dossier on Dossier__c (before insert, before update, after update) {

  List<Dossier__c> dossiers = new List<Dossier__c>();
  Map<Id, Dossier__c> oldDossiers = new Map<Id, Dossier__c>();
  Date today = Date.Today();


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