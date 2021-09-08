public with sharing class InvoicePDF_Controller {

    public Invoice__c invoice {get; set;}
    public Dossier__c dossier {get; set;}

    public InvoicePDF_Controller(ApexPages.StandardController stdCtrl) {
        invoice = (Invoice__c) stdCtrl.getRecord();

        if(invoice != NULL){
            invoice = [SELECT Id, Name, 
                              Account__c, Account__r.Name, Account__r.BillingStreet, Account__r.BillingCity, Account__r.BillingCountry, Account__r.RIB__c, Account__r.Agence_bancaire__c,Account__r.ICE__c,
                              Contact__c, Contact__r.Name, Contact__r.LastName,
                              Invoice_Date__c, Invoice_Due_Date__c, Invoice_N__c, 
                              Total_ht__c, TVA__c, Total_ttc__c,
                              Mode_de_paiement__c,
                              (SELECT Id, Dossier__c, Dossier__r.Name, Dossier__r.Banque__r.Name, 
                                      Dossier__r.Banque__r.BillingStreet, Dossier__r.Banque__r.BillingCity, Dossier__r.Banque__r.BillingCountry,
                                      Dossier__r.Agence_bancaire__r.Name, 
                                      Dossier__r.Contact__r.FirstName, Dossier__r.Contact__r.LastName, Dossier__r.N_CIN__c,
                                      Dossier__r.Com_Brut_en_V_HT_SOS__c, Dossier__r.Date_deblocage__c, Dossier__r.Montant_du_Financement__c,
                                      Dossier__r.Total_des_revenus_mensuels__c, Dossier__r.Prospect_ou_Client_V_A_V_de_la_banque__c,
                                      Dossier__r.Nom_du_co_emprunteur__c, Dossier__r.Contact__r.Nom_du_co_emprunteur__r.Name
                               FROM InvoiceLineItems__r)
                       FROM Invoice__c 
                       WHERE Id =: invoice.Id];
        }
        
    }


    public PageReference saveInvoice(){
        PageReference pdf = Page.InvoicePDF;
        pdf.getParameters().put('id', ApexPages.currentPage().getParameters().get('id'));

        /*Attachment attach = new Attachment();
        Blob body;

        try {
            body = pdf.getContent();
        } catch (VisualforceException e) {
            body = Blob.valueOf('Some Text');
        }


        attach.Body = body;
        attach.Name = 'Soscredit_' + invoice.Name + '_'+ invoice.Invoice_Date__c + '.pdf';
        attach.IsPrivate = false;
        attach.ParentId = invoice.Id;

        insert attach;*/
        
        ContentVersion cv = new ContentVersion();
        cv.ContentLocation = 'S'; 
        cv.PathOnClient = 'Meilleurcreditimmo_' + invoice.Name + '_'+ invoice.Invoice_Date__c + '.pdf';
        cv.Origin = 'H';
        cv.Title =  'Meilleurcreditimmo_' + invoice.Name + '_'+ invoice.Invoice_Date__c + '.pdf';
        cv.VersionData = Test.isRunningTest() ? Blob.valueOf('Hello') : pdf.getContentAsPDF(); 
        insert cv;
        
        cv = [SELECT ContentDocumentId FROM ContentVersion WHERE Id =: cv.Id];
        ContentDocumentLink cdl = new ContentDocumentLink();
        cdl.ContentDocumentId = cv.ContentDocumentId;
        cdl.LinkedEntityId = invoice.Id ;
        cdl.ShareType = 'I';
        cdl.Visibility = 'AllUsers';
        insert cdl;

        return new PageReference('/' + invoice.Id);
    }



}