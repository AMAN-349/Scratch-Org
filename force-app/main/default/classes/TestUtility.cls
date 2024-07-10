public class TestUtility {
    public static List<Event__c> createEventRecord(String name, Integer count){
        List<Event__c> eventList = new List<Event__c>();
        for(Integer i=0; i<count; i++){
            Event__c event = new Event__c();
            event.Name__c = name + i;
            eventList.add(event);
        }
        return eventList;
    }
}