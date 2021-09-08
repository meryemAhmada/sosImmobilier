@isTest
public with sharing class WS_PushStatusToWebsite_Test {
    
    @isTest
    public static void WS_PushStatusToWebsite_Test() {

        /* ACCOUNT */
		Account account = new Account();
		account.Name = 'Test Account';
		account.Email__c = 'test.account@test.com';

		insert account;
        /* CONTACT */
		Contact contact = new Contact();
		contact.lastName = 'contactTest';
		contact.accountId = account.Id;
		contact.Email = 'contacttest@test.com';
        contact.MCI_User_ID__c='1234';	
        contact.Statut_qualification__c = 'Qualifiable';
        contact.Motif__c = 'Pas de titularisation';
		insert contact;

        /* Lead */
		Lead lead = new Lead();
		lead.lastName = 'leadTest';
		lead.Company = 'Test';
		lead.Email = 'contacttest@test.com';
        lead.MCI_User_ID__c='1234';	
        lead.Status = 'Injoignable';
        lead.Resultat__c = 'NRP';
        lead.Motif__c ='1';
		insert lead;

        Test.startTest();

        Set<Id> objectsIds = new Set<Id>();
        Map<Id, Contact> contacts = new Map<Id, Contact>([SELECT Id FROM Contact]);
        Map<Id, Lead> leads = new Map<Id, Lead>([SELECT Id FROM Lead]);
        objectsIds.addAll(contacts.keySet());
        objectsIds.addAll(leads.keySet());
        
        WS_PushStatusToWebsite.ws_PushDataStatusToWebsite(objectsIds);

        Test.stopTest();

    }
}