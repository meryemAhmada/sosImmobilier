global with sharing class SmsServiceReports implements Schedulable{
    global void execute(SchedulableContext SC) {
        SmsService.getDeliveryReport();
    }
}