public class EventTriggerHandler {
    public static void inserting(List<Event_Speaker__c> newSpeakers) {
        Set<Id> speakerIds = new Set<Id>();
        Set<Id> eventIds = new Set<Id>();
        
        for (Event_Speaker__c newSpeaker : newSpeakers) {
            speakerIds.add(newSpeaker.Speaker__c);
            eventIds.add(newSpeaker.Event__c);
        }
        
        List<Event_Speaker__c> existingSpeakers = [SELECT Event__c, Speaker__c 
                                                   FROM Event_Speaker__c 
                                                   WHERE Speaker__c IN :speakerIds];

        Map<String, Id> existingSpeakerMap = new Map<String, Id>();
        for (Event_Speaker__c existingSpeaker : existingSpeakers) {
            String key = existingSpeaker.Speaker__c;
            existingSpeakerMap.put(key, existingSpeaker.Event__c);
        }
        
        for (Event_Speaker__c newSpeaker : newSpeakers) {
            String key = newSpeaker.Speaker__c;
            if (existingSpeakerMap.containsKey(key)) {
                newSpeaker.addError('Speaker already exists for this event.');
            }
        }
    }
    
    public static void updating(List<Event_Speaker__c> newSpeakers) {
        
        Set<Id> speakerIds = new Set<Id>();
        Set<Id> eventIds = new Set<Id>();
        
        for (Event_Speaker__c newSpeaker : newSpeakers) {
            speakerIds.add(newSpeaker.Speaker__c);
            eventIds.add(newSpeaker.Event__c);
        }
        
        List<Event_Speaker__c> existingSpeakers = [SELECT Event__c, Speaker__c 
                                                   FROM Event_Speaker__c 
                                                   WHERE Speaker__c IN :speakerIds];

        Map<String, Id> existingSpeakerMap = new Map<String, Id>();
        for (Event_Speaker__c existingSpeaker : existingSpeakers) {
            String key = existingSpeaker.Speaker__c;
            existingSpeakerMap.put(key, existingSpeaker.Event__c);
        }
        
        for (Event_Speaker__c newSpeaker : newSpeakers) {
            String key = newSpeaker.Speaker__c;
            if (existingSpeakerMap.containsKey(key)) {
                newSpeaker.addError('Speaker already exists for this event.');
            }
        }
    }
}