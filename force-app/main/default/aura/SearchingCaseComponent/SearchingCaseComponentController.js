({
    doInit: function (component, event, helper) {
      component.set("v.columns", [
          {label: "Case Number", fieldName: "linkName", type: "url",
          typeAttributes: {label: { fieldName: "CaseNumber" }, target: "_blank"}},
        { label: "Status", fieldName: "Status", type: "text" },
        { label: "Priority", fieldName: "Priority", type: "text" },
        { label: "Origin", fieldName: "Origin", type: "text" }
      ]);
    },
   
    handleSubmit: function (component, event, helper) {
      let action = component.get("c.finder");
      let caseN = component.get("v.searchV");
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
   
      action.setParams({
        caseNumber: caseN
      });
   
      action.setCallback(this, function (response) {
        let state = response.getState();
        if (state === "SUCCESS") {
          let newRecord = response.getReturnValue();
         
          if (newRecord) {
             
              newRecord.CaseNumber = newRecord.CaseNumber;
              newRecord.linkName = '/' + newRecord.Id;
         
            component.set("v.showError", false);
            component.set("v.showResults", true);
   
            component.set("v.datatable", []);
   
            $A.createComponent(
              "lightning:datatable",
              {
                "aura:id": "dynamicDatatable",
                "data": [newRecord],
                "columns": component.get("v.columns"),
                "keyField": "Id"
              },
              function (newDatatable, status, errorMessage) {
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
   
            let toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
              title: "Success",
              message: "Records retrieved successfully.",
              type: "success"
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
   
   
          let toastEvent = $A.get("e.force:showToast");
          toastEvent.setParams({
            title: "Error",
            message: "Error message: No Case Found",
            type: "error"
          });
          toastEvent.fire();
        }
      });
   
      $A.enqueueAction(action);
    },
   
    handleOnchange: function (component, event, helper) {
      let action = component.get("c.finderlist");
      let caseN = component.get("v.searchV");
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
      action.setParams({
        caseNumber: caseN
      });
   
      action.setCallback(this, function (response) {
        let state = response.getState();
        if (state === "SUCCESS") {
          let cases = response.getReturnValue();
          if (cases.length > 0) {
   
              cases.forEach(function(record) {
                  record.CaseNumber = record.CaseNumber;
                  record.linkName = '/' + record.Id;
              });
   
            component.set("v.showError", false);
            component.set("v.showResults", true);
           
            component.set("v.datatable", []);
   
            $A.createComponent(
              "lightning:datatable",
              {
                "aura:id": "dynamicDatatable",
                "data": cases,
                "columns": component.get("v.columns"),
                "keyField": "Id"
              },
              function (newDatatable, status, errorMessage) {
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
  });