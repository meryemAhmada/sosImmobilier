trigger TR001_SimmulationLeadAffectation on Simulation__c (after insert , after update) {

    User u = [select Id, Bypass_triggers__c from user where id = :UserInfo.getUserId()];
    List<Simulation__c> simulationToUpdate = new List<Simulation__c>();
	if (!u.Bypass_triggers__c){
        if(Trigger.isAfter){
            if(Trigger.isInsert){
                TR001_SimmulationLeadAffectationHandler.handleBeforeInsert(Trigger.new);
            }
            if(Trigger.isUpdate){
                for (Simulation__c simulation : Trigger.new) {
                    if (simulation.reassigner__c == true) {
                        simulationToUpdate.add(simulation);
                    }
                }
                if (simulationToUpdate !=null && !simulationToUpdate.isEmpty()) TR001_SimmulationLeadAffectationHandler.handleBeforeUpdate(simulationToUpdate);
            }
        }
    }
}