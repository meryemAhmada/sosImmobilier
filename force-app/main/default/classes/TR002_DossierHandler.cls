public class TR002_DossierHandler {
    public static Map<String , Map<String , Sobject>> relatedObject;
    public static Boolean documentRequisStatusUpdated = false;

    public static void documentRequisStatusAndDateUpdate(List<Dossier__c> dossiers , Boolean isInsert , Map<Id,Dossier__c> oldDossiers){
        if(! documentRequisStatusUpdated){
            System.debug('START:  documentRequisUpdateStatus');
            setRelatedObject(dossiers);
            String isRequis;
            List<Documents_Requis_Config__mdt> documents = [Select Id , Condition__c , Document_Field_Name__c , Object_Name__c , Operator__c , Requis__c , Document_Date_Field_Name__c FROM Documents_Requis_Config__mdt];
    
            for(Dossier__c dossier : dossiers){
                if(dossier.TECH_Update_Dossier__c || isInsert || (!isInsert && oldDossiers.get(dossier.Id).get('Contact__c') != dossier.contact__c)|| (!isInsert && oldDossiers.get(dossier.Id).get('Simulation__c') != dossier.simulation__C)){
                    //Reset
                    if(dossier.TECH_Update_Dossier__c || (!isInsert && oldDossiers.get(dossier.Id).get('Contact__c') != dossier.contact__c)){
                        for(Documents_Requis_Config__mdt document : documents){
                            if((dossier.get(document.Document_Field_Name__c) != null && !String.valueof(dossier.get(document.Document_Field_Name__c)).contains('Reçu')) || String.isEmpty(String.valueof(dossier.get(document.Document_Field_Name__c))))
                                dossier.put(document.Document_Field_Name__c , 'Non requis');
                        }
                    }
                    //Set Required
                    for(Documents_Requis_Config__mdt document : documents){
                        if((dossier.get(document.Document_Field_Name__c) != null && !String.valueof(dossier.get(document.Document_Field_Name__c)).contains('Reçu')) || String.isEmpty(String.valueof(dossier.get(document.Document_Field_Name__c)))){
                            isRequis = getRequisValue(dossier , document);
                            if(!String.isEmpty(isRequis)){
                                dossier.put(document.Document_Field_Name__c , isRequis);
                            }
                        }
                    } 
                    dossier.TECH_Update_Dossier__c = false; 
                }
                else if(!dossier.TECH_Update_Dossier__c && !isInsert ){
                    for(Documents_Requis_Config__mdt document : documents){
                        if (oldDossiers.get(dossier.Id) != null &&  dossier.get(document.Document_Field_Name__c) != oldDossiers.get(dossier.Id).get(document.Document_Field_Name__c)) {
                            if (oldDossiers.get(dossier.Id).get(document.Document_Field_Name__c) != 'Non requis' && String.valueof(dossier.get(document.Document_Field_Name__c)).contains('Reçu')) dossier.put(document.Document_Date_Field_Name__c , Date.today());
                            else dossier.put(document.Document_Date_Field_Name__c , null);
                        }
                    } 
                }
            }
            documentRequisStatusUpdated = true;
        }
        else{
            for(Dossier__c dossier : dossiers)
            dossier.TECH_Update_Dossier__c = false; 
        }
        
    }

    private static void setRelatedObject(List<Dossier__c> dossiers){
        List<Id> contactIds = new List<Id>();
        List<Id> simulationIds = new List<Id>();

        relatedObject = new Map<String , Map<String , Sobject>>();

        for(Dossier__c dossier : dossiers){
            contactIds.add(dossier.contact__c);
            simulationIds.add(dossier.simulation__c);
        }

        Map<String , Contact> contacts = new Map<String , Contact> ((List<Contact>)Database.query('Select Id , Pays_de_r_sidence__c , Profession__c , Nationalite__c FROM Contact Where Id in :contactIds'));
        Map<String , Simulation__c> simulations = new Map<String , Simulation__c> ((List<Simulation__c>)Database.query('Select Id , Contentieux__c , Type_de_Bien__c , Type_de_cr_dit__c , tes_vous_rentier__c , Montant_des_Frais_de_notaire_enregi_X__c ,  Montant_des_frais_d_am_nagement_inclus_X__c FROM Simulation__c Where Id in :simulationIds'));

        relatedObject.put('Contact__c' , contacts);
        relatedObject.put('Simulation__c' , simulations);
    }

    private static String getRequisValue(Dossier__c dossier , Documents_Requis_Config__mdt document ){
        if(!String.isEmpty(document.Condition__c)){
            List<String> conditionsList = evaluateConditions(document.Condition__c.split(';') , dossier , document.Object_Name__c);
            if(!String.isEmpty(document.Operator__c)){
                String conditionFinal = String.format(getFormattedFilterLogic(document.Operator__c), conditionsList);
                System.debug(document);
                System.debug(conditionFinal);
                return BooleanExpression.eval(conditionFinal) ? document.Requis__c : null;
            }
        }
        return '';
    }

    private static List<String> evaluateConditions(List<String> conditions , Dossier__c dossier , String objectName){
        List<String> evaluations = new List<String>();

        for(String condition : conditions){
            evaluations.add(evaluateSingleCondition(condition , dossier , objectName));
        }

        return evaluations;
    }

    private static String evaluateSingleCondition(String condition , Dossier__c dossier , String objectName){
        List<String> elements = condition.split(':');
        //default case
        if(elements.size() == 2){
            if(!String.isEmpty(String.valueof(relatedObject.get(objectName).get(String.valueof(dossier.get(objectName))).get(elements.get(0)))))
            return String.valueof(relatedObject.get(objectName).get(String.valueof(dossier.get(objectName))).get(elements.get(0))).toLowercase() == elements.get(1).toLowercase() ? 'TRUE' : 'FALSE';
        }
        else if(elements.size() == 3){
            if(elements.get(2).toLowercase() == 'null'){
                if(elements.get(1) == '==')
                return String.isEmpty(String.valueof(relatedObject.get(objectName).get(String.valueof(dossier.get(objectName))).get(elements.get(0)))) ? 'TRUE' : 'FALSE' ;
                if(elements.get(1) == '!=')
                return String.isEmpty(String.valueof(relatedObject.get(objectName).get(String.valueof(dossier.get(objectName))).get(elements.get(0)))) ? 'FALSE' : 'TRUE' ;
            }
            else if(elements.get(1) == '=='){
                if(!String.isEmpty(String.valueof(relatedObject.get(objectName).get(String.valueof(dossier.get(objectName))).get(elements.get(0)))))
                return String.valueof(relatedObject.get(objectName).get(String.valueof(dossier.get(objectName))).get(elements.get(0))).toLowercase() == elements.get(2).toLowercase() ? 'TRUE' : 'FALSE';
            }
            else if(elements.get(1) == '!='){
                if(!String.isEmpty(String.valueof(relatedObject.get(objectName).get(String.valueof(dossier.get(objectName))).get(elements.get(0)))))
                return String.valueof(relatedObject.get(objectName).get(String.valueof(dossier.get(objectName))).get(elements.get(0))).toLowercase() == elements.get(2).toLowercase() ? 'FALSE' : 'TRUE';
            }
        }
        else if(elements.size() == 4){
            objectName = elements.get(0);
            if(elements.get(3).toLowercase() == 'null'){
                if(elements.get(2) == '==')
                return String.isEmpty(String.valueof(relatedObject.get(objectName).get(String.valueof(dossier.get(objectName))).get(elements.get(1)))) ? 'TRUE' : 'FALSE' ;
                if(elements.get(2) == '!=')
                return !String.isEmpty(String.valueof(relatedObject.get(objectName).get(String.valueof(dossier.get(objectName))).get(elements.get(1)))) ? 'TRUE' : 'FALSE' ;
            }
            else if(elements.get(2) == '=='){
                if(!String.isEmpty(String.valueof(relatedObject.get(objectName).get(String.valueof(dossier.get(objectName))).get(elements.get(1)))))
                return String.valueof(relatedObject.get(objectName).get(String.valueof(dossier.get(objectName))).get(elements.get(1))).toLowercase() == elements.get(3).toLowercase() ? 'TRUE' : 'FALSE';
            }
            else if(elements.get(2) == '!='){
                if(!String.isEmpty(String.valueof(relatedObject.get(objectName).get(String.valueof(dossier.get(objectName))).get(elements.get(1)))))
                return String.valueof(relatedObject.get(objectName).get(String.valueof(dossier.get(objectName))).get(elements.get(1))).toLowercase() == elements.get(3).toLowercase() ? 'FALSE' : 'TRUE';
            }
        }

        return 'FALSE';
    }


    private static String getFormattedFilterLogic(String filterLogic){
        try{
            Pattern p = Pattern.compile('(\\d+)');
            Matcher m = p.matcher( filterLogic );
            if(m.find()) {
                do {
                    filterLogic = filterLogic.replace(m.group() , '{'+ String.valueof(Integer.valueof(m.group())-1) +'}');
                } while(m.find());
            }
            return filterLogic;           
        }catch(Exception ex){
            throw new AuraHandledException(ex.getMessage());
        }
    }
}