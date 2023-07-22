import { Router } from "express";
import { AdminController } from "../controllers";

const adminRouter = Router();

// Create a new customer.
adminRouter.post('/customers/', AdminController.storeCustomer);

// View Customers.
adminRouter.get('/customers/', AdminController.getCustomers);

// Update a customer.
adminRouter.put('/customers/:id', AdminController.updateCustomer);

// Delete a customer.
adminRouter.delete('/customers/:id', AdminController.deleteCustomer);


export default adminRouter;