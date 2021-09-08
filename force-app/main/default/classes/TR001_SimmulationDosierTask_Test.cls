@isTest
public class TR001_SimmulationDosierTask_Test {
    @testSetup static void setup(){
        //Create Account
           Account apporteur = new Account(Name = 'Test Apporteur',Email__c = 'apporteurTest@test.com');
		   insert apporteur;
           Account superApporteur = new Account(Name = 'Test Super Apporteur',Email__c = 'testsuperapporteur@test.com');
           insert superApporteur;
       //Create Contact
           Contact contact = new Contact(LastName = 'Test1', Nationalite__c='Morocco', Pays_de_r_sidence__c ='Morocco', Profil__c='Salarié',
        							   Apporteur_Contact__c = apporteur.Id, Super_apporteur_Contact__c = superApporteur.Id);
           insert contact;
       //Create Lead
           Lead lead1 = new Lead (LastName = 'NourFoum', Status = 'Open', Company='SOS');
           insert lead1;
       //Create simmulation
           Simulation__c simulationContact = new Simulation__c(Contact__c =contact.Id);
           insert simulationContact;
           Simulation__c simulationLead = new Simulation__c(Lead__c =lead1.Id, Contact__c =contact.Id);
           insert simulationLead;
       //Create Dossier
       		Dossier__c  dossier = new Dossier__c(Simulation__c =simulationContact.Id , contact__c= contact.Id);
            insert dossier;
        	Dossier__c  dossier1 = new Dossier__c(Simulation__c =simulationLead.Id , contact__c= contact.Id);
            insert dossier1;
       
    }

    @isTest static void test_TR001_SimmulationDosierTask(){
        List<Simulation__c> listSimulations = [SELECT Id,Contact__c FROM Simulation__c];
        List<Dossier__c> listDossier = [SELECT Id FROM Dossier__c];
        List<Task> listOfTask = new List<Task>();
        task tasTrigger = new Task(Type = 'Call',Description = 'NRPtest' , WhatId = listSimulations[0].Id, WhoId=listSimulations[0].contact__c);
        //List<Task> simulationTask = new List<Task>();
        
        for(Simulation__c s : listSimulations){
             Task t = new Task();
                  t.Type = 'Call';
                  t.Description = 'NRP'+ s.Id; //string
                  t.WhatId = s.Id; //record id
                  t.OwnerId =UserInfo.getUserId();
                  listOfTask.add(t);
        }
        for(Dossier__c d : listDossier){
             Task t = new Task();
                  t.Type = 'Call';
                  t.Description = 'IP'+ d.Id; //string
                  t.WhatId = d.Id; //record id
                  t.OwnerId =UserInfo.getUserId();
                  listOfTask.add(t);
        }
        Test.startTest();
          TR001_SimmulationDosierTaskHandler.handleBeforeInsert(listOfTask);
        Test.stopTest();
        system.assertEquals(listOfTask.size(),4 );
        
    }
    
}