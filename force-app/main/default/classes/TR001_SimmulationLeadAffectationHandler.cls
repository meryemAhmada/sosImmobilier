public with sharing class TR001_SimmulationLeadAffectationHandler {
    
    public static void handleBeforeInsert(List<Simulation__c> newSimulations){
        List<Id> sumulatioIds = new List<Id>();
        for (Simulation__c s : newSimulations) {
            sumulatioIds.add(s.Id);
        }
        Map<Id,Simulation__c> currentSumulations = new  Map<Id,Simulation__c> ([SELECT Id,reassigner__c, OwnerId, Lead_Score_MDC__c,Lead__c, Lead__r.reassigner__c, Lead__r.OwnerId
                                                                                FROM   Simulation__c
                                                                                WHERE  Id IN :sumulatioIds
                                                                                AND Lead__r.reassigner__c = false ]);
        List<User> listJunior = getlistJunior(); 
        List<User> listSenior =getlistSenior();  
        List<User>  usersToUpdate    = new  List<User>();
        List<Simulation__c>  simulationToUpdate    = new  List<Simulation__c>();
        User user = new User();
        Integer i=0;
        List<Lead> leadsToUpdate = new List<Lead>();
        for (Id sumulationId : currentSumulations.keySet()) {
            if (currentSumulations.get(sumulationId).Lead_Score_MDC__c < 80 && currentSumulations.get(sumulationId).Lead__r.reassigner__c == false) 
            {
                user = listJunior.get(Math.mod(i, listJunior.size()));
                if(currentSumulations.get(sumulationId).Lead__r != null){
                    currentSumulations.get(sumulationId).Lead__r.OwnerId = user.id;
                    currentSumulations.get(sumulationId).OwnerId = user.id;
                    currentSumulations.get(sumulationId).Lead__r.reassigner__c = true;
                    leadsToUpdate.add(currentSumulations.get(sumulationId).Lead__r);
                    simulationToUpdate.add(currentSumulations.get(sumulationId));
                }
                user.Last_affectation__c = System.now();
                usersToUpdate.add(user);
            }
            else if (currentSumulations.get(sumulationId).Lead_Score_MDC__c > 80 && currentSumulations.get(sumulationId).Lead__r.reassigner__c == false) {
                user = listSenior.get(Math.mod(i, listSenior.size()));
                if (currentSumulations.get(sumulationId).Lead__r != null) {
                    currentSumulations.get(sumulationId).Lead__r.OwnerId = user.id;
                    currentSumulations.get(sumulationId).OwnerId = user.id;
                    currentSumulations.get(sumulationId).Lead__r.reassigner__c = true;
                    leadsToUpdate.add(currentSumulations.get(sumulationId).Lead__r);
                    simulationToUpdate.add(currentSumulations.get(sumulationId));
                }
                user.Last_affectation__c = System.now();
                usersToUpdate.add(user);
            }
            i++;
        }
        if (leadsToUpdate !=null && !leadsToUpdate.isEmpty()) {
            update leadsToUpdate;
        }
        if (simulationToUpdate !=null && !simulationToUpdate.isEmpty()) {
            update simulationToUpdate;
        }
        if (usersToUpdate !=null && !usersToUpdate.isEmpty()) {
            update usersToUpdate;
        }
    }

    public static void handleBeforeUpdate(List<Simulation__c> updatedSimulations){
        
        handleBeforeInsert(updatedSimulations);
    }

    public static List<User> getlistJunior(){
        //Get juniors Groupe
        List<GroupMember> groupJunior=[Select Id, group.type, group.id, UserOrGroupId From GroupMember where group.developerName='Juniors'];
        List<Id> usersIdsInGroupJunior= new List<Id>();
        for(GroupMember gm : groupJunior)
        {
            usersIdsInGroupJunior.add(gm.UserOrGroupId);
        }
        return [SELECT Id, Last_affectation__c  FROM User WHERE Id IN:usersIdsInGroupJunior ORDER BY Last_affectation__c ASC];
    }
    public static List<User> getlistSenior(){
        //Get Siniors Groupe
        List<GroupMember> groupSenior=[Select Id, group.type, group.id, UserOrGroupId From GroupMember where group.developerName='Seniors'];
        List<Id> usersIdsInGroupSenior= new List<Id>();
        for(GroupMember gm : groupSenior)
        {
            usersIdsInGroupSenior.add(gm.UserOrGroupId);
        }
        return [SELECT Id, Last_affectation__c  FROM User WHERE Id IN:usersIdsInGroupSenior ORDER BY Last_affectation__c ASC];
    }

   
}