public class ReportManagementHandler {
    
    public static void sendReports(List<Report_Managment__c> reportsManagement){
        System.debug('*** SEND EMAIL FOR : ' + reportsManagement.size() + ' REPORTS ***');

        Map<String, String> recipientsByReportName = new Map<String, String>();
        for(Report_Managment__c reportManagement : reportsManagement) recipientsByReportName.put(reportManagement.Name, reportManagement.Recipients__c);
        System.debug('---> RECIPIENTS BY REPORT NAME : ' + recipientsByReportName);

        OrgWideEmailAddress orgAddress = [SELECT Address, DisplayName FROM OrgWideEmailAddress ORDER BY CreatedDate DESC LIMIT 1];

        List<Messaging.SingleEmailMessage> emailsToSend = new List<Messaging.SingleEmailMessage>();

        Messaging.SingleEmailMessage emailToSend;
        Messaging.EmailFileAttachment attach;
        ApexPages.PageReference reportFileLink;
        for(Report report : [SELECT Name, DeveloperName FROM Report WHERE DeveloperName IN : recipientsByReportName.keySet()]){
            System.debug('-----> REPORT : ' + report.DeveloperName);

            //reportFileLink = new ApexPages.PageReference('/' + report.Id + '?csv=1');
            reportFileLink = new ApexPages.PageReference('/servlet/PrintableViewDownloadServlet?reportId=' + report.Id);

            attach = new Messaging.EmailFileAttachment();
            //attach.setFileName('report_' + report.Name + '_' + String.valueOf(System.Today()) + '.csv');
            attach.setFileName('report_' + report.Name + '_' + String.valueOf(System.Today()) + '.xlsx');
            if(!Test.isRunningTest()) attach.setBody(reportFileLink.getContent());
            else attach.setBody(Blob.valueOf('Test'));
            //attach.setContentType('text/csv');
            attach.setContentType('application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
            
            emailToSend = new Messaging.SingleEmailMessage();
            emailToSend.setFileAttachments(new List<Messaging.EmailFileAttachment>{attach});
            emailToSend.setSubject('Report - ' + report.Name + ' - ' + String.valueOf(System.Today()));
            emailToSend.setPlainTextBody('');
            emailToSend.setToAddresses(recipientsByReportName.get(report.DeveloperName).split(';'));
            emailToSend.setOrgWideEmailAddressId(orgAddress.id);
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