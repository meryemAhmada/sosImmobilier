public with sharing class Stats_sos {

    
   
   public Stats_sos() {

    }
    
   
      // dossier generer
        public AggregateResult[] results {
        get {
            return [SELECT  count(Id) leads_generes_today from Lead where  CreatedDate=TODAY and   (Source__c='Siteweb SOS' or Source__c='Facebook')];
        }
    }
    
            public AggregateResult[] leadsGeneresYesterday {
        get {
            return [SELECT  count(Id) leads_generes_yesterday from Lead where  CreatedDate=YESTERDAY and   (Source__c='Siteweb SOS' or Source__c='Facebook')];
        }
    }
    
    

        public AggregateResult[] leadsGeneresThisWeek {
        get {
            return [SELECT  count(Id) leads_generes_thisWEEK from Lead where  CreatedDate=THIS_WEEK and   (Source__c='Siteweb SOS' or Source__c='Facebook')];
        }
    }
    
      public AggregateResult[] leadsGeneresLASTWEEK {
        get {
            return [SELECT  count(Id) leads_generes_LAST_WEEK from Lead where  CreatedDate=LAST_WEEK and   (Source__c='Siteweb SOS' or Source__c='Facebook')];
        }
    }
    
      public AggregateResult[] leadsGeneresTHISMONTH {
        get {
            return [SELECT  count(Id) leads_generes_THIS_MONTH from Lead where  CreatedDate=THIS_MONTH and   (Source__c='Siteweb SOS' or Source__c='Facebook')];
        }
    }
    
         public AggregateResult[] leadsGeneresLASTMONTH {
        get {
            return [SELECT  count(Id) leads_generes_LAST_MONTH from Lead where  CreatedDate=LAST_MONTH and   (Source__c='Siteweb SOS' or Source__c='Facebook')];
        }
    }
    
         public AggregateResult[] leadsGeneresTHISYEAR{
        get {
            return [SELECT  count(Id) leads_generes_THIS_YEAR from Lead where  CreatedDate=THIS_YEAR and   (Source__c='Siteweb SOS' or Source__c='Facebook')];
        }
    }
    
         public AggregateResult[] leadsGeneresLASTYEAR{
        get {
            return [SELECT  count(Id) leads_generes_LAST_YEAR from Lead where  CreatedDate=LAST_YEAR and   (Source__c='Siteweb SOS' or Source__c='Facebook')];
        }
    }
    
    
         public AggregateResult[] leadstraiteToday{
        get {
            return [SELECT  count(Id) leads_traite_Today from Lead where Status != 'Open' and (Source__c='Siteweb SOS' or Source__c='Facebook') and LastModifiedDate=TODAY];
        }
    }
     
      public AggregateResult[] leadstraiteYesterday{
        get {
            return [SELECT  count(Id) leads_traite_YESTERDAY from Lead where Status != 'Open' and (Source__c='Siteweb SOS' or Source__c='Facebook') and LastModifiedDate=YESTERDAY];
        }
    }
    
       public AggregateResult[] leadstraiteTHISWEEK{
        get {
            return [SELECT  count(Id) leads_traite_THIS_WEEK from Lead where Status != 'Open' and (Source__c='Siteweb SOS' or Source__c='Facebook') and LastModifiedDate=THIS_WEEK];
        }
    }
    
         public AggregateResult[] leadstraiteLASTWEEK{
        get {
            return [SELECT  count(Id) leads_traite_LAST_WEEK from Lead where Status != 'Open' and (Source__c='Siteweb SOS' or Source__c='Facebook') and LastModifiedDate=LAST_WEEK];
        }
    }
    
    
          public AggregateResult[] leadstraiteTHISMONTH{
        get {
            return [SELECT  count(Id) leads_traite_THIS_MONTH from Lead where Status != 'Open' and (Source__c='Siteweb SOS' or Source__c='Facebook') and LastModifiedDate=THIS_MONTH];
        }
    }
    
       public AggregateResult[] leadstraiteLASTMONTH{
        get {
            return [SELECT  count(Id) leads_traite_LAST_MONTH from Lead where Status != 'Open' and (Source__c='Siteweb SOS' or Source__c='Facebook') and LastModifiedDate=LAST_MONTH];
        }
    }
    
    
    
       public AggregateResult[] leadstraiteTHISYEAR{
        get {
            return [SELECT  count(Id) leads_traite_THIS_YEAR from Lead where Status != 'Open' and (Source__c='Siteweb SOS' or Source__c='Facebook') and LastModifiedDate=THIS_YEAR];
        }
    }
    
      public AggregateResult[] leadstraiteLASTYEAR{
        get {
            return [SELECT  count(Id) leads_traite_LAST_YEAR from Lead where Status != 'Open' and (Source__c='Siteweb SOS' or Source__c='Facebook') and LastModifiedDate=LAST_YEAR];
        }
    }
    
      public AggregateResult[] leadsqualifToday{
        get {
            return [SELECT  count(Id) leads_qualif_Today from Lead where Status= 'Qualifié' and (Source__c='Siteweb SOS' or Source__c='Facebook')  and ConvertedDate=TODAY ];
        }
    }
    
    ////////
    
       public AggregateResult[] leadsqualifYesterday{
        get {
            return [SELECT  count(Id) leads_qualif_YESTERDAY from Lead where Status= 'Qualifié' and (Source__c='Siteweb SOS' or Source__c='Facebook')  and ConvertedDate=YESTERDAY ];
        }
    }
    
        public AggregateResult[] leadsqualifTHISWEEK{
        get {
            return [SELECT  count(Id) leads_qualif_THIS_WEEK  from Lead where Status= 'Qualifié' and (Source__c='Siteweb SOS' or Source__c='Facebook')  and ConvertedDate=THIS_WEEK ];
        }
    }
    
        public AggregateResult[] leadsqualifLASTWEEK{
        get {
            return [SELECT  count(Id) leads_qualif_LAST_WEEK from Lead where Status= 'Qualifié' and (Source__c='Siteweb SOS' or Source__c='Facebook')  and ConvertedDate=LAST_WEEK ]; 
        }
    }
         public AggregateResult[] leadsqualifTHISMONTH{
        get {
            return [SELECT  count(Id) leads_qualif_THIS_MONTH from Lead where Status= 'Qualifié' and (Source__c='Siteweb SOS' or Source__c='Facebook')  and ConvertedDate=THIS_MONTH ];
        }
    }
    
       public AggregateResult[] leadsqualifLASTMONTH{
        get {
            return [SELECT  count(Id) leads_qualif_LAST_MONTH from Lead where Status= 'Qualifié' and (Source__c='Siteweb SOS' or Source__c='Facebook')  and ConvertedDate=LAST_MONTH ];
        }
    }
    
       public AggregateResult[] leadsqualifTHISYEAR{
        get {
            return [SELECT  count(Id) leads_qualif_THIS_YEAR from Lead where Status= 'Qualifié' and (Source__c='Siteweb SOS' or Source__c='Facebook')  and ConvertedDate=THIS_YEAR ];
        }
    }
    
       public AggregateResult[] leadsqualifLASTYEAR{
        get {
            return [SELECT  count(Id) leads_qualif_LAST_YEAR from Lead where Status= 'Qualifié' and (Source__c='Siteweb SOS' or Source__c='Facebook')  and ConvertedDate=LAST_YEAR ];
        }
    }
    
    
       public AggregateResult[] showContactsDemarchesTODAY{
        get {
            return [SELECT  count(Contact.Id) contact from Contact where Contact.Id in(select ContactHistory.ContactId from ContactHistory where Field='Statut__c' 
             and CreatedDate=TODAY  ) and Contact.Statut__c not in('Interesse','Interesse - En Recherche','Perdu')
      ];
        }
    }
   
          public AggregateResult[] showContactsDemarchesYESTERDAY{
        get {
            return [SELECT  count(Contact.Id) contact from Contact where Contact.Id in(select ContactHistory.ContactId from ContactHistory where Field='Statut__c' 
             and CreatedDate=YESTERDAY  ) and Contact.Statut__c not in('Interesse','Interesse - En Recherche','Perdu')
      ];
        }
    }
     
           public AggregateResult[] showContactsDemarchesTHISWEEK{
        get {
            return [SELECT  count(Contact.Id) contact from Contact where Contact.Id in(select ContactHistory.ContactId from ContactHistory where Field='Statut__c' 
             and CreatedDate=THIS_WEEK  ) and Contact.Statut__c not in('Interesse','Interesse - En Recherche','Perdu')
      ];
        }
    }
            public AggregateResult[] showContactsDemarchesLASTWEEK{
        get {
            return [SELECT  count(Contact.Id) contact from Contact where Contact.Id in(select ContactHistory.ContactId from ContactHistory where Field='Statut__c' 
             and CreatedDate=LAST_WEEK  ) and Contact.Statut__c not in('Interesse','Interesse - En Recherche','Perdu')
      ];
        }
    }
          public AggregateResult[] showContactsDemarchesTHISMONTH{
        get {
            return [SELECT  count(Contact.Id) contact from Contact where Contact.Id in(select ContactHistory.ContactId from ContactHistory where Field='Statut__c' 
             and CreatedDate=THIS_MONTH  ) and Contact.Statut__c not in('Interesse','Interesse - En Recherche','Perdu')
      ];
        }
    }
         public AggregateResult[] showContactsDemarchesLASTMONTH{
        get {
            return [SELECT  count(Contact.Id) contact from Contact where Contact.Id in(select ContactHistory.ContactId from ContactHistory where Field='Statut__c' 
             and CreatedDate=LAST_MONTH ) and Contact.Statut__c not in('Interesse','Interesse - En Recherche','Perdu')
      ];
        }
    }
    
         public AggregateResult[] showContactsDemarchesTHISYEAR{
        get {
            return [SELECT  count(Contact.Id) contact from Contact where Contact.Id in(select ContactHistory.ContactId from ContactHistory where Field='Statut__c' 
             and CreatedDate=THIS_YEAR  ) and Contact.Statut__c not in('Interesse','Interesse - En Recherche','Perdu')
      ];
        }
    }
         public AggregateResult[] showContactsDemarchesLASTYEAR{
        get {
            return [SELECT  count(Contact.Id) contact from Contact where Contact.Id in(select ContactHistory.ContactId from ContactHistory where Field='Statut__c' 
             and CreatedDate=LAST_YEAR ) and Contact.Statut__c not in('Interesse','Interesse - En Recherche','Perdu')
      ];
        }
    }

  public AggregateResult[] showdossiersdeposesToday{
        get {
            return [SELECT  count(Id) depose  from Dossier__c where Date_depot_dossier__c=TODAY];
        }
    }
    
    public AggregateResult[] showdossiersdeposesYESTERDAY{
        get {
            return [SELECT  count(Id) depose  from Dossier__c where Date_depot_dossier__c=YESTERDAY];
        }
    }
      public AggregateResult[] showdossiersdeposesTHISWEEK{
        get {
            return [SELECT  count(Id) depose  from Dossier__c where Date_depot_dossier__c=THIS_WEEK];
        }
    }
    
       public AggregateResult[] showdossiersdeposesLASTWEEK{
        get {
            return [SELECT  count(Id) depose  from Dossier__c where Date_depot_dossier__c=LAST_WEEK];
        }
    }
    
       public AggregateResult[] showdossiersdeposesTHISMONTH{
        get {
            return [SELECT  count(Id) depose  from Dossier__c where Date_depot_dossier__c=THIS_MONTH];
        }
    }
     public AggregateResult[] showdossiersdeposesLASTMONTH{
        get {
            return [SELECT  count(Id) depose  from Dossier__c where Date_depot_dossier__c=LAST_MONTH];
        }
    }
    public AggregateResult[] showdossiersdeposesTHISYEAR{
        get {
            return [SELECT  count(Id) depose  from Dossier__c where Date_depot_dossier__c=THIS_YEAR];
        }
    }
       public AggregateResult[] showdossiersdeposesLASTYEAR{
        get {
            return [SELECT  count(Id) depose  from Dossier__c where Date_depot_dossier__c=LAST_YEAR];
        }
    }
   
      public AggregateResult[] showdossiersaccepteToday{
        get {
            return [SELECT  count(Id) accepte    from Dossier__c where  Date_accord_dossier__c=TODAY and Decision_Banque__c=TRUE];
        }
    }
   public AggregateResult[] showdossiersaccepteYESTERDAY{
        get {
            return [SELECT  count(Id) accepte    from Dossier__c where  Date_accord_dossier__c=YESTERDAY and Decision_Banque__c=TRUE];
        }
    }
      public AggregateResult[] showdossiersaccepteTHISWEEK{
        get {
            return [SELECT  count(Id) accepte    from Dossier__c where  Date_accord_dossier__c=THIS_WEEK and Decision_Banque__c=TRUE];
        }
    }
     public AggregateResult[] showdossiersaccepteLASTWEEK{
        get {
            return [SELECT  count(Id) accepte    from Dossier__c where  Date_accord_dossier__c=LAST_WEEK and Decision_Banque__c=TRUE];
        }
    }
      public AggregateResult[] showdossiersaccepteTHISMONTH{
        get {
            return [SELECT  count(Id) accepte    from Dossier__c where  Date_accord_dossier__c=THIS_MONTH and Decision_Banque__c=TRUE];
        }
    }
   
     public AggregateResult[] showdossiersaccepteLASTMONTH{
        get {
            return [SELECT  count(Id) accepte    from Dossier__c where  Date_accord_dossier__c=LAST_MONTH and Decision_Banque__c=TRUE];
        }
    }
    public AggregateResult[] showdossiersaccepteTHISYEAR{
        get {
            return [SELECT  count(Id) accepte    from Dossier__c where  Date_accord_dossier__c=THIS_YEAR and Decision_Banque__c=TRUE];
        }
    }
     public AggregateResult[] showdossiersaccepteLASTYEAR{
        get {
            return [SELECT  count(Id) accepte    from Dossier__c where  Date_accord_dossier__c=LAST_YEAR and Decision_Banque__c=TRUE];
        }
    }
   
      public AggregateResult[] showdossiersFinancesTODAY{
        get {
            return [SELECT  count(Id) finances    from Dossier__c where    Date_deblocage__c=TODAY and Dossier_d_bloqu__c=TRUE];
        }
    }
      public AggregateResult[] showdossiersFinancesYESTERDAY{
        get {
            return [SELECT  count(Id) finances    from Dossier__c where    Date_deblocage__c=YESTERDAY and Dossier_d_bloqu__c=TRUE];
        }
    }
       public AggregateResult[] showdossiersFinancesTHISWEEK{
        get {
            return [SELECT  count(Id) finances    from Dossier__c where    Date_deblocage__c=THIS_WEEK and Dossier_d_bloqu__c=TRUE];
        }
    }
      public AggregateResult[] showdossiersFinancesLASTWEEK{
        get {
            return [SELECT  count(Id) finances    from Dossier__c where    Date_deblocage__c=LAST_WEEK and Dossier_d_bloqu__c=TRUE];
        }
    }
     public AggregateResult[] showdossiersFinancesTHISMONTH{
        get {
            return [SELECT  count(Id) finances    from Dossier__c where    Date_deblocage__c=THIS_MONTH and Dossier_d_bloqu__c=TRUE];
        }
    }
      public AggregateResult[] showdossiersFinancesLASTMONTH{
        get {
            return [SELECT  count(Id) finances    from Dossier__c where    Date_deblocage__c=LAST_MONTH and Dossier_d_bloqu__c=TRUE];
        }
    }
     public AggregateResult[] showdossiersFinancesTHISYEAR{
        get {
            return [SELECT  count(Id) finances    from Dossier__c where    Date_deblocage__c=THIS_YEAR and Dossier_d_bloqu__c=TRUE];
        }
    }
     public AggregateResult[] showdossiersFinancesLASTYEAR{
        get {
            return [SELECT  count(Id) finances    from Dossier__c where    Date_deblocage__c=LAST_YEAR and Dossier_d_bloqu__c=TRUE];
        }
    }
    
      public AggregateResult[] showdossiersFactureToday{
        get {
            return [SELECT  count(Id) facture    from Dossier__c where    Date_d_p_t_facture__c=TODAY and Facture_deposee__c=TRUE];
        }
    }
    
      public AggregateResult[] showdossiersFactureYESTERDAY{
        get {
            return [SELECT  count(Id) facture    from Dossier__c where    Date_d_p_t_facture__c=YESTERDAY and Facture_deposee__c=TRUE];
        }
    }
      public AggregateResult[] showdossiersFactureTHISWEEK{
        get {
            return [SELECT  count(Id) facture    from Dossier__c where    Date_d_p_t_facture__c=THIS_WEEK and Facture_deposee__c=TRUE];
        }
    }
      public AggregateResult[] showdossiersFactureLASTWEEK{
        get {
            return [SELECT  count(Id) facture    from Dossier__c where    Date_d_p_t_facture__c=LAST_WEEK and Facture_deposee__c=TRUE];
        }
    }
      public AggregateResult[] showdossiersFactureTHISMONTH{
        get {
            return [SELECT  count(Id) facture    from Dossier__c where    Date_d_p_t_facture__c=THIS_MONTH and Facture_deposee__c=TRUE];
        }
    }
     public AggregateResult[] showdossiersFactureLASTMONTH{
        get {
            return [SELECT  count(Id) facture    from Dossier__c where    Date_d_p_t_facture__c=LAST_MONTH and Facture_deposee__c=TRUE];
        }
    }
     public AggregateResult[] showdossiersFactureTHISYEAR{
        get {
            return [SELECT  count(Id) facture    from Dossier__c where    Date_d_p_t_facture__c=THIS_YEAR and Facture_deposee__c=TRUE];
        }
    }
     public AggregateResult[] showdossiersFactureLASTYEAR{
        get {
            return [SELECT  count(Id) facture    from Dossier__c where    Date_d_p_t_facture__c=LAST_YEAR and Facture_deposee__c=TRUE];
        }
    }
       public AggregateResult[] showdossiersPayeToday{
        get {
            return [SELECT  count(Id) paye   from Dossier__c where    Date_Paiement_Facture__c=TODAY and Facture_Payee__c=TRUE];
        }
    }
        public AggregateResult[] showdossiersPayeYESTERDAY{
        get {
            return [SELECT  count(Id) paye   from Dossier__c where    Date_Paiement_Facture__c=YESTERDAY and Facture_Payee__c=TRUE];
        }
    }
      public AggregateResult[] showdossiersPayeTHISWEEK{
        get {
            return [SELECT  count(Id) paye   from Dossier__c where    Date_Paiement_Facture__c=THIS_WEEK and Facture_Payee__c=TRUE];
        }
    }
       public AggregateResult[] showdossiersPayeLASTWEEK{
        get {
            return [SELECT  count(Id) paye   from Dossier__c where    Date_Paiement_Facture__c=LAST_WEEK and Facture_Payee__c=TRUE];
        }
    }
      public AggregateResult[] showdossiersPayeTHISMONTH{
        get {
            return [SELECT  count(Id) paye   from Dossier__c where    Date_Paiement_Facture__c=THIS_MONTH and Facture_Payee__c=TRUE];
        }
    }
      public AggregateResult[] showdossiersPayeLASTMONTH{
        get {
            return [SELECT  count(Id) paye   from Dossier__c where    Date_Paiement_Facture__c=LAST_MONTH and Facture_Payee__c=TRUE];
        }
    }
       public AggregateResult[] showdossiersPayeTHISYEAR{
        get {
            return [SELECT  count(Id) paye   from Dossier__c where    Date_Paiement_Facture__c=THIS_YEAR and Facture_Payee__c=TRUE];
        }
    }
        public AggregateResult[] showdossiersPayeLASTYEAR{
        get {
            return [SELECT  count(Id) paye   from Dossier__c where    Date_Paiement_Facture__c=LAST_YEAR and Facture_Payee__c=TRUE];
        }
    }

      
      
}