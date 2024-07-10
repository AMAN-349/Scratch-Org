public class OpportunityAverageAmountController {
    public static void TotalAccountAmountUpdateHandler(List<Opportunity> opp, List<Opportunity> oldOpp)
{
    Set<Id> ParentId = new Set<Id>();
    for(Integer i = 0; i < opp.size(); i++)
    {
        Opportunity newOpp = opp[i];
        Opportunity oldOppRecord = oldOpp[i];
        
        if(newOpp.AccountId != oldOppRecord.AccountId)
        {
            ParentId.add(newOpp.AccountId);
            ParentId.add(oldOppRecord.AccountId);
        }
        else
        {
            ParentId.add(newOpp.AccountId);
        }
    }
    
    List<AggregateResult> aggList = [SELECT AccountId ids, Avg(Amount) Avgsum FROM Opportunity WHERE AccountId IN: ParentId GROUP BY AccountId];
    List<Account> accountsToUpdate = new List<Account>();
    
    for(AggregateResult agg : aggList)
    {
        Account acc = new Account();
        acc.Id = (Id)agg.get('ids');
        acc.Opportunity_Average__c = (Decimal)agg.get('Avgsum');
        accountsToUpdate.add(acc);
    }
    
    update accountsToUpdate;
}

    public static void TotalAccountAmountInsertHandler(List<Opportunity> opp) {
        Set<Id> ParentId = new Set<Id>();
       
        for(Opportunity op: opp)
        {
            ParentId.add(op.AccountId);
        }
        List<AggregateResult> aggList = [SELECT AccountId ids, Avg(Amount) Avgsum from Opportunity where AccountId IN: ParentId Group By AccountId];
        List<Account> mp = new List<Account>();
        for(AggregateResult agg: aggList)
        {
            Account acc = new Account();
            acc.id = (id)agg.get('ids');
            acc.Opportunity_Average__c = (decimal)agg.get('Avgsum');
            mp.add(acc);
        }
        update mp;
    
    }
    public static void TotalAccountAmountDeleteHandler(List<Opportunity> opp) {
        Set<Id> ParentId = new Set<Id>();
        for(Opportunity op : opp)
        {
            ParentId.add(op.AccountId);
        }
        List<AggregateResult> aggList = [SELECT AccountId ids, Avg(Amount) Avgsum from Opportunity where AccountId IN: ParentId Group By AccountId];
        System.debug(aggList);
        List<Account> mp = new List<Account>();
        if(aggList.size() == 0)
        {
            for(Id acc : ParentId)
            {
                Account accn = new Account();
                accn.id = acc;
                accn.Opportunity_Average__c = 0;
                mp.add(accn);
            }

        }
        else
        {
            for(AggregateResult agg: aggList)
            {
                Account acc = new Account();
                acc.id = (id)agg.get('ids');
                acc.Opportunity_Average__c = (decimal)agg.get('Avgsum');
                
                mp.add(acc);
    
            }
        }
        update mp;
    }
}