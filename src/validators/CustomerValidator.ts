import Joi from "joi";
import { ICustomer } from "../types";
export interface Customer {
    first_name: string;
    middle_name: string;
    last_name: string;
    phone: string;
    email: string;
    date_of_birth: string;
    gender: string;
    document_type: string;
    document_number: string;
    country: string;
    state: string;
    city: string;
    district: string;
    landmark: string;
    account_type: string;
    account_balance: number;
}
class CustomerValidator {
    static store_request = (req_body: ICustomer) => Joi.object({
        first_name: Joi.string().required(),
        middle_name: Joi.string().required(),
        last_name: Joi.string().required(),
        email: Joi.string().email().required(),
        phone: Joi.string().max(10).required(),
        date_of_birth: Joi.string().required(),
        gender: Joi.string().required(),
        document_type: Joi.string().required(),
        document_number: Joi.string().max(16).required(),
        country: Joi.string(),
        state: Joi.string().required(),
        city: Joi.string().required(),
        district: Joi.string().required(),
        landmark: Joi.string().required(),
        account_type: Joi.string().required(),
        account_balance: Joi.string().required(),
        submit: Joi.string().min(0)
    }).validate(req_body);

    static update_request = (req_body: object) => Joi.object({
        first_name: Joi.string(),
        last_name: Joi.string(),
        email: Joi.string().email(),
        phone: Joi.string(),
        country: Joi.number(),
        state: Joi.number(),
        city: Joi.number(),
        shop: Joi.string(),
        kyc: Joi.string(),
        address: Joi.string()
    }).validate(req_body);
}

export default CustomerValidator;