@isTest
public with sharing class TR03Task_Test {
	 
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

    @isTest static void testNoficationEmail_Insert(){
    	Contact contact = [SELECT Id,  FirstName, LastName, Email, Phone, MobilePhone,
	                            Apporteur_Contact__r.Email__c, Super_apporteur_Contact__r.Email__c,
	                            Date_du_premier_RECAP__c, Date_recap_client__c, Statut__c, Statut_2__c,
	                            Owner.Name, Owner.Phone, Owner.MobilePhone, Owner.Email
	 					 FROM Contact];

	 	List<Task> tasks = new List<Task>();

    	Test.startTest();
        
        tasks.add(new Task(Subject='NRP Test', WhoId = contact.Id));
        tasks.add(new Task(Subject='IP Test', WhoId = contact.Id));

        insert tasks;


        Test.stopTest();

    }

    @isTest static void testNoficationEmail_Update(){
    	Contact contact = [SELECT Id,  FirstName, LastName, Email, Phone, MobilePhone,
	                            Apporteur_Contact__r.Email__c, Super_apporteur_Contact__r.Email__c,
	                            Date_du_premier_RECAP__c, Date_recap_client__c, Statut__c, Statut_2__c,
	                            Owner.Name, Owner.Phone, Owner.MobilePhone, Owner.Email
	 					 FROM Contact];

	 	contact.Statut__c = 'Perdu';
	 	update contact;

	 	List<Task> tasks = new List<Task>();
        tasks.add(new Task(Subject='Test', WhoId = contact.Id));
        insert tasks;

    	Test.startTest();
        
		tasks[0].Subject = 'IP Test';
		update tasks[0];       

        Test.stopTest();

    }


}