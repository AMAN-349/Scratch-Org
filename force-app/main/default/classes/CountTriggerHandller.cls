public class CountTriggerHandller {
    public static void func(List<Account> acc)
    {
        List<PersonDetail__c> data=new List<PersonDetail__c>();
        for(Account i:acc)
        {
            PersonDetail__c per=new PersonDetail__c();
            per.Name=i.Name;
            per.Person_Phone__c=i.Phone;
            per.Description__c=i.Description;
            per.Person_Email__c=i.Email__c;
            per.Person_Employee_ID__c=i.id;
            per.Parent_Account__c=i.ParentId;
            data.add(per);
        }
        insert data;
        
    }
    
    public static void func2(List<PersonDetail__c> l1,Map<Id,PersonDetail__c> m1)
    {
        
        for(PersonDetail__c p1:l1)
        {
            if(m1!=NULL && (p1.Person_Phone__c!=m1.get(p1.Id).Person_Phone__c) || (p1.Person_Phone__c!=m1.get(p1.Id).Person_Phone__c))
            {
                p1.Description__c='Your Phone number or email is updated';
            }
        }
    }
}