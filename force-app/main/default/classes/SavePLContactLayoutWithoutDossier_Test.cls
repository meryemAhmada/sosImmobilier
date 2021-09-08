@isTest
private class SavePLContactLayoutWithoutDossier_Test {
	
  @isTest public static void testSavePLContact() {

    Account account = new Account();
    account.Name = 'Test Account';
    insert account;

    Contact contact = new Contact();
    contact.lastName = 'contactTest';
    contact.email = 'test@test.com';
    contact.accountId = account.Id;
    insert contact;



    PageReference pref = Page.VF_SavePLContactLayoutWithoutDossier;
    pref.getParameters().put('id', contact.id);
    Test.setCurrentPage(pref);

    ApexPages.StandardController stdCtrl = new ApexPages.StandardController(contact);
    SavePLContactLayoutWithoutDossier con = new SavePLContactLayoutWithoutDossier(stdCtrl);

    Test.startTest();
    pref = con.saveContactCapture();
    Test.stopTest();
  }


	
}