/**
 * CONTROLLER OF PAGES:  VF01_SendMassSMS_{!sObject.Label}, VF02_SendMassSMS_{!sObject.Label}, VF03_SendMassSMS_{!sObject.Label},
 * SEND MASS SMS 
 *
 * @history
 *
 * Date       | Version | Remarks
 * ---------- | ------- | -----------------------------------------
 * 25/09/2018 |  1.0.0  | 
 *
 *
 **/
public class CTRL_SendMassSMS {

    /*
    ----------------------
    PROPERTIES
    -----------------------
        * sObjectType: SOBJECT'S TYPE
        * sObjectLabel: SOBJECT'S LABEL
        * selectedsObjects: SELECTED SOBJECTS MAP FROM LIST VIEW (sObject Id (key) --> sObject (value))
        * selectedsObjectsSize: SELECTED SOBJECTS LIST SIZE
        * selectedPhones: SELECTED PHONE NAMES LIST 
        * allFields: ALL FIELDS NAME LIST (USED FOR MERGING FIELD)
        * phones: PHONE NUMBERS LIST
        * invalidPhones: INVALID PHONE NUMBERS FOR EACH SOBJECT MAP (sObject Id (key) --> List: PhoneNumber (value))
        * validPhones: VALID PHONE NUMBERS FOR EACH SOBJECT MAP (sObject Id (key) --> List: PhoneNumber (value))
        * sObjectsToUpdate: SOBJECTS TO UDPATE MAP (sObject Id (key) --> sObject (value))
        * tasks: TASKS CREATED LIST 
        * smsList: INPUT SMS SERVICE LIST
        * body: SMS'S BODY
        * typeBody: BODY'S TYPE (custom OR template)
        * template: TEMPLATE SELECTED ID
        * mergeField: MERGE FIELD NAME
        * switcher_one: TRUE IF BODY TYPE IS TEMPLATE; FALSE IF NOT
        * switcher_two: TRUE IF BODY TYPE IS CUSTOM; FALSE IF NOT
        * done: INDICATES IF THERE'S NO ERROR WHILE CREATING TASKS AND SENDING SMS
    */
    
    public sObjectType sObjectType {get; set;}
    public String sObjectApiName {get; set;}
    public String sObjectLabel {get; set;}

    public Map<Id, sObject> selectedsObjects {get; set;}
    public Integer selectedsObjectsSize {get; set;}
    
    public List<String> selectedPhones {get; set;}

    public List<SelectOption> allFields {get; set;}
    
    public List<PhoneNumber> phones {get; set;}
    public Map<Id, List<PhoneNumber>> invalidPhones {get; set;} 
    public Map<Id, List<PhoneNumber>> validPhones {get; set;} 
    public Integer invalidPhonesSize {get; set;}
    public Integer validPhonesSize {get; set;}
    
    public Map<Id, sObject> sObjectsToUpdate {get; set;}
    public List<SmsService.inputSmsService> smsList {get; set;}
    public List<Task> tasks {get; set;}
    
    public String body {get; set;}

    public String typeBody{get; set;}
    public String template{get; set;}
    public String mergeField {get; set;}

    public Boolean switcher_one {get; set;}
    public Boolean switcher_two {get; set;}

    public Boolean done {get; set;}


    /* 
     * CONSTRUCTOR 
     * GET SOBJECT'S TYPE, SOBJECT'S LABEL AND SELECTED SOBJECTS MAP
     * INITIALIZE MERGE FIELD, SELECTED PHONES LIST, INVALID/VALID PHONES LISTS SIZE AND SELECTED SOBJECT MAP SIZE
     * IF NO SOBJECT SELETED, SHOW ERROR MESSAGE
     */
    public CTRL_SendMassSMS(ApexPages.StandardSetController stdCtrl){
        sObjectType =  (sObjectType) stdCtrl.getRecord().getsObjectType(); 
        sObjectApiName = sObjectType.getDescribe().getName();        
        sObjectLabel = sObjectType.getDescribe().getLabel();    
       
        selectedsObjects = new Map<Id, sObject>((List<sObject>) stdCtrl.getSelected());         
        if(stdCtrl.getSelected() == NULL) selectedsObjects = new Map<Id, sObject>();
             
        mergeField = '{!' +  sObjectType + '.Id}';

        selectedPhones = new List<String>(); //SELECTED FIELDS
        invalidPhonesSize = 0;
        validPhonesSize = 0;
        selectedsObjectsSize = selectedsObjects.size();
        if(selectedsObjectsSize == 0)
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL, '0 ' + sObjectApiName + ' ' + Label.Selected));

    }
    
  
    /* 
    ------------------
      STEPS
    ------------------
     */
    

    /* STEP 1 : GET PHONE/ALL FIELDS; GET TEMPLATES; TREAT BODY; */

    /*
     * GET CURRENT SOBJECT FIELDS () ONLY PHONES: Field's Name (value) ---> Field's Label (label) )
     * IMPLEMENT ALL FIELDS LIST (USED FOR MERGING FIELD WHEN BODY'S TYPE IS CUSTOM)
     * @return SELECT OPTION LIST  - SOBJECT PHONE FIELDS
     */
    public List<SelectOption> getPhoneFieldsList(){
        List<SelectOption> phoneFieldsList = new List<SelectOption>();
        allFields = new List<SelectOption>();
        
        Map<String, Schema.SObjectField> fields = sObjectType.getDescribe().fields.getMap();
        for(Schema.SObjectField field : fields.values()){
            if(String.valueOf(field.getDescribe().getType()) == 'Phone'){
                phoneFieldsList.add(new SelectOption(field.getDescribe().getName(), field.getDescribe().getLabel()));
            }
            allFields.add(new SelectOption('{!' + sObjectType.getDescribe().getName() + '.' + field.getDescribe().getName() + '}', field.getDescribe().getLabel()));
        }
        system.debug('*** allfields: ' + allFields);
        return phoneFieldsList;
    }


     /*
     * GET ACTIVE SMS TEMPLATES (TEMPLATE ID (value) --> TEMPLATE NAME (label))
     * @return SELECT OPTION LIST - SMS TEMPLATES
     */
    public List<SelectOption> getTemplates(){
        List<SelectOption> list_templates = new List<SelectOption>();
        
        List<SMS_Template__c> templates = [SELECT Id, Name 
                                           FROM SMS_Template__c 
                                           WHERE active__c = true];
        
        for(SMS_Template__c temp : templates)
            list_templates.add(new SelectOption(temp.Id, temp.Name));
            
        return list_templates;    
    }

     /*
     * CHANGE BODY SOURCE
     */
    public void changeSource(){
        body = '';
        if(typeBody == 'template'){
            switcher_one = true;
            switcher_two = false;
            system.debug('the switcher is on');
        }
        else{
            switcher_one = false;
            switcher_two = true;
            system.debug('the switcher is off');
        }
    }

     /*
     * GET BODY'S TYPES
     * @return SELECT OPTION LIST - BODY TYPES
     */
    public List<SelectOption> getTypesBody() {
        List<SelectOption> list_types = new List<SelectOption>();
        list_types.add(new SelectOption('template', Label.BodyTypeTemplate));
        list_types.add(new SelectOption('custom', Label.BodyTypeCustom));
        return list_types;
    }

     /*
     * BACK TO sObject's DEFAULT LIST VIEW
     * @return PAGE REFERENCE - SOBJECT LIST VIEW
     */
    public PageReference cancel(){
        return new PageReference('/' +  sObjectType.getDescribe().getKeyPrefix());
    }
    

     /* STEP 2 : VERIFY BODY, GET AND MANAGE VALUES, THEN GET AND VERIFY SELECTED FIELDS PHONE; */

     /*
     * GO TO STEP 2 
     * VERIFY BODY: IF EVERYTHING IS OKAY AND SELECTED PHONES LIST ISN'T EMPTY THEN GET AND MANAGE VALUES, VERIFY SELECTED FIELDS PHONE AND SHOW SECOND PAGE
     * @return PAGE REFERENCE - VF02_SendMassSMS_{!sObject.Label} OR NULL IF THERE'S AN ERROR
     */
    public PageReference nextStep2(){
        system.debug('***Step2***');
        if(verifyBody()){
            if(selectedPhones.size() > 0){
                getValues();
                manageValues();
                verifyPhoneNumbers();

                done = false;

                return returnStep2();
            }
            else{
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL, Label.Error_SelectPhoneNumber));
            }
        }
        return NULL;
    }
    
    /*
     * VERIFY BODY
     * 1- IF BODY TYPE EQUALS TEMPLATE: CHECK TEMPLATE BODY 
            1.1 GET SELECTED TEMPLATE AND CHECK IF IT'S BODY ISN'T EMPTY
            1.2 IF BODY'S EMPTY, THEN CHECK TEMPLATE'S SOURCE ISN'T NULL AND GET TEMPLATE EMAIL BODY
     * 2- IF BODY TYPE EQUALS CUSTOM:  CHECK IF CUSTOM BODY 
            2.1 IF BODY IS EMPTY: SHOW ERROR MESSAGE
     * 3- IF BODY TYPE IS NULL:  SHOW ERROR MESSAGE
     * @return BOOLEAN - TRUE IF BODY ISN'T EMPTY OR NULL, FALSE IF NOT
     */
    public Boolean verifyBody(){
        if(typeBody == 'template'){
            List<SMS_Template__c> templateSMS = [SELECT Body__c, source__c FROM SMS_Template__c WHERE Id = :template];
            if(templateSMS.size() > 0){
                body = templateSMS[0].Body__c;
                if(body != NULL) return true;
                else if(body == NULL && templateSMS[0].source__c != NULL){
                    EmailTemplate templateEmail = [SELECT Body FROM EmailTemplate WHERE DeveloperName = :templateSMS[0].source__c];
                    body = templateEmail.Body;
                    return true;
                }
                else{
                    ApexPages.addmessage(new ApexPages.Message(ApexPages.Severity.Error, Label.Error_EmptyBody));
                }
            }
            else{
                ApexPages.addmessage(new ApexPages.Message(ApexPages.Severity.Error, Label.Error_EmptyTemplate));
            }
                
        }
        else if(typeBody == 'custom'){
            if(body == NULL ||  String.isEmpty(body)){
                ApexPages.addmessage(new ApexPages.Message(ApexPages.Severity.Error, Label.Error_EmptyBody));
            }
            else return true;
        }
        else{
            ApexPages.addmessage(new ApexPages.Message(ApexPages.Severity.Error, Label.Error_SourceBody));           
        }
        return false;
    }
    

    /*
     * SELECT SELECTED PHONES VALUES (BUILD AND EXECUTE QUERY)
     */
    public void getValues(){
        String query = 'SELECT Id, Name, ';
        for(String phone : selectedPhones){
            query += phone + ', ';
        }
        if(query.substring(query.length()-2, query.length()) == ', ') {
            query = query.substring(0, query.length()-2);
        }
        Set<Id> ids = selectedSObjects.keySet();
        query += ' FROM ' + sObjectType.getDescribe().getName() + ' WHERE Id IN :ids ORDER BY Name ASC';
        
        selectedSObjects = new Map<Id, sObject>(Database.query(query));
        selectedSObjectsSize = selectedSObjects.size();  
    }
    

     /*
     * MANAGE SELECTED PHONES VALUES
     * IMPLEMENT PHONES LIST 
     */
    public void manageValues(){
        phones = new List<PhoneNumber>();
        String phone;
        for(sObject obj : selectedSObjects.values()){
            for(String phoneName : selectedPhones){
                phone = (String) obj.get(phoneName);
                phones.add(new PhoneNumber(phoneName, obj.Id, phone));
            }
        }
        system.debug('**** phones: ' + phones);
    }
  
      
    /*
     * VERIFY ALL PHONE NUMBERS
     * IMPLEMENT INVALID/VALID PHONES MAPS
     */                        
    public void verifyPhoneNumbers(){
        invalidPhones = new Map<Id, List<PhoneNumber>>();
        validPhones = new Map<Id, List<PhoneNumber>>();

        invalidPhonesSize = 0;
        validPhonesSize = 0;
        
        for(PhoneNumber phone : phones){
            if(!phone.isValid()){
                if(invalidPhones.containsKey(phone.sObjectId)) invalidPhones.get(phone.sObjectId).add(phone);
                else invalidPhones.put(phone.sObjectId, new List<PhoneNumber>{phone});

                invalidPhonesSize++;
            }
            else{
               if(validPhones.containsKey(phone.sObjectId)) validPhones.get(phone.sObjectId).add(phone);
               else validPhones.put(phone.sObjectId, new List<PhoneNumber>{phone}); 

               validPhonesSize++; 
            }
        }
        
        system.debug('** INVALID PHONES: ' + invalidPhones);
        system.debug('** VALID PHONES: ' + validPhones);
    }
    
    
    /*
     * BACK TO STEP 1 
     * @return PAGE REFERENCE - VF01_SendMassSMS_{!sobject.Label}
     */
    public PageReference returnStep1(){
        PageReference pg =  new PageReference('/apex/VF01_SendMassSMS_' + sObjectApiName);
        pg.setRedirect(false); 
        return pg;
    }


    /* STEP 3 : CREATE SMS TASKS AND SEND SMSs */


    /*
     * GO TO STEP 2
     * IF VALID PHONES MAP ISN'T EMPTY, CREATE SMS LIST
     * ELSE SHOW ERROR MESSAGE
     * @return PAGE REFERENCE - VF03_SendMassSMS_{!sobject.Label} IF THERE'S NO ERROR, ELSE NULL
     */
    public PageReference nextStep3(){
        system.debug('***Step3***');

        if(validPhones.size() > 0){
            createSmsList();
            if(done) return finish();
        }
        else ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL, Label.Error_NoValidPhoneNumber));

        return NULL;
    }
    
    /*
     * SAVE UPDATES (FOR INVALID PHONE NUMBERS)
     * @return PAGE REFERENCE - NULL
     */
    public PageReference saveUpdates(){
        sObjectsToUpdate = new Map<Id, sObject>();
        Boolean noError = true; 

        List<PhoneNumber> toUpdate = new List<PhoneNumber>();
        for(List<PhoneNumber> phone : invalidPhones.values()) toUpdate.addAll(phone);

        //VERIFY PHONE NUMBERS
        for(PhoneNumber phone : toUpdate){
            if(!phone.isValid()){
                phone.value = (String) selectedsObjects.get(phone.sObjectId).get(phone.Name);
                sObjectsToUpdate.put(phone.sObjectId, selectedSObjects.get(phone.sObjectId));
            }
        }

        //UPDATE SOBJECTS
        system.debug('**sObjectsToUpdate: ' + sObjectsToUpdate);
        if(sObjectsToUpdate.size() > 0) {
            try{
                update sObjectsToUpdate.values();
            }catch(Exception ex){
                System.debug('!!! ERROR WHILE UPDATING sObjectsToUpdate: ' + ex.getMessage());
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL, ex.getMessage()));
                noError = false;
            }
        }

        //REFRESH VALID/INVALID PHONE NUMBERS
        if(noError) verifyPhoneNumbers();

        return NULL;
    }


    /*
     * CREATE SMS LIST
     * @see MergingService.mergeFields; SmsService.createSmsTasks
     */
    public void createSmsList(){
        tasks = new List<Task>();
        List<PhoneNumber> finalList = new List<PhoneNumber>();
        for(List<PhoneNumber> pList : validPhones.values()) finalList.addAll(pList);

        system.debug('*** BEFORE MERGING FIELDS -->  body: ' + body);

        //MERGING SERVICE
        Map<Id, String> messages = MergingService.mergeFields(body, selectedSObjects.values(), sObjectType.getDescribe().getName());

        smsList = new List<SmsService.inputSmsService>();
        SmsService.inputSmsService sms;
        for(PhoneNumber phone : finalList){
            sms = new SmsService.inputSmsService(messages.get(phone.sObjectId), phone.value, Label.info_bip_sender_id, phone.sObjectId);
            smsList.add(sms);
        }
        try{ 
            tasks = SmsService.createSmsTasks(smsList);
            done = true;
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Confirm, Label.SuccessSendMassSMS));
        }catch(Exception ex){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL, ex.getMessage()));
        }

    }
                             
    
    /*
     * BACK TO STEP 2
     * @return PAGE REFERENCE - VF02_SendMassSMS_{!sObject.Label}
     */
    public PageReference returnStep2(){
        PageReference pg = new PageReference('/apex/VF02_SendMassSMS_' + sObjectApiName);
        pg.setRedirect(false); 
        return pg;
    }


    /*
     * FINISH
     * @return PAGE REFERENCE - VF03_SendMassSMS_{!sObject.Label}
     */
    public PageReference finish(){
        PageReference pg = new PageReference('/apex/VF03_SendMassSMS_' + sObjectApiName);
        pg.setRedirect(false); 
        return pg;
    }


    /*
     * GET NEW SMS TASKS CREATED FOR EACH SOBJECT
     * @return SMS TASKS MAP (sObject Id (key) --> List<Task> (value))
     */
    public Map<Id, List<Task>> getNewTasks(){ 
        Map<Id, List<Task>> newTasks = new Map<Id, List<Task>>();
        for(Task task : [SELECT Id, Description, WhoId, Who.Name, WhatId, What.Name, 
                           Error__c, Error_Name__c, Phone__c, Price_per_message__c, Sender_ID__c,
                           SMS_Count__c, Status__c, Status_Name__c, Status
                        FROM Task 
                        WHERE Id IN : tasks
                        ORDER BY Who.Name, What.Name ASC]){

            if(task.WhoId != NULL){
                if(newTasks.containsKey(task.WhoId)) newTasks.get(task.WhoId).add(task);
                else newTasks.put(task.WhoId, new List<Task>{task});
            }

            else if(task.WhatId != NULL){
                if(newTasks.containsKey(task.WhatId)) newTasks.get(task.WhatId).add(task);
                else newTasks.put(task.WhatId, new List<Task>{task});
            }
        }

        return newTasks;
    }


    
    /* WRAPPER CLASSES */

    //PHONE NUMBER
    public class PhoneNumber{
        public String name {get; set;}
        //public String label {get; set;}
        public Id sObjectId {get; set;}
        public String value {get; set;}
        public Boolean valid {get; set;}
        public Boolean toUpdate {get; set;}
        
        public PhoneNumber(String name, Id sObjectId, String value){
            this.name = name;
            this.sObjectId = sObjectId;
            this.value = value;
            this.valid = isValid();
            this.toUpdate = false;
        }
        
        public Boolean isValid(){
            Pattern pattern = Pattern.compile('\\+212[0-9]{9}');
            Matcher matcher; 
            if((value == NULL) || !(pattern.matcher(value).matches())) valid = false;
            else valid = true;  
            return valid;
        }
    }
    
    
}