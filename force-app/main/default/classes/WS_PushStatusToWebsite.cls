public without sharing class WS_PushStatusToWebsite {

    @future (callout=true)
	public static void ws_PushDataStatusToWebsite(Set<Id> objectsIds) {
		String response;

		// INSTANCIATE A NEW HTTP OBJECT
		Http h = new Http();
		// INSTANCIATE A NEW HTTP RESQUEST
		HttpRequest req = new HttpRequest();
        req.setEndpoint(Label.backEndEndPoint+'/update-leads');
		req.setMethod('POST');
		req.setHeader('Content-Type', 'application/json');
		req.setHeader('Accept', 'application/json');
		req.setTimeout(120000);
        system.debug('req' + req);

        //
        Set<Id> contactsIds = new Set<Id>();
        Set<Id> leadsIds = new Set<Id>();
        for(Id objectId : objectsIds){
            if(objectId.getSObjectType().getDescribe().getName() == 'Contact') contactsIds.add(objectId);
            if(objectId.getSObjectType().getDescribe().getName() == 'Lead') leadsIds.add(objectId);
        }

        //
        List<Contact> contacts = [SELECT MCI_USER_ID__c, Statut__c , Motif__c, Description
                                  FROM Contact
                                  WHERE Id IN : contactsIds AND MCI_USER_ID__c != NULL];
        List<Lead> leads = [SELECT MCI_USER_ID__c, Status, Resultat__c, Motif__c, Description
                                  FROM Lead
                                  WHERE Id IN : leadsIds AND MCI_USER_ID__c != NULL];
        system.debug('contacts : ' + contacts);
        system.debug('leads : ' + leads);

        // build JSON data
        Status_CPI statusCPI = new Status_CPI();
        statusCPI.sales_token = Label.backEndToken;
        
        List<Data_CPI> datasCPI = new List<Data_CPI>();
        Data_CPI dataCPI;
        if(!contacts.isEmpty()){
            for(Contact contact : contacts){
                dataCPI = new Data_CPI();
                dataCPI.mci_user_id = contact.MCI_USER_ID__c;
                if(contact.Statut__c != null)dataCPI.sales_force_status_1 = contact.Statut__c;
                else dataCPI.sales_force_status_1 = '-';
                
                if(contact.Motif__c != null)dataCPI.sales_force_status_2 = contact.Motif__c;
                else dataCPI.sales_force_status_2 = '-';
                if(contact.Description != null)dataCPI.sales_description = contact.Description;
                else dataCPI.sales_description = '-';
                datasCPI.add(dataCPI);
            }
        }
        if(!leads.isEmpty()){
            for(Lead lead : leads){
                dataCPI = new Data_CPI();
                dataCPI.mci_user_id = lead.MCI_USER_ID__c;
                if(lead.Status != null)dataCPI.sales_force_status_1 = lead.Status;
                else dataCPI.sales_force_status_1 = '-';
                if(lead.Resultat__c != null || lead.Motif__c != null)dataCPI.sales_force_status_2 = lead.Resultat__c + ' ' + lead.Motif__c;
                else dataCPI.sales_force_status_2 = '-';
                if(lead.Description != null)dataCPI.sales_description = lead.Description;
                else dataCPI.sales_description = '-';
                datasCPI.add(dataCPI);
            }
        }
        
        if(datasCPI.size()>0){
            statusCPI.data = datasCPI;
            String JSON_File = JSON.serialize(statusCPI);
            req.setBody(JSON_File);
            // SEND THE REQUEST AND RETURN A RESPONSE
            if(!Test.isRunningTest()){
                HttpResponse res = h.send(req);
                system.debug('res' + res);
            }
        }   
	}

	public class Status_CPI {
		public String sales_token;
		public List<Data_CPI> data;
	}

	public class Data_CPI {
		public String mci_user_id;
		public String sales_force_status_1;
		public String sales_force_status_2;
		public String sales_description;
	}

}