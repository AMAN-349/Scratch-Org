({
    handleSubmit: function(component, event, helper) {
        var firstName = component.find("firstName").get("v.value");
        var lastName = component.find("lastName").get("v.value");
        var workEmail = component.find("workEmail").get("v.value");
        var phone = component.find("phone").get("v.value");
        var company = component.find("company").get("v.value");
        
        var action = component.get("c.getFormValues");
        action.setParams({
            firstName: firstName,
            lastName: lastName,
            workEmail: workEmail,
            phone: phone,
            company: company
        });
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var newRecord = response.getReturnValue();
                var records = component.get("v.records");
                records.push(newRecord);
                component.set("v.records", records);
            } else {
                console.error(response.getError());
            }
        });
        
        $A.enqueueAction(action);
        component.find("firstName").set("v.value","");
        component.find("lastName").get("v.value","");
        component.find("workEmail").get("v.value","");
        component.find("phone").get("v.value","");
        component.find("company").get("v.value","");
    }
})