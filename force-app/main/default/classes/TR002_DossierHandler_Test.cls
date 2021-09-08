@isTest
public class TR002_DossierHandler_Test {
    
    @testsetup
    public static void setup(){
        
        List<Contact> contacts = TestFactory.createContactsWithSpecificData(null , 'maroc' , 'Rentier' , 'maroc' , 1, true);
        List<Simulation__c> sims = TestFactory.createSimulationsWithSpecificData(contacts.get(0).Id , 'Contact__c', true , 'Appartement' , 'Rachat de crédit immobilier' , false , 0 , 10 , 1, true);
        Dossier__c dossier = new Dossier__c(Simulation__c = sims.get(0).Id , Contact__c = contacts.get(0).Id);
        insert dossier;
    }
    
    @istest
    public static void case1(){
        Simulation__c sim = [Select Id From Simulation__c Limit 1];
        Contact con = [Select Id From Contact Limit 1];
        Dossier__c dossier = new Dossier__c(Simulation__c = sim.Id , Contact__c = con.Id);
        Test.startTest();
        insert dossier;
        Test.stopTest();
        
    }
    
    @istest
    public static void case2(){
        Dossier__c dossier = [Select Id , Attestation_de_travail__c From Dossier__c Limit 1];
        dossier.Attestation_de_travail__c  = 'Reçu copie';
        
        Test.startTest();
        update dossier;
        Test.stopTest();
        
    }
    
    //Nationalite__c:maroc ; Pays_de_r_sidence__c:maroc ; Profession__c:Salarié - secteur public (fonctionnaire)
    @istest
    public static void case3(){
        Dossier__c dossier = [Select Id , Contact__c From Dossier__c LIMIT 1];
        Contact contact = [Select Id , Pays_de_r_sidence__c , Profession__c , Nationalite__c FROM Contact Where Id = :dossier.contact__c];
		contact.Nationalite__c = 'maroc'; contact.Pays_de_r_sidence__c = 'maroc'; contact.Profession__c='Salarié - secteur public (fonctionnaire)';
        
        Test.startTest();
        update contact;
        Test.stopTest();
        dossier = [Select Id , cin_marocaine__c , Carte_de_r_sidence__c , Copie_Passeport__c , Justificatif_de_domicile__c , Etat_engagement__c , Fiches_de_paie__c , Fiches_de_paie_2__c , Attestation_de_salaire__c , Attestation_de_travail__c , Fiche_renseignement_employeur__c , Recap_CNSS__c , Contrat_de_travail_homologue__c , Attestation_de_pension__c , Avis_imposition__c , Modele_J__c , Taxe_professionnelle__c , Carte_Pro_Autorisation_d_exercer__c , Equivalent_de_bilan__c , Patente__c , Registre_de_commerce__c , Justificatifs_revenus_compl_mentaires__c , Bilans_de_la_societe__c , PV_de_distribution_des_dividendes__c , Contrat_de_Bail__c , Certificat_propriete__c , Contrat_de_travail__c , Releves_compte_bancaire_perso_3mois__c , Releves_compte_bancaire_perso_6mois__c , Releves_compte_bancaire_perso_12mois__c , Releves_compte_bancaire_pro_12mois__c , Simple_descriptif_du_bien_objet_du_cr_di__c , Certificat_de_propri_t_du_bien__c , Compromis_de_vente__c , Engagement_de_transfer__c , Engagement_domiciliation_salaire__c , Engagement_domiciliation_revenus__c , Traduction_des_documents__c , Contact__c From Dossier__c LIMIT 1];
        List<String> Documents = new List<String>{'cin_marocaine__c' , 'Carte_de_r_sidence__c' , 'Copie_Passeport__c' , 'Justificatif_de_domicile__c' , 'Etat_engagement__c' , 'Fiches_de_paie__c' , 'Fiches_de_paie_2__c' , 'Attestation_de_salaire__c' , 'Attestation_de_travail__c' , 'Fiche_renseignement_employeur__c' , 'Recap_CNSS__c' , 'Contrat_de_travail_homologue__c' , 'Attestation_de_pension__c' , 'Avis_imposition__c' , 'Modele_J__c' , 'Taxe_professionnelle__c' , 'Carte_Pro_Autorisation_d_exercer__c' , 'Equivalent_de_bilan__c' , 'Patente__c' , 'Registre_de_commerce__c' , 'Justificatifs_revenus_compl_mentaires__c' , 'Bilans_de_la_societe__c' , 'PV_de_distribution_des_dividendes__c' , 'Contrat_de_Bail__c' , 'Certificat_propriete__c' , 'Contrat_de_travail__c' , 'Releves_compte_bancaire_perso_3mois__c' , 'Releves_compte_bancaire_perso_6mois__c' , 'Releves_compte_bancaire_perso_12mois__c' , 'Releves_compte_bancaire_pro_12mois__c' , 'Simple_descriptif_du_bien_objet_du_cr_di__c' , 'Certificat_de_propri_t_du_bien__c' , 'Compromis_de_vente__c' , 'Engagement_de_transfer__c' , 'Engagement_domiciliation_salaire__c' , 'Engagement_domiciliation_revenus__c' , 'Traduction_des_documents__c'};
        List<String> requisValues = new List<String>{'Requis' , 'Non requis' , 'Non requis' , 'Non requis' , 'Requis' , 'Non requis' , 'Non requis' , 'Non requis' , 'Non requis' , 'Non requis' , 'Non requis' , 'Non requis' , 'Non requis' , 'Non requis' , 'Non requis' , 'Non requis' , 'Non requis' , 'Non requis' , 'Non requis' , 'Non requis' , 'Non requis' , 'Non requis' , 'Non requis' , 'Non requis' , 'Non requis' , 'Non requis' , 'Requis' , 'Non requis' , 'Non requis' , 'Non requis' , 'Requis' , 'Requis' , 'Requis' , 'Non requis' , 'Non requis' , 'Non requis' , 'Non requis'};
        for(Integer i = 0; i < documents.size() ; i++){
            System.assertEquals(dossier.get(documents.get(i)), requisValues.get(i));
        }
        
    }
    
    //Nationalite__c:maroc ; Pays_de_r_sidence__c:maroc ; Profession__c:Salarié - Secteur privé
    @istest
    public static void case4(){
        Dossier__c dossier = [Select Id , Contact__c From Dossier__c LIMIT 1];
        Contact contact = [Select Id , Pays_de_r_sidence__c , Profession__c , Nationalite__c FROM Contact Where Id = :dossier.contact__c];
		contact.Nationalite__c = 'maroc'; contact.Pays_de_r_sidence__c = 'maroc'; contact.Profession__c='Salarié - Secteur privé';
        
        Test.startTest();
        update contact;
        Test.stopTest();
        dossier = [Select Id , cin_marocaine__c , Carte_de_r_sidence__c , Copie_Passeport__c , Justificatif_de_domicile__c , Etat_engagement__c , Fiches_de_paie__c , Fiches_de_paie_2__c , Attestation_de_salaire__c , Attestation_de_travail__c , Fiche_renseignement_employeur__c , Recap_CNSS__c , Contrat_de_travail_homologue__c , Attestation_de_pension__c , Avis_imposition__c , Modele_J__c , Taxe_professionnelle__c , Carte_Pro_Autorisation_d_exercer__c , Equivalent_de_bilan__c , Patente__c , Registre_de_commerce__c , Justificatifs_revenus_compl_mentaires__c , Bilans_de_la_societe__c , PV_de_distribution_des_dividendes__c , Contrat_de_Bail__c , Certificat_propriete__c , Contrat_de_travail__c , Releves_compte_bancaire_perso_3mois__c , Releves_compte_bancaire_perso_6mois__c , Releves_compte_bancaire_perso_12mois__c , Releves_compte_bancaire_pro_12mois__c , Simple_descriptif_du_bien_objet_du_cr_di__c , Certificat_de_propri_t_du_bien__c , Compromis_de_vente__c , Engagement_de_transfer__c , Engagement_domiciliation_salaire__c , Engagement_domiciliation_revenus__c , Traduction_des_documents__c , Contact__c From Dossier__c LIMIT 1];
        List<String> Documents = new List<String>{'cin_marocaine__c' , 'Carte_de_r_sidence__c' , 'Copie_Passeport__c' , 'Justificatif_de_domicile__c' , 'Etat_engagement__c' , 'Fiches_de_paie__c' , 'Fiches_de_paie_2__c' , 'Attestation_de_salaire__c' , 'Attestation_de_travail__c' , 'Fiche_renseignement_employeur__c' , 'Recap_CNSS__c' , 'Contrat_de_travail_homologue__c' , 'Attestation_de_pension__c' , 'Avis_imposition__c' , 'Modele_J__c' , 'Taxe_professionnelle__c' , 'Carte_Pro_Autorisation_d_exercer__c' , 'Equivalent_de_bilan__c' , 'Patente__c' , 'Registre_de_commerce__c' , 'Justificatifs_revenus_compl_mentaires__c' , 'Bilans_de_la_societe__c' , 'PV_de_distribution_des_dividendes__c' , 'Contrat_de_Bail__c' , 'Certificat_propriete__c' , 'Contrat_de_travail__c' , 'Releves_compte_bancaire_perso_3mois__c' , 'Releves_compte_bancaire_perso_6mois__c' , 'Releves_compte_bancaire_perso_12mois__c' , 'Releves_compte_bancaire_pro_12mois__c' , 'Simple_descriptif_du_bien_objet_du_cr_di__c' , 'Certificat_de_propri_t_du_bien__c' , 'Compromis_de_vente__c' , 'Engagement_de_transfer__c' , 'Engagement_domiciliation_salaire__c' , 'Engagement_domiciliation_revenus__c' , 'Traduction_des_documents__c'};
        List<String> requisValues = new List<String>{'Requis' , 'Non requis' , 'Non requis' , 'Non requis' , 'Non requis' , 'Requis' , 'Non requis' , 'Requis' , 'Requis' , 'Requis' , 'Requis' , 'Non requis' , 'Non requis' , 'Non requis' , 'Non requis' , 'Non requis' , 'Non requis' , 'Non requis' , 'Non requis' , 'Non requis' , 'Non requis' , 'Non requis' , 'Non requis' , 'Non requis' , 'Non requis' , 'Non requis' , 'Requis' , 'Non requis' , 'Non requis' , 'Non requis' , 'Requis' , 'Requis' , 'Requis' , 'Non requis' , 'Requis' , 'Non requis' , 'Non requis'
            };
        for(Integer i = 0; i < documents.size() ; i++){
            System.assertEquals(dossier.get(documents.get(i)), requisValues.get(i) , documents.get(i));
        }
        
    }
    
    
}