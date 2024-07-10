({
    doInit : function(component, event, helper) {
        component.set("v.columns", [
            {label: "First Name", fieldName: "firstName", type: "text"},
            {label: "Last Name", fieldName: "lastName", type: "text"},
            {label: "Email", fieldName: "email", type: "email"},
            {label: "Phone", fieldName: "phone", type: "phone"},
            {label: "Company", fieldName: "company", type: "text"}
        ]);
    },

    Submit : function(component, event, helper) {
        // Get the values from the component's attributes
        let newRecord1 = component.get("v.first_name");
        let newRecord2 = component.get("v.last_name");
        let newRecord3 = component.get("v.email");
        let newRecord4 = component.get("v.phone");
        let newRecord5 = component.get("v.company");


        let newRecord = {
            "firstName": newRecord1,
            "lastName": newRecord2,
            "email": newRecord3,
            "phone": newRecord4,
            "company": newRecord5
        };
        

        if(!newRecord1 || !newRecord2 || !newRecord3 || !newRecord4 || !newRecord5) {
            var cnt1=0;
            var cnt2=0;
            var cnt3=0;
            var cnt4=0;
            var cnt5=0;

            if(!newRecord1) cnt1++;
            if(!newRecord2) cnt2++;
            if(!newRecord3) cnt3++;
            if(!newRecord4) cnt4++;
            if(!newRecord4) cnt4++;

            var ans="";
            ans+="Enter ";
            if(!newRecord1) ans+="First Name,";
            if(!newRecord2) ans+="Last Name,";
            if(!newRecord3) ans+="Email,";
            if(!newRecord4) ans+="Phone,";
            if(!newRecord5) ans+="Company";

            component.set("v.errorMessage", "All fields are required. Please fill in all the fields.");
            alert(ans);
            return;
        }

        component.set("v.errorMessage", "");

        
        let records = component.get("v.records");
        if (!records) {
            records = [];
        }
        records.push(newRecord);
        component.set("v.records", records);
        component.set("v.first_name", "");
        component.set("v.last_name", "");
        component.set("v.email", "");
        component.set("v.phone", "");
        component.set("v.company", "");
    }
})