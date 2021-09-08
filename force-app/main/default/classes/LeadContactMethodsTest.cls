@isTest
public class LeadContactMethodsTest {

    @isTest    
    public static void testAssignLeadContact()
    {
        
        List<Id> usersIdsInGroup= new List<Id>();
        List<GroupMember> groupMembers=[Select Id, group.type, group.id, UserOrGroupId From GroupMember where group.developerName='Commerciaux_lead_immo'];
        system.debug('group id : ' + groupMembers.get(0).group.id);
        for(GroupMember gm : groupMembers)
        {
            usersIdsInGroup.add(gm.UserOrGroupId);
        }
        
        User commercial = [Select Id, Last_affectation__c  FROM User WHERE Id IN:usersIdsInGroup ORDER BY Last_affectation__c ASC LIMIT 1];
        
        
        Test.startTest();
        
        	
        	Contact contact = TestFactory.createContactsWithSpecificData(NULL, '+21261234599', '0000', 1, true).get(0);
        	Lead l = TestFactory.createLeads(1, true).get(0);
        
        	//List<sObject> objContact = new List<sObject>{contact}; 
            //List<sObject> objLead = new List<sObject>{l}; 
                
        	String contactId = contact.id;
        	String leadId = l.id;
        
            LeadContactMethods.assignLeadContact(contactId);
        	LeadContactMethods.assignLeadContact(leadId);
                
        Test.stopTest();
		
        Lead insertedLead = [Select Id,OwnerId FROM Lead WHERE ID = :l.id LIMIT 1];
        Contact insertedContact = [Select Id,OwnerId FROM Contact WHERE ID = :contact.id LIMIT 1];
    }
    
    
}