import { LightningElement, track } from 'lwc';

export default class Testing extends LightningElement {
    @track str;

    handleClick() {
        let childcmp = this.template.querySelector('c-testingchild');
        if (childcmp) {
            this.str = childcmp.getvalue();
            console.log(this.str);
        }
    }
}