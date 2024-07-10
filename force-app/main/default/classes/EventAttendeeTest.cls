@IsTest
public class EventAttendeeTest {

    @TestSetup
    static void setup() {
        EventAttendeeTestUtility.createRecords('Celebration Party', 1, true);
    }

    @IsTest
    public static void positive() {
        Event__c tempEvent = new Event__c(Name__c = 'Test 2', Start__c = Date.today(), End__c = Date.today().addDays(10), Max_Seats__c=50, Live__c = true);
        insert tempEvent;
        
        Attendee__c tempAttendee = new Attendee__c(Name = 'Abhinav Tyagi', Email__c = 'aman.tyagi@mirketa.com');
        insert tempAttendee;

        Event_Attendee__c temp = new Event_Attendee__c();
        temp.Name = 'Birthday Party';
        temp.Event__c = tempEvent.Id;
        temp.Attendee__c = tempAttendee.Id;

        Test.startTest();
        insert temp;
        Test.stopTest();

        Event_Attendee__c insertedAttendee = [SELECT Id, Name, Event__c, Attendee__c FROM Event_Attendee__c WHERE Id = :temp.Id LIMIT 1];
        System.assertNotEquals(null, insertedAttendee, 'Event_Attendee record should be inserted.');
        
    }
    
    @IsTest
    public static void negative() {
        Event__c tempEvent = new Event__c(Name__c = 'Test 3', End__c = Date.today().addDays(10), Max_Seats__c=50);
        insert tempEvent;

        Attendee__c tempAttendee = new Attendee__c(Name = 'Aman Tyagi');
        insert tempAttendee;

        Event_Attendee__c temp = new Event_Attendee__c();
        temp.Name = 'Appraisal Party';
        temp.Event__c = tempEvent.Id;
        temp.Attendee__c = tempAttendee.Id;

        Test.startTest();
        try{
        insert temp;
        }
        catch(Exception e)
        {
            System.debug('Exception occurs');
        }
        Test.stopTest();
        List<Event_Attendee__c> list1=[SELECT Id from Event_Attendee__c where Id =: temp.Id];
        System.assertEquals(0,list1.size(),'Fails');
    }
}