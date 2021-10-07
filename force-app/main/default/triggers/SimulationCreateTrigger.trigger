trigger SimulationCreateTrigger on Simulation__c (before insert) {
	 /*
     * Si la simulation n'est pas active, et qu'il n'existe aucune autre simulation qui est rattaché à 
     * un dossier en cours (Sauf dossier temps en won ou lost) = l'activer automatiquement et désactiver les autres sim
     * 
     * */
    //Update of 16/09/2021
    
    /*List<Id> contactIds = new List<Id>();
    List<Id> leadIds = new List<Id>();
    List<Id> newSims = new List<Id>();
    List<Simulation__c> simulationToDeactivate = new List<Simulation__c>();
    Boolean withError;
    List<Simulation__c> simulationsWithError = new List<Simulation__c>();
    
	Map<Id , List<Simulation__c>> relatedSimsMap = new Map<Id , List<Simulation__c>>();
    List<Simulation__c> relatedSims = new List<Simulation__c>();
    
    
    if(checkRecursive.runOnce()){
        for(Simulation__c sim : Trigger.new){
            newSims.add(sim.Id);
            if(sim.Contact__c != NULL) contactIds.add(sim.Contact__c);
            else if(sim.Lead__c != NULL) leadIds.add(sim.Lead__c);
        }
        
        
        List<Simulation__c> allRelatedSims = [select Id , Contact__c ,Lead__c , (Select Id From Dossiers__r where Doss_Temp__c != 'Won' and  Doss_Temp__c != 'Lost' and Doss_Temp__c != 'Dead') from Simulation__c where (Contact__c In :contactIds OR Lead__c In :leadIds) AND (Not(Id IN :newSims))];
        
        
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
            if(Trigger.isUpdate && Trigger.oldMap.get(sim.Id).Actif__c == True && sim.Actif__c == false){
                //No action to perform
            }
            else{
                relatedSims = new List<Simulation__c>();
                
                if(sim.Contact__c != NULL){
                    if(relatedSimsMap.containsKey(sim.Contact__c)) relatedSims = relatedSimsMap.get(sim.Contact__c);
                }
                else if(sim.Lead__c != NULL){
                    if(relatedSimsMap.containsKey(sim.Lead__c)) relatedSims = relatedSimsMap.get(sim.Lead__c);
                }
                
                if(sim.Actif__c && relatedSims.size() > 0){
                    withError = false;
                    for(Simulation__c relatedSim : relatedSims){
                        if(relatedSim.Dossiers__r.size() > 0){
                            withError = true;
                            simulationsWithError.add(sim);
                        }
                    }
                    if(!withError) simulationToDeactivate.addAll(relatedSims); 
                }
                else{
                    if(relatedSims.size() == 0){
                        sim.Actif__c = TRUE;
                    }
                    else {
                        Boolean existSimWithDossierEnCours = false;
                        for(Simulation__c relatedSim : relatedSims){
                            if(relatedSim.Dossiers__r.size() > 0){
                                existSimWithDossierEnCours = true;
                            }
                        }
                        if(!existSimWithDossierEnCours) {
                            sim.Actif__c = TRUE;
                            simulationToDeactivate.addAll(relatedSims); 
                        }
                    }
                } 
            }
        }
        
        //Désactivation des autres simulations
        for(Simulation__c sim : simulationToDeactivate){
            if(sim.Dossiers__r.size() == 0){
                sim.Actif__c = FALSE;
                sim.Statut__c = 'Autre sim MCI';
            }
        }
        update simulationToDeactivate;
        
        
        for(Simulation__c sim : simulationsWithError){
            sim.addError(Label.Activation_d_une_simulatio_erreur);
            
        }
    }*/
    
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
    
    List<Simulation__c> allRelatedSims = [select Id , Contact__c ,Lead__c , (Select Id From Dossiers__r) from Simulation__c where (Contact__c In :contactIds OR Lead__c In :leadIds) and actif__c = true];
    
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
    List<String> contactOrLeadsWithSimActive = new List<String>();
    String leadOrConId;
    for(Simulation__c sim : Trigger.new){
        leadOrConId = '';
        relatedSims = new List<Simulation__c>();
        if(sim.Contact__c != NULL){
            leadOrConId = sim.Contact__c;
            if(relatedSimsMap.containsKey(sim.Contact__c)) relatedSims = relatedSimsMap.get(sim.Contact__c);
        }
        else if(sim.Lead__c != NULL){
            leadOrConId = sim.Lead__c;
            if(relatedSimsMap.containsKey(sim.Lead__c)) relatedSims = relatedSimsMap.get(sim.Lead__c);
        }
        
        if(relatedSims.size() < 1 && !contactOrLeadsWithSimActive.contains(leadOrConId)){
            contactOrLeadsWithSimActive.add(leadOrConId);
            sim.Actif__c = TRUE;
        }
    }
}