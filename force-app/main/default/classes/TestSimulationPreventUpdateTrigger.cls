@isTest
public class TestSimulationPreventUpdateTrigger {

    static testMethod void testUnit(){
        Contact con = new Contact(FirstName='TestF', LastName = 'TestL',email='Test@test.com', IsConverted__c=True);
        insert con;
        
        Simulation__c simulation = new Simulation__c();
		/*simulation.Name = 'Test Sim';*/
        simulation.Actif__c = TRUE;
        simulation.Contact__c = con.Id;
        simulation.MCI_Sim_ID__c = '1234';
        // Sim Hot
        simulation.Statut__c = 'Qualifié';
        simulation.Resultat__c = 'Trouvé le bien-AFD';
        simulation.Motif__c = 'Shopping';
        insert simulation;
        
        Dossier__c dossier = new Dossier__c();
        dossier.Contact__c = con.Id;
        dossier.Simulation__c = simulation.Id;
        dossier.Dossier_Constitue_P1__c = True;
        insert dossier;
        
        Test.startTest();
        Simulation__c simulationTest = [select Id, Motif__c from Simulation__c where Id = :simulation.Id];
        simulationTest.Motif__c = 'Négo vendeur';
        Database.SaveResult updateResult = Database.update(simulationTest, false);
        Test.stopTest();

        System.assert(!updateResult.isSuccess());
        System.assert(updateResult.getErrors().size() > 0);
    }
}