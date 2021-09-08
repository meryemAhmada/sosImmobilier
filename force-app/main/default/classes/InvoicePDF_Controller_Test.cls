@isTest
private class InvoicePDF_Controller_Test {
	
	@isTest static void test_method_one() {
		Account account = new Account();
		account.Name = 'Test Account';
		insert account;

		Contact contact = new Contact();
		contact.lastName = 'contactTest';
		contact.email = 'test@test.com';
		contact.Date_de_naissance__c = Date.newInstance(1980, 7, 26);
		contact.relev_Compte_Perso_N_1__c = 11274001;
		contact.rach_CD1_Frais_de_notaire_estim_en__c = 20;
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
        dossier.Dossier_d_bloqu__c = true;
        dossier.Facture_Payee_global__c = false;
		insert dossier;

		Invoice__c facture = new Invoice__c();
		facture.Account__c = account.Id;
		insert facture;

		InvoiceLineItem__c ili = new InvoiceLineItem__c();
		ili.Dossier__c = dossier.Id;
		ili.Invoice__c = facture.Id;
		insert ili;

		Test.StartTest();

		ApexPages.StandardController stdCtrl = new ApexPages.StandardController(facture);
		InvoicePDF_Controller ctrl = new InvoicePDF_Controller(stdCtrl);

		PageReference pref = Page.InvoicePDFSaveAttachment;
		pref.getParameters().put('id', facture.id);
		Test.setCurrentPage(pref);
		PageReference result = ctrl.saveInvoice();

		Test.StopTest();
	}
	
}