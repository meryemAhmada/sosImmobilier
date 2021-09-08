public with sharing class SavePLContactLayoutWithoutDossier {

    public Contact contact {get; set;}

    public SavePLContactLayoutWithoutDossier(ApexPages.StandardController stdCtrl) {
        //Dossier
        contact = (Contact) stdCtrl.getRecord();

        if (contact != NULL) {
            contact = [SELECT Id, Name, Date_du_premier_RECAP__c, RECAP_GENERE__c FROM Contact WHERE Id = : contact.Id];
        }

    }

    //SAVE PDF
    public PageReference saveContactCapture() {
        PageReference pdf = Page.VF_PrintContactLayoutWithoutDossier;
        pdf.getParameters().put('id', ApexPages.currentPAge().getParameters().get('id'));

        /*Attachment attach = new Attachment();
        Blob body;

        try {
            body = pdf.getContent();
        } catch (VisualforceException e) {
            body = Blob.valueOf('Error PDF');
        }

        Integer version = contact.Attachments.size() + 1;

        attach.Body = body;
        attach.Name = 'Soscredit_'+ contact.name + '.pdf';
        attach.IsPrivate = false;
        attach.ParentId = contact.Id;
        insert attach;*/
        
        ContentVersion cv = new ContentVersion();
        cv.ContentLocation = 'S'; 
        cv.PathOnClient = 'Meilleurcreditimmo_'+ contact.name + '.pdf';
        cv.Origin = 'H';
        cv.Title =  'Meilleurcreditimmo_'+ contact.name + '.pdf';
        cv.VersionData = Test.isRunningTest() ? Blob.valueOf('Hello') : pdf.getContentAsPDF(); 
        insert cv;
        
        cv = [SELECT ContentDocumentId FROM ContentVersion WHERE Id =: cv.Id];
        ContentDocumentLink cdl = new ContentDocumentLink();
        cdl.ContentDocumentId = cv.ContentDocumentId;
        cdl.LinkedEntityId = contact.Id ;
        cdl.ShareType = 'I';
        cdl.Visibility = 'AllUsers';
        insert cdl;

        if(contact.RECAP_GENERE__c == false && contact.Date_du_premier_RECAP__c == null){
            contact.RECAP_GENERE__c = true;
            contact.Date_du_premier_RECAP__c = datetime.now();
            contact.RecapGeneratedBy__c = UserInfo.getUserId();
            update contact;
        }


        return new PageReference('/' + contact.Id);

    }
}