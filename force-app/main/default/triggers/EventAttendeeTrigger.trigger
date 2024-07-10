/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 05-29-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
trigger EventAttendeeTrigger on Event_Attendee__c (after insert) {
    if(Trigger.isAfter && Trigger.isInsert){
     AttendeeTriggerHandeller.sendEmail(Trigger.new);
    }
}