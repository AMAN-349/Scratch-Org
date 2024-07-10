trigger EventSpeakerTrigger on Event_Speaker__c (before insert, before update) {
    if (Trigger.isBefore) {
        if (Trigger.isInsert) {
            EventTriggerHandler.inserting(Trigger.new);
        }
        if (Trigger.isUpdate) {
            EventTriggerHandler.updating(Trigger.new);
        }
    }
}