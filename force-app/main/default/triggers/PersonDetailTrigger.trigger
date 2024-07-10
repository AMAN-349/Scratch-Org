trigger PersonDetailTrigger on PersonDetail__c (before update) {
    
    if(Trigger.isBefore && Trigger.isUpdate)
    {
        CountTriggerHandller.func2(Trigger.new,Trigger.oldmap);
    }
}