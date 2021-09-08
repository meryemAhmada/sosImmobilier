@isTest
public with sharing class WS_PushSimStatusToWebsite_Test {

    @isTest
    public static void WS_PushSimStatusToWebsite_Test() {
        /* Lead */
		Simulation__c simulation = new Simulation__c();
		//simulation.Name = 'Test Sim';
        simulation.MCI_Sim_ID__c = '1234';
        simulation.Statut__c = 'Nouvelle';
        simulation.Resultat__c = 'Test Res';
        simulation.Motif__c ='1';
		insert simulation;
        
        Test.startTest();
        
        Set<Id> simulationIds = new Set<Id>();
        Map<Id, Simulation__c> simulations = new Map<Id, Simulation__c>([SELECT Id FROM Simulation__c]);
        simulationIds.addAll(simulations.keySet());
        
        WS_PushSimStatusToWebsite.ws_PushDataSimStatusToWebsite(simulationIds);
        
        Test.stopTest();
    }
}