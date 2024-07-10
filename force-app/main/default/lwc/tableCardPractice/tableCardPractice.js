import { LightningElement,api } from 'lwc';

export default class TableCardPractice extends LightningElement {
    @api sets = [];
    get hasTableData() {
        return this.sets && this.sets.length > 0;
      }
}