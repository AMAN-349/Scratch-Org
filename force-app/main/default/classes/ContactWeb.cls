/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 05-15-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
@RestResource(urlMapping='/Cont/*')
global with sharing class ContactWeb {
    @HttpGet
    global static Contact getRecord() {
        RestRequest request = RestContext.request;
        String conId = request.requestURI.substring(
          request.requestURI.lastIndexOf('/')+1);
        Contact result =  [SELECT Name
                        FROM Contact
                        WHERE Id = :conId];
        return result;

    }
    @HttpPost
    global static Id postRecord(String name)
    {
        Contact con=new Contact(FirstName=name);
        insert con;
        return con.id;
    }

    @HttpPut
    global static Id putRecord(String name)
    {
        Contact con=new Contact(FirstName=name);
        upsert con;
        return con.Id;
    }

    @HttpDelete
    global static void deleteRecord()
    {
        RestRequest req=RestContext.request;
        String myId=req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        Contact c=[Select Id,Name from Contact where Id=:myId];
        delete c;
    }
    
    @HttpPatch
    global static Id patchRecord()
    {
        RestRequest request = RestContext.request;
        String conId = request.requestURI.substring(
            request.requestURI.lastIndexOf('/')+1);
        Contact thisContact = [SELECT Id FROM Contact WHERE Id = :conId];
        Map<String, Object> params = (Map<String, Object>)JSON.deserializeUntyped(request.requestbody.tostring());
        for(String fieldName : params.keySet()) {
            thisContact.put(fieldName, params.get(fieldName));
        }
        update thisContact;
        return thisContact.Id;
    }


    
}