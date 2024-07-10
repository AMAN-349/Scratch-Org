/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 06-05-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class StudentController {
  @AuraEnabled
  public static string createStudent(
    String firstName,
    String lastName,
    Date dob,
    Integer age,
    String gender,
    String mobileNo,
    Boolean graduated
  ) {
      New_Student__c student = new New_Student__c(
      First_Name__c = firstName,
      Last_Name__c = lastName,
      Date_of_Birth__c = dob,
      Age__c = age,
      Gender__c = gender,
      Mobile_No__c = mobileNo,
      Graduated__c = graduated
    );

    try {
      insert student;
      return 'SUCCESS';
    } catch (Exception e) {
      String exec = e.getMessage();
      return exec;
    }
  }
}