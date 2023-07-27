import { Router } from "express";
import { auth } from "../middlewares";
import { CustomerController } from "../controllers";

const customerRouter = Router();

/**
 * Get Profile.
 */
customerRouter.get('/me', auth, CustomerController.getMyProfile);

customerRouter.get('/me/account', auth, CustomerController.getMyAccount);

// customerRouter.get('/me/account/statements', auth, CustomerController.getMyAccountStatements);

customerRouter.get('/me/account/transactions', auth, CustomerController.getMyAccountTransactions);

customerRouter.get('/me/account/history', auth, CustomerController.getMyAccountHistory);

customerRouter.post('/me/account/deposite', auth, CustomerController.depositMyAccount);

customerRouter.post('/me/account/withdraw', auth, CustomerController.withdrawMyAccount);



export default customerRouter;