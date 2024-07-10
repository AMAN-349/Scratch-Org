public class EventApexBatch implements Database.Batchable<sObject> {
    public Database.QueryLocator start(Database.BatchableContext bc)
    {
        return Database.getQueryLocator([SELECT Id FROM Event__c WHERE End__c < :System.today().addMonths(-2) AND Live__c = false]);
    }
    
    public void execute(Database.BatchableContext bc, List<Event__c> event)
    {
        delete event;
    }
    
    public void finish(Database.BatchableContext bc) {
        try {
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setToAddresses(new String[] {'aman.tyagi@mirketa.com'});
            mail.setSubject('Batch Execution Complete');
            mail.setPlainTextBody('The execution of the OldEventsBatch has been processed.');

            Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});
            
            System.debug('Batch execution complete and email sent to admin.');
        } catch (Exception e) {
            System.debug('Error sending email: ' + e.getMessage());
        }
    }
}