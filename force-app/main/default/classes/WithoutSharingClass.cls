/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 05-18-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public without sharing class WithoutSharingClass {
    @AuraEnabled
    public static Integer countAccounts() {
        return [SELECT Id, Name, Active__c FROM Account].size();
    }

    public static void performDML(Account a) {
        Contact con = new Contact(LastName = 'TestContactwithoutsharing', AccountId = a.Id);
        try {
            // Using Database.insert to bypass sharing rules
            Database.insert(con, false);
        } catch (DmlException e) {
            System.debug('Error inserting Contact: ' + e.getMessage());
        }
    }

    @AuraEnabled
    public static void performDML() {
        List<Account> accounts = [SELECT Id FROM Account WHERE Name = 'Acme Corporation' LIMIT 1];
        if (accounts.isEmpty()) {
            throw new AuthorisationException('No Account found with the name Acme Corporation.');
        }
        Account a = accounts[0];
        Contact con = new Contact(LastName = 'TestContactwithoutsharing', AccountId = a.Id);
        try {
            // Using Database.insert to bypass sharing rules
            Database.insert(con, false);
        } catch (DmlException e) {
            System.debug('Error inserting Contact: ' + e.getMessage());
        }
    }

    @AuraEnabled
    public static void performDMLWithSharing() {
        Account a = [SELECT Id FROM Account WHERE Name = 'Acme Corporation' LIMIT 1];
        WithSharingClass.performDML(a);
    }

    @AuraEnabled
    public static void performDMLInheritedSharing() {
        InheritedSharing.performDML();
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
            AccessType.READABLE, [SELECT id FROM Account]);
        System.debug(securityDecision.getRecords());
    }

    @AuraEnabled
    public static void stripInaccessibleDML() {
        List<Account> newAccounts = new List<Account>();
        Account a = new Account(Name = 'Acme Corporation');
        Account b = new Account(Name = 'Blaze Comics', Rating = 'Warm');
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
        System.debug([SELECT Id, Name, Active__c FROM Account WITH SECURITY_ENFORCED].size());
    }

    @AuraEnabled
    public static void withSecurityEnforcedAndWhereClause() {
        System.debug([SELECT Id, Name FROM Account WHERE Rating = 'Warm' WITH SECURITY_ENFORCED].size());
    }

    @AuraEnabled
    public static void withUserModeAndWhereClause() {
        System.debug([SELECT Id, Name FROM Account WHERE Rating = 'Warm' WITH USER_MODE].size());
    }

    @AuraEnabled
    public static void performDMLWithUserMode() {
        Account a = [SELECT Id FROM Account WHERE Name = 'System Admin Created' LIMIT 1];
        update as user a;
    }
}