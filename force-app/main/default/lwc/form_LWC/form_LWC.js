import { LightningElement, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
 

export default class formComponent extends LightningElement {
    @track formData = {
        name: '',
        gender: '',
        email: '',
        dob: '',
        address: ''
    };
 
    @track dataTable = [];
    @track showData = false;
    @track isSubmitDisabled = true;
 
    genderOptions = [
        { label: 'Male', value: 'male' },
        { label: 'Female', value: 'female' },
        { label: 'Other', value: 'other' }
    ];
 
    columns = [
        { label: 'Name', fieldName: 'name' },
        { label: 'Gender', fieldName: 'gender' },
        { label: 'Email', fieldName: 'email' },
        { label: 'Date of Birth', fieldName: 'dob' },
        { label: 'Address', fieldName: 'address' }
    ];
 
    handleInputChange(event) {
        const field = event.target.name;
        this.formData = { ...this.formData, [field]: event.target.value };
        this.validateForm();
    }
 
    handleCancel() {
        this.formData = {
            name: '',
            gender: '',
            email: '',
            dob: '',
            address: ''
        };
        this.isSubmitDisabled = true;
    }
 
    handleSubmit() {
        this.dataTable = [...this.dataTable, { ...this.formData, id: this.dataTable.length + 1 }];
        this.dispatchEvent(new ShowToastEvent({
            title: 'Success',
            message: 'Form submitted successfully',
            variant: 'success'
        }));
        this.handleCancel();
    }
 
    handleShowData() {
        this.showData = true;
    }
 
    validateForm() {
        const { name, gender, email, dob, address } = this.formData;
        const emailPattern = this.template.querySelector('[data-id="email"]');
        emailPattern.reportValidity();
        this.isSubmitDisabled = !(
          name &&
          gender &&
          email &&
          emailPattern.checkValidity() &&
          dob &&
          address
        );
    }
    
}