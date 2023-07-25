import { Router } from "express";
import { auth } from "../middlewares";
import { CustomerController } from "../controllers";

const customerRouter = Router();

/**
 * Get Profile.
 */
customerRouter.post('/me', auth, CustomerController.getMyProfile);

customerRouter.get('/me/account', auth, CustomerController.getMyAccount);

customerRouter.get('/me/account/statements', auth, CustomerController.getMyAccountStatements);

customerRouter.get('/me/account/transaction', auth, CustomerController.getMyAccountTransactions);

customerRouter.get('/me/account/history', auth, CustomerController.getMyAccountHistory);

customerRouter.get('/me/account/deposite', auth, CustomerController.depositMyAccount);

customerRouter.get('/me/account/withdraw', auth, CustomerController.withdrawMyAccount);



export default customerRouter;