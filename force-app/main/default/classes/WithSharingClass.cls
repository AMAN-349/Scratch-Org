/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 05-18-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class WithSharingClass {
    @AuraEnabled
    public static Integer countAccounts() {
        return [Select Id, Name, Active__c from Account].size();
    }
   
    public static void performDML(Account a) {
        if (Schema.sObjectType.Contact.isCreateable()) {
            Contact con = new Contact(LastName='TestContactwithsharing', AccountId = a.Id);
            insert con;
        } else {
            throw new AuthorisationException('Insufficient permissions to create Contact.');
        }
    }
   
    @AuraEnabled
    public static void performDML() {
        Account a = [Select Id from Account where Name = 'Acme Corporation' LIMIT 1];
        if (Schema.sObjectType.Contact.isCreateable()) {
            Contact con = new Contact(LastName='TestContactwithsharing', AccountId = a.Id);
            insert con;
        } else {
            throw new AuthorisationException('Insufficient permissions to create Contact.');
        }
    }
   
    @AuraEnabled
    public static void performDMLWithoutSharing() {
        Account a = [Select Id from Account where Name = 'Acme Corporation' LIMIT 1];
        if (Schema.sObjectType.Contact.isCreateable()) {
            Contact con = new Contact(LastName='TestContactwithsharing', AccountId = a.Id);
            insert con;
        } 
        else {
            throw new AuthorisationException('Insufficient permissions to create Contact.');
        }
    }
   
    @AuraEnabled
    public static void performDMLInheritedSharing() {
        if (Schema.sObjectType.Contact.isCreateable()) {
        InheritedSharing.performDML();
        }
        else {
            throw new AuthorisationException('Insufficient permissions to create Contact.');
        }
    }
   
    @AuraEnabled
    public static String CRUD() {
        if (!Schema.SObjectType.Account.isAccessible()) {
            return 'Access Denied';
        } else {
            return 'Access Provided';
        }
    }
   
    @AuraEnabled
    public static String FLS() {
        if (!Schema.SObjectType.Account.fields.Name.isAccessible()) {
            return 'Access Denied';
        } else {
            return 'Access Provided';
        }
    }
   
    @AuraEnabled
    public static void stripInaccessibleSOQL() {
        SObjectAccessDecision securityDecision = Security.stripInaccessible(
                                         AccessType.READABLE, [Select id from Account]);
        System.debug(securityDecision.getRecords());
    }
   
    @AuraEnabled
    public static void stripInaccessibleDML() {
        List<Account> newAccounts = new List<Account>();
        Account a = new Account(Name='Acme Corporation');
        Account b = new Account(Name='Blaze Comics', Rating='Warm');
        newAccounts.add(a);
        newAccounts.add(b);
       
        SObjectAccessDecision securityDecision = Security.stripInaccessible(
            AccessType.CREATABLE, newAccounts);
       
        insert securityDecision.getRecords();
       
        System.debug(securityDecision.getRemovedFields().get('Account')); // Prints "Rating"
        System.debug(securityDecision.getModifiedIndexes()); // Prints "1"
    }
   
    @AuraEnabled
    public static void securityEnforcedSOQL() {
         System.debug([Select Id, Name, Active__c from Account WITH SECURITY_ENFORCED].size());
    }
   
    @AuraEnabled
    public static void withSecurityEnforcedAndWhereClause() {
         System.debug([Select Id, Name from Account where Rating = 'Warm' WITH SECURITY_ENFORCED].size());
    }
   
    @AuraEnabled
    public static void withUserModeAndWhereClause() {
         System.debug([Select Id, Name from Account where Rating = 'Warm' WITH USER_MODE].size());
    }
   
    @AuraEnabled
    public static void performDMLWithUserMode() {
         Account a = [Select Id from Account where Name = 'System Admin Created' LIMIT 1];
         //CRUD, FLS and Sharing Rule is enforced
         update as user a;
    }
}