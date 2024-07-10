public class CandidateClass {
  public void perform(String name,String phone, String email){            
        Candidate__c candidate =new Candidate__c(
        Name=name,
        Email__c=email,
        Phone__c=phone);
        insert candidate; 	 		
        createCandidateAnother(candidate.Name,candidate.Phone__c, candidate.Email__c);
    }
   @future(callout = true)
    public static void createCandidateAnother(String name,String phone,String email){
        CalloutClass c = new CalloutClass();
        c.createCandidateC(name,phone,email);  
    }
 
}