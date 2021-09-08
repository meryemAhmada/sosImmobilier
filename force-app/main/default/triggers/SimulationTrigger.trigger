trigger SimulationTrigger on Simulation__c (before insert, before update, after insert, after update) {

    /*if(Trigger.isBefore){
        Set<Id> contactsId = new Set<Id>();
        Map<Id, Contact> contactsInfo = new Map<Id, Contact>();

        for(Simulation__c sim : Trigger.new){
            if(sim.Contact__c != NULL 
              && (Trigger.isInsert || (Trigger.isUpdate && (sim.TECH_Refresh__c || (sim.Actif__c && sim.Actif__c != Trigger.oldMap.get(sim.Id).Actif__c) || (sim.Contact__c != NULL && sim.Contact__c != Trigger.oldMap.get(sim.Id).Contact__c)))) 
            )
                contactsId.add(sim.Contact__c);
        }
        
        
        
        for(Contact contact : [SELECT Profil__c, Nationalite__c, Pays_de_r_sidence__c
                               FROM Contact
                               WHERE Id IN : contactsId]){
            contactsInfo.put(contact.Id, contact);
        }
        
        if(!contactsInfo.isEmpty()) SimulationHandler.handleRequiredDocuments(Trigger.new, contactsInfo);
        if(Trigger.isUpdate) SimulationHandler.handleDateRequiredDocuments(Trigger.new, Trigger.oldMap);

    }else*/ if(Trigger.isAfter){
        
        if((Trigger.isInsert || Trigger.isUpdate) ){
                
                SimulationHandler.UpdateSimStatus(Trigger.New);
            
                //WS
                if(!Test.isRunningTest() && !System.isBatch())WS_PushSimStatusToWebsite.ws_PushDataSimStatusToWebsite(trigger.newMap.keySet());
                
        }
            
        
        
    }
}