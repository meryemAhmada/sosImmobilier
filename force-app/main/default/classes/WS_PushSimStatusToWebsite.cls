public without sharing class WS_PushSimStatusToWebsite {

    @future (callout=true)
	public static void ws_PushDataSimStatusToWebsite(Set<Id> simulationIds) {
        String response;
        
        // INSTANCIATE A NEW HTTP OBJECT
		Http h = new Http();
		// INSTANCIATE A NEW HTTP RESQUEST
		HttpRequest req = new HttpRequest();
        req.setEndpoint(Label.backEndEndPoint+'/update-simulations');
		req.setMethod('POST');
		req.setHeader('Content-Type', 'application/json');
		req.setHeader('Accept', 'application/json');
		req.setTimeout(120000);
        system.debug('req' + req);

        //
        List<Simulation__c> simulations = [SELECT MCI_Sim_ID__c, Statut__c, Resultat__c, Motif__c
                                           FROM Simulation__c
                                           WHERE Id IN : simulationIds AND MCI_Sim_ID__c != NULL];
        system.debug('simulations : ' + simulations);
        
        // build JSON data
        Status_CPI statusCPI = new Status_CPI();
        statusCPI.sales_token = Label.backEndToken;
        
        List<Data_CPI> datasCPI = new List<Data_CPI>();
        Data_CPI dataCPI;
        if(!simulations.isEmpty()){
            for(Simulation__c simulation : simulations){
                dataCPI = new Data_CPI();
                dataCPI.simulation_id = simulation.MCI_Sim_ID__c;
                if(simulation.Statut__c != null)dataCPI.statut = simulation.Statut__c;
                else dataCPI.statut = '-';
				if(simulation.Resultat__c != null)dataCPI.resultat = simulation.Resultat__c;
                else dataCPI.resultat = '-';                
                if(simulation.Motif__c != null)dataCPI.motif = simulation.Motif__c;
                else dataCPI.motif = '-';
                datasCPI.add(dataCPI);
            }
        }
        
        if(datasCPI.size()>0){
            statusCPI.data = datasCPI;
            String JSON_File = JSON.serialize(statusCPI);
            req.setBody(JSON_File);
            // SEND THE REQUEST AND RETURN A RESPONSE
            if(!Test.isRunningTest() && !System.isBatch()){
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
		public String simulation_id;
		public String statut;
		public String resultat;
		public String motif;
	}
}