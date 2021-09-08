@isTest
public class WS_Mubawab_Test {
    //CASE 1 : CONTACT EXISTS WITH SAME PHONE NUMBER
    @isTest static void test_push2SF_case1(){
        System.debug('### test_push2SF_case1 : CONTACT EXISTS WITH SAME PHONE NUMBER');
        Contact contact = TestFactory.createContactsWithSpecificData(NULL, '+21261234567', '0000', 1, true).get(0);
        
        RestRequest req = new RestRequest();
        req.requestURI = '/services/apexrest/leadMubawab';  
        req.httpMethod = 'POST';
        req.requestBody = Blob.valueOf('{"name" : "TEST", "phone" : "+21261234567"}');
        RestContext.request = req;

        Test.startTest();

        Id[] fixedSearchResults= new Id[1];
        fixedSearchResults[0] = contact.Id;
        Test.setFixedSearchResults(fixedSearchResults);

        WS_Mubawab.pushToSF();

        Test.stopTest();

        contact = [SELECT Email, (SELECT Id FROM Simulations__r) FROM Contact];
        

    }
    

    //CASE 2 : LEAD EXISTS WITH SAME PHONE NUMBER
    @isTest static void test_push2SF_case2(){
        System.debug('### test_push2SF_case2 :  LEAD EXISTS WITH SAME PHONE NUMBER');
        Lead lead = TestFactory.createLeadsWithSpecificData('+21261234568', '0000', 1, true).get(0);
        
        RestRequest req = new RestRequest();
        req.requestURI = '/services/apexrest/leadMubawab';  
        req.httpMethod = 'POST';
        req.requestBody = Blob.valueOf('{"name" : "TEST", "phone" : "+21261234568"}');
        RestContext.request = req;

        Test.startTest();

        Id[] fixedSearchResults= new Id[1];
        fixedSearchResults[0] = lead.Id;
        Test.setFixedSearchResults(fixedSearchResults);

        WS_Mubawab.pushToSF();

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
        req.requestBody = Blob.valueOf('{"name" : "TEST", "phone" : "+212600000000"}');
        RestContext.request = req;

        Test.startTest();

        WS_Mubawab.pushToSF();

        Test.stopTest();

        Lead lead = [SELECT Apporteur__c, (SELECT Id FROM Simulations__r) FROM Lead];
       

    }


    //CASE 4 : NO CONTACT/LEAD WITH SAME PHONE NUMBER + LEAD WIHT MCI_USER_ID == APPORTEUR_ID
    @isTest static void test_push2SF_case4(){
        System.debug('### test_push2SF_case4 :  NO CONTACT/LEAD WITH SAME PHONE NUMBER + LEAD WIHT MCI_USER_ID == APPORTEUR_ID');
        Lead lead = TestFactory.createLeadsWithSpecificData('+21261234569', Label.mubawabMCI, 1, true).get(0);
        
        RestRequest req = new RestRequest();
        req.requestURI = '/services/apexrest/leadMubawab';  
        req.httpMethod = 'POST';
        req.requestBody = Blob.valueOf('{"name" : "TEST", "phone" : "+212600000000"}');
        RestContext.request = req;

        Test.startTest();

        WS_Mubawab.pushToSF();

        Test.stopTest();

        lead = [SELECT Apporteur__c, (SELECT Id FROM Simulations__r) FROM Lead WHERE MCI_User_ID__c = :Label.mubawabMCI];


    }

}