public class LeadTriggerMethods {
    
    public static void assignLead(List<Lead> listLeads)
    {
        //Id rtLeadImmo = [Select Id FROM RecordType WHERE DeveloperName = 'Lead_Immo'].id;
        
        List<Id> usersIdsInGroup= new List<Id>();
        List<GroupMember> groupMembers=[Select Id, group.type, group.id, UserOrGroupId From GroupMember where group.developerName='Commerciaux_lead_immo'];
        system.debug('group id : ' + groupMembers.get(0).group.id);
        for(GroupMember gm : groupMembers)
        {
            usersIdsInGroup.add(gm.UserOrGroupId);
        }
        
        system.debug('members : ' + usersIdsInGroup);
        
        List<User> commerciaux = [Select Id, Last_affectation__c  FROM User WHERE Id IN:usersIdsInGroup ORDER BY Last_affectation__c ASC];
        map<Id,User> usersToUpdate = new map<Id,User>();
        Lead l;
        User u;
        for(Integer i = 0; i<listLeads.size(); i++)
        {
            l = listLeads.get(i);
            u = commerciaux.get(Math.mod(i, commerciaux.size()));
            if(l.Do_Not_Reassign__c == false)l.OwnerId = u.id;
            u.Last_affectation__c = System.now();
            usersToUpdate.put(u.id,u);
            system.debug('lead affectation : ' + u.id);
        }
        System.debug(usersToUpdate.size());
        update usersToUpdate.values();
    }
    public static String duplicateLead(List<Lead> listLeads){
        String ErrorMessage;
        for(Lead l : listLeads) {
            if(l.lastname != null && l.mobilephone != null) {
                String lead_phone = l.mobilephone.replaceAll('\\D','');
                lead_phone = lead_phone.trim();
                if(!String.isEmpty(lead_phone)){
                    String lead_phone2 = lead_phone.substring(lead_phone.length() - 9, lead_phone.length());
                    System.debug('--> lead_phone2 : ' + lead_phone2);
                    List<List<sObject>> searchList = [FIND :lead_phone2 IN PHONE FIELDS RETURNING Contact(Id, Email LIMIT 1), Lead(Id, Email LIMIT 1)];
                    sObject obj;
                    
                    if(!searchList.isEmpty() && searchList.size() > 0) {
                        //CONTACT
                        if(!searchList [0].isEmpty() && searchList [0].size() > 0) {
                            obj = searchList [0] [0];
                        }
                        //LEAD
                        else if(!searchList [1].isEmpty() && searchList [1].size() > 0) {
                            obj = searchList [1] [0];
                        }
                    }
                    
                    System.debug('--> OBJECT FOUND : ' + obj);
                    
                    if(obj != NULL) {
                        ErrorMessage = 'Phone found on existing record';
                    }
                }
                
                
            }
            
        }
        System.debug(ErrorMessage);
        return ErrorMessage;
    }
}