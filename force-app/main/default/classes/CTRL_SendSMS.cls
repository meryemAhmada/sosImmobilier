/**
 * CONTROLLER OF PAGE:  VF00_SendSMS_{!sObject.Label}
 * SEND SIMPLE SMS 
 *
 * @history
 *
 * Date       | Version | Remarks
 * ---------- | ------- | -----------------------------------------
 * 25/09/2018 |  1.0.0  | 
 *
 *
 **/
public class CTRL_SendSMS {

    /*
    ----------------------
    PROPERTIES
    -----------------------
        * SObjectId : SOBJECT ID
        * currentsObject: CURRENT SOBJECT
        * selectedPhones: SELECTED PHONE NAMES LIST 
        * phones: PHONES' VALUES MAP (FIELD's Name (key) --> FIELD's Value (value)) 
        * tasks: TASKS CREATED LIST 
        * smsList: INPUT SMS SERVICE LIST
        * body: SMS'S BODY
        * noError: INDICATES IF THERE'S NO ERROR WHILE CREATING TASKS AND SENDING SMS
    */
    
    public Id sObjectId {get; set;}
    public sObject currentsObject {get; set;}

    public List<String> selectedPhones {get; set;}
    public Map<String, String> phones {get; set;}

    public List<Task> tasks {get; set;}
    public List<SmsService.inputSmsService> smsList {get; set;}

    public String body {get; set;}

    public Boolean noError {get; set;}

    

    /* 
     * CONSTRUCTOR 
     * GET SOBJECT ID AND INITIALIZE SELECTED PHONES LIST AND NO ERROR
     * GET CURRENT USER LANGUAGE
     */ 
    public CTRL_SendSMS(ApexPages.StandardController stdCtrl){
        sObjectId =  (Id) stdCtrl.getRecord().Id;
        selectedPhones = new List<String>(); //SELECTED FIELDS
        noError = true;
    }
    
    /*
     * @return SOBJECT PHONE FIELDS LIST (Field's Name (key) ---> Field's Label (value))
     */ 
    public List<SelectOption> getPhoneFieldsList(){
        List<SelectOption> phoneFieldsList = new List<SelectOption>();

        Map<String, Schema.SObjectField> fields = sObjectId.getSObjectType().getDescribe().fields.getMap();
        for(Schema.SObjectField field : fields.values()){
            if(String.valueOf(field.getDescribe().getType()) == 'Phone'){
                phoneFieldsList.add(new SelectOption(field.getDescribe().getName(), field.getDescribe().getLabel()));
            }
        }

        return phoneFieldsList;
    }
       
    /*
    * CREATE SMS LIST
    * IF SELECTED PHONES LIST AND BODY AREN'T EMPTY, GET SOBJECT PHONE VALUES, CHECK IF THERE'RE VALIDATED THEN CREATE SMS LIST AND SMS TASKS
    * @see:  SmsService.createSmsTasks
    */ 
    public void createSmsList(){
        smsList = new List<SmsService.inputSmsService>();
        tasks = new List<Task>();
        if(selectedPhones.size() > 0 && !String.isEmpty(body)){
            getValues();
            if(checkPhoneNumbers()){
                for(String phone : phones.values()){
                    smsList.add(new SmsService.inputSmsService(body, phone, Label.info_bip_sender_id, sObjectId));
                }
                try{ 
                    tasks = SmsService.createSmsTasks(smsList);
                    noError = true;
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Confirm, Label.SuccessSendSMS));
                }catch(Exception ex){
                    noError = false;
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL, ex.getMessage()));
                }
            }
        } 
        else{
             noError = false;
             ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL, Label.Error_SelectPhoneNumber_EmptyBody));
        }
    }
    
    /*
     * GET SOBJECT VALUES
     * SELECT SELECTED PHONES FROM SOBJECT, THEN SAVE VALUES ON PHONES LIST
     */
    public void getValues(){
        phones = new Map<String, String>(); //VALUES
        
        /* BUILD AND EXECUTE QUERY */
        String query = 'SELECT ';
        for(String phone : selectedPhones){
            query += phone + ', ';
        }
        if(query.substring(query.length()-2, query.length()) == ', ') {
            query = query.substring(0, query.length()-2);
        }
        query += ' FROM ' + sObjectId.getsObjectType().getDescribe().getName() + ' WHERE Id = \'' + sObjectId + '\'';
        
        currentSObject = Database.query(query);
        
        /* SAVE VALUES */
        for(String phone : selectedPhones){
            phones.put(phone, (String) currentSObject.get(phone));
        }
    }
    
    /*
     * CHECK PHONE NUMBERS
     * @return  TRUE IF ALL PHONE NUMBERS ARE VALIDATED, FALSE IF NOT
     */
    public Boolean checkPhoneNumbers(){ 
        List<String> messages = new List<String>();
        String phone;
        for(String phoneName : phones.keySet()){
            phone = phones.get(phoneName);

            if(phone == NULL){
                messages.add(phoneName + ' is empty !');
            }
            else if(!(phone.length() == 13 && phone.substring(0,4) == '+212' && phone.substring(1, phone.length()).isNumeric()) ){
                messages.add('"' + phone + '" (' + phoneName + ') ' +  Label.Error_invalidPhoneNumber);
            } 
        }
        
        if(messages.size() > 0) {
            noError = false;
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL, string.join(messages,'\n')));
            return false;
        }
        return true;
    }


    

    
}