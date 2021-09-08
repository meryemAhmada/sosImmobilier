trigger TR03Task on Task (after insert, after update) {

    if(Trigger.isAfter){

        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
        Set<Id> contactIDs = new Set<Id>();
        List<Task> tasks = new List<Task>();
        
        for(Task task : Trigger.new){
            if(Trigger.isInsert || 
                (Trigger.isUpdate && task.Subject != Trigger.oldMap.get(task.Id).Subject)){
                    if((task.whoId) != null){Schema.sObjectType sObjType = (task.whoId).getSObjectType();
                    Schema.DescribeSObjectResult sObjDescribeResult = sObjType.getDescribe();
                                             if(sObjDescribeResult.getName()=='Contact') contactIds.add(task.whoId);}
                 tasks.add(task);
            }
        }

        if(!contactIDs.isEmpty()){
            Map<Id, Contact> contacts = new Map<Id, Contact>([SELECT Name, FirstName, LastName, Email, Phone, MobilePhone,
                                                                    Apporteur_Contact__r.Email__c, Super_apporteur_Contact__r.Email__c,
                                                                    Date_du_premier_RECAP__c, Date_recap_client__c, Statut__c, Statut_2__c,
                                                                    Owner.Name, Owner.Phone, Owner.MobilePhone, Owner.Email
                                                            FROM Contact
                                                            WHERE Id IN : contactIDs]);

            for(Task task : tasks){
                if((task.whoId) != null)mails.addAll(ContactNotificationMethods.notificationEmail(contacts.get(task.whoId), task, 'Appel'));
            }
        }


        try {
            if (!mails.isEmpty()) Messaging.sendEmail(mails,false);
        } 
        catch (System.EmailException emailExp) {
            //error msg
        }
    }

}