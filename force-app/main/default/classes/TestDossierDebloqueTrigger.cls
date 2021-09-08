@isTest
public class TestDossierDebloqueTrigger {

    static testMethod void testUnit(){
        Contact con = new Contact(FirstName='TestF', LastName = 'TestL',email='Test@test.com');
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
        
        Dossier__c dossierPr = new Dossier__c();
        dossierPr.Contact__c = con.Id;
        dossierPr.Simulation__c = simulation.Id;
        dossierPr.Dossier_Constitue_P1__c = True;
        dossierPr.Dossier_d_bloqu__c = True;
        
        
        Dossier__c dossierSec = new Dossier__c();
        dossierSec.Contact__c = con.Id;
        dossierSec.Simulation__c = simulation.Id;
        dossierSec.Dossier_Constitue_P1__c = True;
        dossierSec.Dossier_d_bloqu__c = True;
        dossierSec.Dossier_Perdu__c = False;
        insert dossierSec;
        
        Test.startTest();
 		insert dossierPr;
        Test.stopTest();
        
        Dossier__c dossierRes = [select Id, Dossier_d_bloqu__c, Dossier_Perdu__c from Dossier__c where Id = :dossierSec.Id];
        System.assertEquals(dossierRes.Dossier_d_bloqu__c, False);
        System.assertEquals(dossierRes.Dossier_Perdu__c, True);
    }
}