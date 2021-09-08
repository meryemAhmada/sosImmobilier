trigger SimulationPreventUpdateTrigger on Simulation__c (before update) {

    set<Id> SimWithErro = new set<Id>();
    For(Simulation__c sim :[select id,HOT_WARM_COLD__c,(select id from dossiers__r) from Simulation__c where id IN :Trigger.new]){
        if(sim.HOT_WARM_COLD__c == 'Sim Hot' && sim.dossiers__r.size()>0 && Trigger.oldMap.get(sim.Id).Motif__c != Trigger.newMap.get(sim.Id).Motif__c){
            SimWithErro.add(sim.Id);
            
        }
    }
    for(Simulation__c sim : Trigger.new){
        if(SimWithErro.contains(sim.Id)){
            sim.addError('Vous ne pouvez changer le motif une fois le dossier est créé');
        }
    }
    /*for(Simulation__c sim : Trigger.new){ 
        if(sim.HOT_WARM_COLD__c == 'Sim Hot'){
            Integer dossiersCount = [select count() from Dossier__c where Simulation__c = :sim.Id];
            if(dossiersCount > 0){
                // Simulation becomes HOT & a dossier is created : can't change motif of simulation
                sim.Motif__c = Trigger.oldMap.get(sim.Id).Motif__c;
                sim.addError('Cannot change motif if simulation HOT & a dossier is created.');
            }
        }
    }*/
}