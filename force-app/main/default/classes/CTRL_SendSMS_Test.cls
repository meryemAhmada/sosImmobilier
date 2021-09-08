@isTest
public class CTRL_SendSMS_Test{
    
    @testSetup public static void testSetup(){
        
        /* ACCOUNT */
        Account account = new Account(Name='Account4Test', Phone='+212612345678');
        insert account;
        
        /* CONTACT */
        Contact contact = new Contact(LastName='Contact4Test', 
                                      Phone='+212612345678', MobilePhone='+212612345678', 
                                      AssistantPhone='0612345678999', HomePhone=NULL); 
        insert contact;
    }
    
    /*
     * TEST: SEND SMS FOR STANDARD SOBJECT (WHOID) (EXAMPLE: CONTACT)
     * CASE 1 : WRONG NUMBER
     * CASE 2 : NO NUMBER
     * CASE 3 : CORRECT NUMBER
     * CASE 4 : NO SELECTED PHONES
     */
    @isTest public static void testSendSMS_toContact(){
        Contact contact = [SELECT Id, Phone, MobilePhone, AssistantPhone, HomePhone FROM Contact];

        Test.setMock(HttpCalloutMock.class, new Mock_StatusCode_200());
        
        Test.startTest();

        ApexPages.StandardController stdCtrl = new ApexPages.standardController(contact);
        CTRL_SendSMS ctrl = new CTRL_SendSMS(stdCtrl);
        
        ctrl.body = 'SMS Test';
        ctrl.getPhoneFieldsList();
        
        //CASE 1
        ctrl.selectedPhones.add('AssistantPhone');
        ctrl.createSmsList();
        
        System.assertEquals(0, ctrl.tasks.size());
        
        ctrl.selectedPhones = new List<String>();
        
        //CASE 2
        ctrl.selectedPhones.add('HomePhone');
        ctrl.createSmsList();
        
        System.assertEquals(0, ctrl.tasks.size());
        
        ctrl.selectedPhones = new List<String>();

        //CASE 3
        ctrl.selectedPhones.add('Phone');
        ctrl.selectedPhones.add('MobilePhone');
        ctrl.createSmsList();
        
        System.assertEquals(2, ctrl.tasks.size());
        System.assertEquals(contact.Phone, ctrl.tasks.get(0).Phone__c);
        System.assertEquals(contact.MobilePhone, ctrl.tasks.get(1).Phone__c);
        
        ctrl.selectedPhones = new List<String>();
        
        //CASE 4
        ctrl.createSmsList();

        System.assertEquals(0, ctrl.tasks.size());

        
        Test.stopTest();
    }
    
    /*
     * TEST: SEND SMS FOR STANDARD SOBJECT (WHATID) (EXAMPLE: ACCOUNT)
     */
    @isTest public static void testSendSMS_toAccount(){
        Account account = [SELECT Id, Phone FROM Account];
        List<Task> tasks;

        Test.setMock(HttpCalloutMock.class, new Mock_StatusCode_200());
        
        Test.startTest();
        
        ApexPages.StandardController stdCtrl = new ApexPages.standardController(account);
        CTRL_SendSMS ctrl = new CTRL_SendSMS(stdCtrl);
        
        ctrl.body = 'SMS Test';

        ctrl.selectedPhones.add('Phone');
        ctrl.createSmsList();
        
        System.assertEquals(1, ctrl.tasks.size());
        System.assertEquals(account.Phone, ctrl.tasks.get(0).Phone__c);
        

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