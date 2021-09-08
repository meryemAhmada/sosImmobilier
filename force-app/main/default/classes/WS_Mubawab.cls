@ RestResource(urlMapping = '/leadMubawab')
global without sharing class WS_Mubawab {
    @HttpPost
    global static void pushToSF() {
        RestResponse response = RestContext.response;
        try {
            System.debug('**** PUSH TO SF ****');
            
            Data data = (Data) JSON.deserialize(RestContext.request.requestBody.toString(), Data.class);
            System.debug('** DATA : ' + data);
            
            /* SEARCH CONTACTS OR LEADS WITH SAME PHONE  */
            
            System.debug('** PHONE : ' + data.phone);
            List<Id> usersIdsInGroup= new List<Id>();
            String mobilePhone = data.phone.right(9);
            List<List<sObject>> searchList = [FIND :mobilePhone IN PHONE FIELDS RETURNING Contact(Id, Email, OwnerId LIMIT 1), Lead(Id, Email, OwnerId LIMIT 1)];
            List<GroupMember> groupMembers=[Select Id, group.type, group.id, UserOrGroupId From GroupMember where group.developerName='Commerciaux_lead_immo'];
            
            for(GroupMember gm : groupMembers)
            {
                usersIdsInGroup.add(gm.UserOrGroupId);
            }
            
            
            sObject obj;
            
            if(!searchList.isEmpty() && searchList.size() > 0) {
                //CONTACT
                if(!searchList [0].isEmpty() && searchList [0].size() > 0) {
                    obj = searchList [0] [0];
                    
                }
                //LEAD
                else if(!searchList [1].isEmpty() && searchList [1].size() > 0) {
                    obj = searchList [1] [0];
                }
            }
            
            System.debug('--> OBJECT FOUND : ' + obj);
            
            /* TREATMENT */
            
            if(obj != NULL) {
				Task task_toInsert = new Task();
				task_toInsert.WhoId = obj.id;
				task_toInsert.OwnerId = (Id) obj.get('ownerid');
				task_toInsert.Subject = System.Label.taskobject;
				task_toInsert.priority = 'Normal';
				task_toInsert.description = System.Label.taskdescription;
				insert task_toInsert;

				//System.debug('** EMAIL : ' + data.email);

				//UPDATE EMAIL
				//System.debug('--> UPDATE EMAIL');
				//if(!String.isEmpty(data.email)) obj.put('EmaiL', data.email);
				
				//UPDATE MOBILE PHONE
				System.debug('--> UPDATE MOBILE PHONE : ' + mobilePhone);
				if(!String.isEmpty(mobilePhone)) obj.put('mobilePhone', '+212' + mobilePhone);

				if(!usersIdsInGroup.contains((Id) obj.get('ownerid'))) {
					LeadContactMethods.assignLeadContact(obj.Id);
				}
				update obj;
            }
            else {
                //APPORTEUR
                Id apporteurId;
                Id MCI_parrainId;
                
                if(!String.isEmpty(Label.mubawabMCI)) {
                    List<Contact> contacts = [SELECT Id,AccountId FROM Contact WHERE MCI_User_ID__c = :Label.mubawabMCI LIMIT 1];
                    System.debug('--> Contact WITH MCI USER ID == APPORTEUR ID : ' + contacts);
                    
                    if(!contacts.isEmpty()) {
                        apporteurId = contacts[0].AccountId;
                        MCI_parrainId = contacts[0].Id;
                    }
                    
                    
                    System.debug('--> APPORTEUR ID : ' + apporteurId);
                    
                    //INSERT NEW LEAD
                    System.debug('--> INSERT NEW LEAD');
                    
                    Lead lead;
                    
                    lead = new Lead(LastName = data.name, 
                    Company = 'Mubawab',
                    LeadSource = 'SiteWeb Mubawab', 
                    MobilePhone = data.phone, 
                    //Email = data.email,
                    Apporteur__c = apporteurId, 
                    MCI_parrain__c = MCI_parrainId);
                    insert lead;
                    
                    System.debug('--> LEAD : ' + lead);
                    
                }
            }
        } catch(Exception e) {
            system.debug('Error msg : '+e.getMessage());
            if(!Test.isRunningTest()){
                response.statusCode = 500;
                response.responseBody = Blob.valueOf(e.getMessage());
            }
        }
        
    }
    
    
    public class Data {
        public String name;
        public String phone;
        //public String email;
    }
    
}