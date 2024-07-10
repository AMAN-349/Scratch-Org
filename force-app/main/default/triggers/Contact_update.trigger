trigger Contact_update on Contact (after insert,after delete) {
    if(Trigger.isAfter)
    {
        UpdateClass.con(Trigger.New,Trigger.oldmap);
    }
}