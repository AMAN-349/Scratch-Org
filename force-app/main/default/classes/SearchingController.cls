/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 06-05-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public without sharing class SearchingController {
    @AuraEnabled
    public static Case finder(String caseNumber)
    {
        return [SELECT CaseNumber, Status from Case where CaseNumber =: caseNumber LIMIT 1];
    } 
    @AuraEnabled
    public static List<Case> finderlist(String caseNumber)
    {
        if(caseNumber=='')
        {
            return [SELECT CaseNumber, Status from Case where CaseNumber =: 'caseNumber'];
        }
        String searchKey = caseNumber + '%';
        return [SELECT CaseNumber, Status FROM Case WHERE CaseNumber LIKE :searchKey];
    }
    @AuraEnabled
    public static List<Case> finderlistsosl(String caseNumber) {
        if(caseNumber=='')
        {
            return new List<Case>();
        }
        String searchKey = caseNumber + '*';
        List<List<SObject>> searchResults = [FIND :searchKey IN ALL FIELDS RETURNING Case (CaseNumber, Status)];
        List<Case> cases = (List<Case>) searchResults[0];
        return cases;
    }
}