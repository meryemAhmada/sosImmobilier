@isTest public class WS_updateSimulationTest {
	@TestSetup
    static void setup()
    {
        User currentUser = [Select Id , Bypass_VR__c  From User Where Id = :UserInfo.getUserId()];
        currentUser.Bypass_VR__c = true;
        update currentUser;
    }
    
    //CASE 1 : SIMULATION WITH CONTACT
    @isTest static void test_push2SF_case1(){
        Contact contact = TestFactory.createContactsWithSpecificData(NULL, '+21261234567', '0000', 1, true).get(0);
        TestFactory.createSimulations(new List<String>{'3XCX08'},contact.Id,'Contact__c',1,true);
        RestRequest req = new RestRequest();
        req.requestURI = '/services/apexrest/restUpdateSimulation';  
        req.httpMethod = 'POST';
        String data = '{"ville_naissance":"Casablanca","utm_var":"utmvarTest","utm_term":"utmTermTest","utm_source":"utmsourceTest","utm_product":"utmProductTest","utm_medium":"utmmediumTest","utm_lang":"utmLangTest","utm_format":"utmformatTest","utm_creadate":"24/12/2021","utm_content":"utmcontentTest","utm_ciblage":"utmciblageTest","utm_campaign":"utmcampaignTest","utm_apporteur":"utmapporteurTest","simulation":{ "usage_type":"Résidence principale","type_credit":"Immo","trouve_bien":false,"total_revenus":44228,"total_des_frais_de_notaire":12,"total_credits_encours":45,"sim_selected_year":2021,"sim_selected_type_adis":"Mensualisée","sim_selected_taux_type":"Fixe","sim_selected_taux_ht":44444,"sim_selected_taux_dendettementinc_ech":10,"sim_selected_taux_as_prime_unique":2,"sim_selected_taux_as_mensualise":44440,"sim_selected_taeg":4,"sim_selected_frais_de_dossier":5,"sim_selected_economies":6,"sim_selected_echeance_mensuelle":8,"sim_selected_difference_de_mensualite":9,"sim_selected_cout_credit":4,"sim_selected_bank_name":"Attijari Wafabank","quotite_de_financement":44413,"oc_type_taux":"Fixe","oc_taux_ht_credit":4,"oc_taux_de_lassurance_deces_invalidite_pu":2,"oc_taux_de_lassurance_deces_invalidite_m":3,"oc_taeg_effectif_two":4,"oc_montant_credit":3,"oc_frais_de_dossier":44447,"oc_duree_credit_nbr_dannees":4,"oc_bank_name":"Attijari Wafabank","oc_autres_conditions_proposees_au_client":"test","montant_frais_notaire_inclus_credit_bancaire":67,"montant_frais_amenagement_inclus_credit_bancaire":100,"montant_credit":44256,"MCI_User_ID":"123","MCI_SIM_ID":"3XCX08","has_co_emprunt":true,"filter_client_bank":"Attijari Wafabank","etre_accompagne_par_muwabawb":false,"etat_du_bien_immobililer_objet_du_financement":"Ancien","estate_type":"Appartement","estate_price":100,"delai_de_concretistion":"1 mois","date_preparation_two_annees_bilan":"12/11/2021","date_declatement_du_titre":"12/11/2021","date_debut_activite_pro":"20/11/2021","date_de_titularisation":"12/11/2021","construction_price":2334,"co_emprunt_amount":12,"cap_endettement":44410,"autres_conditions_demandees_par_le_client":"test","apport_en_fonds_propres_requis":44287,"anciennete_activite_pro":1,"Recap_envoye": true },"Sexe":"Homme","registered":false,"profession":"professionTest","phone":"+212612345678","niveau_academique":"Bac+1","nationality":"Morocco","name":"TEST","first_call_to_action":"first_call_to_actionTest","email":"test@soscreditimmo.com","date_naissance":"20/11/1997","country":"Morocco","client_age":24,"age":24 }';
        req.requestBody = Blob.valueOf(data);
        RestContext.request = req;

        Test.startTest();

        WS_updateSimulation.pushToSF();

        Test.stopTest();

        Simulation__c sim = [SELECT Id, contact__r.Ville_de_r_sidence_si_Maroc__c ,Total_des_revenus__c,Recap_envoye__c  FROM Simulation__c Where MCI_SIM_ID__c = '3XCX08'];
        system.assertEquals('Casablanca', sim.contact__r.Ville_de_r_sidence_si_Maroc__c);
        system.assertEquals(44228, sim.Total_des_revenus__c);
        system.assertEquals(true, sim.Recap_envoye__c);

    }
    
    //CASE 1 : SIMULATION WITH LEAD
    @isTest static void test_push2SF_case2(){
        Lead lead = TestFactory.createLeads(1,true).get(0);
        TestFactory.createSimulations(new List<String>{'3XCX08'},lead.Id,'Lead__c',1,true);
        RestRequest req = new RestRequest();
        req.requestURI = '/services/apexrest/restUpdateSimulation';  
        req.httpMethod = 'POST';
        String data = '{"ville_naissance":"Casablanca","utm_var":"utmvarTest","utm_term":"utmTermTest","utm_source":"utmsourceTest","utm_product":"utmProductTest","utm_medium":"utmmediumTest","utm_lang":"utmLangTest","utm_format":"utmformatTest","utm_creadate":"24/12/2021","utm_content":"utmcontentTest","utm_ciblage":"utmciblageTest","utm_campaign":"utmcampaignTest","utm_apporteur":"utmapporteurTest","simulation":{ "usage_type":"Résidence principale","type_credit":"Immo","trouve_bien":false,"total_revenus":44228,"total_des_frais_de_notaire":12,"total_credits_encours":45,"sim_selected_year":2021,"sim_selected_type_adis":"Mensualisée","sim_selected_taux_type":"Fixe","sim_selected_taux_ht":44444,"sim_selected_taux_dendettementinc_ech":10,"sim_selected_taux_as_prime_unique":2,"sim_selected_taux_as_mensualise":44440,"sim_selected_taeg":4,"sim_selected_frais_de_dossier":5,"sim_selected_economies":6,"sim_selected_echeance_mensuelle":8,"sim_selected_difference_de_mensualite":9,"sim_selected_cout_credit":4,"sim_selected_bank_name":"Attijari Wafabank","quotite_de_financement":44413,"oc_type_taux":"Fixe","oc_taux_ht_credit":4,"oc_taux_de_lassurance_deces_invalidite_pu":2,"oc_taux_de_lassurance_deces_invalidite_m":3,"oc_taeg_effectif_two":4,"oc_montant_credit":3,"oc_frais_de_dossier":44447,"oc_duree_credit_nbr_dannees":4,"oc_bank_name":"Attijari Wafabank","oc_autres_conditions_proposees_au_client":"test","montant_frais_notaire_inclus_credit_bancaire":67,"montant_frais_amenagement_inclus_credit_bancaire":100,"montant_credit":44256,"MCI_User_ID":"123","MCI_SIM_ID":"3XCX08","has_co_emprunt":true,"filter_client_bank":"Attijari Wafabank","etre_accompagne_par_muwabawb":false,"etat_du_bien_immobililer_objet_du_financement":"Ancien","estate_type":"Appartement","estate_price":100,"delai_de_concretistion":"1 mois","date_preparation_two_annees_bilan":"12/11/2021","date_declatement_du_titre":"12/11/2021","date_debut_activite_pro":"20/11/2021","date_de_titularisation":"12/11/2021","construction_price":2334,"co_emprunt_amount":12,"cap_endettement":44410,"autres_conditions_demandees_par_le_client":"test","apport_en_fonds_propres_requis":44287,"anciennete_activite_pro":1,"Recap_envoye": true },"Sexe":"Homme","registered":false,"profession":"professionTest","phone":"+212612345678","niveau_academique":"Bac+1","nationality":"Morocco","name":"TEST","first_call_to_action":"first_call_to_actionTest","email":"test@soscreditimmo.com","date_naissance":"20/11/1997","country":"Morocco","client_age":24,"age":24 }';
        req.requestBody = Blob.valueOf(data);
        RestContext.request = req;

        Test.startTest();

        WS_updateSimulation.pushToSF();

        Test.stopTest();

        Simulation__c sim = [SELECT Id, lead__r.Ville_de_r_sidence_si_Maroc__c ,Total_des_revenus__c,Recap_envoye__c  FROM Simulation__c Where MCI_SIM_ID__c = '3XCX08'];
        system.assertEquals('Casablanca', sim.lead__r.Ville_de_r_sidence_si_Maroc__c);
        system.assertEquals(44228, sim.Total_des_revenus__c);
        system.assertEquals(true, sim.Recap_envoye__c);

    }
    

}