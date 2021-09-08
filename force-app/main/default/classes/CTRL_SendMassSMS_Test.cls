@isTest
public class CTRL_SendMassSMS_Test{
    
    @testSetup public static void testSetup(){

        /* CURRENT USER */
        User currentUser = [SELECT Id FROM User WHERE Id =: UserInfo.getUserId()];

        /* ACCOUNTS */
        List<Account> accounts = new List<Account>();
        accounts.add(new Account(Name='Account4Test1', Phone='+212677581425'));
        accounts.add(new Account(Name='Account4Test2', Phone=NULL));
        accounts.add(new Account(Name='Account4Test3', Phone='0678142536'));
        accounts.add(new Account(Name='Account4Test4', Phone='+212612345678'));
        insert accounts;

        /* CONTACTS */
        List<Contact> contacts = new List<Contact>();
        contacts.add(new Contact(LastName='Contact4Test1', 
                                      Phone='+212612345678', MobilePhone='+212612345678', 
                                      AssistantPhone='0612345678999', HomePhone=NULL));
        contacts.add(new Contact(LastName='Contact4Test2', 
                                      Phone=NULL, MobilePhone=NULL, 
                                      AssistantPhone='+212666882244', HomePhone=NULL));
        contacts.add(new Contact(LastName='Contact4Test3', 
                                      Phone='0666612345678', MobilePhone='+2mkoihu', 
                                      AssistantPhone=NULL, HomePhone='067142536')); 
        insert contacts;

        /* EMAIL TEMPLATE */
        EmailTemplate emailTemplate = new EmailTemplate(DeveloperName='EmailTemplate4Test', Name='EmailTemplate4Test', Subject='Test',
                                                        Body='Test', TemplateType= 'Text', IsActive=true, FolderId = currentUser.Id);
        //SYSTEM.RUNAS(currentUser){} --> AVOID 'MIXED_DML_OPERATION' ERROR
        System.runAs(currentUser){ insert emailTemplate; } 

        
         /* SMS TEMPLATES */
        List<SMS_Template__c> templates = new List<SMS_Template__c>();
        templates.add(new SMS_Template__c(Name='Template 1 for Test', RelatedTo__c = 'Contact', Body__c = 'Hello {!Contact.Name}', Active__c = true));
        templates.add(new SMS_Template__c(Name='Template 3 for Test', Body__c = '', Source__c = 'EmailTemplate4Test', Active__c = true));
        templates.add(new SMS_Template__c(Name='Template 2 for Test', Body__c = '', Active__c = true));
        insert templates;


    }
    
    /*
     * TEST: SEND MASS SMS FOR STANDARD SOBJECT (EXAMPLE: CONTACT) - CUSTOM BODY
     * CASE 1 : NO SOURCE
     * CASE 2 : CUSTOM BODY TYPE
     * CASE 3: NO SELECTED SOBJECTS
     */
    @isTest public static void testSendMassSMS_CustomBody(){
        List<Contact> contacts = [SELECT Id, Phone, MobilePhone, AssistantPhone, HomePhone FROM Contact];
        List<SMS_Template__c> templates = [SELECT Id FROM SMS_Template__c];
        Map<Id, List<Task>> mapTasks;

        Test.setMock(HttpCalloutMock.class, new Mock_StatusCode_200());
        
        Test.startTest();
        
        ApexPages.StandardSetController stdSetCtrl = new ApexPages.StandardSetController(contacts);
        stdSetCtrl.setSelected(contacts);
        CTRL_SendMassSMS ctrl = new CTRL_SendMassSMS(stdSetCtrl);

        ctrl.getPhoneFieldsList();
        ctrl.getTypesBody();
        ctrl.getTemplates();

        //CASE 1 
        ctrl.nextStep2(); //NO BODY SOURCE

        //CASE 2
        ctrl.typeBody = 'custom';
        ctrl.changeSource();

        ctrl.nextStep2(); //EMPTY BODY
        ctrl.returnStep1();

        ctrl.body = 'Hi there !';
        ctrl.nextStep2();

        ctrl.nextStep2(); //NO SELECTED PHONES
        ctrl.returnStep1();

        ctrl.selectedPhones.add('Phone');
        ctrl.selectedPhones.add('MobilePhone');
        ctrl.selectedPhones.add('HomePhone');
        ctrl.selectedPhones.add('AssistantPhone');

        ctrl.nextStep2(); 

        ctrl.invalidPhones.get(contacts[0].Id)[0].value = '+21278751425'; //UPDATE INVALID PHONE NUMBER
        ctrl.saveUpdates();

        ctrl.nextStep3();

        mapTasks = ctrl.getNewTasks();

        //VERIFY RESULTS
        System.assertEquals(2, mapTasks.size());
        System.assertEquals(true, mapTasks.containsKey(contacts[0].Id));
        System.assertEquals(2, mapTasks.get(contacts[0].Id).size());
        System.assertEquals(true, mapTasks.containsKey(contacts[1].Id));
        System.assertEquals(1, mapTasks.get(contacts[1].Id).size());
        System.assertEquals(false, mapTasks.containsKey(contacts[2].Id));

        ctrl.cancel();

        //REFRESH
        stdSetCtrl = new ApexPages.StandardSetController(new List<Contact>());
        stdSetCtrl.setSelected(new List<Contact>());
        ctrl = new CTRL_SendMassSMS(stdSetCtrl);

        ctrl.nextStep2(); 

        System.assertEquals(0, ctrl.selectedsObjectsSize);

        
        Test.stopTest();
    }


    /*
     * TEST: SEND MASS SMS FOR STANDARD SOBJECT (EXAMPLE: CONTACT) - TEMPLATE BODY TYPE
     * CASE 4 : TEMPLATE WITH NO EMPTY BODY
     * CASE 5: WRONG TEMPLATE
     */
     @isTest public static void testSendMassSMS_TemplateBody_Contact(){
        List<Contact> contacts = [SELECT Id, Phone, MobilePhone, AssistantPhone, HomePhone FROM Contact];
        List<SMS_Template__c> templates = [SELECT Id FROM SMS_Template__c];
        Map<Id, List<Task>> mapTasks;

        Test.setMock(HttpCalloutMock.class, new Mock_StatusCode_200());
        
        Test.startTest();
        
        ApexPages.StandardSetController stdSetCtrl = new ApexPages.StandardSetController(contacts);
        stdSetCtrl.setSelected(contacts);
        CTRL_SendMassSMS ctrl = new CTRL_SendMassSMS(stdSetCtrl);

        ctrl.typeBody = 'template';
        ctrl.changeSource();

        //CASE 4
        ctrl.template = templates[0].Id;

        ctrl.selectedPhones.add('Phone');
        ctrl.selectedPhones.add('MobilePhone');
        ctrl.selectedPhones.add('HomePhone');
        ctrl.selectedPhones.add('AssistantPhone');

        ctrl.nextStep2();
        ctrl.nextStep3();

        mapTasks = ctrl.getNewTasks();

        //VERIFY RESULTS
        System.assertEquals(2, mapTasks.size());
        System.assertEquals('Hello Contact4Test1', mapTasks.get(contacts[0].Id)[0].description);
        System.assertEquals('Hello Contact4Test1', mapTasks.get(contacts[0].Id)[1].description);
        System.assertEquals('Hello Contact4Test2', mapTasks.get(contacts[1].Id)[0].description);

        ctrl.cancel();

        //REFRESH
        ctrl = new CTRL_SendMassSMS(stdSetCtrl);

        ctrl.typeBody = 'template';
        ctrl.changeSource();

        //CASE 5
        ctrl.template = '00T11111111';

        ctrl.selectedPhones.add('Phone');
        ctrl.selectedPhones.add('MobilePhone');
        ctrl.selectedPhones.add('HomePhone');
        ctrl.selectedPhones.add('AssistantPhone');

        ctrl.nextStep2();

        System.assertEquals(true, String.isEmpty(ctrl.body));

        Test.stopTest();
    }

    /*
     * TEST: SEND MASS SMS FOR STANDARD SOBJECT (EXAMPLE: ACCOUNT) - TEMPLATE BODY TYPE
     * CASE 6 : TEMPLATE WITH SOURCE AND NO EMPTY BODY
     * CASE 7 : TEMPLATE WITH EMPTY BODY AND SOURCE
     * CASE 8 : NO VALID PHONE NUMBER  
     */
     @isTest public static void testSendMassSMS_TemplateBody_Account(){
        List<Account> accounts = [SELECT Id, Phone FROM Account];
        List<SMS_Template__c> templates = [SELECT Id FROM SMS_Template__c];
        Map<Id, List<Task>> mapTasks;

        Test.setMock(HttpCalloutMock.class, new Mock_StatusCode_200());
        
        Test.startTest();
        
        ApexPages.StandardSetController stdSetCtrl = new ApexPages.StandardSetController(accounts);
        stdSetCtrl.setSelected(accounts);
        CTRL_SendMassSMS ctrl = new CTRL_SendMassSMS(stdSetCtrl);

        ctrl.typeBody = 'template';
        ctrl.changeSource();


        //CASE 6
        ctrl.template = templates[1].Id;

        ctrl.selectedPhones.add('Phone');

        ctrl.nextStep2();
        ctrl.nextStep3();

        system.debug('*** CASE 4/TASKS: ' + ctrl.tasks);

        mapTasks = ctrl.getNewTasks();

        //VERIFY RESULTS
        System.assertEquals(2, mapTasks.size());
        System.assertEquals('Test', mapTasks.get(accounts[0].Id)[0].description);
        System.assertEquals('Test', mapTasks.get(accounts[3].Id)[0].description);

        ctrl.cancel();

        //REFRESH
        ctrl = new CTRL_SendMassSMS(stdSetCtrl);

        ctrl.typeBody = 'template';
        ctrl.changeSource();

        //CASE 7
        ctrl.template = templates[2].Id;

        ctrl.selectedPhones.add('Phone');

        ctrl.nextStep2();

        System.assertEquals(true, String.isEmpty(ctrl.body));

        ctrl.cancel();

        //CASE 8
        stdSetCtrl = new ApexPages.StandardSetController(new List<Account>{accounts[1]});
        stdSetCtrl.setSelected(new List<Account>{accounts[1]});
        ctrl = new CTRL_SendMassSMS(stdSetCtrl);

        ctrl.typeBody = 'template';
        ctrl.changeSource();

        ctrl.template = templates[0].Id;

        ctrl.selectedPhones.add('Phone');

        ctrl.nextStep2();
        ctrl.nextStep3();

        System.assertEquals(0, ctrl.validPhones.size());

        Test.stopTest();
    }



     //HttpCalloutMock
    private class Mock_StatusCode_200 implements HttpCalloutMock{
        public HTTPResponse respond(HTTPRequest req) {

            System.assertEquals(Label.info_bip_endpoint_mass_2, req.getEndpoint());
            System.assertEquals('POST', req.getMethod());

            Task insertedTask = [Select Id FROM Task WHERE phone__c = '+212612345678' LIMIT 1];
            
            // Create a fake response
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{"messages": [{"status": {"name": "TEST", "description": "TEST"}, "smsCount": 1, "messageId": "'+insertedTask.id+'"} ] }');
            res.setStatusCode(200);
            return res;
        }
    }


}