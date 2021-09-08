global class BA001_SendReportsDaily implements Database.Batchable<sObject>, Database.AllowsCallouts{
    
    public String query = 'Select Name, Recipients__c FROM Report_Managment__c WHERE Frequency__c = \'Daily\'';
    
    global Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, List<sObject> scope){
        ReportManagementHandler.sendReports(scope);
    }
    
    global void finish(Database.BatchableContext BC){}
}