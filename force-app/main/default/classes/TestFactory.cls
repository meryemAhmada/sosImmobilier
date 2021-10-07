@isTest
public class TestFactory {
    
    public static List<User> createUsers(Integer n, Boolean doInsert)
    {
        Id profileID = [Select Id FROM Profile WHERE Name = 'CC'].id;
        List<User> listUsers = new List<User>();
        User u;
        for(Integer i = 0 ; i < n; i++)
        {
            u = new User();
            u.LastName = EncodingUtil.convertToHex(crypto.generateAesKey(128)).substring(0,10);
            u.Email = EncodingUtil.convertToHex(crypto.generateAesKey(128)).substring(0,6)+'@'+EncodingUtil.convertToHex(crypto.generateAesKey(128)).substring(0,4)+'.com';
            u.UserName = EncodingUtil.convertToHex(crypto.generateAesKey(128)).substring(0,6)+'@'+EncodingUtil.convertToHex(crypto.generateAesKey(128)).substring(0,4)+'.com';
            u.Alias = EncodingUtil.convertToHex(crypto.generateAesKey(128)).substring(0,5);
            u.profileId = profileID;
            u.TimeZoneSidKey = 'GMT';
            u.LanguageLocaleKey = 'en_US';
            u.EmailEncodingKey = 'UTF-8';
            u.LocaleSidKey = 'en_US';
            listUsers.add(u);
        }
        
        if(doInsert) insert listUsers;
        return listUsers;
    }
    
    public static List<User> createAdmins(Integer n, Boolean doInsert)
    {
        Id profileID = [Select Id FROM Profile WHERE Name = 'System Administrator'].id;
        List<User> listUsers = new List<User>();
        User u;
        for(Integer i = 0 ; i < n; i++)
        {
            u = new User();
            u.LastName = EncodingUtil.convertToHex(crypto.generateAesKey(128)).substring(0,10);
            u.Email = EncodingUtil.convertToHex(crypto.generateAesKey(128)).substring(0,6)+'@'+EncodingUtil.convertToHex(crypto.generateAesKey(128)).substring(0,4)+'.com';
            u.UserName = EncodingUtil.convertToHex(crypto.generateAesKey(128)).substring(0,6)+'@'+EncodingUtil.convertToHex(crypto.generateAesKey(128)).substring(0,4)+'.com';
            u.Alias = EncodingUtil.convertToHex(crypto.generateAesKey(128)).substring(0,5);
            u.profileId = profileID;
            u.TimeZoneSidKey = 'GMT';
            u.LanguageLocaleKey = 'en_US';
            u.EmailEncodingKey = 'UTF-8';
            u.LocaleSidKey = 'en_US';
            u.Bypass_VR__c = true;
            listUsers.add(u);
        }
        
        if(doInsert) insert listUsers;
        return listUsers;
    }
    
    public static Id createPublicGroup(SET<Id> members, String Name)
    {
        Group newGroup = new Group();
        newGroup.Name = Name;
        insert newGroup;
        
        List<GroupMember> groupMembers = new List<GroupMember>();
        GroupMember groupMember;
        for(Id member : members)
        {
            groupMember = new groupMember();
            groupMember.GroupId=newGroup.id;
            groupMember.UserOrGroupId=member;
            groupMembers.add(groupMember);
        }
        insert groupMembers;
        return newGroup.id;
    }
    
    public static List<Lead> createLeads(Integer n, Boolean doInsert)
    {
        List<Lead> leads = new List<Lead>();
        Id rtLeadImmo = [Select Id FROM RecordType WHERE DeveloperName = 'Lead_Immo'].id;
        Lead l;
        for(Integer i = 0; i<n; i++)
        {
            l = new Lead();
            l.RecordTypeId = rtLeadImmo;
            l.lastName = EncodingUtil.convertToHex(crypto.generateAesKey(128)).substring(0,10);
            l.company = EncodingUtil.convertToHex(crypto.generateAesKey(128)).substring(0,10);
            leads.add(l);
        }
        
        if(doInsert) insert leads;
        return leads;
    }

    public static List<Lead> createLeadsWithSpecificData(String phone, String MCI_User_ID, Integer n, Boolean doInsert)
    {
        List<Lead> leads = new List<Lead>();
        Lead l;
        for(Integer i = 0; i<n; i++)
        {
            l = new Lead();
            l.lastName = EncodingUtil.convertToHex(crypto.generateAesKey(128)).substring(0,10);
            l.company = EncodingUtil.convertToHex(crypto.generateAesKey(128)).substring(0,10);
            l.MobilePhone = phone;
            l.MCI_User_ID__c = MCI_User_ID;
            leads.add(l);
        }
        
        if(doInsert) insert leads;
        return leads;
    }

    public static List<Account> createAccountsWithSpecificData(String MCI_User_ID, Integer n, Boolean doInsert)
    {
        List<Account> accounts = new List<Account>();
        
        Account acc;
        for(Integer i = 0; i<n; i++)
        {
            acc = new Account(Name = 'Account ' + i, MCI_User_ID__c = MCI_User_ID);
            accounts.add(acc);
        }
        
        if(doInsert) insert accounts;
        return accounts;
    }

    public static List<Contact> createContactsWithSpecificData(Id accountId, String phone, String MCI_User_ID, Integer n, Boolean doInsert)
    {
        List<Contact> contacts = new List<Contact>();

        if(accountId == NULL) accountId = createAccountsWithSpecificData(MCI_User_ID, 1, true).get(0).Id;

        Contact contact;
        for(Integer i = 0; i<n; i++)
        {
            contact = new Contact();
            contact.lastName = EncodingUtil.convertToHex(crypto.generateAesKey(128)).substring(0,10);
            contact.AccountId = accountId;
            contact.MobilePhone = phone;
            contact.MCI_User_ID__c = MCI_User_ID;
            contacts.add(contact);
        }
        
        if(doInsert) insert contacts;
        return contacts;
    }
    
    public static List<Contact> createContactsWithSpecificData(Id accountId, String paysDeResidence , String profession , String nationnalite , Integer n, Boolean doInsert)
    {
        List<Contact> contacts = new List<Contact>();

        if(accountId == NULL) accountId = createAccountsWithSpecificData('55', 1, true).get(0).Id;

        Contact contact;
        for(Integer i = 0; i<n; i++)
        {
            contact = new Contact();
            contact.lastName = EncodingUtil.convertToHex(crypto.generateAesKey(128)).substring(0,10);
            contact.AccountId = accountId;
            contact.Pays_de_r_sidence__c = paysDeResidence;
            contact.Profession__c = profession;
            contact.Nationalite__c = nationnalite;
            contacts.add(contact);
        }
        
        if(doInsert) insert contacts;
        return contacts;
    }
    
    public static List<Simulation__c> createSimulations(List<String> MCI_SIM_IDs , Id contactorLeadId, String contactOrLead , Integer n, Boolean doInsert){
         List<Simulation__c> simulations = new List<Simulation__c>();
        
        Simulation__c simulation;
        for(Integer i = 0; i<n; i++)
        {
            simulation = new Simulation__c(MCI_SIM_ID__c = MCI_SIM_IDs[i]);
            simulation.put(contactOrLead , contactorLeadId);
            simulations.add(simulation);
        }
        
        if(doInsert) insert simulations;
        return simulations;
        
    }
    
    public static List<Simulation__c> createSimulationsWithSpecificData(Id contactorLeadId, String contactOrLead, Boolean contentieux , String typeDeBien , String typeDeCredit , Boolean rentier , Decimal montantFraisNotaire , Decimal MontantFraisAmenagement , Integer n, Boolean doInsert){
         List<Simulation__c> simulations = new List<Simulation__c>();
        
        Simulation__c simulation;
        for(Integer i = 0; i<n; i++)
        {
            simulation = new Simulation__c();
            simulation.put(contactOrLead , contactorLeadId);
            simulation.Contentieux__c = contentieux;
            simulation.Type_de_Bien__c = typeDeBien;
            simulation.Type_de_cr_dit__c = typeDeCredit;
            simulation.tes_vous_rentier__c = rentier;
            simulation.Montant_des_Frais_de_notaire_enregi_X__c = montantFraisNotaire;
            simulation.Montant_des_frais_d_am_nagement_inclus_X__c = MontantFraisAmenagement;
            simulations.add(simulation);
        }
        
        if(doInsert) insert simulations;
        return simulations;
        
    }
    
}