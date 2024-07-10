/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 05-17-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public inherited sharing class InheritedSharing {
    public static void performDML() {
        Account a = [Select Id from Account where Name = 'Acme Corporation' LIMIT 1];
        Contact con = new Contact(LastName = 'TestContactInheritedSharing');
        con.AccountId = a.Id;
        insert con;
    }
}