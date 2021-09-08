public with sharing class Stats_Dossiers_Zak{

public Stats_Dossiers_Zak() {

    }
     public Stats_Dossiers_Zak(ApexPages.StandardController controller) {

    }
  //dossierDepose Zak
public AggregateResult[] dossierDeposeZakToday {
        get {
            return [SELECT  count(Id) depot ,SUM(Montant_du_Financement__c) somme   from Dossier__c where  Date_depot_dossier__c=TODAY and Proprietaire__c ='Zakarya BAGHBOUNI' ];
        }
    }

public AggregateResult[] dossierDeposeZakYESTERDAY {
        get {
            return [SELECT  count(Id) depot ,SUM(Montant_du_Financement__c) somme   from Dossier__c where  Date_depot_dossier__c=YESTERDAY and Proprietaire__c ='Zakarya BAGHBOUNI' ];
        }
    }
    public AggregateResult[] dossierDeposeZakTHISWEEK{
        get {
            return [SELECT  count(Id) depot ,SUM(Montant_du_Financement__c) somme   from Dossier__c where  Date_depot_dossier__c=THIS_WEEK and Proprietaire__c ='Zakarya BAGHBOUNI' ];
        }
    }
      public AggregateResult[] dossierDeposeZakLASTWEEK{
        get {
            return [SELECT  count(Id) depot ,SUM(Montant_du_Financement__c) somme   from Dossier__c where  Date_depot_dossier__c=LAST_WEEK and Proprietaire__c ='Zakarya BAGHBOUNI' ];
        }
    }
      public AggregateResult[] dossierDeposeZakTHISMONTH{
        get {
            return [SELECT  count(Id) depot ,SUM(Montant_du_Financement__c) somme   from Dossier__c where  Date_depot_dossier__c=THIS_MONTH and Proprietaire__c ='Zakarya BAGHBOUNI' ];
        }
     }
    public AggregateResult[] dossierDeposeZakLASTMONTH{
        get {
            return [SELECT  count(Id) depot ,SUM(Montant_du_Financement__c) somme   from Dossier__c where  Date_depot_dossier__c=LAST_MONTH and Proprietaire__c ='Zakarya BAGHBOUNI' ];
        }
    }
    public AggregateResult[] dossierDeposeZakTHISYEAR{
        get {
            return [SELECT  count(Id) depot ,SUM(Montant_du_Financement__c) somme   from Dossier__c where  Date_depot_dossier__c=THIS_YEAR and Proprietaire__c ='Zakarya BAGHBOUNI' ];
        }
    }
    public AggregateResult[] dossierDeposeZakLASTYEAR{
        get {
            return [SELECT  count(Id) depot ,SUM(Montant_du_Financement__c) somme   from Dossier__c where  Date_depot_dossier__c=LAST_YEAR and Proprietaire__c ='Zakarya BAGHBOUNI' ];
        }
    }
    public AggregateResult[] dossierDeposeZakALL{
        get {
            return [SELECT  count(Id) depot ,SUM(Montant_du_Financement__c) somme   from Dossier__c where  Proprietaire__c ='Zakarya BAGHBOUNI' ];
        }
    }
    // Dossier Accepter
    
       public AggregateResult[] dossierAccepteZakTodaY{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme   from Dossier__c where    Date_accord_dossier__c=TODAY and Decision_Banque__c=TRUE and  Proprietaire__c ='Zakarya BAGHBOUNI' ];
        }
    }
 
       public AggregateResult[] dossierAccepteZakYESTERDAY{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme   from Dossier__c where    Date_accord_dossier__c=YESTERDAY and Decision_Banque__c=TRUE and  Proprietaire__c ='Zakarya BAGHBOUNI' ];
        }
    }
     public AggregateResult[] dossierAccepteZakTHISWEEK{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme   from Dossier__c where    Date_accord_dossier__c=THIS_WEEK and Decision_Banque__c=TRUE and  Proprietaire__c ='Zakarya BAGHBOUNI' ];
        }
    }
       public AggregateResult[] dossierAccepteZakLASTWEEK{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme   from Dossier__c where    Date_accord_dossier__c=LAST_WEEK and Decision_Banque__c=TRUE and  Proprietaire__c ='Zakarya BAGHBOUNI' ];
        }
    }
     public AggregateResult[] dossierAccepteZakTHISMONTH{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme   from Dossier__c where    Date_accord_dossier__c=THIS_MONTH and Decision_Banque__c=TRUE and  Proprietaire__c ='Zakarya BAGHBOUNI' ];
        }
    }
     public AggregateResult[] dossierAccepteZakLASTMONTH{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme   from Dossier__c where    Date_accord_dossier__c=LAST_MONTH and Decision_Banque__c=TRUE and  Proprietaire__c ='Zakarya BAGHBOUNI' ];
        }
    }
    public AggregateResult[] dossierAccepteZakTHISYEAR{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme   from Dossier__c where    Date_accord_dossier__c=THIS_YEAR and Decision_Banque__c=TRUE and  Proprietaire__c ='Zakarya BAGHBOUNI' ];
        }
    }
      public AggregateResult[] dossierAccepteZakLASTYEAR{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme   from Dossier__c where    Date_accord_dossier__c=LAST_YEAR and Decision_Banque__c=TRUE and  Proprietaire__c ='Zakarya BAGHBOUNI' ];
        }
    }
    public AggregateResult[] dossierAccepteZakALL{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme   from Dossier__c where    Decision_Banque__c=TRUE and  Proprietaire__c ='Zakarya BAGHBOUNI' ];
        }
    }
      //Dossier Finances par zak
    public AggregateResult[] dossierFinanceZakToday{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme   from Dossier__c where    Date_deblocage__c=TODAY and Dossier_d_bloqu__c=TRUE and  Proprietaire__c ='Zakarya BAGHBOUNI' ];
        }
    }
    
      public AggregateResult[] dossierFinanceZakYesterday{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme   from Dossier__c where    Date_deblocage__c=YESTERDAY and Dossier_d_bloqu__c=TRUE and  Proprietaire__c ='Zakarya BAGHBOUNI' ];
        }
    }
    
      public AggregateResult[] dossierFinanceZakTHISWEEK{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme   from Dossier__c where    Date_deblocage__c=THIS_WEEK and Dossier_d_bloqu__c=TRUE and  Proprietaire__c ='Zakarya BAGHBOUNI' ];
        }
    }
 public AggregateResult[] dossierFinanceZakLASTWEEK{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme   from Dossier__c where    Date_deblocage__c=LAST_WEEK and Dossier_d_bloqu__c=TRUE and  Proprietaire__c ='Zakarya BAGHBOUNI' ];
        }
    }
    
    public AggregateResult[] dossierFinanceZakTHISMONTH{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme   from Dossier__c where    Date_deblocage__c=THIS_MONTH and Dossier_d_bloqu__c=TRUE and  Proprietaire__c ='Zakarya BAGHBOUNI' ];
        }
    }
      public AggregateResult[] dossierFinanceZakLASTMONTH{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme   from Dossier__c where    Date_deblocage__c=LAST_MONTH and Dossier_d_bloqu__c=TRUE and  Proprietaire__c ='Zakarya BAGHBOUNI' ];
        }
    }
         
      public AggregateResult[] dossierFinanceZakTHISYEAR{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme   from Dossier__c where    Date_deblocage__c=THIS_YEAR and Dossier_d_bloqu__c=TRUE and  Proprietaire__c ='Zakarya BAGHBOUNI' ];
        }
    }
             public AggregateResult[] dossierFinanceZakLASTYEAR{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme   from Dossier__c where    Date_deblocage__c=LAST_YEAR and Dossier_d_bloqu__c=TRUE and  Proprietaire__c ='Zakarya BAGHBOUNI' ];
        }
    }  
        public AggregateResult[] dossierFinanceZakALL{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme   from Dossier__c where Dossier_d_bloqu__c=TRUE and  Proprietaire__c ='Zakarya BAGHBOUNI' ];
        }
    }  
    // Dossier facturer
     public AggregateResult[] dossierFactureZakToday{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme    from Dossier__c where    Date_d_p_t_facture__c=TODAY and Facture_deposee__c=TRUE and Proprietaire__c  ='Zakarya BAGHBOUNI' ];
        }
    }  
      public AggregateResult[] dossierFactureZakYESTERDAY{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme    from Dossier__c where    Date_d_p_t_facture__c=YESTERDAY and Facture_deposee__c=TRUE and Proprietaire__c  ='Zakarya BAGHBOUNI' ];
        }
    }  
      public AggregateResult[] dossierFactureZakTHISWEEK{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme    from Dossier__c where    Date_d_p_t_facture__c=THIS_WEEK and Facture_deposee__c=TRUE and Proprietaire__c  ='Zakarya BAGHBOUNI' ];
        }
    }  
          public AggregateResult[] dossierFactureZakLASTWEEK{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme    from Dossier__c where    Date_d_p_t_facture__c=LAST_WEEK and Facture_deposee__c=TRUE and Proprietaire__c  ='Zakarya BAGHBOUNI' ];
        }
    }  
         public AggregateResult[] dossierFactureZakTHISMONTH{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme    from Dossier__c where    Date_d_p_t_facture__c=THIS_MONTH and Facture_deposee__c=TRUE and Proprietaire__c  ='Zakarya BAGHBOUNI' ];
        }
    }  
        public AggregateResult[] dossierFactureZakLASTMONTH{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme    from Dossier__c where    Date_d_p_t_facture__c=LAST_MONTH and Facture_deposee__c=TRUE and Proprietaire__c  ='Zakarya BAGHBOUNI' ];
        }
    }  
    public AggregateResult[] dossierFactureZakTHISYEAR{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme    from Dossier__c where    Date_d_p_t_facture__c=THIS_YEAR and Facture_deposee__c=TRUE and Proprietaire__c  ='Zakarya BAGHBOUNI' ];
        }
    }  
    
        public AggregateResult[] dossierFactureZakLASTYEAR{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme    from Dossier__c where    Date_d_p_t_facture__c=LAST_YEAR and Facture_deposee__c=TRUE and Proprietaire__c  ='Zakarya BAGHBOUNI' ];
        }
    }  
   public AggregateResult[] dossierFactureZakALL{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme    from Dossier__c where    Facture_deposee__c=TRUE and Proprietaire__c  ='Zakarya BAGHBOUNI' ];
        }
    }  
    //Payes

public AggregateResult[] dossierPayeZakTODAY{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme    from  Dossier__c where     Date_Paiement_Facture__c=TODAY and Facture_Payee__c=TRUE and Proprietaire__c  ='Zakarya BAGHBOUNI' ];
        }
    }  
public AggregateResult[] dossierPayeZakYESTERDAY{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme    from  Dossier__c where     Date_Paiement_Facture__c=YESTERDAY and Facture_Payee__c=TRUE and Proprietaire__c  ='Zakarya BAGHBOUNI' ];
        }
    }  

 
public AggregateResult[] dossierPayeZakTHISWEEK{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme    from  Dossier__c where     Date_Paiement_Facture__c=THIS_WEEK and Facture_Payee__c=TRUE and Proprietaire__c  ='Zakarya BAGHBOUNI' ];
        }
    }  
public AggregateResult[] dossierPayeZakLASTWEEK{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme    from  Dossier__c where     Date_Paiement_Facture__c=LAST_WEEK and Facture_Payee__c=TRUE and Proprietaire__c  ='Zakarya BAGHBOUNI' ];
        }
    }  
    public AggregateResult[] dossierPayeZakTHISMONTH{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme    from  Dossier__c where     Date_Paiement_Facture__c=THIS_MONTH and Facture_Payee__c=TRUE and Proprietaire__c  ='Zakarya BAGHBOUNI' ];
        }
    }
     public AggregateResult[] dossierPayeZakLASTMONTH{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme    from  Dossier__c where     Date_Paiement_Facture__c=LAST_MONTH and Facture_Payee__c=TRUE and Proprietaire__c  ='Zakarya BAGHBOUNI' ];
        }
        }
         public AggregateResult[] dossierPayeZakTHISYEAR{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme    from  Dossier__c where     Date_Paiement_Facture__c=THIS_YEAR and Facture_Payee__c=TRUE and Proprietaire__c  ='Zakarya BAGHBOUNI' ];
        }
    }
        public AggregateResult[] dossierPayeZakLASTYEAR{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme    from  Dossier__c where     Date_Paiement_Facture__c=LAST_YEAR and Facture_Payee__c=TRUE and Proprietaire__c  ='Zakarya BAGHBOUNI' ];
        }
    }
 public AggregateResult[] dossierPayeZakALL{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme    from  Dossier__c where     Facture_Payee__c=TRUE and Proprietaire__c  ='Zakarya BAGHBOUNI' ];
        }
    }
  
}