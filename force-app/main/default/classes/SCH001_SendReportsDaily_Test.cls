@isTest(SeeAllData=true)
public class SCH001_SendReportsDaily_Test {

    @isTest
    public static void test_SendReportsDaily(){
        List<Report_Managment__c> reportsManagement = new List<Report_Managment__c>();
        
        for(Report report : [SELECT DeveloperName FROM Report LIMIT 50]){
            reportsManagement.add(new Report_Managment__c(Name = report.DeveloperName, Recipients__c = 'test1@test.com;test2@test.com', Frequency__c = 'Daily'));
        }
        insert reportsManagement;
        
        Test.startTest();
        
        String hour = String.valueOf(Datetime.now().hour());
        String min = String.valueOf(Datetime.now().minute() + 10); 
        
        Integer minIntValue=integer.valueof(min);
        Integer hourIntValue=integer.valueof(hour);        
        if (minIntValue>59){
            minIntValue = minIntValue - 59;
            hourIntValue = hourIntValue + 1;
            min = String.valueOf(minIntValue);
            hour = String.valueOf(hourIntValue);
        }
        
        String ss = String.valueOf(Datetime.now().second());
        String timeToRun = ss + ' ' + min + ' ' + hour + ' * * ?';
        
        System.schedule('SEND REPORT DAILY', timeToRun, new SCH001_SendReportsDaily());
        
        Test.stopTest();
    }
}