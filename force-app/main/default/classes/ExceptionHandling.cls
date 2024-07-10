public class ExceptionHandling {
    public static void exceptionmethod(String logDetails, String processName)
    {
        Error_Log__c loger=new Error_Log__c();
        loger.Log_Date_Time__c=dateTime.now();
        loger.Log_Details__c=logDetails;
        loger.Process_Name__c=processName;
        try{
            insert loger;
        }
        catch(Exception e)
        {
            System.debug('Error'+e.getMessage());
        }
    }
}