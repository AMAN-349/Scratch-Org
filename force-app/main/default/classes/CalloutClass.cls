public class CalloutClass {
    public void createCandidateC(String name, String phone, String email){
        Http http = new Http();
        HttpRequest request=new HttpRequest();
        request.setEndpoint('callout:Assign_Cred/services/apexrest/Candidates');
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        request.setBody('{"name":"' + name + '","candPhone":"' + phone + '","candEmail":"' + email + '"}');
        try{
            HttpResponse response =http.send(request);
        system.debug(response.getStatusCode());
        if(response.getStatusCode()==200){
            System.debug(response);
            System.debug(response.getBody());
        }
        }Catch(Exception e){
           System.debug(e.getMessage()); 
        }
    }
}