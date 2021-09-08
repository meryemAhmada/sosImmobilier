trigger UpdateSimStatusTrigger on Simulation__c (before update) {
    
    for(Simulation__c sim : Trigger.new){
        if(sim.Contact__c != NULL && sim.Actif__c != Trigger.oldMap.get(sim.Id).Actif__c && sim.Actif__c == TRUE){
            Id simContactId = sim.Contact__c;  
            List<Simulation__c> simulationsToUpdate = new List<Simulation__c>();           
            for(Simulation__c simulation : [SELECT Actif__c FROM Simulation__c WHERE Contact__c = :simContactId AND Id != :sim.Id]){
            	List<Dossier__c> dossiers = [SELECT Id FROM Dossier__c WHERE Simulation__c = :simulation.Id];
                if(dossiers.isEmpty()){
                    simulation.Actif__c = FALSE;
                    simulation.Statut__c = 'Autre sim MCI';
                    simulationsToUpdate.add(simulation);
                }               
            }            
            update simulationsToUpdate;           
        }
    }
}