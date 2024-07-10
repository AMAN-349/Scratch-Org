import { LightningElement, track } from 'lwc';

export default class FormTable extends LightningElement {
    @track formData = {
        name: "",
        email: "",
        phone: ""
    };

    @track email;
    @track toggleValue=false;

    @track data = [];

    handleInputChange(event) {
        const field = event.target.dataset.id;
        this.formData[field] = event.target.value;
    }

    handleSubmit() {
        // Create a new object to avoid mutation issues
        const newData = { ...this.formData };
        this.data = [...this.data, newData];
    }

    handletoggle(event)
    {
        this.toggleValue=event.target.checked;
    }

    handlechange(event)
    {
        this.email = event.target.value;
    }

    handledelete(event)
    {

        this.data = this.data.filter(item => item.email !== this.email);
    }
}