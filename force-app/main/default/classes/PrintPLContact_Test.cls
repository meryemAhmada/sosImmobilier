@isTest
public class PrintPLContact_Test {

	@isTest public static void testPrintPLContact() {

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
        // Sim Hot
        simulation.Statut__c = 'Qualifié';
        simulation.Resultat__c = 'Trouvé le bien-AFD';
        simulation.Motif__c = 'Shopping';
		insert simulation;

		Dossier__c dossier = new Dossier__c();
		dossier.contact__c = contact.Id;
		dossier.simulation__c = simulation.Id;
        dossier.Dossier_Constitue_P1__c = True;
		insert dossier;

		Test.StartTest();

		ApexPages.StandardController stdCtrl = new ApexPages.StandardController(dossier);
		PrintPLContact ctrl = new PrintPLContact(stdCtrl);

		Test.StopTest();
	}

}