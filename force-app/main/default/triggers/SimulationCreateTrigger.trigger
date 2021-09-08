trigger SimulationCreateTrigger on Simulation__c (before insert) {

    for(Simulation__c sim : Trigger.new){
        if(sim.Contact__c != NULL){
            Id simContactId = sim.Contact__c;
            Integer contactsCount = [select count() from Simulation__c where Contact__c = :simContactId];
            if(contactsCount == 0){
                sim.Actif__c = TRUE;
            }
        }
        if(sim.Lead__c != NULL){
            Id simLeadId = sim.Lead__c;
            Integer leadsCount = [select count() from Simulation__c where Lead__c = :simLeadId];
            if(leadsCount == 0){
                sim.Actif__c = TRUE;
            }
        }
    }
}