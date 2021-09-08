@isTest
private class SmsService_Test {
        
    @testSetup static void init() 
    {
        
        Contact c = new Contact(FirstName = 'Test', LastName = 'Name',  MobilePhone = '00212650382336');
        insert c; 
        
        List<Task> insertedTask = new List<Task>();
        
        Task t = new Task(Description='Test',  phone__c = '00212650382336', WhoId = c.id );
        
        insert t;
    }

    
    @isTest static void test_sendSmsFromTasks()
    {
        Task insertedTask = [Select Id FROM Task WHERE phone__c = '00212650382336' LIMIT 1];
        
        Test.setMock(HttpCalloutMock.class, new Mock_StatusCode_200());
        
        Test.startTest();
        SmsService.sendSmsFromTasks(new Set<Id>{insertedTask.id});
        Test.stopTest();

        insertedTask = [Select Id,Status_Name__c,Status__c,SMS_Count__c FROM Task WHERE phone__c = '00212650382336' LIMIT 1];

        System.assertEquals('TEST', insertedTask.Status_Name__c);
        System.assertEquals('TEST', insertedTask.Status__c);
        System.assertEquals(1, insertedTask.SMS_Count__c);

    }


    private class Mock_StatusCode_200 implements HttpCalloutMock 
    {
        public HTTPResponse respond(HTTPRequest req) {

            System.assertEquals(Label.info_bip_endpoint_mass_2, req.getEndpoint());
            System.assertEquals('POST', req.getMethod());

            Task insertedTask = [Select Id FROM Task WHERE phone__c = '00212650382336' LIMIT 1];
            
            // Create a fake response
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{"messages": [{"status": {"name": "TEST", "description": "TEST"}, "smsCount": 1, "messageId": "'+insertedTask.id+'"} ] }');
            res.setStatusCode(200);
            return res;
        }
    }


    private class Mock_StatusCode_200_DeliveryReport implements HttpCalloutMock 
    {
        public HTTPResponse respond(HTTPRequest req) {

            System.assertEquals(Label.info_bip_endpoint_all_reports, req.getEndpoint());
            System.assertEquals('GET', req.getMethod());

            Task insertedTask = [Select Id FROM Task WHERE  phone__c = '00212650382336' LIMIT 1];
            
            // Create a fake response
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{"results":[{"messageId":"'+insertedTask.id+'", "smsCount":1, "price":{"pricePerMessage":0.29 }, "status":{"name":"TEST", "description":"TEST"}, "error":{"name":"NO_ERROR","description":"NO_ERROR"}}]}');
            res.setStatusCode(200);
            return res;
        }
    }

    
}