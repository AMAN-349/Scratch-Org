trigger AccountTrigger on Account (after insert) {
    if(Trigger.isInsert && Trigger.isafter)
    {
        CountTriggerHandller.func(Trigger.new);
    }
}