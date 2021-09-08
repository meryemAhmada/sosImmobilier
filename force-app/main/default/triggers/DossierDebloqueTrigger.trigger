trigger DossierDebloqueTrigger on Dossier__c (before insert, before update) {

    List<Dossier__c> dossiersToSet = new List<Dossier__c>();
    for (Dossier__c dossier : Trigger.New) {
        if(dossier.Simulation__c != NULL && dossier.Dossier_d_bloqu__c == TRUE){
            Id dossierSimulationId = dossier.Simulation__c;
            for(Dossier__c dossierToSet : [SELECT Id, Dossier_Perdu__c FROM Dossier__c WHERE Simulation__c = :dossierSimulationId AND Id != :dossier.Id]){
                dossierToSet.Dossier_Perdu__c = TRUE;
                dossierToSet.Dossier_d_bloqu__c = FALSE;
                dossiersToSet.add(dossierToSet);
            }
            update dossiersToSet; 
        }
    }
}