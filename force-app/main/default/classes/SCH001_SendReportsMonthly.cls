global class SCH001_SendReportsMonthly implements Schedulable {
   
    global void execute(SchedulableContext SC) {
      Database.executebatch(new BA001_SendReportsMonthly());
   }
}