@isTest(SeeAllData=true)
public class SCH001_SendReportsMonthly_Test {

    @isTest
    public static void test_SendReportsMonthly(){
        List<Report_Managment__c> reportsManagment = new List<Report_Managment__c>();
        
        for(Report report : [SELECT DeveloperName FROM Report LIMIT 50]){
            reportsManagment.add(new Report_Managment__c(Name = report.DeveloperName, Recipients__c = 'test1@test.com;test2@test.com', Frequency__c = 'Monthly'));
        }
        insert reportsManagment;
        
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
        
        System.schedule('SEND REPORT MONTHLY', timeToRun, new SCH001_SendReportsMonthly());
        
        Test.stopTest();
    }
}