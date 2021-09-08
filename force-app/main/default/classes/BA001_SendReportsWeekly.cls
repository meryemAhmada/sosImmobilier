global class BA001_SendReportsWeekly implements Database.Batchable<sObject>, Database.AllowsCallouts{
    
    public String query = 'Select Name, Recipients__c FROM Report_Managment__c WHERE Frequency__c = \'Weekly\'';
    
    global Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, List<sObject> scope){
        ReportManagementHandler.sendReports(scope);
    }
    
    global void finish(Database.BatchableContext BC){}
}