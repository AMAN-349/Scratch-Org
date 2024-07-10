trigger DeveloperTrigger on Developer__c (before insert) {
    if(Trigger.isInsert)
    {
        DeveloperTriggerHandeller.func(Trigger.new);
    }
}