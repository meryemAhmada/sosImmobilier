public with sharing class Stats_Dossiers{

 public Stats_Dossiers() {

    }
     public Stats_Dossiers(ApexPages.StandardController controller) {

    }
    //dossierDepose Omar
public AggregateResult[] dossierDeposeOmarToday {
        get {
        System.debug('The value is: ');
            return [SELECT  count(Id) depot ,SUM(Montant_du_Financement__c) somme   from Dossier__c where  Date_depot_dossier__c=TODAY and Proprietaire__c ='Omar BENZHA' ];
        }
    }

public AggregateResult[] dossierDeposeOmarYESTERDAY {
        get {
            return [SELECT  count(Id) depot ,SUM(Montant_du_Financement__c) somme   from Dossier__c where  Date_depot_dossier__c=YESTERDAY and Proprietaire__c ='Omar BENZHA' ];
        }
    }
    public AggregateResult[] dossierDeposeOmarTHISWEEK{
        get {
            return [SELECT  count(Id) depot ,SUM(Montant_du_Financement__c) somme   from Dossier__c where  Date_depot_dossier__c=THIS_WEEK and Proprietaire__c ='Omar BENZHA' ];
        }
    }
      public AggregateResult[] dossierDeposeOmarLASTWEEK{
        get {
            return [SELECT  count(Id) depot ,SUM(Montant_du_Financement__c) somme   from Dossier__c where  Date_depot_dossier__c=LAST_WEEK and Proprietaire__c ='Omar BENZHA' ];
        }
    }
      public AggregateResult[] dossierDeposeOmarTHISMONTH{
        get {
            return [SELECT  count(Id) depot ,SUM(Montant_du_Financement__c) somme   from Dossier__c where  Date_depot_dossier__c=THIS_MONTH and Proprietaire__c ='Omar BENZHA' ];
        }
     }
    public AggregateResult[] dossierDeposeOmarLASTMONTH{
        get {
            return [SELECT  count(Id) depot ,SUM(Montant_du_Financement__c) somme   from Dossier__c where  Date_depot_dossier__c=LAST_MONTH and Proprietaire__c ='Omar BENZHA' ];
        }
    }
    public AggregateResult[] dossierDeposeOmarTHISYEAR{
        get {
            return [SELECT  count(Id) depot ,SUM(Montant_du_Financement__c) somme   from Dossier__c where  Date_depot_dossier__c=THIS_YEAR and Proprietaire__c ='Omar BENZHA' ];
        }
    }
    public AggregateResult[] dossierDeposeOmarLASTYEAR{
        get {
            return [SELECT  count(Id) depot ,SUM(Montant_du_Financement__c) somme   from Dossier__c where  Date_depot_dossier__c=LAST_YEAR and Proprietaire__c ='Omar BENZHA' ];
        }
    }
    public AggregateResult[] dossierDeposeOmarALL{
        get {
            return [SELECT  count(Id) depot ,SUM(Montant_du_Financement__c) somme   from Dossier__c where  Proprietaire__c ='Omar BENZHA' ];
        }
    }
    // Dossier Accepter
    
       public AggregateResult[] dossierAccepteOmarTodaY{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme   from Dossier__c where    Date_accord_dossier__c=TODAY and Decision_Banque__c=TRUE and  Proprietaire__c ='Omar BENZHA' ];
        }
    }
 
       public AggregateResult[] dossierAccepteOmarYESTERDAY{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme   from Dossier__c where    Date_accord_dossier__c=YESTERDAY and Decision_Banque__c=TRUE and  Proprietaire__c ='Omar BENZHA' ];
        }
    }
     public AggregateResult[] dossierAccepteOmarTHISWEEK{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme   from Dossier__c where    Date_accord_dossier__c=THIS_WEEK and Decision_Banque__c=TRUE and  Proprietaire__c ='Omar BENZHA' ];
        }
    }
       public AggregateResult[] dossierAccepteOmarLASTWEEK{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme   from Dossier__c where    Date_accord_dossier__c=LAST_WEEK and Decision_Banque__c=TRUE and  Proprietaire__c ='Omar BENZHA' ];
        }
    }
     public AggregateResult[] dossierAccepteOmarTHISMONTH{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme   from Dossier__c where    Date_accord_dossier__c=THIS_MONTH and Decision_Banque__c=TRUE and  Proprietaire__c ='Omar BENZHA' ];
        }
    }
     public AggregateResult[] dossierAccepteOmarLASTMONTH{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme   from Dossier__c where    Date_accord_dossier__c=LAST_MONTH and Decision_Banque__c=TRUE and  Proprietaire__c ='Omar BENZHA' ];
        }
    }
    public AggregateResult[] dossierAccepteOmarTHISYEAR{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme   from Dossier__c where    Date_accord_dossier__c=THIS_YEAR and Decision_Banque__c=TRUE and  Proprietaire__c ='Omar BENZHA' ];
        }
    }
      public AggregateResult[] dossierAccepteOmarLASTYEAR{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme   from Dossier__c where    Date_accord_dossier__c=LAST_YEAR and Decision_Banque__c=TRUE and  Proprietaire__c ='Omar BENZHA' ];
        }
    }
    public AggregateResult[] dossierAccepteOmarALL{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme   from Dossier__c where    Decision_Banque__c=TRUE and  Proprietaire__c ='Omar BENZHA' ];
        }
    }
    //Dossier Finances par omar
    public AggregateResult[] dossierFinanceOmarToday{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme   from Dossier__c where    Date_deblocage__c=TODAY and Dossier_d_bloqu__c=TRUE and  Proprietaire__c ='Omar BENZHA' ];
        }
    }
    
      public AggregateResult[] dossierFinanceOmarYesterday{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme   from Dossier__c where    Date_deblocage__c=YESTERDAY and Dossier_d_bloqu__c=TRUE and  Proprietaire__c ='Omar BENZHA' ];
        }
    }
    
      public AggregateResult[] dossierFinanceOmarTHISWEEK{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme   from Dossier__c where    Date_deblocage__c=THIS_WEEK and Dossier_d_bloqu__c=TRUE and  Proprietaire__c ='Omar BENZHA' ];
        }
    }
 public AggregateResult[] dossierFinanceOmarLASTWEEK{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme   from Dossier__c where    Date_deblocage__c=LAST_WEEK and Dossier_d_bloqu__c=TRUE and  Proprietaire__c ='Omar BENZHA' ];
        }
    }
    
    public AggregateResult[] dossierFinanceOmarTHISMONTH{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme   from Dossier__c where    Date_deblocage__c=THIS_MONTH and Dossier_d_bloqu__c=TRUE and  Proprietaire__c ='Omar BENZHA' ];
        }
    }
      public AggregateResult[] dossierFinanceOmarLASTMONTH{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme   from Dossier__c where    Date_deblocage__c=LAST_MONTH and Dossier_d_bloqu__c=TRUE and  Proprietaire__c ='Omar BENZHA' ];
        }
    }
         
      public AggregateResult[] dossierFinanceOmarTHISYEAR{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme   from Dossier__c where    Date_deblocage__c=THIS_YEAR and Dossier_d_bloqu__c=TRUE and  Proprietaire__c ='Omar BENZHA' ];
        }
    }
             public AggregateResult[] dossierFinanceOmarLASTYEAR{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme   from Dossier__c where    Date_deblocage__c=LAST_YEAR and Dossier_d_bloqu__c=TRUE and  Proprietaire__c ='Omar BENZHA' ];
        }
    }  
        public AggregateResult[] dossierFinanceOmarALL{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme   from Dossier__c where Dossier_d_bloqu__c=TRUE and  Proprietaire__c ='Omar BENZHA' ];
        }
    }  
    
    // Dossier facturer
     public AggregateResult[] dossierFactureOmarToday{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme    from Dossier__c where    Date_d_p_t_facture__c=TODAY and Facture_deposee__c=TRUE and Proprietaire__c  ='Omar BENZHA' ];
        }
    }  
      public AggregateResult[] dossierFactureOmarYESTERDAY{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme    from Dossier__c where    Date_d_p_t_facture__c=YESTERDAY and Facture_deposee__c=TRUE and Proprietaire__c  ='Omar BENZHA' ];
        }
    }  
      public AggregateResult[] dossierFactureOmarTHISWEEK{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme    from Dossier__c where    Date_d_p_t_facture__c=THIS_WEEK and Facture_deposee__c=TRUE and Proprietaire__c  ='Omar BENZHA' ];
        }
    }  
          public AggregateResult[] dossierFactureOmarLASTWEEK{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme    from Dossier__c where    Date_d_p_t_facture__c=LAST_WEEK and Facture_deposee__c=TRUE and Proprietaire__c  ='Omar BENZHA' ];
        }
    }  
         public AggregateResult[] dossierFactureOmarTHISMONTH{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme    from Dossier__c where    Date_d_p_t_facture__c=THIS_MONTH and Facture_deposee__c=TRUE and Proprietaire__c  ='Omar BENZHA' ];
        }
    }  
        public AggregateResult[] dossierFactureOmarLASTMONTH{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme    from Dossier__c where    Date_d_p_t_facture__c=LAST_MONTH and Facture_deposee__c=TRUE and Proprietaire__c  ='Omar BENZHA' ];
        }
    }  
    public AggregateResult[] dossierFactureOmarTHISYEAR{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme    from Dossier__c where    Date_d_p_t_facture__c=THIS_YEAR and Facture_deposee__c=TRUE and Proprietaire__c  ='Omar BENZHA' ];
        }
    }  
    
        public AggregateResult[] dossierFactureOmarLASTYEAR{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme    from Dossier__c where    Date_d_p_t_facture__c=LAST_YEAR and Facture_deposee__c=TRUE and Proprietaire__c  ='Omar BENZHA' ];
        }
    }  
   public AggregateResult[] dossierFactureOmarALL{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme    from Dossier__c where    Facture_deposee__c=TRUE and Proprietaire__c  ='Omar BENZHA' ];
        }
    }  
//Payes

public AggregateResult[] dossierPayeOmarTODAY{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme    from  Dossier__c where     Date_Paiement_Facture__c=TODAY and Facture_Payee__c=TRUE and Proprietaire__c  ='Omar BENZHA' ];
        }
    }  
public AggregateResult[] dossierPayeOmarYESTERDAY{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme    from  Dossier__c where     Date_Paiement_Facture__c=YESTERDAY and Facture_Payee__c=TRUE and Proprietaire__c  ='Omar BENZHA' ];
        }
    }  

 
public AggregateResult[] dossierPayeOmarTHISWEEK{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme    from  Dossier__c where     Date_Paiement_Facture__c=THIS_WEEK and Facture_Payee__c=TRUE and Proprietaire__c  ='Omar BENZHA' ];
        }
    }  
public AggregateResult[] dossierPayeOmarLASTWEEK{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme    from  Dossier__c where     Date_Paiement_Facture__c=LAST_WEEK and Facture_Payee__c=TRUE and Proprietaire__c  ='Omar BENZHA' ];
        }
    }  
    public AggregateResult[] dossierPayeOmarTHISMONTH{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme    from  Dossier__c where     Date_Paiement_Facture__c=THIS_MONTH and Facture_Payee__c=TRUE and Proprietaire__c  ='Omar BENZHA' ];
        }
    }
     public AggregateResult[] dossierPayeOmarLASTMONTH{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme    from  Dossier__c where     Date_Paiement_Facture__c=LAST_MONTH and Facture_Payee__c=TRUE and Proprietaire__c  ='Omar BENZHA' ];
        }
        }
         public AggregateResult[] dossierPayeOmarTHISYEAR{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme    from  Dossier__c where     Date_Paiement_Facture__c=THIS_YEAR and Facture_Payee__c=TRUE and Proprietaire__c  ='Omar BENZHA' ];
        }
    }
        public AggregateResult[] dossierPayeOmarLASTYEAR{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme    from  Dossier__c where     Date_Paiement_Facture__c=LAST_YEAR and Facture_Payee__c=TRUE and Proprietaire__c  ='Omar BENZHA' ];
        }
    }
 public AggregateResult[] dossierPayeOmarALL{
        get {
            return [SELECT  count(Id) accepte ,SUM(Montant_du_Financement__c) somme    from  Dossier__c where     Facture_Payee__c=TRUE and Proprietaire__c  ='Omar BENZHA' ];
        }
    }
    
    
}