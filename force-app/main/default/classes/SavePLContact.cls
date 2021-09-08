public with sharing class SavePLContact {

    public Dossier__c dossier {get; set;}
    public Contact contact {get; set;}

    public SavePLContact(ApexPages.StandardController stdCtrl) {
        //Dossier
        dossier = (Dossier__c) stdCtrl.getRecord();

        if (dossier != NULL) {
            dossier = [SELECT Id, Contact__c, Banque__r.name,name, Simulation__c,
                       Agence_bancaire__r.name, VILLE_BANQUE__c, Super_banquier__r.Name,
                       Banquier__r.Name, Prospect_ou_Client_V_A_V_de_la_banque__c, Date_depot_dossier__c,CANEVAS_GENERE__c,Date_du_premier_CANEVAS__c,
                       (SELECT Id FROM Attachments WHERE Name LIKE '%DossierClient__%')
                       FROM Dossier__c WHERE Id = : dossier.Id];
            contact = [SELECT Id, Name FROM Contact WHERE Id = : dossier.Contact__c];
        }

    }

    //SAVE PDF
    public PageReference saveDossier() {
        PageReference pdf = Page.VF_PrintPLContact;
        pdf.getParameters().put('id', ApexPages.currentPAge().getParameters().get('id'));

        /*Attachment attach = new Attachment();
        Blob body;

        try {
            body = pdf.getContent();
        } catch (VisualforceException e) {
            body = Blob.valueOf('Some Text');
        }

        Integer version = dossier.Attachments.size() + 1;

        attach.Body = body;
        attach.Name = 'Meilleurcreditimmo_' +dossier.Banque__r.name+'_'+dossier.name+'_'+ contact.name + '.pdf';
        attach.IsPrivate = false;
        attach.ParentId = dossier.Id;

        insert attach;
        if(dossier.CANEVAS_GENERE__c == false && dossier.Date_du_premier_CANEVAS__c == null){
            dossier.CANEVAS_GENERE__c = true;
            dossier.Date_du_premier_CANEVAS__c = datetime.now();
            dossier.CanevasGeneratedBy__c = UserInfo.getUserId();
            update dossier;
        }

        return new PageReference('/' + attach.Id);*/
        
        ContentVersion cv = new ContentVersion();
        cv.ContentLocation = 'S'; 
        cv.PathOnClient = 'Meilleurcreditimmo_' + dossier.Banque__r.name +'_'+dossier.name+'_'+ contact.name + '.pdf';
        cv.Origin = 'H';
        cv.Title =  'Meilleurcreditimmo_' +dossier.Banque__r.name+'_'+dossier.name+'_'+ contact.name + '.pdf';
        cv.VersionData = Test.isRunningTest() ? Blob.valueOf('Hello') : pdf.getContentAsPDF(); 
        insert cv;
        
        cv = [SELECT ContentDocumentId FROM ContentVersion WHERE Id =: cv.Id];
        ContentDocumentLink cdl = new ContentDocumentLink();
        cdl.ContentDocumentId = cv.ContentDocumentId;
        cdl.LinkedEntityId = dossier.Id ;
        cdl.ShareType = 'I';
        cdl.Visibility = 'AllUsers';
        insert cdl;
        
		return new PageReference('/' + dossier.Id);
    }


}