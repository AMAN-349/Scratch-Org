({
	getNumberOfAccounts : function(component, event, helper) {
        component.set("v.showSpinner", true);
		var action = component.get('c.countAccounts'); 
        
        action.setCallback(this, function(a){
            component.set("v.showSpinner", false);

            var state = a.getState(); // get the response state
            if(state == 'SUCCESS') {
                component.set('v.numberOfRecords', a.getReturnValue());
            }
        });
        $A.enqueueAction(action);
	},
    
    dmlOnRecordWithoutSharing : function(component, event, helper) {
        component.set("v.showSpinner", true);
		var action = component.get('c.performDML'); 

        action.setCallback(this, function(a){
            component.set("v.showSpinner", false);

            var state = a.getState(); // get the response state
            if(state == 'SUCCESS') {
                alert('Success');
            } else {
                alert(JSON.stringify(a.getError()[0]));
            }
        });
        $A.enqueueAction(action);
	},
    
    dmlOnRecordWithSharing : function(component, event, helper) {
        component.set("v.showSpinner", true);
		var action = component.get('c.performDMLWithSharing'); 

        action.setCallback(this, function(a){
            component.set("v.showSpinner", false);

            var state = a.getState(); // get the response state
            if(state == 'SUCCESS') {
                alert('Success');
            } else {
                alert(JSON.stringify(a.getError()[0]));
            }
        });
        $A.enqueueAction(action);
	},
    
    dmlOnRecordInheritedSharing : function(component, event, helper) {
        component.set("v.showSpinner", true);
		var action = component.get('c.performDMLInheritedSharing'); 

        action.setCallback(this, function(a){
            component.set("v.showSpinner", false);

            var state = a.getState(); // get the response state
            if(state == 'SUCCESS') {
                alert('Success');
            } else {
                alert(JSON.stringify(a.getError()[0]));
            }
        });
        $A.enqueueAction(action);
	},
    
    dmlOnRecord : function(component, event, helper) {
        component.set("v.showSpinner", true);
		var action = component.get('c.performDML'); 
        
        action.setCallback(this, function(a){
            component.set("v.showSpinner", false);

            var state = a.getState(); // get the response state
            if(state == 'SUCCESS') {
                alert('Success');
            } else {
                alert(JSON.stringify(a.getError()[0]));
            }
        });
        $A.enqueueAction(action);
	},
    
    schemaCRUD : function(component, event, helper) {
        component.set("v.showSpinner", true);
		var action = component.get('c.CRUD'); 
        
        action.setCallback(this, function(a){
            component.set("v.showSpinner", false);

            var state = a.getState(); // get the response state
            if(state == 'SUCCESS') {
                alert('Success');
            } else {
                alert(JSON.stringify(a.getError()[0]));
            }
        });
        $A.enqueueAction(action);
	},
    
    schemaFLS : function(component, event, helper) {
        component.set("v.showSpinner", true);
		var action = component.get('c.FLS'); 
        
        action.setCallback(this, function(a){
            component.set("v.showSpinner", false);

            var state = a.getState(); // get the response state
            if(state == 'SUCCESS') {
                alert('Success');
            } else {
                alert(JSON.stringify(a.getError()[0]));
            }
        });
        $A.enqueueAction(action);
	},

    SOQLStripInaccessible : function(component, event, helper) {
        component.set("v.showSpinner", true);
		var action = component.get('c.stripInaccessibleSOQL'); 
        
        action.setCallback(this, function(a){
            component.set("v.showSpinner", false);

            var state = a.getState(); // get the response state
            if(state == 'SUCCESS') {
                alert('Success');
            } else {
                alert(JSON.stringify(a.getError()[0]));
            }
        });
        $A.enqueueAction(action);
	},
    

    DMLStripInaccessible : function(component, event, helper) {
        component.set("v.showSpinner", true);
		var action = component.get('c.stripInaccessibleDML'); 
        
        action.setCallback(this, function(a){
            component.set("v.showSpinner", false);

            var state = a.getState(); // get the response state
            if(state == 'SUCCESS') {
                alert('Success');
            } else {
                alert(JSON.stringify(a.getError()[0]));
            }
        });
        $A.enqueueAction(action);
	},
    
    retrieveRecordsWithSecurityEnforced : function(component, event, helper) {
        component.set("v.showSpinner", true);
		var action = component.get('c.securityEnforcedSOQL'); 
        
        action.setCallback(this, function(a){
            component.set("v.showSpinner", false);

            var state = a.getState(); // get the response state
            if(state == 'SUCCESS') {
                alert('Success');
            } else {
                alert(JSON.stringify(a.getError()[0]));
            }
        });
        $A.enqueueAction(action);
	},
    
    retrieveRecordsWithSecurityEnforcedAndWhereClause : function(component, event, helper) {
        component.set("v.showSpinner", true);
		var action = component.get('c.withSecuirtyEnforcedAndWhereClause'); 
        
        action.setCallback(this, function(a){
            component.set("v.showSpinner", false);

            var state = a.getState(); // get the response state
            if(state == 'SUCCESS') {
                alert('Success');
            } else {
                alert(JSON.stringify(a.getError()[0]));
            }
        });
        $A.enqueueAction(action);
	},
    
    userModeSOQL : function(component, event, helper) {
        component.set("v.showSpinner", true);
		var action = component.get('c.withUserModeAndWhereClause'); 
        
        action.setCallback(this, function(a){
            component.set("v.showSpinner", false);

            var state = a.getState(); // get the response state
            if(state == 'SUCCESS') {
                alert('Success');
            } else {
                alert(JSON.stringify(a.getError()[0]));
            }
        });
        $A.enqueueAction(action);
	},
    
    userModeDML : function(component, event, helper) {
        component.set("v.showSpinner", true);
		var action = component.get('c.performDMLWithUserMode'); 
        
        action.setCallback(this, function(a){
            component.set("v.showSpinner", false);

            var state = a.getState(); // get the response state
            if(state == 'SUCCESS') {
                alert('Success');
            } else {
                alert(JSON.stringify(a.getError()[0]));
            }
        });
        $A.enqueueAction(action);
	},
})