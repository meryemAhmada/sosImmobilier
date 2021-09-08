/**
 * SmsService
 * HANDLE SMS
 *
 * @history
 *
 * Date       | Version | Remarks
 * ---------- | ------- | -----------------------------------------
 * 25/09/2018 |  1.0.0  | 
 *
 *
 **/
public class SmsService {
    

    public class inputSmsService
    {
        @InvocableVariable
        public String body;

        @InvocableVariable
        public String recipient;

        @InvocableVariable
        public String senderId;

        @InvocableVariable
        public Id assignedToId;

        public Id taskId;

        public inputSmsService(String body, String recipient, String senderId , Id assignedToId)
        {
            this.body = body;
            this.recipient = recipient;
            this.assignedToId = assignedToId;
            this.senderId = senderId;
        }

        public inputSmsService(String body, String recipient, Id taskId , String senderId)
        {
            this.body = body;
            this.recipient = recipient;
            this.taskId = taskId;
            this.senderId = senderId;
        }

        public inputSmsService(){}
    }


    @InvocableMethod
    public static List<Task> createSmsTasks(List<inputSmsService> inputs)
    {
        List<Task> tasks = new List<Task>();
        Task currentTask;

        for(inputSmsService input : inputs)
        {
            currentTask = new Task(Subject='SMS - TO '+input.recipient, Description= input.body, Phone__c = input.recipient, Sender_ID__c= input.senderId, isSMS__c = true);
            if(input.assignedToId.getsobjecttype() == Contact.getsobjecttype() || input.assignedToId.getsobjecttype() == Lead.getsobjecttype())
                currentTask.WhoId = input.assignedToId;
            else
                currentTask.WhatId = input.assignedToId;

            tasks.add(currentTask);
        }  

        insert tasks;
        sendSmsFromTasks((new Map<Id,Task>(tasks)).keySet());
        return tasks;
    }
    
    @future(callout=true)
    public static void sendSmsFromTasks(SET<Id> tasksids)
    {

        system.debug('**** TASKS ID: ' + tasksids);
        Map<Id, Task> tasks = new Map<Id, Task>([Select ID,description,phone__c,Sender_ID__c FROM Task WHERE Id IN :tasksids For Update]);
        List<inputSmsService> smsList = new List<inputSmsService>();
        for(Task t : tasks.values())
        {
            if(!String.isEmpty(t.description) && !String.isEmpty(t.phone__c))
                smsList.add(new inputSmsService(t.description, t.phone__c,t.id,t.Sender_ID__c));
            else
                throw new SmsServiceException('Attempt to send SMS with empty body or/and phone');
        }

        if(smsList.size() > 0)
        {
            //String stringResponse = massSending(smsList);
            String stringResponse = massSendingWithTracking(smsList);
            
            system.debug('stringResponse: '+ stringResponse);
            JsonResponse response = (JsonResponse)JSON.deserialize(stringResponse, JsonResponse.class);
            for(MessageOutput message : response.messages){
                tasks.get(message.messageId).SMS_Count__c = message.smsCount;
                tasks.get(message.messageId).Price_per_message__c = message.price!=null?message.price.pricePerMessage:null;

                tasks.get(message.messageId).Status_Name__c = message.status!=null?message.status.name:null;
                tasks.get(message.messageId).Status__c = message.status!=null?message.status.description:null;

                tasks.get(message.messageId).Error__c = message.error!=null?message.error.description:null;
                tasks.get(message.messageId).Error_Name__c = message.error!=null?message.error.name:null;

                tasks.get(message.messageId).Status = Label.TaskDone;
            }

            update tasks.values();
        }
    }
    
    public static String massSending(List<inputSmsService> messages)
    {
        if(messages == null || messages.size() == 0)
            throw new SmsServiceException('no messages specified !');
                
        String data = '[';
        String current_message;
        
        for(Integer i = 0 ;i<messages.size(); i++)
        {
            if(messages.get(i).recipient == null || messages.get(i).recipient == '')
                throw new SmsServiceException('Recipient in message '+messages.get(i).taskId+' can\'t be null or empty!');
            
            if(messages.get(i).body == null || messages.get(i).body == '')
                throw new SmsServiceException('Body in message '+messages.get(i).taskId+' can\'t be null or empty!');
            
            current_message = '{"from": "'+messages.get(i).senderId+'","destinations":[{"to": "'+messages.get(i).recipient+'","messageId": "'+messages.get(i).taskId+'"}] , "text": '+JSON.serialize(messages.get(i).body)+'}';
            if(i != messages.size()-1) current_message+=',';
            data+=current_message;
            
        }
        data+=']';
        System.debug('== DATA =='+data);
        
        String requestbody = '{"messages":'+data+'}';
        
        // this method return TRUE if the response's status is 200. FALSE if not.
        String result = invoke_ws_send(requestbody);        
        return result;
    }
    
    public static String invoke_ws_send(String body)
    {   

        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:Info_Bip_Mass_SMS/sms/1/advanced');
        request.setMethod('POST');
        request.setHeader('Content-Type','application/json');  
        request.setHeader('Accept', 'application/json');      
        request.setBody(body);
        system.debug('body : ' + body);

        Http http = new Http();
        HttpResponse response = http.send(request);
        
        System.debug('response  : ' + response.getBody());
        return response.getBody();
        
    }
    
    @future(callout=true)
    public static void getDeliveryReport()
    {

        
        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:Info_Bip_Mass_SMS/sms/1/reports');
        request.setMethod('GET');
        request.setHeader('Content-Type','application/json');  
        request.setHeader('Accept', 'application/json');      

        Http http = new Http();
        HttpResponse response = http.send(request);

        System.debug('Response is : ' + response.getBody());
        String stringResponse = response.getBody();
        JsonResponse jsonResponse = (JsonResponse)JSON.deserialize(stringResponse, JsonResponse.class);

        if(jsonResponse.results.size() > 0)
        {
            SET<Id> messagesIds = new SET<Id>();
            for(MessageOutput message : jsonResponse.results)
                messagesIds.add(message.messageId);

            Map<Id, Task> tasks = new Map<Id, Task>([Select ID FROM Task WHERE Id IN :messagesIds For Update]);

            for(MessageOutput message : jsonResponse.results)
            {
                if(isValidSalesforceId(message.messageId) && tasks.containsKey(message.messageId)){
                    tasks.get(message.messageId).SMS_Count__c = message.smsCount;
                    tasks.get(message.messageId).Price_per_message__c = message.price!=null?message.price.pricePerMessage:null;
    
                    tasks.get(message.messageId).Status_Name__c = message.status!=null?message.status.name:null;
                    tasks.get(message.messageId).Status__c = message.status!=null?message.status.description:null;
    
                    tasks.get(message.messageId).Error__c = message.error!=null?message.error.description:null;
                    tasks.get(message.messageId).Error_Name__c = message.error!=null?message.error.name:null;
                }
            }

            if(tasks.size() > 0) update tasks.values();
        }
    }
    
     public static Boolean isValidSalesforceId(String theId){
         if(Pattern.compile('[a-zA-Z0-9]{15}|[a-zA-Z0-9]{18}').matcher(theId).matches() ){
             return true;
         }
         return false;
    }

    public static void validateNumber(String phoneNumber)
    {
        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:Info_Bip_Mass_SMS/number/1/query');
        request.setMethod('POST');
        request.setHeader('Content-Type','application/json');  
        request.setHeader('Accept', 'application/json');  

        String data = '{"to":["'+phoneNumber+'"]}';
        request.setBody(data);

        System.debug('request data  : ' + data);

        Http http = new Http();
        HttpResponse response = http.send(request);

        System.debug('response  : ' + response.getBody());
    }


    public static Decimal getAccountBalance()
    {
        system.debug('*** GET: ACCOUNT BALANCE ***');

        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:Info_Bip_Mass_SMS/account/1/balance');
        request.setMethod('GET');
        request.setHeader('Content-Type','application/json');  
        request.setHeader('Accept', 'application/json');  

        Http http = new Http();
        HttpResponse response = http.send(request);

        String stringResponse = response.getBody();
        
        System.debug('response  : ' + response.getBody());

        AccountBalance jsonResponse = (AccountBalance)JSON.deserialize(stringResponse, AccountBalance.class);

        return jsonResponse.balance;
    }


    public static String massSendingWithTracking(List<inputSmsService> messages){
        if(messages == null || messages.size() == 0)
            throw new SmsServiceException('no messages specified !');
                
        String data = '[';
        String current_message;
        
        for(Integer i = 0 ;i<messages.size(); i++)
        {
            if(messages.get(i).recipient == null || messages.get(i).recipient == '')
                throw new SmsServiceException('Recipient in message '+messages.get(i).taskId+' can\'t be null or empty!');
            
            if(messages.get(i).body == null || messages.get(i).body == '')
                throw new SmsServiceException('Body in message '+messages.get(i).taskId+' can\'t be null or empty!');
            
            current_message = '{"from": "'+messages.get(i).senderId+'","destinations":[{"to": "'+messages.get(i).recipient+'","messageId": "'+messages.get(i).taskId+'"}] , "text": '+JSON.serialize(messages.get(i).body)+'}';
            if(i != messages.size()-1) current_message+=',';
            data+=current_message;
            
        }
        data+='], "tracking":{"track":"URL", "type":"SOCIAL_INVITES"}';
        System.debug('== DATA =='+data);
        
        String requestbody = '{"messages":'+data+'}';
        
        // this method return TRUE if the response's status is 200. FALSE if not.
        String result = invoke_ws_send(requestbody);        
        return result;
    }


    
    public class SmsServiceException extends Exception {}

    // objects for parsing JSON response
    public class JsonResponse {public List<MessageOutput> results;/*Used for reports*/public List<MessageOutput> messages;/*Used for Sending*/}
    public class MessageOutput{public String messageId;public Integer smsCount;public ErrorOutput error;public StatusOutput status;public PriceOutput price;}
    public class ErrorOutput{public String name;public String description;}
    public class StatusOutput{public String name;public String description;}
    public class PriceOutput{public Decimal pricePerMessage;}
    public class AccountBalance{public Decimal balance;}

   
}