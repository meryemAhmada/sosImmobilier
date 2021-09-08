@isTest
public class TestSimulationCreateTrigger {
    
    static testMethod void testUnit(){
        Contact con = new Contact(FirstName='TestF', LastName = 'TestL',email='Test@test.com');
        insert con;
        
        Lead led = new Lead(lastname = 'TestLa', firstName ='TestFi', company = 'ABC');
        insert led;
        
        Simulation__c simulation = new Simulation__c();
		/*simulation.Name = 'Test Sim';*/
        simulation.Actif__c = FALSE;
        simulation.Contact__c = con.Id;
        simulation.Lead__c = led.Id;
        simulation.MCI_Sim_ID__c = '1234';
        
		Test.startTest();
        insert simulation;
        Test.stopTest(); 
        
        Simulation__c simulationTest = [select Actif__c from Simulation__c where Id = :simulation.Id];
        System.assertEquals(simulationTest.Actif__c, True);
    }
}