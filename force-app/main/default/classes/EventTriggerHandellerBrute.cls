public class EventTriggerHandellerBrute {
    public static void inserting(List<Event_Speaker__c> l1)
    {
        for(Event_Speaker__c it:l1)
        {
            List<Event_Speaker__c> var=[SELECT Event__c from Event_Speaker__c where Speaker__c =: it.Speaker__c];
            if(var.size()!=0)
            {
                it.addError('Speaker Already Exist');
            }
            else{
                Event_Speaker__c newone =new Event_Speaker__c();
                newone.Event__c=it.Event__c;
                newone.Speaker__c=it.Speaker__c;
                insert newone;
            }
        }
    }
    
    public static void updating(List<Event_Speaker__c> l1)
    {
        for(Event_Speaker__c it:l1)
        {
            List<Event_Speaker__c> var=[SELECT Event__c from Event_Speaker__c where Speaker__c =: it.Speaker__c];
            if(var.size()!=0)
            {
                it.addError('Speaker Already Exist');
            }
            else{
                Event_Speaker__c newone =[SELECT Id from Event_Speaker__c where Id =: it.Id];
                newone.Event__c=it.Event__c;
                newone.Speaker__c=it.Speaker__c;
                update newone;
            }
        }
    }
}