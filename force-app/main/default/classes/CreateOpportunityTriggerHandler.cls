/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 05-30-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class CreateOpportunityTriggerHandler {
    public static void createOpportunity(List<Account> newAccounts) {
        List<Opportunity> opportunitiesToInsert = new List<Opportunity>();
       
        for (Account acc : newAccounts) {
            if (Schema.sObjectType.Opportunity.isCreateable()) {
                Opportunity opp = new Opportunity();
                opp.Name = acc.Name;
                opp.StageName = 'Prospecting';
                opp.CloseDate = Date.today().addDays(3);
                opportunitiesToInsert.add(opp);
            }
        }
       
        if (!opportunitiesToInsert.isEmpty()) {
            insert opportunitiesToInsert;
        }
    }
 
    public static void createOpportunityUserMode(List<Account> newAccounts){
        List<Opportunity> opportunitiesToInsert = new List<Opportunity>();
 
        for(Account acc : newAccounts){
            Opportunity opp = new Opportunity();
            opp.Name = acc.Name;
            opp.StageName = 'Prospecting';
            opp.CloseDate = Date.today().addDays(3);
            opportunitiesToInsert.add(opp);
        }
 
        if(!opportunitiesToInsert.isEmpty()){
            Database.insert(opportunitiesToInsert, true, AccessLevel.User_mode);
        }
    }
}