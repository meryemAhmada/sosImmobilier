public with sharing class Stats_Dossiers_Total{

public Stats_Dossiers_Total() {

    }
     public Stats_Dossiers_Total(ApexPages.StandardController controller) {

    }
    
  
public AggregateResult[] dossierDeposeToday{
        get {
            return [SELECT  count(Id) depot ,SUM(Montant_du_Financement__c) somme   from Dossier__c where Date_depot_dossier__c=TODAY and  Proprietaire__c in('Omar BENZHA','Zakarya BAGHBOUNI') ];
        }
    }    
    public AggregateResult[] dossierDeposeYesterday{
        get {
            return [SELECT  count(Id) depot ,SUM(Montant_du_Financement__c) somme   from Dossier__c where Date_depot_dossier__c=YESTERDAY and  Proprietaire__c in('Omar BENZHA','Zakarya BAGHBOUNI') ];
        }
    }    
    
    public AggregateResult[] dossierDeposeTHISWEEK{
        get {
            return [SELECT  count(Id) depot ,SUM(Montant_du_Financement__c) somme   from Dossier__c where  Date_depot_dossier__c=THIS_WEEK and Proprietaire__c in('Omar BENZHA','Zakarya BAGHBOUNI') ];
        }
    }
      public AggregateResult[] dossierDeposeLASTWEEK{
        get {
            return [SELECT  count(Id) depot ,SUM(Montant_du_Financement__c) somme   from Dossier__c where  Date_depot_dossier__c=LAST_WEEK and Proprietaire__c in('Omar BENZHA','Zakarya BAGHBOUNI') ];
        }
    }
      public AggregateResult[] dossierDeposeTHISMONTH{
        get {
            return [SELECT  count(Id) depot ,SUM(Montant_du_Financement__c) somme   from Dossier__c where  Date_depot_dossier__c=THIS_MONTH and Proprietaire__c in('Omar BENZHA','Zakarya BAGHBOUNI') ];
        }
     }
    public AggregateResult[] dossierDeposeLASTMONTH{
        get {
            return [SELECT  count(Id) depot ,SUM(Montant_du_Financement__c) somme   from Dossier__c where  Date_depot_dossier__c=LAST_MONTH and Proprietaire__c in('Omar BENZHA','Zakarya BAGHBOUNI') ];
        }
    }
    public AggregateResult[] dossierDeposeTHISYEAR{
        get {
            return [SELECT  count(Id) depot ,SUM(Montant_du_Financement__c) somme   from Dossier__c where  Date_depot_dossier__c=THIS_YEAR and Proprietaire__c in('Omar BENZHA','Zakarya BAGHBOUNI') ];
        }
    }
    public AggregateResult[] dossierDeposeLASTYEAR{
        get {
            return [SELECT  count(Id) depot ,SUM(Montant_du_Financement__c) somme   from Dossier__c where  Date_depot_dossier__c=LAST_YEAR and Proprietaire__c in('Omar BENZHA','Zakarya BAGHBOUNI') ];
        }
    }
public AggregateResult[] dossierDeposeTotal{
        get {
            return [SELECT  count(Id) depot , SUM(Montant_du_Financement__c) somme   from Dossier__c where  Proprietaire__c in('Omar BENZHA','Zakarya BAGHBOUNI') ];
        }
    }
//Dossier Accepter

     public AggregateResult[] dossierAcceptekTodaY{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme   from Dossier__c where    Date_accord_dossier__c=TODAY and Decision_Banque__c=TRUE and  Proprietaire__c in('Omar BENZHA','Zakarya BAGHBOUNI') ];
        }
    }
 
       public AggregateResult[] dossierAcceptekYESTERDAY{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme   from Dossier__c where    Date_accord_dossier__c=YESTERDAY and Decision_Banque__c=TRUE and  Proprietaire__c in('Omar BENZHA','Zakarya BAGHBOUNI') ];
        }
    }
     public AggregateResult[] dossierAcceptekTHISWEEK{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme   from Dossier__c where    Date_accord_dossier__c=THIS_WEEK and Decision_Banque__c=TRUE and  Proprietaire__c in('Omar BENZHA','Zakarya BAGHBOUNI') ];
        }
    }
       public AggregateResult[] dossierAcceptekLASTWEEK{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme   from Dossier__c where    Date_accord_dossier__c=LAST_WEEK and Decision_Banque__c=TRUE and  Proprietaire__c in('Omar BENZHA','Zakarya BAGHBOUNI') ];
        }
    }
     public AggregateResult[] dossierAcepteTHISMONTH{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme   from Dossier__c where    Date_accord_dossier__c=THIS_MONTH and Decision_Banque__c=TRUE and  Proprietaire__c in('Omar BENZHA','Zakarya BAGHBOUNI') ];
        }
    }
     public AggregateResult[] dossierAcceptekLASTMONTH{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme   from Dossier__c where    Date_accord_dossier__c=LAST_MONTH and Decision_Banque__c=TRUE and  Proprietaire__c in('Omar BENZHA','Zakarya BAGHBOUNI') ];
        }
    }
    public AggregateResult[] dossierAcceptekTHISYEAR{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme   from Dossier__c where    Date_accord_dossier__c=THIS_YEAR and Decision_Banque__c=TRUE and  Proprietaire__c in('Omar BENZHA','Zakarya BAGHBOUNI') ];
        }
    }
      public AggregateResult[] dossierAcceptekLASTYEAR{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme   from Dossier__c where    Date_accord_dossier__c=LAST_YEAR and Decision_Banque__c=TRUE and  Proprietaire__c in('Omar BENZHA','Zakarya BAGHBOUNI') ];
        }
    }
    public AggregateResult[] dossierAcceptekALL{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme   from Dossier__c where    Decision_Banque__c=TRUE and  Proprietaire__c in('Omar BENZHA','Zakarya BAGHBOUNI') ];
        }
    }
    //dossier finance total
    public AggregateResult[] dossierFinanceToday{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme   from Dossier__c where    Date_deblocage__c=TODAY and Dossier_d_bloqu__c=TRUE and  Proprietaire__c in('Omar BENZHA','Zakarya BAGHBOUNI') ];
        }
    }
    
      public AggregateResult[] dossierFinanceYesterday{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme   from Dossier__c where    Date_deblocage__c=YESTERDAY and Dossier_d_bloqu__c=TRUE and  Proprietaire__c in('Omar BENZHA','Zakarya BAGHBOUNI') ];
        }
    }
    
      public AggregateResult[] dossierFinanceTHISWEEK{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme   from Dossier__c where    Date_deblocage__c=THIS_WEEK and Dossier_d_bloqu__c=TRUE and  Proprietaire__c in('Omar BENZHA','Zakarya BAGHBOUNI') ];
        }
    }
 public AggregateResult[] dossierFinanceLASTWEEK{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme   from Dossier__c where    Date_deblocage__c=LAST_WEEK and Dossier_d_bloqu__c=TRUE and  Proprietaire__c in('Omar BENZHA','Zakarya BAGHBOUNI') ];
        }
    }
    
    public AggregateResult[] dossierFinanceTHISMONTH{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme   from Dossier__c where    Date_deblocage__c=THIS_MONTH and Dossier_d_bloqu__c=TRUE and  Proprietaire__c in('Omar BENZHA','Zakarya BAGHBOUNI') ];
        }
    }
      public AggregateResult[] dossierFinanceLASTMONTH{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme   from Dossier__c where    Date_deblocage__c=LAST_MONTH and Dossier_d_bloqu__c=TRUE and  Proprietaire__c in('Omar BENZHA','Zakarya BAGHBOUNI') ];
        }
    }
         
      public AggregateResult[] dossierFinanceTHISYEAR{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme   from Dossier__c where    Date_deblocage__c=THIS_YEAR and Dossier_d_bloqu__c=TRUE and  Proprietaire__c in('Omar BENZHA','Zakarya BAGHBOUNI') ];
        }
    }
             public AggregateResult[] dossierFinanceLASTYEAR{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme   from Dossier__c where    Date_deblocage__c=LAST_YEAR and Dossier_d_bloqu__c=TRUE and  Proprietaire__c in('Omar BENZHA','Zakarya BAGHBOUNI') ];
        }
    }  
        public AggregateResult[] dossierFinanceALL{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme   from Dossier__c where Dossier_d_bloqu__c=TRUE and  Proprietaire__c in('Omar BENZHA','Zakarya BAGHBOUNI') ];
        }
    }  
    //Dossier facturer
    public AggregateResult[] dossierFactureToday{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme    from Dossier__c where    Date_d_p_t_facture__c=TODAY and Facture_deposee__c=TRUE and Proprietaire__c in('Omar BENZHA','Zakarya BAGHBOUNI') ];
        }
    }  
      public AggregateResult[] dossierFactureYESTERDAY{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme    from Dossier__c where    Date_d_p_t_facture__c=YESTERDAY and Facture_deposee__c=TRUE and Proprietaire__c in('Omar BENZHA','Zakarya BAGHBOUNI') ];
        }
    }  
      public AggregateResult[] dossierFactureTHISWEEK{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme    from Dossier__c where    Date_d_p_t_facture__c=THIS_WEEK and Facture_deposee__c=TRUE and Proprietaire__c in('Omar BENZHA','Zakarya BAGHBOUNI') ];
        }
    }  
          public AggregateResult[] dossierFactureLASTWEEK{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme    from Dossier__c where    Date_d_p_t_facture__c=LAST_WEEK and Facture_deposee__c=TRUE and Proprietaire__c in('Omar BENZHA','Zakarya BAGHBOUNI') ];
        }
    }  
         public AggregateResult[] dossierFactureTHISMONTH{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme    from Dossier__c where    Date_d_p_t_facture__c=THIS_MONTH and Facture_deposee__c=TRUE and Proprietaire__c in('Omar BENZHA','Zakarya BAGHBOUNI') ];
        }
    }  
        public AggregateResult[] dossierFactureLASTMONTH{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme    from Dossier__c where    Date_d_p_t_facture__c=LAST_MONTH and Facture_deposee__c=TRUE and Proprietaire__c in('Omar BENZHA','Zakarya BAGHBOUNI') ];
        }
    }  
    public AggregateResult[] dossierFactureTHISYEAR{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme    from Dossier__c where    Date_d_p_t_facture__c=THIS_YEAR and Facture_deposee__c=TRUE and Proprietaire__c in('Omar BENZHA','Zakarya BAGHBOUNI') ];
        }
    }  
    
        public AggregateResult[] dossierFactureLASTYEAR{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme    from Dossier__c where    Date_d_p_t_facture__c=LAST_YEAR and Facture_deposee__c=TRUE and Proprietaire__c in('Omar BENZHA','Zakarya BAGHBOUNI') ];
        }
    }  
   public AggregateResult[] dossierFactureALL{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme    from Dossier__c where    Facture_deposee__c=TRUE and Proprietaire__c in('Omar BENZHA','Zakarya BAGHBOUNI') ];
        }
    } 
    //dossier pay all
    public AggregateResult[] dossierPayeTODAY{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme    from  Dossier__c where     Date_Paiement_Facture__c=TODAY and Facture_Payee__c=TRUE and  Proprietaire__c in('Omar BENZHA','Zakarya BAGHBOUNI') ];
        }
    }  
public AggregateResult[] dossierPayeYESTERDAY{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme    from  Dossier__c where     Date_Paiement_Facture__c=YESTERDAY and Facture_Payee__c=TRUE and  Proprietaire__c in('Omar BENZHA','Zakarya BAGHBOUNI') ];
        }
    }  

 
public AggregateResult[] dossierPayeTHISWEEK{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme    from  Dossier__c where     Date_Paiement_Facture__c=THIS_WEEK and Facture_Payee__c=TRUE and  Proprietaire__c in('Omar BENZHA','Zakarya BAGHBOUNI') ];
        }
    }  
public AggregateResult[] dossierPayeLASTWEEK{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme    from  Dossier__c where     Date_Paiement_Facture__c=LAST_WEEK and Facture_Payee__c=TRUE and  Proprietaire__c in('Omar BENZHA','Zakarya BAGHBOUNI') ];
        }
    }  
    public AggregateResult[] dossierPayeTHISMONTH{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme    from  Dossier__c where     Date_Paiement_Facture__c=THIS_MONTH and Facture_Payee__c=TRUE and  Proprietaire__c in('Omar BENZHA','Zakarya BAGHBOUNI') ];
        }
    }
     public AggregateResult[] dossierPayeLASTMONTH{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme    from  Dossier__c where     Date_Paiement_Facture__c=LAST_MONTH and Facture_Payee__c=TRUE and  Proprietaire__c in('Omar BENZHA','Zakarya BAGHBOUNI') ];
        }
        }
         public AggregateResult[] dossierPayeTHISYEAR{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme    from  Dossier__c where     Date_Paiement_Facture__c=THIS_YEAR and Facture_Payee__c=TRUE and  Proprietaire__c in('Omar BENZHA','Zakarya BAGHBOUNI') ];
        }
    }
        public AggregateResult[] dossierPayeLASTYEAR{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme    from  Dossier__c where     Date_Paiement_Facture__c=LAST_YEAR and Facture_Payee__c=TRUE and  Proprietaire__c in('Omar BENZHA','Zakarya BAGHBOUNI') ];
        }
    }
 public AggregateResult[] dossierPayeALL{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme    from  Dossier__c where     Facture_Payee__c=TRUE and  Proprietaire__c in('Omar BENZHA','Zakarya BAGHBOUNI') ];
        }
    }
}