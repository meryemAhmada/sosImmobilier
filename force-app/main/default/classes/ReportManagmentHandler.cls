public class ReportManagmentHandler {
    
    public static void sendReports(List<Report_Managment__c> reportsManagment){
        System.debug('*** SEND EMAIL FOR : ' + reportsManagment.size() + ' REPORTS ***');

        Map<String, String> recipientsByReportName = new Map<String, String>();
        for(Report_Managment__c reportManagment : reportsManagment) recipientsByReportName.put(reportManagment.Name, reportManagment.Recipients__c);
        System.debug('---> RECIPIENTS BY REPORT NAME : ' + recipientsByReportName);

        List<Messaging.SingleEmailMessage> emailsToSend = new List<Messaging.SingleEmailMessage>();

        Messaging.SingleEmailMessage emailToSend;
        Messaging.EmailFileAttachment attach;
        ApexPages.PageReference reportFileLink;
        for(Report report : [SELECT Name, DeveloperName FROM Report WHERE DeveloperName IN : recipientsByReportName.keySet()]){
            System.debug('-----> REPORT : ' + report.DeveloperName);

            reportFileLink = new ApexPages.PageReference('/' + report.Id + '?csv=1');
            
            attach = new Messaging.EmailFileAttachment();
            attach.setFileName('report_' + report.DeveloperName + '_' + String.valueOf(System.Today()) + '.csv');
            if(!Test.isRunningTest()) attach.setBody(reportFileLink.getContent());
            else attach.setBody(Blob.valueOf('Test'));
            attach.setContentType('text/csv');
            
            emailToSend = new Messaging.SingleEmailMessage();
            emailToSend.setFileAttachments(new List<Messaging.EmailFileAttachment>{attach});
            emailToSend.setSubject('Report - ' + report.Name + ' - ' + String.valueOf(System.Today()));
            emailToSend.setPlainTextBody('');
            emailToSend.setToAddresses(recipientsByReportName.get(report.DeveloperName).split(';'));
            emailsToSend.add(emailToSend);
        }
        System.debug('---> EMAILS TO SEND : ' + emailsToSend);


        if(!emailsToSend.isEmpty()) {
            List<Messaging.SendEmailResult> results = Messaging.sendEmail(emailsToSend, false);

            System.debug('---> RESULTS : ');
            for(Messaging.SendEmailResult result : results) System.debug(result);
        }
    }


}