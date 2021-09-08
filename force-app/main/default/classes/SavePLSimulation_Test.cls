@isTest
public class SavePLSimulation_Test {
	@isTest public static void testSavePLSimulation() {

		Account account = new Account();
		account.Name = 'Test Account';
		insert account;

		Contact contact = new Contact();
		contact.lastName = 'contactTest';
		contact.email = 'test@test.com';
		contact.accountId = account.Id;
		insert contact;
        
        Simulation__c simulation = new Simulation__c();
        simulation.Contact__c = contact.Id;
        insert simulation;

		PageReference pref = Page.VF_SavePLSimulation;
		pref.getParameters().put('id', simulation.Id);
		Test.setCurrentPage(pref);

		ApexPages.StandardController stdCtrl = new ApexPages.StandardController(simulation);
		SavePLSimulation con = new SavePLSimulation(stdCtrl);

		Test.startTest();
		pref = con.saveSimulation();
		Test.stopTest();
	}

}