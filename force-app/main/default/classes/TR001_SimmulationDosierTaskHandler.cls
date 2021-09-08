public with sharing class TR001_SimmulationDosierTaskHandler {

    public static void handleBeforeInsert(List<Task> newTasks){
        List<String> ids = new List<String>();
        for (Task t : newTasks) {
            ids.add(t.WhatId);
        }
        Map<Id, Simulation__c> simulations = new Map<Id, Simulation__c>([SELECT Id,Lead__c,Contact__c 
                                                    FROM Simulation__c 
                                                    WHERE Id IN :ids ]);
        Map<Id, Dossier__c> dossiers = new Map<Id, Dossier__c> ([SELECT Id,contact__c
                                                             FROM Dossier__c 
                                                             WHERE Id IN :ids  ]);
        //Update Task with contact or Lead
        for (Task tsk : newTasks) {
            if(simulations.keySet().contains(tsk.WhatId)){
                if(simulations.get(tsk.WhatId).contact__c != null){
                    tsk.WhoId =simulations.get(tsk.WhatId).contact__c;
                }
                else if(simulations.get(tsk.WhatId).Lead__c != null){
                    tsk.WhoId =simulations.get(tsk.WhatId).Lead__c;
                }
                else{
                    tsk.WhoId = null ;
                }
            }
            else if(dossiers.keySet().contains(tsk.WhatId) ){
                if(dossiers.get(tsk.WhatId).contact__c != null){
                    tsk.WhoId =dossiers.get(tsk.WhatId).contact__c;
                }
                else{
                    tsk.WhoId = null ;
                }
            }
        }
        //insert tasks
    }
}