({
    doInit : function(component, event, helper) {
        component.set("v.columns", [
            {label: "Case Number", fieldName: "CaseNumber", type: "text"},
            {label: "Status", fieldName: "Status", type: "text"}
        ]);
    },

    handlesubmit : function(component, event, helper) {
        let action = component.get("c.finder");
        let caseN=component.get("v.findValue");
        if (!caseN || caseN.length < 3) {
            if (!caseN) {
              component.set("v.showResults", false);
              component.set("v.showError", true);
              component.set("v.errorMessage", "Please enter a case number.");
            } else {
              component.set("v.showResults", false);
              component.set("v.showError", true);
              component.set(
                "v.errorMessage",
                "Please enter at least three characters."
              );
            }
            return;
          }
        action.setParams({ caseNumber: component.get("v.findValue") });

        action.setCallback(this, function(response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                let caseDetails = response.getReturnValue();
                if (caseDetails) {
                    component.set("v.showError", false);
                    component.set("v.showResults", true);

                    // Clear existing datatable components
                    component.set("v.datatable", []);

                    // Dynamically create the datatable component
                    $A.createComponent(
                        "lightning:datatable",
                        {
                            "aura:id": "dynamicDatatable",
                            "data": [caseDetails],
                            "columns": component.get("v.columns"),
                            "keyField": "Id"
                        },
                        function(newDatatable, status, errorMessage) {
                            if (status === "SUCCESS") {
                                let body = component.get("v.datatable");
                                body.push(newDatatable);
                                component.set("v.datatable", body);
                            } else if (status === "INCOMPLETE") {
                                console.log("No response from server or client is offline.");
                            } else if (status === "ERROR") {
                                console.log("Error: " + errorMessage);
                            }
                        }
                    );
                    
                    // Show success toast
                    let toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        "title": "Success",
                        "message": "Records retrieved successfully.",
                        "type": "success"
                    });
                    toastEvent.fire();
                } else {
                    component.set("v.showResults", false);
                    component.set("v.showError", true);
                    component.set("v.errorMessage", "Case Does Not Exist");
                }
            } else {
                component.set("v.showResults", false);
                component.set("v.showError", true);
                component.set("v.errorMessage", "Error in fetching case details");
                
                // Show error toast
                let toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "title": "Error",
                    "message": "Error message: " + state,
                    "type": "error"
                });
                toastEvent.fire();
            }
        });

        $A.enqueueAction(action);
    },

    handlechange : function(component, event, helper) {
        let action = component.get("c.finderlistsosl");
        action.setParams({ caseNumber: component.get("v.findValue") });
        let caseN=component.get("v.findValue");
        if (!caseN || caseN.length < 3) {
            if (!caseN) {
              component.set("v.showResults", false);
              component.set("v.showError", true);
              component.set("v.errorMessage", "Please enter a case number.");
            } else {
              component.set("v.showResults", false);
              component.set("v.showError", true);
              component.set(
                "v.errorMessage",
                "Please enter at least three characters."
              );
            }
            return;
          }

        action.setCallback(this, function(response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                let cases = response.getReturnValue();
                if (cases.length > 0) {
                    component.set("v.showError", false);
                    component.set("v.showResults", true);

                    // Clear existing datatable components
                    component.set("v.datatable", []);

                    // Dynamically create the datatable component
                    $A.createComponent(
                        "lightning:datatable",
                        {
                            "aura:id": "dynamicDatatable",
                            "data": cases,
                            "columns": component.get("v.columns"),
                            "keyField": "Id"
                        },
                        function(newDatatable, status, errorMessage) {
                            if (status === "SUCCESS") {
                                let body = component.get("v.datatable");
                                body.push(newDatatable);
                                component.set("v.datatable", body);
                            } else if (status === "INCOMPLETE") {
                                console.log("No response from server or client is offline.");
                            } else if (status === "ERROR") {
                                console.log("Error: " + errorMessage);
                            }
                        }
                    );
                } else {
                    component.set("v.showResults", false);
                    component.set("v.showError", true);
                    component.set("v.errorMessage", "No matching cases found.");
                }
            }
        });

        $A.enqueueAction(action);
    }
})