@isTest
public class ExceptionHandlingTest {
    @isTest
    static void testExceptionMethod() {
        String logDetails = 'Test log details';
        String processName = 'Test process name';

        Test.startTest();
        ExceptionHandling.exceptionmethod(logDetails, processName);
        Test.stopTest();

        List<Error_Log__c> logs = [SELECT Log_Date_Time__c, Log_Details__c, Process_Name__c FROM Error_Log__c WHERE Process_Name__c = :processName];
        System.assertEquals(1, logs.size(), 'There should be one log record');
    }

    @isTest
    static void testExceptionMethodWithException() {
        String logDetails = null;
        String processName = 'Test process name with exception';

        Test.startTest();
        ExceptionHandling.exceptionmethod(logDetails, processName);
        Test.stopTest();

        List<Error_Log__c> logs = [SELECT Log_Date_Time__c, Log_Details__c, Process_Name__c FROM Error_Log__c WHERE Process_Name__c = :processName];
        System.assertEquals(0, logs.size(), 'There should be no log record due to exception');
    }
}