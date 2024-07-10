trigger OpportunityAverageAmountTrigger on Opportunity (after insert, after update, after delete) {
    if(trigger.isAfter && (trigger.isInsert || trigger.isUndelete))
    {
        OpportunityAverageAmountController.TotalAccountAmountInsertHandler(trigger.new);
       
    }
    if(trigger.isAfter && trigger.isUpdate )
    {
        OpportunityAverageAmountController.TotalAccountAmountUpdateHandler(trigger.new,trigger.old);
    }
    if(trigger.isAfter && trigger.isDelete)
    {
        OpportunityAverageAmountController.TotalAccountAmountDeleteHandler(trigger.old);
    }
}