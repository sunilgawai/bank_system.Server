import { Router } from "express";
import { AccountController, AdminController } from "../controllers";
import { auth } from "../middlewares";

const adminRouter = Router();

// Create a new customer.
adminRouter.get('/details', AdminController.getAllDetails);


// Create a new customer.
adminRouter.post('/customers/', AdminController.storeCustomer);

// Get Customers.
adminRouter.get('/customers/', AdminController.getCustomers);

adminRouter.get('/accounts/history', AdminController.getAllAccountHistory);

// View Customers.
adminRouter.get('/customers/:id', auth, AdminController.viewCustomer);

// Update a customer.
adminRouter.put('/customers/:id', AdminController.updateCustomer);

// Delete a customer.
adminRouter.delete('/customers/:id', AdminController.deleteCustomer);


// Get Accounts.
adminRouter.get('/accounts/', AccountController.getAccountsList);

// View Account.
adminRouter.get('/accounts/:id', AccountController.viewAccount);

// Update a Account.
adminRouter.put('/accounts/:id', AccountController.updateAccount);

// Delete a Account.
adminRouter.delete('/accounts/:id', AccountController.deleteAccount);


// Delete a Account.

export default adminRouter;