@isTest
private class Test_ConversionBatch {
    @testSetup 
	static void setup() {
        List<Lead> leads = new List<Lead>();
        for (Integer i=0;i<20;i++) {
            leads.add(new Lead(LastName='Test'+i, FirstName='Tester'+i,Status='Joignable',Company='test', To_Convert__c = true));
        }
        insert leads;
    }
    static testmethod void test() {        
        Test.startTest();
        ConversionBatch bc = new ConversionBatch();
        Id batchId = Database.executeBatch(bc, 200);
        Test.stopTest();
        System.assertEquals(20, [select count() from contact where LastName LIKE 'Test%']);
    }
}