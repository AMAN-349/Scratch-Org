public class Updateclass {
    public static void con(List<Contact> c1,Map<Id,Contact> m1)
    {
        if(c1==NULL)
        {
            for(Id key:m1.keySet())
            {
                Account acc=m1.get(key).Account;
                acc.No_of_Contacts__c-=1;
                System.debug('Phase 1');
            }
        }
        if(m1!=NULL)
        {
            for(Id key:m1.keySet())
            {
                Account acc=m1.get(key).Account;
                acc.No_of_Contacts__c+=1;
                System.debug('Phase 2');
            }
        }
    }
}