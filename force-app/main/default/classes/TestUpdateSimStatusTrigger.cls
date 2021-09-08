@isTest
public class TestUpdateSimStatusTrigger {

    static testMethod void testUnit(){
        Contact con = new Contact(FirstName='TestF', LastName = 'TestL',email='Test@test.com');
        insert con;
        
        Simulation__c simulationPr = new Simulation__c();
		/*simulationPr.Name = 'Test SimPr';*/
        simulationPr.Actif__c = FALSE;
        simulationPr.Contact__c = con.Id;
        simulationPr.MCI_Sim_ID__c = '1234';
        
        
        Simulation__c simulationSec = new Simulation__c();
		/*simulationSec.Name = 'Test SimSec';*/
        simulationSec.Actif__c = TRUE;
        simulationSec.Contact__c = con.Id;
        simulationSec.MCI_Sim_ID__c = '1235';
        insert simulationSec;
        
        Test.startTest();
        insert simulationPr;
        Simulation__c simulationTest = [select Id, Actif__c from Simulation__c where Id = :simulationPr.Id];
        simulationTest.Actif__c = TRUE;
        update simulationTest;
        Test.stopTest();
        
        Simulation__c simulationRes = [select Id, Actif__c from Simulation__c where Id = :simulationSec.Id];
        System.assertEquals(simulationRes.Actif__c, False);
    }
}