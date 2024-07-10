import { LightningElement, api } from 'lwc';

export default class TestingChild extends LightningElement {
    @api
    getvalue() {
        return 'Some value';
    }

    _name;

    get name()
    {
        return this._name;
    }


    set name(value)
    {
        this._name = value;
    }
}