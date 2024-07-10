import { LightningElement, api, track } from 'lwc';

export default class TablePractice extends LightningElement {
    @track columns = [
        { label: "Name", fieldName: "name" },
        { label: "Email", fieldName: "email" },
        { label: "Phone", fieldName: "phone" }
    ];

    @api sets = [];
}