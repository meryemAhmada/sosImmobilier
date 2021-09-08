global class BatchContact implements Database.Batchable<sObject>, Database.Stateful{

    public String query = 'Select Id, AccountId FROM Contact WHERE Account = null';

    global Database.QueryLocator start(Database.BatchableContext bc){
        
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, List<sObject> scope){
        for(Contact c : (List<Contact>)(scope))
        {
            c.AccountId = '';
        }
    }
    
    global void finish(Database.BatchableContext BC){
        
    }
}