public class LeadContactMethods {

    
    public static void assignLeadContact(String objId)
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
        List<User> usersToUpdate = new List<User>();
        List<Contact> contactList = [SELECT id, OwnerId from Contact where id = :objId];
        List<Lead> leadList = [SELECT id, OwnerId from Lead where id = :objId];
        
        
        User u;
       
            //obj = listLeadscontacts.get(i);
            u = commerciaux.get(Math.mod(1, commerciaux.size()));
            if(contactList.size() != 0 ){
                for(Contact c : contactList){
                    c.OwnerId = u.id;                
                }
                 update contactList;          
            
            }
            
      
        
            if(leadList.size() != 0 ){
                for(Lead l : leadList){
                    l.OwnerId = u.id;                
                }
                update leadList;
            }
        
        
            //l.OwnerId = u.id;
            u.Last_affectation__c = System.now();
            usersToUpdate.add(u);
            system.debug('lead affectation : ' + u.id);
            //}
        
        update usersToUpdate;
    }
    
    
}