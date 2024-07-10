@isTest
private class EventTriggerHandlerTest {
    
    @TestSetup static void insertTestRecords(){
        Location_Address_Book__c location = new Location_Address_Book__c();
        location.Name = 'Test Location';
        insert location;
        
        Event_Organizer__c organizer = new Event_Organizer__c();
        organizer.Name = 'Test Organizer';
        insert organizer;
        
        List<Event__c> eventsToInsert = TestUtility.createEventRecord('Test', 2);
        for(Event__c event : eventsToInsert){
        event.Organizer__c = organizer.Id;
        event.Location__c = location.Id;
        event.Start__c = Datetime.now();
        event.End__c = Datetime.now().addDays(10);
        event.Live__c = true;
        event.Max_Seats__c = 20;
        }
        insert eventsToInsert;
        
        
        Speaker__c speaker = new Speaker__c();
        speaker.Name = 'Test Speaker';
        insert speaker;
        
        Event_Speaker__c eventSpeaker1 = new Event_Speaker__c(Name='Aman Tyagi',Event__c = eventsToInsert[0].Id, Speaker__c = speaker.Id);
        insert eventSpeaker1;
        
        Event_Speaker__c eventSpeaker2 = new Event_Speaker__c(Name='Aman Rawli',Event__c = eventsToInsert[1].Id, Speaker__c = speaker.Id);

        Test.startTest();
        try {
            insert eventSpeaker2;
            System.assert(false, 'Duplicate booking should not be allowed.');
        } catch (DmlException e) {
            System.debug('Nothing');
        }
        Test.stopTest();
        
        
   }
   
    @isTest static void testDuplicateBooking(){
        List<Event_Speaker__c> testList = [SELECT Name,Speaker__c,Event__c FROM Event_Speaker__c];
        Test.startTest();
        try {
            insert testList;
            System.assert(false, 'Duplicate booking should not be allowed.');
        } catch (DmlException e) {
            List<Event_Speaker__c> testList2 = [SELECT Name,Speaker__c,Event__c FROM Event_Speaker__c];
            System.assertEquals(1,testList2.size());
        }
        Test.stopTest();
        System.assertEquals(1,testList.size());
        
    }
}