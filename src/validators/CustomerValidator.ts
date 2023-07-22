import Joi from "joi";
import { ICustomer } from "../types";

class CustomerValidator {
    static store_request = (req_body: ICustomer) => Joi.object({
        first_name: Joi.string().required(),
        middle_name: Joi.string().required(),
        last_name: Joi.string().required(),
        email: Joi.string().email().required(),
        phone: Joi.string().max(10).required(),
        password: Joi.string().min(6).max(18).required(),
        repeat_password: Joi.ref('password'),
        date_of_birth: Joi.string().required(),
        gender: Joi.string().required(),
        documents: Joi.array(),
        address: Joi.object({
            country: Joi.string(),
            state: Joi.string().required(),
            city: Joi.string().required(),
            district: Joi.string().required(),
            landmark: Joi.string().required()
        }).required(),
        account: Joi.object({
            account_type: Joi.string().required(),
            account_balance: Joi.number().default(0),
            document: Joi.object({
                document_type: Joi.string().required(),
                document_number: Joi.number().required()
            }).required(),
        }).required()
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