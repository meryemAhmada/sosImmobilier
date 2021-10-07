trigger UpdateSimStatusTrigger on Simulation__c (before update) {
    
    List<Id> newSims = new List<Id>();
    List<Id> contactIds = new List<Id>();
    List<Id> leadIds = new List<Id>();
    List<Simulation__c> relatedSims = new List<Simulation__c>();
    
    Map<Id , List<Simulation__c>> relatedSimsMap = new Map<Id , List<Simulation__c>>();
    List<Simulation__c> simulationsToUpdate = new List<Simulation__c>();
    
    for(Simulation__c sim : Trigger.new){
        newSims.add(sim.Id);
        if(sim.Contact__c != NULL) contactIds.add(sim.Contact__c);
        else if(sim.Lead__c != NULL) leadIds.add(sim.Lead__c);
    }
    
    List<Simulation__c> allRelatedSims = [select Id , Contact__c ,Lead__c , (Select Id From Dossiers__r) from Simulation__c where (Contact__c In :contactIds OR Lead__c In :leadIds)];

    for(Simulation__c relatedSim : allRelatedSims){
        if(relatedSim.Contact__c != null){
            if(!relatedSimsMap.containsKey(relatedSim.Contact__c))
                relatedSimsMap.put(relatedSim.Contact__c , new List<Simulation__c>());
            relatedSimsMap.get(relatedSim.Contact__c).add(relatedSim);
        }
        else if(relatedSim.Lead__c != null){
            if(!relatedSimsMap.containsKey(relatedSim.Lead__c))
                relatedSimsMap.put(relatedSim.Lead__c , new List<Simulation__c>());
            relatedSimsMap.get(relatedSim.Lead__c).add(relatedSim);
        }
    }
    
    for(Simulation__c sim : Trigger.new){
        // if(sim.Contact__c != NULL && sim.Actif__c != Trigger.oldMap.get(sim.Id).Actif__c && sim.Actif__c == TRUE){
        if(sim.Actif__c != Trigger.oldMap.get(sim.Id).Actif__c && sim.Actif__c == TRUE){
            relatedSims = new List<Simulation__c>();
            if(sim.Contact__c != NULL){
                if(relatedSimsMap.containsKey(sim.Contact__c)) relatedSims = relatedSimsMap.get(sim.Contact__c);
            }
            else if(sim.Lead__c != NULL){
                if(relatedSimsMap.containsKey(sim.Lead__c)) relatedSims = relatedSimsMap.get(sim.Lead__c);
            }
            for(Simulation__c relatedSim : relatedSims){
                if(relatedSim.Id != sim.Id && relatedSim.Dossiers__r.size() == 0){
                    relatedSim.Actif__c = FALSE;
                    relatedSim.Statut__c = 'Autre sim MCI';
                    simulationsToUpdate.add(relatedSim);
                }
            }           
        }
    }
    update simulationsToUpdate;
    
   /*for(Simulation__c sim : Trigger.new){
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
    }*/
}