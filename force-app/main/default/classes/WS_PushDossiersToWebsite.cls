public without sharing class WS_PushDossiersToWebsite {
    @future (callout=true)
	public static void ws_PushDataDossiersToWebsite(Set <Id> dossiersIds) {
		String response;

		// INSTANCIATE A NEW HTTP OBJECT
		Http h = new Http();
		// INSTANCIATE A NEW HTTP RESQUEST
		HttpRequest req = new HttpRequest();
        req.setEndpoint(Label.backEndEndPoint+'/update-documents');
		req.setMethod('POST');
		req.setHeader('Content-Type', 'application/json');
		req.setHeader('Accept', 'application/json');
		req.setTimeout(120000);
		
		
		system.debug('req' + req);
        // build JSON data
        Dossier_CPI dossierCPI = new Dossier_CPI();
        dossierCPI.sales_token = Label.backEndToken;
        List<Data_CPI> datasCPI = new List<Data_CPI>();
        List<dossier__c> dossiers = [SELECT Id,createdDate,Name,Montant_du_Financement__c,Etape_Actuelle__c,
                                     Commission_parrain_MCI__c,Parrain_paye_impaye__c,MCI_User_ID__c 
                                     FROM dossier__c WHERE Id IN :dossiersIds];
        for(Dossier__c dossier :dossiers){
            if(dossier.MCI_User_ID__c != null){
                Data_CPI dataCPI = new Data_CPI();
                dataCPI.dossier_created_at = String.valueOf(dossier.createdDate);
                dataCPI.dossier_sforce_number = Integer.valueOf(dossier.Name.split('-')[1]);
                dataCPI.dossier_sforce_montant_credit = dossier.Montant_du_Financement__c;
                dataCPI.dossier_state = dossier.Etape_Actuelle__c;
                dataCPI.dossier_montant_commission_parrain = dossier.Commission_parrain_MCI__c;
                dataCPI.dossier_statut_commission_parrain = dossier.Parrain_paye_impaye__c;
                dataCPI.dossier_document_id = dossier.Id;
                dataCPI.user_id = Integer.valueOf(dossier.MCI_User_ID__c);
                datasCPI.add(dataCPI);
            }
            
        }
        
        if(datasCPI.size()>0){
            dossierCPI.data = datasCPI;
            String JSON_File = JSON.serialize(dossierCPI);
            req.setBody(JSON_File);
            // SEND THE REQUEST AND RETURN A RESPONSE
            if(!Test.isRunningTest()){
                HttpResponse res = h.send(req);
                system.debug('res' + res);
            }
        }   
	}

	public class Dossier_CPI {
		public String sales_token;
		public List<Data_CPI> data;
	}

	public class Data_CPI {
		public String dossier_created_at;
		public Integer dossier_sforce_number;
		public Decimal dossier_sforce_montant_credit;
		public String dossier_state;
		public Decimal dossier_montant_commission_parrain;
		public String dossier_statut_commission_parrain;
		public String dossier_document_id;
		public Integer user_id;
	}
}