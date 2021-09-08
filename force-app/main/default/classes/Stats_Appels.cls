public with sharing class Stats_Appels{

    public Stats_Appels() {

    }


    

    
/*public static string message { get; set; }*/

    public Stats_Appels(ApexPages.StandardController controller) {

    } 
    
    //APPEL FOR OMAR
  
   
    public  AggregateResult[] appelOmarToday {
        get {
            return [SELECT  count(Id) appel from Task where    CreatedById='0050Y000000Uab5' and CreatedDate=TODAY];
        }
    }

   public AggregateResult[] appelOmarYesterday {
        get {
            return [SELECT  count(Id) appel from Task where    CreatedById='0050Y000000Uab5' and CreatedDate=YESTERDAY];
        }
    }

public AggregateResult[] appelOmarTHISWEEK{
        get {
            return [SELECT  count(Id) appel from Task where    CreatedById='0050Y000000Uab5' and CreatedDate=THIS_WEEK];
        }
    }
    public AggregateResult[] appelOmarLASTWEEK{
        get {
            return [SELECT  count(Id) appel from Task where    CreatedById='0050Y000000Uab5' and CreatedDate=LAST_WEEK];
        }
    }
     public AggregateResult[] appelOmarTHISMONTH{
        get {
            return [SELECT  count(Id) appel from Task where    CreatedById='0050Y000000Uab5' and CreatedDate=THIS_MONTH];
        }
    }
     public AggregateResult[] appelOmarLASTMONTH{
        get {
            return [SELECT  count(Id) appel from Task where    CreatedById='0050Y000000Uab5' and CreatedDate=LAST_MONTH];
        }
    }
      public AggregateResult[] appelOmarTHISYEAR{
        get {
            return [SELECT  count(Id) appel from Task where    CreatedById='0050Y000000Uab5' and CreatedDate=THIS_YEAR];
        }
    }
     public AggregateResult[] appelOmarLASTYEAR{
        get {
            return [SELECT  count(Id) appel from Task where    CreatedById='0050Y000000Uab5' and CreatedDate=LAST_YEAR];
        }
    }
    
    //Appel For ZAKARIYA
     public AggregateResult[] appelZakariyaToday {
        get {
            return [SELECT  count(Id) appel from Task where    CreatedById='0050Y000000Ugf2' and CreatedDate=TODAY];
        }
    }

   public AggregateResult[] appelZakariyaYesterday {
        get {
            return [SELECT  count(Id) appel from Task where    CreatedById='0050Y000000Ugf2' and CreatedDate=YESTERDAY];
        }
    }

public AggregateResult[] appelZakariyaTHISWEEK{
        get {
            return [SELECT  count(Id) appel from Task where    CreatedById='0050Y000000Ugf2' and CreatedDate=THIS_WEEK];
        }
    }
    public AggregateResult[] appelZakariyaLASTWEEK{
        get {
            return [SELECT  count(Id) appel from Task where    CreatedById='0050Y000000Ugf2' and CreatedDate=LAST_WEEK];
        }
    }
     public AggregateResult[] appelZakariyaTHISMONTH{
        get {
            return [SELECT  count(Id) appel from Task where    CreatedById='0050Y000000Ugf2' and CreatedDate=THIS_MONTH];
        }
    }
     public AggregateResult[] appelZakariyaLASTMONTH{
        get {
            return [SELECT  count(Id) appel from Task where    CreatedById='0050Y000000Ugf2' and CreatedDate=LAST_MONTH];
        }
    }
      public AggregateResult[] appelZakariyaTHISYEAR{
        get {
            return [SELECT  count(Id) appel from Task where    CreatedById='0050Y000000Ugf2' and CreatedDate=THIS_YEAR];
        }
    }
     public AggregateResult[] appelZakariyaLASTYEAR{
        get {
            return [SELECT  count(Id) appel from Task where    CreatedById='0050Y000000Ugf2' and CreatedDate=LAST_YEAR];
        }
    }
    //Appel For Karim
     public AggregateResult[] appelkarimToday {
        get {
            return [SELECT  count(Id) appel from Task where    CreatedById='0050Y000000VEdz' and CreatedDate=TODAY];
        }
    }

   public AggregateResult[] appelkarimYesterday {
        get {
            return [SELECT  count(Id) appel from Task where    CreatedById='0050Y000000VEdz' and CreatedDate=YESTERDAY];
        }
    }

public AggregateResult[] appelkarimTHISWEEK{
        get {
            return [SELECT  count(Id) appel from Task where    CreatedById='0050Y000000VEdz' and CreatedDate=THIS_WEEK];
        }
    }
    public AggregateResult[] appelkarimLASTWEEK{
        get {
            return [SELECT  count(Id) appel from Task where    CreatedById='0050Y000000VEdz' and CreatedDate=LAST_WEEK];
        }
    }
     public AggregateResult[] appelkarimTHISMONTH{
        get {
            return [SELECT  count(Id) appel from Task where    CreatedById='0050Y000000VEdz' and CreatedDate=THIS_MONTH];
        }
    }
     public AggregateResult[] appelkarimLASTMONTH{
        get {
            return [SELECT  count(Id) appel from Task where    CreatedById='0050Y000000VEdz' and CreatedDate=LAST_MONTH];
        }
    }
      public AggregateResult[] appelkarimTHISYEAR{
        get {
            return [SELECT  count(Id) appel from Task where    CreatedById='0050Y000000VEdz' and CreatedDate=THIS_YEAR];
        }
    }
     public AggregateResult[] appelkarimLASTYEAR{
        get {
            return [SELECT  count(Id) appel from Task where    CreatedById='0050Y000000VEdz' and CreatedDate=LAST_YEAR];
        }
    }
     public AggregateResult[] appelImaneDahmaniToday {
        get {
            return [SELECT  count(Id) appel from Task where    CreatedById='0050Y000000VFsU' and CreatedDate=TODAY];
        }
    }

   public AggregateResult[] appelImaneDahmaniYesterday {
        get {
            return [SELECT  count(Id) appel from Task where    CreatedById='0050Y000000VFsU' and CreatedDate=YESTERDAY];
        }
    }

public AggregateResult[] appelImaneDahmaniTHISWEEK{
        get {
            return [SELECT  count(Id) appel from Task where    CreatedById='0050Y000000VFsU' and CreatedDate=THIS_WEEK];
        }
    }
    public AggregateResult[] appelImaneDahmaniLASTWEEK{
        get {
            return [SELECT  count(Id) appel from Task where    CreatedById='0050Y000000VFsU' and CreatedDate=LAST_WEEK];
        }
    }
     public AggregateResult[] appelImaneDahmaniTHISMONTH{
        get {
            return [SELECT  count(Id) appel from Task where    CreatedById='0050Y000000VFsU' and CreatedDate=THIS_MONTH];
        }
    }
     public AggregateResult[] appelImaneDahmaniLASTMONTH{
        get {
            return [SELECT  count(Id) appel from Task where    CreatedById='0050Y000000VFsU' and CreatedDate=LAST_MONTH];
        }
    }
      public AggregateResult[] appelImaneDahmaniTHISYEAR{
        get {
            return [SELECT  count(Id) appel from Task where    CreatedById='0050Y000000VFsU' and CreatedDate=THIS_YEAR];
        }
    }
     public AggregateResult[] appelImaneDahmaniLASTYEAR{
        get {
            return [SELECT  count(Id) appel from Task where    CreatedById='0050Y000000VFsU' and CreatedDate=LAST_YEAR];
        }
    }
    
    public AggregateResult[] appelChahnazHaidarToday {
        get {
            return [SELECT  count(Id) appel from Task where    CreatedById='0050Y000000VEe4' and CreatedDate=TODAY];
        }
    }

   public AggregateResult[] appelChahnazHaidarYesterday {
        get {
            return [SELECT  count(Id) appel from Task where    CreatedById='0050Y000000VEe4' and CreatedDate=YESTERDAY];
        }
    }

public AggregateResult[] appelChahnazHaidarTHISWEEK{
        get {
            return [SELECT  count(Id) appel from Task where    CreatedById='0050Y000000VEe4' and CreatedDate=THIS_WEEK];
        }
    }
    public AggregateResult[] appelChahnazHaidarLASTWEEK{
        get {
            return [SELECT  count(Id) appel from Task where    CreatedById='0050Y000000VEe4' and CreatedDate=LAST_WEEK];
        }
    }
     public AggregateResult[] appelChahnazHaidarTHISMONTH{
        get {
            return [SELECT  count(Id) appel from Task where    CreatedById='0050Y000000VEe4' and CreatedDate=THIS_MONTH];
        }
    }
     public AggregateResult[] appelChahnazHaidarLASTMONTH{
        get {
            return [SELECT  count(Id) appel from Task where    CreatedById='0050Y000000VEe4' and CreatedDate=LAST_MONTH];
        }
    }
      public AggregateResult[] appelChahnazHaidarTHISYEAR{
        get {
            return [SELECT  count(Id) appel from Task where    CreatedById='0050Y000000VEe4' and CreatedDate=THIS_YEAR];
        }
    }
     public AggregateResult[] appelChahnazHaidarLASTYEAR{
        get {
            return [SELECT  count(Id) appel from Task where    CreatedById='0050Y000000VEe4' and CreatedDate=LAST_YEAR];
        }
    }
    // ToTAL APPEL 
     public AggregateResult[] appelAllToday {
        get {
            return [SELECT  count(Id) appel from Task where    CreatedById in('0050Y000000VEdz','0050Y000000Ugf2','0050Y000000Uab5','0050Y000000VFsU','0050Y000000VEe4') and CreatedDate=TODAY];
        }
    }

   public AggregateResult[] appelAllYesterday {
        get {
            return [SELECT  count(Id) appel from Task where   CreatedById in('0050Y000000VEdz','0050Y000000Ugf2','0050Y000000Uab5','0050Y000000VFsU','0050Y000000VEe4') and CreatedDate=YESTERDAY];
        }
    }

public AggregateResult[] appelAllTHISWEEK{
        get {
            return [SELECT  count(Id) appel from Task where   CreatedById in('0050Y000000VEdz','0050Y000000Ugf2','0050Y000000Uab5','0050Y000000VFsU','0050Y000000VEe4') and CreatedDate=THIS_WEEK];
        }
    }
    public AggregateResult[] appelAllLASTWEEK{
        get {
            return [SELECT  count(Id) appel from Task where   CreatedById in('0050Y000000VEdz','0050Y000000Ugf2','0050Y000000Uab5','0050Y000000VFsU','0050Y000000VEe4') and CreatedDate=LAST_WEEK];
        }
    }
     public AggregateResult[] appelAllTHISMONTH{
        get {
            return [SELECT  count(Id) appel from Task where   CreatedById in('0050Y000000VEdz','0050Y000000Ugf2','0050Y000000Uab5','0050Y000000VFsU','0050Y000000VEe4') and CreatedDate=THIS_MONTH];
        }
    }
     public AggregateResult[] appelAllLASTMONTH{
        get {
            return [SELECT  count(Id) appel from Task where   CreatedById in('0050Y000000VEdz','0050Y000000Ugf2','0050Y000000Uab5','0050Y000000VFsU','0050Y000000VEe4') and CreatedDate=LAST_MONTH];
        }
    }
      public AggregateResult[] appelAllTHISYEAR{
        get {
            return [SELECT  count(Id) appel from Task where   CreatedById in('0050Y000000VEdz','0050Y000000Ugf2','0050Y000000Uab5','0050Y000000VFsU','0050Y000000VEe4') and CreatedDate=THIS_YEAR];
        }
    }
     public AggregateResult[] appelAllLASTYEAR{
        get {
            return [SELECT  count(Id) appel from Task where   CreatedById in('0050Y000000VEdz','0050Y000000Ugf2','0050Y000000Uab5','0050Y000000VFsU','0050Y000000VEe4') and CreatedDate=LAST_YEAR];
        }
    }
}