global class ConversionBatch implements Database.Batchable<sObject>, Database.Stateful{
     public String query = 'Select Id, tech_contact_migration__c, tech_contact_migration__r.accountId  FROM Lead WHERE To_Convert__c = true and IsConverted = false';
    
    global Database.QueryLocator start(Database.BatchableContext bc){    
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext bc, List<Lead> scope){
        for (Lead ld : scope)
        {      
            LeadStatus convertStatus = [SELECT Id, MasterLabel FROM LeadStatus WHERE IsConverted = true LIMIT 1];
            
            Database.LeadConvert lc = new database.LeadConvert();
			lc.setLeadId(ld.Id);
            lc.setContactId(ld.tech_contact_migration__c );
			lc.setAccountId(ld.tech_contact_migration__r.accountId );
			lc.setDoNotCreateOpportunity(true);
			lc.setConvertedStatus(convertStatus.MasterLabel);

			Database.LeadConvertResult lcr = Database.convertLead(lc);
			System.debug('--> CONVERT LEAD ? ' + lcr.isSuccess());
        }
    }
    
    global void finish(Database.BatchableContext bc){
        
    }
}