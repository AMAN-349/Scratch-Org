import { LightningElement } from 'lwc';

export default class DemoLwc extends LightningElement {
    name='';
    handleInputChange(event)
    {
        this.name=event.target.value;
    }
}