public with sharing class SavePLSimulation {

    public Simulation__c simulation {get; set;}

    public SavePLSimulation(ApexPages.StandardController stdCtrl) {
        simulation = (Simulation__c) stdCtrl.getRecord();
        
        if(simulation != NULL){
            simulation = [SELECT Name, Contact__c FROM Simulation__c WHERE Id =: simulation.Id];
        }
    }

    //SAVE PDF
    public PageReference saveSimulation() {
        if(simulation.Contact__c != NULL){
            PageReference pdf = Page.VF_PrintPLSimulation;
            pdf.getParameters().put('id', ApexPages.currentPAge().getParameters().get('id'));
            
            Contact contact = [SELECT Name, RECAP_GENERE__c, Date_du_premier_RECAP__c, RecapGeneratedBy__c 
                               FROM Contact 
                               WHERE Id =: simulation.Contact__c];
            
            ContentVersion cv = new ContentVersion();
            cv.ContentLocation = 'S'; 
            cv.PathOnClient = 'Meilleurcreditimmo_'+ simulation.Name + '_' + contact.Name + '.pdf';
            cv.Origin = 'H';
            cv.Title = 'Meilleurcreditimmo_'+ simulation.Name + '_' + contact.Name + '.pdf';
            cv.VersionData = Test.isRunningTest() ? Blob.valueOf('Hello') : pdf.getContentAsPDF(); 
            insert cv;
            
            cv = [SELECT ContentDocumentId FROM ContentVersion WHERE Id =: cv.Id];
            ContentDocumentLink cdl = new ContentDocumentLink();
            cdl.ContentDocumentId = cv.ContentDocumentId;
            cdl.LinkedEntityId = simulation.Id ;
            cdl.ShareType = 'I';
            cdl.Visibility = 'AllUsers';
            insert cdl;
    
            if(contact.RECAP_GENERE__c == false && contact.Date_du_premier_RECAP__c == null){
                contact.RECAP_GENERE__c = true;
                contact.Date_du_premier_RECAP__c = datetime.now();
                contact.RecapGeneratedBy__c = UserInfo.getUserId();
                update contact;
            }
        }
        return new PageReference('/' + simulation.Id);
    }
}