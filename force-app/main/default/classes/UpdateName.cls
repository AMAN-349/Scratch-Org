public class UpdateName {
    public static void fn1()
    {
    	List<PersonDetail__c> l1=[Select Id,Name from PersonDetail__c];
    	for(PersonDetail__c it:l1)
    	{
        	it.Name='Aman'+it.Name;
            System.debug(it.Name);
    	}
        
    }
}