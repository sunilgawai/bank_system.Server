import { Request, Response, NextFunction } from 'express';
import { CustomerValidator } from '../../validators';
import { database } from '../../services/database';
import { ICustomer } from '../../types';
import { AccountService, CustomErrorHandler } from '../../services';

class AdminController {
    static async storeCustomer(req: Request, res: Response, next: NextFunction): Promise<any> {
        console.log("body", req.body);
        // Request Validation.
        const { error } = CustomerValidator.store_request(req.body);
        if (error) {
            return next(error);
        }
        const { first_name, middle_name, last_name, email, phone, password, repeat_password, gender, date_of_birth, account, documents, address } = req.body as ICustomer;
        const {
            account_type,
            account_balance,
            document: {
                document_number,
                document_type
            }
        } = account;

        // Database Validation.
        try {
            const exists = await database.customer.findFirst({
                where: {
                    OR: [
                        { phone: phone },
                        { email: email }
                    ]
                }
            });

            if (exists) {
                return next(CustomErrorHandler.alreadyExists("Customer already registered."));
            }
        } catch (error) {
            return next(error);
        }

        // Database Submissions.
        let customer;
        let account_number = await AccountService.generateAccountNumber();
        try {
            customer = await database.customer.create({
                data: {
                    first_name,
                    middle_name,
                    last_name,
                    email,
                    phone,
                    gender,
                    date_of_birth,
                    Accounts: {
                        create: {
                            account_type,
                            account_number,
                            Document: {
                                create: {
                                    document_number,
                                    document_type
                                }
                            }
                        }
                    },
                    Addresses: {
                        create: {
                            state: address.state,
                            city: address.city,
                            district: address.district,
                            landmark: address.landmark
                            // type: address.type
                        }
                    },
                    Documents: {
                        createMany: {
                            data: documents.map(_doc => ({
                                document_type: _doc.document_type,
                                document_number: _doc.document_number
                            }))
                        }
                    }
                },
                include: {
                    Accounts: true,
                    Addresses: true,
                    Documents: true
                }
            })
        } catch (error) {
            console.log("error saving customer", error);
            return next(error);
        }

        // User Operation.
        // Response.
        res.status(200).json({ customer });
    }

    static async getCustomers(req: Request, res: Response, next: NextFunction): Promise<any> {
        try {
            await database.customer.findMany({
                include: {
                    Accounts: true,
                    Addresses: true,
                    Documents: true
                }
            }).then((results) => {
                res.status(200).json(results);
            }).catch((err) => {
                return next(err);
            })
        } catch (error) {
            return next(error);
        }
    }

    static async updateCustomer(req: Request, res: Response, next: NextFunction): Promise<any> {

        res.json(req.body);
    }

    static async deleteCustomer(req: Request, res: Response, next: NextFunction): Promise<any> {
        if (!req.params.id) {
            return next(CustomErrorHandler.wrongCredentials("Wrong params."))
        }

        try {
            const customer = await database.customer.delete({
                where: {
                    id: req.params.id
                }
            })

            if (!customer) {
                return next(CustomErrorHandler.notFound("Customer not found."));
            }

            res.status(200).json(customer);
        } catch (error) {
            return next(error);
        }
    }
}

export default AdminController;