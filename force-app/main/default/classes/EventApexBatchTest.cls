@isTest
public class EventApexBatchTest {
    @isTest
    public static void testBatchClass()
    {
        List<Event__c> list1=new List<Event__c>();
        for(Integer i=0;i<100;i++)
        {
            list1.add(new Event__c(Name__c='Farewell Party'+i, Start__c=Date.today(), End__c=Date.today().addDays(10),Live__c=true));
        }
        for(Integer i=0;i<100;i++)
        {
            list1.add(new Event__c(Name__c='Farewell Party'+i, Start__c=Date.today().addMonths(-4), End__c=Date.today().addMonths(-3),Live__c=false));
        }
        
        insert list1;
        Test.startTest();
        EventApexBatch event=new EventApexBatch();
        Id batchId=Database.executeBatch(event,200);
        Test.stopTest();
        List<Event__c> updated=[Select Id from Event__c where Live__c=false];
        System.assertEquals(0,updated.size());
        
        
    }
}