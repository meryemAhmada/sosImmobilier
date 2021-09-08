@isTest(seeAllData = true)
public class LeadTriggersMethodsTest {
    
    @isTest    
    public static void testAssignLead()
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
        	Lead l = TestFactory.createLeads(1, true).get(0);
        Test.stopTest();

        Lead insertedLead = [Select Id,OwnerId FROM Lead WHERE ID = :l.id LIMIT 1];
    }
    
    @isTest
    public static void testDuplicateLead()
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
        List<Lead> listof_leadsToInsert = new List<Lead>();
        Id rtLeadImmo = [Select Id FROM RecordType WHERE DeveloperName = 'Lead_Immo'].id;
        Lead l1 = new Lead(RecordTypeId = rtLeadImmo, Company = 'CX', LastName = 'Test 3CX', Status = 'Open', Mobilephone = '0606787884');
        listof_leadsToInsert.add(l1);
        insert listof_leadsToInsert;
        Test.stopTest();
    }
    
}