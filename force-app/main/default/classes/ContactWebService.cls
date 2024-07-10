/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 05-15-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
@RestResource(urlMapping='/Contact/*')
global with sharing class ContactWebService {
    @HttpGet
    global static Contact getRecord() {
        // Add your code
        RestRequest request = RestContext.request;
        // grab the caseId from the end of the URL
        String conId = request.requestURI.substring(
          request.requestURI.lastIndexOf('/')+1);
        Contact result =  [SELECT Name
                        FROM Contact
                        WHERE Id = :conId];
        return result;

    }
}