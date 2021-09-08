@isTest
public with sharing class TR002_Dossier_Test {
    
    @testSetup static void testSetup(){
        /* CUSTOM SETTING NOTIFICATION*/

		Notifications__c notifEmailParam = New Notifications__c();
		notifEmailParam.Activee__c = true;
		notifEmailParam.Subject__c = 'test';
		notifEmailParam.SenderDisplayName__c = 'Test';
		notifEmailParam.ReplyTo__c = 'test@test.com';
		notifEmailParam.ccAddresses__c = 'test@test.com';
		insert notifEmailParam;

		/* ACCOUNT */
		Account account = new Account();
		account.Name = 'Test Account';
		account.Email__c = 'test.account@test.com';
		
		insert account;

		/* CO-EMPRUNTEUR */
		Contact coemprunteur = new Contact();
		coemprunteur.lastName = 'coemprunteurTest';
		coemprunteur.Email = 'coemprunteurtest@test.com';

		insert coemprunteur;

		/* CONTACT */
		Contact contact = new Contact();
		contact.lastName = 'contactTest';
		contact.accountId = account.Id;
		contact.Email = 'contacttest@test.com';
		contact.Nom_du_co_emprunteur__c = coemprunteur.Id;
		
		insert contact;

		/* SUPER BANQUIER */
		Account superBanquier = new Account();
		superBanquier.Name = 'Test Super Banquier';
		superBanquier.Type = 'Banque';
		superBanquier.Email__c = 'testsuperbanquier@test.com';

		insert superBanquier;

		/* BANQUIER */
		Account banquier = new Account();
		banquier.Name = 'Test Banquier';
		banquier.Type = 'Banque';
		banquier.Email__c = 'testbanquier@test.com';

		insert banquier;


		/* NOTAIRE */
		Contact notaire = new Contact();
		notaire.lastName = 'notaireTest';
		notaire.Email = 'notairetest@test.com';
		
		insert notaire;

		/* SUPER APPORTEUR */
		Account superApporteur = new Account();
		superApporteur.Name = 'Test Super Apporteur';
		superApporteur.Email__c = 'testsuperapporteur@test.com';

		insert superApporteur;

		/* APPORTEUR */
		Contact apporteur = new Contact();
		apporteur.lastName = 'apporteurTest';
		apporteur.Email = 'apporteurTest@test.com';

		insert apporteur;
        
        Simulation__c simulation = new Simulation__c();
        simulation.Actif__c = TRUE;
        simulation.Contact__c = contact.Id;
        simulation.MCI_Sim_ID__c = '1234';
        // Sim Hot
        simulation.Statut__c = 'Qualifié';
        simulation.Resultat__c = 'Trouvé le bien-AFD';
        simulation.Motif__c = 'Shopping';
        insert simulation;

		/* DOSSIER */
		Dossier__c dossier = new Dossier__c();
		dossier.contact__c = contact.Id;
        dossier.Simulation__c = simulation.Id;
        dossier.Dossier_Constitue_P1__c = True;
		dossier.Super_banquier__c = superBanquier.Id;
		dossier.Banquier__c = banquier.Id;
		dossier.Notaire__c = notaire.Id;
		dossier.Super_apporteur_Dossier__c = superApporteur.Id;
		dossier.Apporteur__c = apporteur.Id;
		dossier.Date_estim_accord__c = System.Today().addDays(10);
		dossier.Date_depot_dossier__c = SYstem.Today();
		dossier.Date_Estim_D_blocage__c = System.Today().addDays(15);

		insert dossier;

    }
        
	@isTest static void testUpdateDossier(){

		
		Dossier__c dossierInserted = [Select Id From Dossier__c LIMIT 1];
		Dossier__c dossier = new Dossier__c();
        dossier.Id = dossierInserted.Id;
		dossier.Dossier_Constitue_P1__c = true;
		dossier.Depot_Banque__c = true;
        dossier.Confirmation_Envoi_l_analyse__c = true;
		dossier.Pieces_manquantes_P1__c = true;
		dossier.Dossier_Complet__c = true;
		dossier.Expertise_du_bien_non_requise__c = true;
		dossier.Expertise_du_bien_requise__c = true;
		dossier.Expertise_du_bien_realisee__c = true;
		dossier.Decision_Banque__c = true;
		dossier.Transmettre_Dossier_l_agence__c = true;
        dossier.Envoi_des_conditions1_au_client__c = true;
        dossier.Retour_a_charges__c = true;
        dossier.Decision_banque_re_Retour_charges__c = true;
        dossier.Envoi_des_conditions2_au_client__c = true;
        dossier.Accord_client_sur_conditions_reserves__c = true;
		dossier.RDV_Ouverture_de_compte_programme__c = true;
        dossier.Signature_de_OPC__c = true;
		dossier.Signature_Assurances__c = true;
		dossier.Exemplaires_docs_envoyes_au_client__c = true;
        dossier.RDV_pris_visite_medicale__c = true;
		dossier.Lettre_accompagnement_fourni_client__c = true;
		dossier.Reponse_assurance_recue__c = true;
		dossier.Dossier_Constitue_P2_3__c = true;
		dossier.Depot_Banque_P2_3__c = true;
		dossier.Pieces_manquantes_P2_3__c  = true;
		dossier.Dossier_complet_P2_3__c  = true;
        dossier.Virement_du_premier_salaire_domicile__c = true;
        dossier.Env_acc_sign_cach_ou_OPC_not__c = true;
		dossier.VEFA_caution_bq_remise_bq_prom__c = true;
        dossier.Levee_des_reserves__c = true;
		dossier.Env_contr_pret_signes_leg_bq__c = true;
        dossier.Env_cp_contr_not_pour_ed_min__c = true;
		dossier.Env_min_serv_jur_via_ag_pour_val__c = true;
        dossier.Minute_validee_par_service_juridique__c = true;
		dossier.Min_renv_not_par_serv_jur__c = true;
		dossier.Dossier_debloque_systeme_banque__c = true;
		dossier.Sign_min_par_bq_vend_ach_dev_not__c = true;
		dossier.Dossier_d_bloqu__c = true;
		dossier.Facture_deposee__c = true;
        dossier.Facture_validee__c = true;
		dossier.Facture_avancee__c = true;
		dossier.Facture_Payee_global__c = true;
		dossier.Facture_Payee__c = true;
		dossier.Facture_payee_en_partie__c = true;

		dossier.Compte_Bancaire_Ouvert__c = true;
		dossier.RDV_Visite_M_dicale__c = true;
		dossier.Lettre_d_engagement_notaire_chez_Banque__c = true;
		dossier.Edition_du_contrat_de_pr_t__c = true;
		dossier.Contrat_l_galis_transmis_par_client__c = true;
		dossier.Minute_tablie_par_le_notaire__c = true;
		dossier.Cheque_Banque_remis_au_notaire__c = true;
		dossier.Dossier_Perdu__c = true;
		dossier.RDV_Ouverture_de_compte__c = true;


		update dossier;

		/*dossier = [SELECT D_Dossier_debloque_systeme_banque__c, D_Confirmation_Envoi_l_analyse__c  FROM Dossier__c WHERE Id =: dossier.Id];
		system.assertEquals(dossier.D_Dossier_debloque_systeme_banque__c , Date.Today());*/

		
        
        Test.startTest();
        // UPDATE DATE
		dossier.D_Confirmation_Envoi_l_analyse__c = Date.Today().addDays(-3);
		update dossier;
		Test.stopTest();
        
		dossier = [SELECT D_Dossier_debloque_systeme_banque__c, D_Confirmation_Envoi_l_analyse__c  FROM Dossier__c WHERE Id =: dossier.Id];
		system.assertEquals(dossier.D_Confirmation_Envoi_l_analyse__c, Date.Today().addDays(-3));
		system.assertEquals(dossier.D_Dossier_debloque_systeme_banque__c, Date.Today());

	}
}