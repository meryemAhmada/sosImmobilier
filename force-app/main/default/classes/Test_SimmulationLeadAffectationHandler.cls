@isTest
public class Test_SimmulationLeadAffectationHandler {
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
        Lead leadJunior = new Lead (LastName = 'NourFoum Jun', Status = 'Open', Company='SOS');
        insert leadJunior;
        Lead leadSenior = new Lead (LastName = 'NourFoum Sen', Status = 'Open', Company='SOS');
        insert leadSenior;
    }
    
    @isTest public static void Test_TR001_SimmulationLeadAffectation(){
        List<Lead> leads = [SELECT Id FROM Lead ];
        List<Contact> contacts = [SELECT Id FROM Contact ];
        List<Simulation__c> simulationsToInsert = new List<Simulation__c>();
        List<Simulation__c> simulationsToUpdate = new List<Simulation__c>();
        Id LeadOwnerId = leads[0].Id;
        //Create simmulation
        Simulation__c simulationJunior = new Simulation__c(Contact__c =contacts[0].Id , Lead__c =leads[0].Id , Montant_du_cr_dit__c =0, Total_des_revenus__c =0);
        Simulation__c simulationSenior = new Simulation__c(Lead__c =leads[1].Id, Contact__c =contacts[0].Id,  Montant_du_cr_dit__c = 20000, Total_des_revenus__c =25000 );
        simulationsToInsert.add(simulationJunior);
        simulationsToInsert.add(simulationSenior);
        
        Test.startTest(); 
        Insert simulationsToInsert;
       
        
         // test of After Update
        List<Simulation__c>  simulations = [SELECT Id,Montant_du_cr_dit__c,Total_des_revenus__c, reassigner__c,Lead__r.reassigner__c  FROM Simulation__c];
        simulations[0].Montant_du_cr_dit__c =20000;
        simulations[0].Total_des_revenus__c =40000;
        simulationsToUpdate.add(simulations[0]);
        update simulationsToUpdate;
        Test.stopTest();
        system.assertEquals(false, simulations[0].reassigner__c);
        system.assertEquals(true, simulations[0].Lead__r.reassigner__c);
    }
    
  
    
}