/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class testtt {
    @IsTest(SeeAllData=true) public static  void myUnitTest1() {
         Stats_Appels s=new Stats_Appels();
           system.debug(s);
       system.debug(s.appelOmarToday);
        system.debug(s.appelOmarYesterday);
       system.debug(s.appelOmarTHISWEEK);
        system.debug(s.appelOmarLASTWEEK);
         system.debug(s.appelOmarTHISMONTH);
          system.debug(s.appelOmarLASTMONTH);
           system.debug(s.appelOmarTHISYEAR);
            system.debug(s.appelOmarLASTYEAR);
             system.debug(s.appelZakariyaToday);
              system.debug(s.appelZakariyaYesterday);
               system.debug(s.appelZakariyaTHISWEEK);
                system.debug(s.appelZakariyaLASTWEEK);
                 system.debug(s.appelZakariyaTHISMONTH);
                  system.debug(s.appelZakariyaLASTMONTH);
                   system.debug(s.appelZakariyaTHISYEAR);
              system.debug(s.appelZakariyaLASTYEAR);
                system.debug(s.appelKarimToday);
              system.debug(s.appelKarimYesterday);
               system.debug(s.appelKarimTHISWEEK);
                system.debug(s.appelKarimLASTWEEK);
                 system.debug(s.appelKarimTHISMONTH);
                  system.debug(s.appelKarimLASTMONTH);
                   system.debug(s.appelKarimTHISYEAR);
              system.debug(s.appelKarimLASTYEAR);
                system.debug(s.appelChahnazHaidarToday);
              system.debug(s.appelChahnazHaidarYesterday);
               system.debug(s.appelChahnazHaidarTHISWEEK);
                system.debug(s.appelChahnazHaidarLASTWEEK);
                 system.debug(s.appelChahnazHaidarTHISMONTH);
                  system.debug(s.appelChahnazHaidarLASTMONTH);
                   system.debug(s.appelChahnazHaidarTHISYEAR);
              system.debug(s.appelChahnazHaidarLASTYEAR);
                 system.debug(s.appelImaneDahmaniToday);
              system.debug(s.appelImaneDahmaniYesterday);
               system.debug(s.appelImaneDahmaniTHISWEEK);
                system.debug(s.appelImaneDahmaniLASTWEEK);
                 system.debug(s.appelImaneDahmaniTHISMONTH);
                  system.debug(s.appelImaneDahmaniLASTMONTH);
                   system.debug(s.appelImaneDahmaniTHISYEAR);
              system.debug(s.appelImaneDahmaniLASTYEAR);
                 system.debug(s.appelAllToday);
              system.debug(s.appelAllYesterday);
               system.debug(s.appelAllTHISWEEK);
                system.debug(s.appelAllLASTWEEK);
                 system.debug(s.appelAllTHISMONTH);
                  system.debug(s.appelAllLASTMONTH);
                   system.debug(s.appelAllTHISYEAR);
              system.debug(s.appelAllLASTYEAR);
              
         Stats_Dossiers d=new  Stats_Dossiers();
       
         system.debug(d);
                system.debug(d.dossierDeposeOmarToday);
                system.debug(d.dossierDeposeOmarYESTERDAY);
                system.debug(d.dossierDeposeOmarTHISWEEK);
                
                system.debug(d.dossierDeposeOmarLASTWEEK);
                system.debug(d.dossierDeposeOmarTHISMONTH);
                
                
                system.debug(d.dossierDeposeOmarLASTMONTH);
                
                system.debug(d.dossierDeposeOmarTHISYEAR);
                system.debug(d.dossierDeposeOmarLASTYEAR);
                
                
                system.debug(d.dossierDeposeOmarALL);
                system.debug(d.dossierAccepteOmarTodaY);
                system.debug(d.dossierAccepteOmarYESTERDAY);
                
                
                system.debug(d.dossierAccepteOmarTHISWEEK);
                system.debug(d.dossierAccepteOmarLASTWEEK);
                system.debug(d.dossierAccepteOmarTHISMONTH);
                system.debug(d.dossierAccepteOmarLASTMONTH);
                
                system.debug(d.dossierAccepteOmarTHISYEAR);
                system.debug(d.dossierAccepteOmarLASTYEAR);
                system.debug(d.dossierAccepteOmarALL);
                system.debug(d.dossierFinanceOmarToday);
                system.debug(d.dossierFinanceOmarYesterday);
                
                 system.debug(d.dossierFinanceOmarTHISWEEK);
                  system.debug(d.dossierFinanceOmarLASTWEEK);
                   system.debug(d.dossierFinanceOmarTHISMONTH);
                    system.debug(d.dossierFinanceOmarTHISYEAR);
                
                 system.debug(d.dossierFinanceOmarLASTYEAR);
                  system.debug(d.dossierFactureOmarToday);
                   system.debug(d.dossierFactureOmarYESTERDAY);
                    system.debug(d.dossierFactureOmarTHISWEEK);
                    
                    
                     system.debug(d.dossierFinanceOmarALL);
                  system.debug(d.dossierFinanceOmarLASTMONTH);
                   system.debug(d.dossierFactureOmarLASTWEEK);
                    system.debug(d.dossierFactureOmarTHISMONTH);
                    
                     system.debug(d.dossierFactureOmarLASTMONTH);
                  system.debug(d.dossierFactureOmarTHISYEAR);
                   system.debug(d.dossierFactureOmarLASTYEAR);
                    system.debug(d.dossierFactureOmarALL);
                    
                    
                    
                      system.debug(d.dossierPayeOmarTODAY);
                  system.debug(d.dossierPayeOmarYESTERDAY);
                   system.debug(d.dossierPayeOmarTHISWEEK);
                    system.debug(d.dossierPayeOmarLASTWEEK);
                    
                     system.debug(d.dossierPayeOmarTHISMONTH);
                  system.debug(d.dossierPayeOmarLASTMONTH);
                   system.debug(d.dossierPayeOmarTHISYEAR);
                    system.debug(d.dossierPayeOmarALL);
    }
        // TO DO: implement unit test
     
    @IsTest(SeeAllData=true) public static  void myUnitTest() {
        // TO DO: implement unit test
      Stats_Appels s=new Stats_Appels();
       Stats_Dossiers_Total t=new  Stats_Dossiers_Total();
     
       Stats_Dossiers_Zak dz=new  Stats_Dossiers_Zak();
       Stats_sos sos=new Stats_sos();
    
      
         system.debug(t);
          system.debug(sos);
           
                 system.debug(dz);
                 
                 
                  system.debug(dz.dossierDeposeZakToday);
                system.debug(dz.dossierDeposeZakYESTERDAY);
                system.debug(dz.dossierDeposeZakTHISWEEK);
                
                system.debug(dz.dossierDeposeZakLASTWEEK);
                system.debug(dz.dossierDeposeZakTHISMONTH);
                
                
                system.debug(dz.dossierDeposeZakLASTMONTH);
                
                system.debug(dz.dossierDeposeZakTHISYEAR);
                system.debug(dz.dossierDeposeZakLASTYEAR);
                
                
                system.debug(dz.dossierDeposeZakALL);
                system.debug(dz.dossierAccepteZakTodaY);
                system.debug(dz.dossierAccepteZakYESTERDAY);
                
                
                system.debug(dz.dossierAccepteZakTHISWEEK);
                system.debug(dz.dossierAccepteZakLASTWEEK);
                system.debug(dz.dossierAccepteZakTHISMONTH);
                system.debug(dz.dossierAccepteZakLASTMONTH);
                
                system.debug(dz.dossierAccepteZakTHISYEAR);
                system.debug(dz.dossierAccepteZakLASTYEAR);
                system.debug(dz.dossierAccepteZakALL);
                system.debug(dz.dossierFinanceZakToday);
                system.debug(dz.dossierFinanceZakYesterday);
                
                 system.debug(dz.dossierFinanceZakTHISWEEK);
                  system.debug(dz.dossierFinanceZakLASTWEEK);
                   system.debug(dz.dossierFinanceZakTHISMONTH);
                    system.debug(dz.dossierFinanceZakTHISYEAR);
                
                 system.debug(dz.dossierFinanceZakLASTYEAR);
                  system.debug(dz.dossierFactureZakToday);
                   system.debug(dz.dossierFactureZakYESTERDAY);
                    system.debug(dz.dossierFactureZakTHISWEEK);
                    
                    
                     system.debug(dz.dossierFinanceZakALL);
                  system.debug(dz.dossierFinanceZakLASTMONTH);
                   system.debug(dz.dossierFactureZakLASTWEEK);
                    system.debug(dz.dossierFactureZakTHISMONTH);
                    
                     system.debug(dz.dossierFactureZakLASTMONTH);
                  system.debug(dz.dossierFactureZakTHISYEAR);
                   system.debug(dz.dossierFactureZakLASTYEAR);
                    system.debug(dz.dossierFactureZakALL);
                    
                    
                    
                      system.debug(dz.dossierPayeZakTODAY);
                  system.debug(dz.dossierPayeZakYESTERDAY);
                   system.debug(dz.dossierPayeZakTHISWEEK);
                    system.debug(dz.dossierPayeZakLASTWEEK);
                    
                     system.debug(dz.dossierPayeZakTHISMONTH);
                  system.debug(dz.dossierPayeZakLASTMONTH);
                   system.debug(dz.dossierPayeZakTHISYEAR);
                    system.debug(dz.dossierPayeZakALL);
                  system.debug(dz.dossierPayeZakTHISYEAR);
                  system.debug(dz.dossierPayeZakLASTYEAR);
                     system.debug(sos.leadsGeneresYesterday);
                     system.debug(sos.leadsGeneresThisWeek);
                     
                       system.debug(t.dossierFinanceToday);
                                                            system.debug(t.dossierFinanceYesterday);
                                                            system.debug(t.dossierFinanceTHISWEEK);
                                                            system.debug(t.dossierFinanceLASTWEEK);
                                                            system.debug(t.dossierFinanceTHISMONTH);
                                                            system.debug(t.dossierFinanceLASTMONTH);
                                                            system.debug(t.dossierFinanceTHISYEAR);
                                                            
                                                            system.debug(t.dossierFinanceLASTYEAR);
                                                            system.debug(t.dossierFinanceALL);
                                                            
                                                            system.debug(t.dossierFactureToday);
                                                            system.debug(t.dossierFactureYESTERDAY);
                                                            system.debug(t.dossierFactureTHISWEEK);
                                                            system.debug(t.dossierFactureLASTWEEK);
                                                            system.debug(t.dossierFactureTHISMONTH);
                                                            
                                                            
                                                            system.debug(t.dossierFactureLASTMONTH);
                                                            system.debug(t.dossierFactureTHISYEAR);
                                                            system.debug(t.dossierFactureLASTYEAR);
                                                            system.debug(t.dossierFactureALL);
                         system.debug(t.dossierDeposeToday);
                           system.debug(t.dossierDeposeYesterday);
                             system.debug(t.dossierDeposeTHISWEEK);
                               system.debug(t.dossierDeposeLASTWEEK);
                                 system.debug(t.dossierDeposeTHISMONTH);
                                   system.debug(t.dossierDeposeLASTMONTH);
                                     system.debug(t.dossierDeposeTHISYEAR);
                                        system.debug(t.dossierDeposeLASTYEAR);
                                          system.debug(t.dossierDeposeTotal);
                                            system.debug(t.dossierAcceptekTodaY);
                                              system.debug(t.dossierAcceptekYESTERDAY);
                                                system.debug(t.dossierAcceptekTHISWEEK);
                                                  system.debug(t.dossierAcceptekLASTWEEK);
                                                    system.debug(t.dossierAcepteTHISMONTH);
                                                      system.debug(t.dossierAcceptekLASTMONTH);
                                                        system.debug(t.dossierAcceptekTHISYEAR);
                                                          system.debug(t.dossierAcceptekLASTYEAR);
                                                            system.debug(t.dossierAcceptekALL);
                                                             system.debug(t.dossierPayeLASTYEAR);
                                                            
                                                            system.debug(t.dossierPayeTHISWEEK);
                                                            system.debug(t.dossierPayeLASTWEEK);
                                                            system.debug(t.dossierPayeTHISMONTH);
                                                            system.debug(t.dossierPayeLASTMONTH);
                                                            system.debug(t.dossierPayeTHISYEAR);
                                                            system.debug(t.dossierPayeALL);
                                                             system.debug(t.dossierPayeTODAY);
                                                              system.debug(t.dossierPayeYESTERDAY);
                                                              
                                                            
                    
                    
    }
    
         
    
}