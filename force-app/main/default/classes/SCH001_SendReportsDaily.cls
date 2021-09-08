global class SCH001_SendReportsDaily implements Schedulable {
    
    global void execute(SchedulableContext SC) {
        Database.executebatch(new BA001_SendReportsDaily());
    }
}