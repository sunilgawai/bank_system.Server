import { Request, Response, NextFunction } from 'express';

class CustomerController {
    static async getTransaction(req: Request, res: Response, next: NextFunction): Promise<any> {
        try {
            
        } catch (error) {
            
        }
    }

    static async getCustomers(req: Request, res: Response, next: NextFunction): Promise<any> {
        try {
            
        } catch (error) {
            return next(error);
        }
    }

    static async updateCustomer(req: Request, res: Response, next: NextFunction): Promise<any> {

        res.json(req.body);
    }

    static async deleteCustomer(req: Request, res: Response, next: NextFunction): Promise<any> {
        
        try {
            
        } catch (error) {
            return next(error);
        }
    }
}

export default CustomerController;