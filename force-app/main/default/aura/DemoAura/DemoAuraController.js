({
    handleSubmit: function(component, event, helper) {
        // Initialize the action from the Apex controller
        let firstName = component.find("firstName");
        let lastName = component.find("lastName");
        let dob = component.find("dob");
        let age = component.find("age");
        let gender = component.find("gender");
        let mobileNumberr = component.find("mobileNumber");


        // Use reportValidity() to validate fields
        console.log("inside handle submit");
        let m = component.find("mobileNumber");
        let validity1 = m.get("v.validity");

        let m2 = component.find("firstName");
        let validity2 = m2.get("v.validity");

        let m3 = component.find("lastName");
        let validity3 = m3.get("v.validity");

        let m4=component.find("age");
        let validity4= m4.get("v.validity");

        var ans="";

        if (!validity1.valid || !validity2.valid || !validity3.valid || !validity4.valid) {
            var c1=0;
            var c2=0;
            var c3=0;
            var c4=0;
            if(!validity1.valid)
                {
                    m.showHelpMessageIfInvalid();
                    c1++;
                }
            if(!validity2.valid){
                m2.showHelpMessageIfInvalid();
                c2++;
            }
            if(!validity3.valid){
            m3.showHelpMessageIfInvalid();
            c3++;
            }
            if(!validity4.valid){
                m4.showHelpMessageIfInvalid();
                c4++;
                }
            if(c2){
                ans+="First Name ";
            }
            if(c3){
                ans+="Last Name ";
            }
            if(c1)
                {
                    ans+="Mobile Number ";
                }
                if(c4)
                    {
                        ans+="age correctly ";
                    }
            let toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                "title": "Error",
                "message": "Enter "+ans,
                "type": "error"
            });
            toastEvent.fire();
            return;
        }

        let action = component.get("c.createStudent");
        if (!action) {
            console.error('Action is undefined.');
            return;
        }

        // Set the parameters for the action
        action.setParams({
            firstName: component.get("v.firstName"),
            lastName: component.get("v.lastName"),
            dob: component.get("v.dateOfBirth"),
            age: component.get("v.age"),
            gender: component.get("v.gender"),
            mobileNo: component.get("v.mobileNumber"),
            graduated: component.get("v.graduated")
        });

        // Define the callback function
        action.setCallback(this, function(response) {
            let state = response.getReturnValue();
            if (state === "SUCCESS") {
                let toastEvent = $A.get("e.force:showToast");
                
                toastEvent.setParams({
                    "title": "Success",
                    "message": "Record inserted successfully.",
                    "type": "success"
                });
                toastEvent.fire();
                
            } else {
                
                let toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "title": "Error",
                    "message": "Error message: " + state,
                    "type": "error"
                });
                toastEvent.fire();
            }
        });

        // Enqueue the action
        $A.enqueueAction(action);
    },
    handlechange: function(cmp, event) {
        let mobileNumber = cmp.find("mobileNumber");
        let validity = mobileNumber.get("v.validity");

        // if (!validity.valid) {
        //     let toastEvent = $A.get("e.force:showToast");
        //     toastEvent.setParams({
        //         "title": "Error",
        //         "message": "Please enter a valid 10-digit mobile number.",
        //         "type": "error"
        //     });
        //     toastEvent.fire();
        // }
    }
    
})