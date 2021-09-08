@isTest
public with sharing class WS_PushDossiersToWebsite_Test {
    @isTest
    public static void WS_PushDossiersToWebsite_Test() {

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

        /* DOSSIER */
		Dossier__c dossier = new Dossier__c();
		dossier.contact__c = contact.Id;
        dossier.Simulation__c = simulation.Id;
        dossier.Dossier_Constitue_P1__c = True;
		dossier.Date_estim_accord__c = System.Today().addDays(10);
		dossier.Date_depot_dossier__c = SYstem.Today();
		dossier.Date_Estim_D_blocage__c = System.Today().addDays(15);

		insert dossier;

        Test.startTest();
        Set <Id> dossiersIds = new set<Id>();
        List<dossier__c> dossiers = [select id from dossier__c];
        for(dossier__c dossier2 :dossiers){
            dossiersIds.add(dossier2.Id);
        }
        WS_PushDossiersToWebsite.ws_PushDataDossiersToWebsite(dossiersIds);

        Test.stopTest();

    }
}