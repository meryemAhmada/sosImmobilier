@isTest
public class SavePLContact_Test {
	@isTest public static void testSavePLContact() {

		Account account = new Account();
		account.Name = 'Test Account';
		insert account;

		Contact contact = new Contact();
		contact.lastName = 'contactTest';
		contact.email = 'test@test.com';
		contact.accountId = account.Id;
		insert contact;
        
        Simulation__c simulation = new Simulation__c();
        simulation.Actif__c = TRUE;
        simulation.Contact__c = contact.Id;
        simulation.MCI_Sim_ID__c = '1234';
        // Sim Hot
        simulation.Statut__c = 'Qualifié';
        simulation.Resultat__c = 'Trouvé le bien-AFD';
        simulation.Motif__c = 'Shopping';
        insert simulation;

		Dossier__c dossier = new Dossier__c();
		dossier.contact__c = contact.Id;
        dossier.Simulation__c = simulation.Id;
        dossier.Dossier_Constitue_P1__c = True;
		insert dossier;


		PageReference pref = Page.VF_SavePLContact;
		pref.getParameters().put('id', dossier.id);
		Test.setCurrentPage(pref);

		ApexPages.StandardController stdCtrl = new ApexPages.StandardController(dossier);
		SavePLContact con = new SavePLContact(stdCtrl);

		Test.startTest();
		pref = con.saveDossier();
		Test.stopTest();
	}

}