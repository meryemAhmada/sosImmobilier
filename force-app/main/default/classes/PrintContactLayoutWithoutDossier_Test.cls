@isTest
public class PrintContactLayoutWithoutDossier_Test {
	
	@isTest public static void testPrintContactLayoutWithoutDossier() {

		Account account = new Account();
		account.Name = 'Test Account';
		insert account;

		Contact contact = new Contact();
		contact.lastName = 'contactTest';
		contact.email = 'test@test.com';
		contact.relev_Compte_Perso_N_1__c = 11274001;
		contact.accountId = account.Id;
		insert contact;
        
        Simulation__c simulation = new Simulation__c();
		simulation.Contact__c = contact.Id;
		simulation.Actif__c = true;
		simulation.rach_CD1_Frais_de_notaire_estim_en__c = 20;
		insert simulation;

		Test.StartTest();

		ApexPages.StandardController stdCtrl = new ApexPages.StandardController(contact);
		PrintContactLayoutWithoutDossier ctrl = new PrintContactLayoutWithoutDossier(stdCtrl);

		Test.StopTest();
	}

}