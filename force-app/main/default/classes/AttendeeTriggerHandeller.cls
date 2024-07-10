public class AttendeeTriggerHandeller {
    public static void sendEmail(List<Event_Attendee__c> newList){
        Set<Id> newEvtAtt = new Set<Id>();
        for(Event_Attendee__c evtAtt : newList){
            newEvtAtt.add(evtAtt.Id);
        }
        List<Event_Attendee__c> eventAttendeeList = [SELECT Id, Event__r.Name__c, Attendee__r.Name, Event__r.Location__r.Name, 
                                                    Event__r.Organizer__r.Name, Event__r.Start__c,Attendee__r.Email__c 
                                                    FROM Event_Attendee__c WHERE Id IN :newEvtAtt];     
        List<Messaging.Email> emailList = new List<Messaging.Email>();
        for (Event_Attendee__c eventAttendee : eventAttendeeList) 
        {  try{
            if (eventAttendee.Attendee__r.Email__c != null) {
                  Messaging.SingleEmailMessage emailMsg = new Messaging.SingleEmailMessage();
                  String[] toAddress = new String[] { eventAttendee.Attendee__r.Email__c }; 
                  emailMsg.setToAddresses(toAddress);
                  String emailSub = 'Pass for the ' + eventAttendee.Event__r.Name + ' event';
                  emailMsg.setSubject(emailSub);
                  String content = 'Dear ' +  eventAttendee.Attendee__r.Name + ',<br/>' +
				                   'Thank you for registering for '+ eventAttendee.Event__r.Name 
                                   +' which will be Organized on '+ eventAttendee.Event__r.Start__c + 
                                   ' & will be held in ' + eventAttendee.Event__r.Location__r.Name +
				                   ' We are excited to have you, see you at the event. ' + '<br/>'+
				                   ' Thanks, '+ '<br/>' +
				                   eventAttendee.Event__r.Organizer__r.Name + '<br/>' +
                                   'Event Organizer';
                 emailMsg.setHtmlBody(content);
                 emailList.add(emailMsg);
 
            }
       Messaging.sendEmail(emailList);
        }
         catch(Exception e){
             ExceptionHandling.exceptionMethod(e.getMessage(), 'EventAttendeeEmailHandler');
         }
        }
    }
   }