global class SCH001_SendReportsWeekly implements Schedulable {
    
    global void execute(SchedulableContext SC) {
        Database.executebatch(new BA001_SendReportsWeekly());
    }
}