trigger TR001_SimmulationDosierTask on Task (before insert) {
    if(Trigger.isBefore){
        if(Trigger.isInsert){
            TR001_SimmulationDosierTaskHandler.handleBeforeInsert(Trigger.new);
        }
    }
}