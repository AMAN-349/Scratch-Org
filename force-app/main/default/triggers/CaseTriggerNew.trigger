trigger CaseTriggerNew on New_Case_Entry__e (after insert) {
    List<Case> cases = new List<Case>();
    for (New_Case_Entry__e event : Trigger.New) {
        if (event.Status__c == 'New') {
            System.debug(event.Origin__c);
        }
   }
}