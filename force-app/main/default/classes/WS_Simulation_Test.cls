@isTest
public class WS_Simulation_Test {
    
    @TestSetup
    static void setup()
    {
        User currentUser = [Select Id , Bypass_VR__c  From User Where Id = :UserInfo.getUserId()];
        currentUser.Bypass_VR__c = true;
        update currentUser;
    }


    //CASE 1 : CONTACT EXISTS WITH SAME PHONE NUMBER
    @isTest static void test_push2SF_case1(){
        System.debug('### test_push2SF_case1 : CONTACT EXISTS WITH SAME PHONE NUMBER');
        Contact contact = TestFactory.createContactsWithSpecificData(NULL, '+21261234567', '0000', 1, true).get(0);
        
        RestRequest req = new RestRequest();
        req.requestURI = '/services/apexrest/restSimulation';  
        req.httpMethod = 'POST';
        req.requestBody = Blob.valueOf('{"name" : "TEST", "phone" : "+21261234567", "email" : "test@soscreditimmo.com", "MCI_User_ID" : "1234", "apporteur_ID" : "5678", "utm_source" : "", "utm_campaign" : "", "utm_medium" : "", "utm_term" : "", "utm_content" : "",  "utm_apporteur" : "", "profession" : "Consultant", "first_call_to_action": "", "registered": false, "simulation" : {"MCI_User_ID" : "1234", "MCI_SIM_ID" : "0192", "type_credit" : "Immo", "trouve_bien" : false, "montant_credit" : 150000, "total_revenus" : 250000, "cap_endettement" : 100, "total_credits_encours" : 15000 , "has_co_emprunt" : false , "etre_accompagne_par_muwabawb" : false}}');
        RestContext.request = req;

        Test.startTest();

        Id[] fixedSearchResults= new Id[1];
        fixedSearchResults[0] = contact.Id;
        Test.setFixedSearchResults(fixedSearchResults);

        WS_Simulation.pushToSF();

        Test.stopTest();

        contact = [SELECT Email, (SELECT Id FROM Simulations__r) FROM Contact];
        

    }
    

    //CASE 2 : LEAD EXISTS WITH SAME PHONE NUMBER
    @isTest static void test_push2SF_case2(){
        System.debug('### test_push2SF_case2 :  LEAD EXISTS WITH SAME PHONE NUMBER');
        Lead lead = TestFactory.createLeadsWithSpecificData('+21261234568', '0000', 1, true).get(0);
        
        RestRequest req = new RestRequest();
        req.requestURI = '/services/apexrest/restSimulation';  
        req.httpMethod = 'POST';
        req.requestBody = Blob.valueOf('{"name" : "TEST", "phone" : "+21261234568", "email" : "test@soscreditimmo.com", "MCI_User_ID" : "1234", "apporteur_ID" : "5678", "utm_source" : "", "utm_campaign" : "", "utm_medium" : "", "utm_term" : "", "utm_content" : "", "utm_apporteur" : "", "profession" : "Consultant", "first_call_to_action": "", "registered": false, "simulation" : {"MCI_User_ID" : "1234", "MCI_SIM_ID" : "0192", "type_credit" : "Immo", "trouve_bien" : false, "montant_credit" : 150000, "total_revenus" : 250000, "cap_endettement" : 100, "total_credits_encours" : 15000 , "has_co_emprunt" : false , "etre_accompagne_par_muwabawb" : false}}');
        RestContext.request = req;

        Test.startTest();

        Id[] fixedSearchResults= new Id[1];
        fixedSearchResults[0] = lead.Id;
        Test.setFixedSearchResults(fixedSearchResults);

        WS_Simulation.pushToSF();

        Test.stopTest();

        lead = [SELECT Email, (SELECT Id FROM Simulations__r) FROM Lead];
       

    }


    //CASE 3 : NO CONTACT/LEAD WITH SAME PHONE NUMBER + ACCOUNT WIHT MCI_USER_ID == APPORTEUR_ID
    @isTest static void test_push2SF_case3(){
        System.debug('### test_push2SF_case3 :  NO CONTACT/LEAD WITH SAME PHONE NUMBER + ACCOUNT WIHT MCI_USER_ID == APPORTEUR_ID');
        Account account = TestFactory.createAccountsWithSpecificData('5678', 1, true).get(0);
        
        RestRequest req = new RestRequest();
        req.requestURI = '/services/apexrest/restSimulation';  
        req.httpMethod = 'POST';
        req.requestBody = Blob.valueOf('{"name" : "TEST", "phone" : "+212600000000", "email" : "test@soscreditimmo.com", "MCI_User_ID" : "1234", "apporteur_ID" : "5678", "utm_source" : "", "utm_campaign" : "", "utm_medium" : "", "utm_term" : "", "utm_content" : "", "utm_apporteur" : "", "profession" : "Consultant", "first_call_to_action": "", "registered": false, "simulation" : {"MCI_User_ID" : "1234", "MCI_SIM_ID" : "0192", "type_credit" : "Immo", "trouve_bien" : false, "montant_credit" : 150000, "total_revenus" : 250000, "cap_endettement" : 100, "total_credits_encours" : 1500 , "has_co_emprunt" : false , "etre_accompagne_par_muwabawb" : false}}');
        RestContext.request = req;

        Test.startTest();

        WS_Simulation.pushToSF();

        Test.stopTest();

        Lead lead = [SELECT Apporteur__c, (SELECT Id FROM Simulations__r) FROM Lead];
       

    }


    //CASE 4 : NO CONTACT/LEAD WITH SAME PHONE NUMBER + LEAD WIHT MCI_USER_ID == APPORTEUR_ID
    @isTest static void test_push2SF_case4(){
        System.debug('### test_push2SF_case4 :  NO CONTACT/LEAD WITH SAME PHONE NUMBER + LEAD WIHT MCI_USER_ID == APPORTEUR_ID');
        Lead lead = TestFactory.createLeadsWithSpecificData('+21261234569', '5678', 1, true).get(0);
        
        RestRequest req = new RestRequest();
        req.requestURI = '/services/apexrest/restSimulation';  
        req.httpMethod = 'POST';
        req.requestBody = Blob.valueOf('{"name" : "TEST", "phone" : "+212600000000", "email" : "test@soscreditimmo.com", "MCI_User_ID" : "1234", "apporteur_ID" : "5678", "utm_source" : "", "utm_campaign" : "", "utm_medium" : "", "utm_term" : "", "utm_content" : "", "utm_apporteur" : "", "profession" : "Consultant", "first_call_to_action": "", "registered": false, "simulation" : {"MCI_User_ID" : "1234",  "MCI_SIM_ID" : "0192", "type_credit" : "Immo", "trouve_bien" : false, "montant_credit" : 150000, "total_revenus" : 250000, "cap_endettement" : 100, "total_credits_encours" : 15000 , "has_co_emprunt" : false , "etre_accompagne_par_muwabawb" : false}}');
        RestContext.request = req;

        Test.startTest();

        WS_Simulation.pushToSF();

        Test.stopTest();

        Contact contact = [SELECT MCI_User_ID__c, AccountId FROM Contact];

        lead = [SELECT LastName, Apporteur__c, (SELECT Id FROM Simulations__r) FROM Lead  WHERE MCI_User_ID__c = '1234'];
        //System.assertEquals('TEST', lead.LastName);

    }
    
    //CASE 5 : NO CONTACT/LEAD WITH SAME PHONE NUMBER + LEAD NAME IS BLANK/NULL
    @isTest static void test_push2SF_case5(){
        RestRequest req = new RestRequest();
        req.requestURI = '/services/apexrest/restSimulation';  
        req.httpMethod = 'POST';
        req.requestBody = Blob.valueOf('{"name" : "", "phone" : "+212600000000", "email" : "test@soscreditimmo.com", "MCI_User_ID" : "1234", "apporteur_ID" : "", "utm_source" : "", "utm_campaign" : "", "utm_medium" : "", "utm_term" : "", "utm_content" : "", "utm_apporteur" : "", "profession" : "Consultant", "first_call_to_action": "", "registered": false, "simulation" : {"MCI_User_ID" : "1234",  "MCI_SIM_ID" : "0192", "type_credit" : "Immo", "trouve_bien" : false, "montant_credit" : 150000, "total_revenus" : 250000, "cap_endettement" : 100, "total_credits_encours" : 1500 , "has_co_emprunt" : false , "etre_accompagne_par_muwabawb" : false}}');
        RestContext.request = req;

        Test.startTest();

        WS_Simulation.pushToSF();

        Test.stopTest();

        Lead lead = [SELECT LastName, Apporteur__c, (SELECT Id FROM Simulations__r) FROM Lead  WHERE MCI_User_ID__c = '1234'];
        //System.assertEquals('1234', lead.LastName);
    }
    
    //CASE 6 : CONTACT EXISTS WITH SAME PHONE NUMBER + MCI_SIM_ID IS BLANK/NULL
    @isTest static void test_push2SF_case6(){
        System.debug('### test_push2SF_case1 : CONTACT EXISTS WITH SAME PHONE NUMBER');
        Contact contact = TestFactory.createContactsWithSpecificData(NULL, '+21261234567', '0000', 1, true).get(0);
        
        RestRequest req = new RestRequest();
        req.requestURI = '/services/apexrest/restSimulation';  
        req.httpMethod = 'POST';
        req.requestBody = Blob.valueOf('{"name" : "TEST", "phone" : "+21261234567", "email" : "test@soscreditimmo.com", "MCI_User_ID" : "1234", "apporteur_ID" : "5678", "utm_source" : "", "utm_campaign" : "", "utm_medium" : "", "utm_term" : "", "utm_content" : "",  "utm_apporteur" : "", "profession" : "Consultant", "first_call_to_action": "", "registered": false, "simulation" : {"MCI_User_ID" : "1234", "MCI_SIM_ID" : "", "type_credit" : "Immo", "trouve_bien" : false, "montant_credit" : 150000, "total_revenus" : 250000, "cap_endettement" : 100, "total_credits_encours" : 15000 , "has_co_emprunt" : false , "etre_accompagne_par_muwabawb" : false}}');
        RestContext.request = req;

        Test.startTest();

        Id[] fixedSearchResults= new Id[1];
        fixedSearchResults[0] = contact.Id;
        Test.setFixedSearchResults(fixedSearchResults);

        WS_Simulation.pushToSF();

        Test.stopTest();
    }
    
    //CASE 7 : NO CONTACT/LEAD WITH SAME PHONE NUMBER + + MCI_SIM_ID IS BLANK/NULL
    @isTest static void test_push2SF_case7(){
        RestRequest req = new RestRequest();
        req.requestURI = '/services/apexrest/restSimulation';  
        req.httpMethod = 'POST';
        req.requestBody = Blob.valueOf('{"name" : "TEST", "phone" : "+212600000000", "email" : "test@mubawab.com", "MCI_User_ID" : "1234", "apporteur_ID" : "", "utm_source" : "", "utm_campaign" : "", "utm_medium" : "", "utm_term" : "", "utm_content" : "", "utm_apporteur" : "", "profession" : "Consultant", "first_call_to_action": "", "registered": false, "simulation" : {"MCI_User_ID" : "1234",  "MCI_SIM_ID" : "", "type_credit" : "Immo", "trouve_bien" : false, "montant_credit" : 150000, "total_revenus" : 250000, "cap_endettement" : 100, "total_credits_encours" : 15000 , "has_co_emprunt" : false , "etre_accompagne_par_muwabawb" : false}}');
        RestContext.request = req;

        Test.startTest();

        WS_Simulation.pushToSF();

        Test.stopTest();
    }

    
     //CASE 8 : NO CONTACT/LEAD WITH SAME PHONE NUMBER + LEAD EMAIL CONTAINS '@mubawab.com'
     @isTest static void test_push2SF_case8(){
        RestRequest req = new RestRequest();
        req.requestURI = '/services/apexrest/restSimulation';  
        req.httpMethod = 'POST';
        req.requestBody = Blob.valueOf('{"name" : "TEST", "phone" : "+212600000000", "email" : "test@mubawab.com", "MCI_User_ID" : "1234", "apporteur_ID" : "", "utm_source" : "", "utm_campaign" : "", "utm_medium" : "", "utm_term" : "", "utm_content" : "", "utm_apporteur" : "", "profession" : "Consultant", "first_call_to_action": "", "registered": false, "simulation" : {"MCI_User_ID" : "1234",  "MCI_SIM_ID" : "0192", "type_credit" : "Immo", "trouve_bien" : false, "montant_credit" : 150000, "total_revenus" : 250000, "cap_endettement" : 100, "total_credits_encours" : 15000 , "has_co_emprunt" : false , "etre_accompagne_par_muwabawb" : false}}');
        RestContext.request = req;

        Test.startTest();

        WS_Simulation.pushToSF();

        Test.stopTest();
    }
    
    @isTest static void test_push2SF_case9(){
        RestRequest req = new RestRequest();
        req.requestURI = '/services/apexrest/restSimulation';  
        req.httpMethod = 'POST';
        req.requestBody = Blob.valueOf('{"ville_naissance":"Casablanca","utm_var":"utmvarTest","utm_term":"utmTermTest","utm_source":"utmsourceTest","utm_product":"utmProductTest","utm_medium":"utmmediumTest","utm_lang":"utmLangTest","utm_format":"utmformatTest","utm_creadate":"24/12/2021","utm_content":"utmcontentTest","utm_ciblage":"utmciblageTest","utm_campaign":"utmcampaignTest","utm_apporteur":"utmapporteurTest","simulation":{"MCI_SIM_ID":"009","usage_type":"Résidence principale","type_credit":"Immo","trouve_bien":false,"total_revenus":12,"total_credits_encours":12,"montant_credit":1.3,"MCI_User_ID":"0050N0000079aM8QAI","has_co_emprunt":true,"filter_client_bank":"Attijari Wafabank","etre_accompagne_par_muwabawb":false,"etat_du_bien_immobililer_objet_du_financement":"Ancien","estate_type":"Appartement","estate_price":100,"delai_de_concretistion":"ASAP","date_preparation_two_annees_bilan":"12/11/2021","date_declatement_du_titre":"20/12/2021","date_debut_activite_pro":"12/11/2021","date_de_titularisation":"12/11/2021","construction_price":100,"co_emprunt_amount":12,"cap_endettement":1.6,"anciennete_activite_pro":1},"Sexe":"Femme","registered":false,"profession":"professionTest","phone":"+21261234567","niveau_academique":"Bac+1","nationality":"Morocco","name":"TEST","MCI_User_ID":"0050N0000079aM8QAI","first_call_to_action":"first_call_to_actionTest","email":"test@soscreditimmo.com","date_naissance":"20/11/1997","country":"Morocco","client_age":24,"apporteur_ID":"0050N0000079aM8QAI","age":24}');
        RestContext.request = req;

        Test.startTest();

        WS_Simulation.pushToSF();

        Test.stopTest();
        
        Simulation__c simulation = [Select Id , D_lai_de_concr_tisation__c , Type_de_cr_dit__c , Montant_du_cr_dit__c from Simulation__c];
        Lead lead = [Select Id from Lead];
        
        system.assertEquals('ASAP', simulation.D_lai_de_concr_tisation__c);
        system.assertEquals('Immo', simulation.Type_de_cr_dit__c);
        system.assertEquals(1.3, simulation.Montant_du_cr_dit__c);
    }
 
    
    
}