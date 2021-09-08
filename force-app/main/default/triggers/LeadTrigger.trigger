trigger LeadTrigger on Lead (before insert, after insert,after update) {

	User u = [select Id, Bypass_triggers__c from user where id = :UserInfo.getUserId()];
	if (!u.Bypass_triggers__c) {
		if (Trigger.isBefore) {
			if (Trigger.isInsert) {
				LeadTriggerMethods.assignLead(Trigger.new);
                String errorMessage = LeadTriggerMethods.duplicateLead(Trigger.new);
                if(errorMessage != null){
                    for(Lead l : Trigger.new){
                        if(l.MCI_User_ID__c == null)l.addError(errorMessage);
                    }
                    
                }
			}
		}
        if(Trigger.isAfter){
            
                //WS
        		if(!Test.isRunningTest() && !System.isBatch())WS_PushStatusToWebsite.ws_PushDataStatusToWebsite(trigger.newMap.keySet());
            
        }
	}

}