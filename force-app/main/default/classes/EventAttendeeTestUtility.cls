public class EventAttendeeTestUtility {
    public static List<Event_Attendee__c> createRecords(String name, Integer count, Boolean isInsert) {
        List<Event_Attendee__c> eventList = new List<Event_Attendee__c>();

        Event__c tempEvent = new Event__c(Name__c = 'Test Event', Start__c = Date.today(), End__c = Date.today().addDays(10), Max_Seats__c=50, Live__c = true);
        insert tempEvent;
        
        Attendee__c tempAttendee = new Attendee__c(Name = 'Aman Tyagi', Email__c = 'aman.tyagi@mirketa.com');
        insert tempAttendee;

        for (Integer i = 0; i < count; i++) {
            Event_Attendee__c temp = new Event_Attendee__c();
            temp.Name = name + ' ' + i;
            temp.Event__c = tempEvent.Id;
            temp.Attendee__c = tempAttendee.Id;
            eventList.add(temp);
        }

        if (isInsert) {
            insert eventList;
        }

        return eventList;
    }
}