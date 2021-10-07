@isTest
public class TestSimulationCreateTrigger {
    
    @testSetup static void testSetup(){
        Contact con = new Contact(FirstName='TestF', LastName = 'TestL',email='Test@test.com');
        insert con;
        
        Lead lead = new Lead(lastname = 'TestLa', firstName ='TestFi', company = 'ABC');
        insert lead;
        
        List<Simulation__c> sims = TestFactory.createSimulations(new List<String>{'123' , '456'} , con.Id , 'Contact__c' , 2 , false);
        sims.get(0).resultat__c='Trouvé le bien-AFD'; sims.get(0).Statut__c='Qualifié';sims.get(0).Actif__c  = true;
        insert sims;
    }
    
    //Créer simulation pour un contact qui deux sims sans dossier -> La sim crée ne doit pas etre activée
    static testMethod void testUnit(){

            Contact con = [Select Id from Contact limit 1];
            Lead lead = [Select Id from Lead limit 1];
            Simulation__c simulation = new Simulation__c();
            simulation.Actif__c = FALSE;
            simulation.Contact__c = con.Id;
            simulation.Lead__c = lead.Id;
            simulation.MCI_Sim_ID__c = '1234';
            
            Test.startTest();
                insert simulation;
            Test.stopTest();  

        Simulation__c simulationTest = [select Actif__c from Simulation__c where Id = :simulation.Id];
        List<Simulation__c> simsd = [Select Id , Actif__c from Simulation__c where id != :simulation.Id and Actif__c = true ];
        
        system.assertEquals(simsd.size() , 1);
        
        System.assertEquals(simulationTest.Actif__c, false);
    }
    
    //Activer une simulation pour un contact qui a une sim avec dossier  -> la nouvelle sim sera activée + la sim avec dossier reste active et les autres seront désactivées
    static testMethod void testUnit2(){        
		Contact con = [Select Id from Contact limit 1];
        Lead lead = [Select Id from Lead limit 1];
        List<Simulation__c> sims = [Select Id from Simulation__c];
        Dossier__c dossier = new Dossier__c(Simulation__c = sims.get(0).Id , Contact__c = con.Id, Dossier_Constitue_P1__c  = true);
		insert dossier;
        
        Simulation__c simulation = new Simulation__c();
		/*simulation.Name = 'Test Sim';*/
        simulation.Actif__c = FALSE;
        simulation.Contact__c = con.Id;
        simulation.Lead__c = lead.Id;
        simulation.MCI_Sim_ID__c = '1234';
		insert simulation;
		Test.startTest();
        simulation.Actif__c = True;
        update simulation;
        Test.stopTest(); 
        
        Simulation__c simulationTest = [select Actif__c from Simulation__c where Id = :simulation.Id];
        System.assertEquals(simulationTest.Actif__c, true);
        
        List<Simulation__c> simsd = [Select Id , Actif__c from Simulation__c where Actif__c = true ];
        
        system.assertEquals(simsd.size() , 2);
        
        
    }
    
    static testMethod void testUnit3(){  
       Lead lead = [Select Id from Lead limit 1];
       TestFactory.createSimulations(new List<String>{'1232' , '4562' , '4572'} , lead.Id , 'lead__c' , 3 , true);
       List<Simulation__c> simsd = [Select Id , Actif__c from Simulation__c where Actif__c = false and lead__c = :lead.Id ];
        system.debug('***Test Class '+simsd.size());
		Test.startTest();
		Simulation__c simulation = new Simulation__c();
		/*simulation.Name = 'Test Sim';*/
        simulation.Actif__c = FALSE;
        simulation.Lead__c = lead.Id;
        simulation.MCI_Sim_ID__c = '1234';
		insert simulation;
        Test.stopTest(); 
        
        Simulation__c simulationTest = [select Actif__c from Simulation__c where Id = :simsd[0].Id];
        System.assertEquals(simulationTest.Actif__c, false);
        
       simsd = [Select Id , Actif__c from Simulation__c where Actif__c = true  and lead__c = :lead.Id];
        
        system.assertEquals(simsd.size() , 1);
    }
    
    static testMethod void testUnit4(){  
       Lead lead = [Select Id from Lead limit 1];
       TestFactory.createSimulations(new List<String>{'1232' , '4562' , '4572'} , lead.Id , 'lead__c' , 3 , true);
       List<Simulation__c> simsd = [Select Id , Actif__c from Simulation__c where Actif__c = false and lead__c = :lead.Id ];
        system.debug('***Test Class '+simsd.size());
		Test.startTest();
		simsd[0].Actif__c = TRUE;  
        update simsd[0];
        Test.stopTest(); 
        
        Simulation__c simulationTest = [select Actif__c from Simulation__c where Id = :simsd[0].Id];
        System.assertEquals(simulationTest.Actif__c, true);
        
       simsd = [Select Id , Actif__c from Simulation__c where Actif__c = true  and lead__c = :lead.Id];
        
        system.assertEquals(simsd.size() , 1);
    }
}