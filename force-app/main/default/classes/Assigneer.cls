public class Assigneer {
    public static void create() {
        Candidate__c con = new Candidate__c(Name = 'Abhi', Email__c = 'abhi345@gmail.com', Phone__c = '9866');
        insert con;
        receiver(con.Id);
    }

    @future(callout = true)
    public static void receiver(Id candidateId) {
        // Retrieve the Candidate__c record within the future method
        Candidate__c candi = [SELECT Name, Email__c, Phone__c FROM Candidate__c WHERE Id = :candidateId LIMIT 1];

        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:Assign_Cred/services/apexrest/Candidate');
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        request.setBody('{"name":'+ candi.Name +', "email":'+ Candi.Email__c +',"phone":'+ Candi.Phone__c +'}');

        HttpResponse response = http.send(request);
        System.debug(response.getBody());
    }
}