public class RecordFormController {
    @AuraEnabled
    public static Map<String, String> getFormValues(String firstName, String lastName, String workEmail, String phone, String company) {
        Map<String, String> formValues = new Map<String, String>();
        formValues.put('FirstName', firstName);
        formValues.put('LastName', lastName);
        formValues.put('WorkEmail', workEmail);
        formValues.put('Phone', phone);
        formValues.put('Company', company);
        return formValues;
    }
}