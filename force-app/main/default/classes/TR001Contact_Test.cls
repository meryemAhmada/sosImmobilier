@isTest
public class TR001Contact_Test {
    
    @testSetup static void testSetup(){
        Contact contact = new Contact(LastName = 'Test1', Nationalite__c='Morocco', Pays_de_r_sidence__c ='Morocco', Profil__c='Salarié');
        insert contact;

        Notifications__c notifications = new Notifications__c(Contact_Notif_Activee__c = true,ccAddresses__c = 'bbenslimane@soscreditimmo.ma', Subject__c = 'TEST Email Notification', Activee__c = true,
                                                                SenderDisplayName__c = 'SOS Credit Immo TEST', ReplyTo__c = 'Contact@soscreditimmo.ma');
        insert notifications;
    }
    /*
    @isTest static void testInsert(){
        Test.startTest();
        
        //MAROCAIN + RESIDENT AU MAROC + SALARIE
        Contact contact = new Contact(LastName = 'Test2', Nationalite__c='Morocco', Pays_de_r_sidence__c ='Morocco', Profil__c='Salarié');
        insert contact;

        Simulation__c simulation = new Simulation__c(Contact__c = contact.Id);
        insert simulation;
        
        simulation = [SELECT Copie_CIN__c, Carte_de_r_sidence__c FROM Simulation__c WHERE Id =: simulation.Id];
        System.assertEquals(simulation.Copie_CIN__c, 'REQUIS P1');
        System.assertEquals(simulation.Carte_de_r_sidence__c, 'Non requis');
        
        //MAROCAIN + RESIDENT A L'ETRANGER + RETRAITE
        contact = new Contact(LastName = 'Test2', Nationalite__c='Morocco', Pays_de_r_sidence__c ='France', Profil__c='Retraité');
        insert contact;

        simulation = new Simulation__c(Contact__c = contact.Id);
        insert simulation;
        
        simulation = [SELECT Copie_CIN__c, Carte_de_r_sidence__c FROM Simulation__c WHERE Id =: simulation.Id];
        System.assertEquals(simulation.Copie_CIN__c, 'REQUIS P1');
        System.assertEquals(simulation.Carte_de_r_sidence__c, 'REQUIS P1');
        
        //ETRANGER + RESIDENT AU MAROC + SALARIE
        contact = new Contact(LastName = 'Test2', Nationalite__c='France', Pays_de_r_sidence__c ='Morocco', Profil__c='Salarié');
        insert contact;

        simulation = new Simulation__c(Contact__c = contact.Id);
        insert simulation;
        
        simulation = [SELECT Copie_CIN__c, Carte_de_r_sidence__c FROM Simulation__c WHERE Id =: simulation.Id];
        System.assertEquals(simulation.Copie_CIN__c, 'Non requis');
        System.assertEquals(simulation.Carte_de_r_sidence__c, 'REQUIS P1');
        
        //ETRANGER + RESIDENT AU ETRANGER + PRO SANS COMPTABILITE
        contact = new Contact(LastName = 'Test2', Nationalite__c='France', Pays_de_r_sidence__c ='France', Profil__c='Pro sans comptabilité');
        insert contact;

        simulation = new Simulation__c(Contact__c = contact.Id);
        insert simulation;
        
        simulation = [SELECT Copie_CIN__c, Carte_de_r_sidence__c FROM Simulation__c WHERE Id =: simulation.Id];
        System.assertEquals(simulation.Copie_CIN__c, 'Non requis');
        System.assertEquals(simulation.Carte_de_r_sidence__c, 'Non requis');
        
        //ETRANGER + RESIDENT AU ETRANGER + PRO SANS COMPTABILITE + SALARIE
        contact = new Contact(LastName = 'Test2', Nationalite__c='France', Pays_de_r_sidence__c ='France', Profil__c='Pro sans comptabilité;Salarié');
        insert contact;

        simulation = new Simulation__c(Contact__c = contact.Id);
        insert simulation;
        
        simulation = [SELECT Copie_CIN__c, Fiches_de_paie_2__c FROM Simulation__c WHERE Id =: simulation.Id];
        System.assertEquals(simulation.Copie_CIN__c, 'Non requis');
        System.assertEquals(simulation.Fiches_de_paie_2__c, 'REQUIS P1');
        
        Test.stopTest();
    }
    
    @isTest static void testUpdate(){
        Contact contact = [SELECT Id, Copie_CIN__c, Nationalite__c, Profil__c, Pays_de_r_sidence__c FROM Contact LIMIT 1];
        Simulation__c simulation = new Simulation__c(Contact__c = contact.Id, Actif__c = true);
        insert simulation;
        
        Test.startTest();
        
        //UPDATE PROFILE
        contact.Profil__c = 'Retraité';
        update contact;
        
        simulation = [SELECT Modele_J__c, Engagement_domiciliation_revenus__c FROM Simulation__c WHERE Contact__c =: contact.Id];
        System.assertEquals(simulation.Modele_J__c, 'Non requis');
        System.assertEquals(simulation.Engagement_domiciliation_revenus__c, 'Non requis');
        
        contact.Profil__c = 'Rentier';
        update contact;
        
        simulation = [SELECT Modele_J__c, Engagement_domiciliation_revenus__c FROM Simulation__c WHERE Contact__c =: contact.Id];
        System.assertEquals(simulation.Modele_J__c, 'Non requis');
        System.assertEquals(simulation.Engagement_domiciliation_revenus__c, 'REQUIS P3');
        
        contact.Profil__c = 'Fonctionnaire';
        update contact;
        
        simulation = [SELECT Modele_J__c, Engagement_domiciliation_revenus__c FROM Simulation__c WHERE Contact__c =: contact.Id];
        System.assertEquals(simulation.Modele_J__c, 'Non requis');
        System.assertEquals(simulation.Engagement_domiciliation_revenus__c, 'Non requis');
        
        contact.Profil__c = 'Pro avec comptabilité';
        update contact;
        
        simulation = [SELECT Modele_J__c, Engagement_domiciliation_revenus__c FROM Simulation__c WHERE Contact__c =: contact.Id];
        System.assertEquals(simulation.Modele_J__c, 'REQUIS P1');
        System.assertEquals(simulation.Engagement_domiciliation_revenus__c, 'REQUIS P3');
        
        contact.Profil__c = 'Pro sans comptabilité';
        update contact;
        
        simulation = [SELECT Modele_J__c, Engagement_domiciliation_revenus__c FROM Simulation__c WHERE Contact__c =: contact.Id];
        System.assertEquals(simulation.Modele_J__c, 'Non requis');
        System.assertEquals(simulation.Engagement_domiciliation_revenus__c, 'REQUIS P3');
        
        //UPDATE NATIONALITE
        contact.Nationalite__c = 'France';
        update contact;
        
        simulation = [SELECT Copie_CIN__c, Carte_de_r_sidence__c FROM Simulation__c WHERE Contact__c =: contact.Id];
        System.assertEquals(simulation.Copie_CIN__c, 'Non requis');
        System.assertEquals(simulation.Carte_de_r_sidence__c, 'REQUIS P1');
        
        contact.Nationalite__c = 'Morocco';
        update contact;
        
        simulation = [SELECT Copie_CIN__c, Carte_de_r_sidence__c FROM Simulation__c WHERE Contact__c =: contact.Id];
        System.assertEquals(simulation.Copie_CIN__c, 'REQUIS P1');
        System.assertEquals(simulation.Carte_de_r_sidence__c, 'Non requis');
        
        //UPDATE PAYS
        contact.Pays_de_r_sidence__c = 'France';
        update contact;
        
        simulation = [SELECT Copie_CIN__c, Carte_de_r_sidence__c FROM Simulation__c WHERE Contact__c =: contact.Id];
        System.assertEquals(simulation.Copie_CIN__c, 'REQUIS P1');
        System.assertEquals(simulation.Carte_de_r_sidence__c, 'REQUIS P1');
            
        contact.Pays_de_r_sidence__c = 'Morocco';
        update contact;
        
        simulation = [SELECT Copie_CIN__c, Carte_de_r_sidence__c FROM Simulation__c WHERE Contact__c =: contact.Id];
        System.assertEquals(simulation.Copie_CIN__c, 'REQUIS P1');
        System.assertEquals(simulation.Carte_de_r_sidence__c, 'Non requis');
        
        //UPDATE COPIE CIN
        simulation.Copie_CIN__c = 'Reçu copie';
        update simulation;

        simulation = [SELECT Copie_CIN__c, Carte_de_r_sidence__c FROM Simulation__c WHERE Contact__c =: contact.Id];
        System.assertEquals(simulation.Copie_CIN__c, 'Reçu copie');

        Test.stopTest();
        
    }*/

    @isTest static void testNotificationEmail(){
        Contact contact = [SELECT Date_recap_client__c, Statut__c FROM Contact LIMIT 1];
        Simulation__c simulation = new Simulation__c(Contact__c = contact.Id, Actif__c = true);
        insert simulation;

        simulation = [SELECT Carte_Pro_Autorisation_d_exercer__c, Carte_de_r_sidence__c, 
                            Copie_Passeport__c, Fiche_renseignement_employeur__c, Contrat_de_travail_homologue__c,
                            Attestation_de_pension__c, Avis_imposition__c, Modele_J__c,Taxe_professionnelle__c,Equivalent_de_bilan__c,
                            Patente__c, Registre_de_commerce__c, Justificatifs_revenus_compl_mentaires__c,
                            Bilans_de_la_societe__c, Bilan_provisoire__c, PV_de_distribution_des_dividendes__c, Contrat_de_bail__c,
                            Certificat_propriete__c, Releves_compte_bancaire_perso_12mois__c, Releves_compte_bancaire_pro_3mois__c,
                            Releves_compte_bancaire_pro_6mois__c, Releves_compte_bancaire_pro_12mois__c, Engagement_de_transfer__c,
                            Attestation_en_cours__c, Devis_de_construction__c, Engagement_domiciliation_revenus__c,
                            Traduction_des_documents__c, Statut_societe__c, Etat_engagement__c, Fiches_de_paie_2__c, Contrat_de_travail__c 
                      FROM Simulation__c 
                      WHERE Id =: simulation.Id];

        simulation.Carte_de_r_sidence__c = 'REQUIS P1';
        simulation.Carte_Pro_Autorisation_d_exercer__c = 'REQUIS P1';
        simulation.Copie_Passeport__c = 'REQUIS P1';
        simulation.Fiche_renseignement_employeur__c = 'REQUIS P1';
        simulation.Contrat_de_travail_homologue__c = 'REQUIS P1';
        simulation.Attestation_de_pension__c = 'REQUIS P1';
        simulation.Avis_imposition__c = 'REQUIS P1';
        simulation.Modele_J__c = 'REQUIS P1';
        simulation.Taxe_professionnelle__c = 'REQUIS P1';
        simulation.Equivalent_de_bilan__c = 'REQUIS P1';
        simulation.Patente__c = 'REQUIS P1';
        simulation.Registre_de_commerce__c  = 'REQUIS P1';
        simulation.Justificatifs_revenus_compl_mentaires__c = 'REQUIS P1';
        simulation.Bilans_de_la_societe__c= 'REQUIS P1';
        simulation.Bilan_provisoire__c = 'REQUIS P1';
        simulation.PV_de_distribution_des_dividendes__c = 'REQUIS P1';
        simulation.Contrat_de_bail__c = 'REQUIS P1';
        simulation.Certificat_propriete__c = 'REQUIS P1';
        simulation.Releves_compte_bancaire_perso_12mois__c = 'REQUIS P1';
        simulation.Releves_compte_bancaire_pro_3mois__c = 'REQUIS P1';
        simulation.Releves_compte_bancaire_pro_6mois__c = 'REQUIS P1';
        simulation.Releves_compte_bancaire_pro_12mois__c = 'REQUIS P1';
        simulation.Engagement_de_transfer__c = 'REQUIS P1';
        simulation.Attestation_en_cours__c = 'REQUIS P1';
        simulation.Devis_de_construction__c = 'REQUIS P1';
        simulation.Engagement_domiciliation_revenus__c = 'REQUIS P1';
        simulation.Traduction_des_documents__c = 'REQUIS P1';
        simulation.Statut_societe__c = 'REQUIS P1';
        simulation.Etat_engagement__c = 'REQUIS P1';
        simulation.Fiches_de_paie_2__c  = 'REQUIS P1';
        simulation.Contrat_de_travail__c = 'REQUIS P1';
        update simulation;

        
        Test.startTest();

        contact.Date_recap_client__c = Date.Today().addDays(-7);
        update contact;

        contact.Date_recap_client__c = Date.Today().addDays(-15);
        update contact;

        contact.Date_recap_client__c = Date.Today().addDays(-21);
        update contact;

        contact.Date_recap_client__c = Date.Today().addDays(-30);
        update contact;

        contact.Date_recap_client__c = Date.Today().addDays(-45);
        update contact;

        contact.Date_recap_client__c = Date.Today().addDays(-60);
        update contact;

        contact.Date_recap_client__c = Date.Today().addDays(-100);
        update contact;

        contact.Statut__c = 'Perdu';
        update contact;

        Test.stopTest();
        
    }



}