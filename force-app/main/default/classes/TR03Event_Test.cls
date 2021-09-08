@isTest
public with sharing class TR03Event_Test {
	 
	 @testSetup static void testSetup(){

		/* SUPER APPORTEUR */
		Account superApporteur = new Account();
		superApporteur.Name = 'Test Super Apporteur';
		superApporteur.Email__c = 'testsuperapporteur@test.com';

		insert superApporteur;

		/* APPORTEUR */
		Account apporteur = new Account();
		apporteur.Name = 'Test Apporteur';
		apporteur.Email__c = 'apporteurTest@test.com';

		insert apporteur;

		/* CONTACT */
        Contact contact = new Contact(LastName = 'Test1', Nationalite__c='Morocco', Pays_de_r_sidence__c ='Morocco', Profil__c='Salarié',
        							   Apporteur_Contact__c = apporteur.Id, Super_apporteur_Contact__c = superApporteur.Id);
        insert contact;
    }

    @isTest static void testNoficationEmail(){
    	Contact contact = [SELECT Id,  FirstName, LastName, Email, Phone, MobilePhone,
	                            Apporteur_Contact__r.Email__c, Super_apporteur_Contact__r.Email__c,
	                            Date_du_premier_RECAP__c, Date_recap_client__c, Statut__c, Statut_2__c,
	                            Owner.Name, Owner.Phone, Owner.MobilePhone, Owner.Email
	 					 FROM Contact];

	 	List<Event> events = new List<Event>();

    	Test.startTest();
        
        events.add(new Event(Subject='NRP Test', Type='Call', WhoId = contact.Id, StartDateTime=Date.Today(), EndDateTime=Date.Today()));
        events.add(new Event(Subject='IP Test', Type='Call', WhoId = contact.Id, StartDateTime=Date.Today(), EndDateTime=Date.Today()));

        insert events;


        Test.stopTest();

    }


}