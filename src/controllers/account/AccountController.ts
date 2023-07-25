import { Request, Response, NextFunction } from "express";
import { database } from "../../services/database";
import { CustomErrorHandler } from "../../services";

class AccountController {
  static async getAccountsList(
    req: Request,
    res: Response,
    next: NextFunction
  ): Promise<any> {
    let accounts;
    try {
      accounts = await database.account.findMany({
        include: {
          Customer: true,
          Document: true,
          received_transactions: true,
          sent_transactions: true,
        },
      });
    } catch (error) {
      return next(error);
    }

    res.status(200).json(accounts);
  }

  static async viewAccount(
    req: Request,
    res: Response,
    next: NextFunction
  ): Promise<any> {
    let account;
    try {
      account = await database.account.findUnique({
        where: {
          id: req.params.id,
        },
        include: {
          Customer: true,
          Document: true,
          received_transactions: true,
          sent_transactions: true,
        },
      });
    } catch (error) {
      return next(error);
    }

    res.status(200).json(account);
  }

  static async deleteAccount(
    req: Request,
    res: Response,
    next: NextFunction
  ): Promise<any> {
    let account;
    try {
      account = await database.account.delete({
        where: {
          id: req.params.id,
        },
        include: {
          Customer: true,
          Document: true,
          received_transactions: true,
          sent_transactions: true,
        },
      });
    } catch (error) {
      return next(error);
    }

    res.status(200).json(account);
  }

  static async updateAccount(
    req: Request,
    res: Response,
    next: NextFunction
  ): Promise<any> {
    const { account_type } = req.body;
    let account;
    try {
      account = await database.account.update({
        where: {
          id: req.params.id,
        },
        data: {
          account_type: account_type,
        },
        include: {
          Customer: true,
          Document: true,
          received_transactions: true,
          sent_transactions: true,
        },
      });
    } catch (error) {
      return next(error);
    }

    res.status(200).json(account);
  }

  static async getTransactionHistory(
    req: Request,
    res: Response,
    next: NextFunction
  ): Promise<any> {
    let account_transactions;
    try {
      account_transactions = await database.transaction.findMany({
        where: {
          Sender: {
            id: {
              equals: req.user.id,
            },
          },
        },
      });
    } catch (error) {
      return next(error);
    }
  }

  static async getAccountStatements(
    req: Request,
    res: Response,
    next: NextFunction
  ): Promise<any> {
    let account_statements;
    try {
      account_statements = await database.accountTransaction.findMany({
        where: {
          customer_id: req.user.id,
        },
        include: {
          customer: true,
        },
      });
    } catch (error) {
      return next(error);
    }
    res.status(200).json(account_statements);
  }

  static async getAccountDetails(
    req: Request,
    res: Response,
    next: NextFunction
  ): Promise<any> {
    let account;
    try {
      account = await database.customer.findUnique({
        where: {
          id: req.user.id,
        },
        include: {
          account: {
            include: {
              Document: true,
              sent_transactions: true,
              received_transactions: true,
            },
          },
        },
      });
    } catch (error) {
      return next(error);
    }

    res.status(200).json(account);
  }

  static async deposit(
    req: Request,
    res: Response,
    next: NextFunction
  ): Promise<any> {
    const { amount } = req.body;
    let customer;
    try {
      customer = await database.customer.findUnique({
        where: { id: req.user.id },
        include: { account: true },
      });
    } catch (error) {
      return next(error);
    }

    if (!customer || !customer.account) {
      return next(CustomErrorHandler.unAuthorized(""));
    }

    // Check if the deposit amount is valid
    const depositAmount = parseFloat(amount);
    if (isNaN(depositAmount) || depositAmount <= 0) {
      CustomErrorHandler.wrongCredentials("Invalid withdrawal amount.");

      // Calculate the updated account balance after deposit
      const currentBalance = parseFloat(customer.account.account_balance);
      const updatedBalance = (currentBalance + depositAmount).toFixed(2);

      let account;
      try {
        account = await database.customer.update({
          where: { id: req.user.id },
          data: {
            account: {
              update: {
                account_balance: updatedBalance,
              },
            },
          },
          include: {
            AccountTransaction: true,
          },
        });
      } catch (error) {
        return next(error);
      }

      res.status(200).json(customer);
    }
  }

  static async withdraw(
    req: Request,
    res: Response,
    next: NextFunction
  ): Promise<any> {
    const { amount } = req.body;
    let customer;
    try {
      customer = await database.customer.findUnique({
        where: { id: req.user.id },
        include: { account: true },
      });
    } catch (error) {
      return next(error);
    }

    if (!customer || !customer.account) {
      return next(CustomErrorHandler.unAuthorized(""));
    }

    // Check if the withdrawal amount is valid
    const withdrawalAmount = parseFloat(amount);
    if (isNaN(withdrawalAmount) || withdrawalAmount <= 0) {
      return next(
        CustomErrorHandler.wrongCredentials("Invalid withdrawal amount.")
      );
    }

    // Check if the account has sufficient balance for withdrawal
    const currentBalance = parseFloat(customer.account.account_balance);
    if (currentBalance < withdrawalAmount) {
      return next(
        CustomErrorHandler.unAuthorized("Insufficient account balance.")
      );
    }

    // Calculate the updated account balance after withdrawal
    const updatedBalance = (currentBalance - withdrawalAmount).toFixed(2);

    let account;
    try {
      account = await database.customer.update({
        where: { id: req.user.id },
        data: {
          account: {
            update: {
              account_balance: updatedBalance,
            },
          },
        },
        include: {
          AccountTransaction: true,
        },
      });
    } catch (error) {
      return next(error);
    }

    res.status(200).json(customer);
  }

  static async moneyTransfer(
    req: Request,
    res: Response,
    next: NextFunction
  ): Promise<any> {
    const { account_number, amount } = req.body;
    const senderCustomerId = req.user.id;

    try {
      // Fetch the sender's customer and account details
      const senderCustomer = await database.customer.findUnique({
        where: { id: senderCustomerId },
        include: { account: true },
      });

      if (!senderCustomer || !senderCustomer.account) {
        return next(
          CustomErrorHandler.unAuthorized("Customer or account not found.")
        );
      }

      // Check if the transfer amount is valid
      const transferrableAmount = parseFloat(amount);
      if (isNaN(transferrableAmount) || transferrableAmount <= 0) {
        return next(
          CustomErrorHandler.wrongCredentials("Invalid transfer amount.")
        );
      }

      // Check if the sender's account has sufficient balance for transfer
      const senderCurrentBalance = parseFloat(
        senderCustomer.account.account_balance
      );
      if (senderCurrentBalance < transferrableAmount) {
        return next(
          CustomErrorHandler.unAuthorized("Insufficient account balance.")
        );
      }

      // Calculate the updated balance for the sender's account after transfer
      const senderUpdatedBalance = (
        senderCurrentBalance - transferrableAmount
      ).toFixed(2);

      // Fetch the receiver's account
      const receiverAccount = await database.account.findUnique({
        where: { account_number: account_number },
      });

      if (!receiverAccount) {
        return next(
          CustomErrorHandler.notFound("Receiver's account not found.")
        );
      }

      // Calculate the updated balance for the receiver's account after transfer
      const receiverCurrentBalance = parseFloat(
        receiverAccount.account_balance
      );
      const receiverUpdatedBalance = (
        receiverCurrentBalance + transferrableAmount
      ).toFixed(2);

      // Perform database updates for both sender and receiver accounts
      await database.customer.update({
        where: { id: senderCustomerId },
        data: {
          account: {
            update: {
              account_balance: senderUpdatedBalance,
            },
          },
        },
      });

      await database.account.update({
        where: { account_number: account_number },
        data: {
          account_balance: receiverUpdatedBalance,
        },
      });

      // Create a new account transaction record for the transfer for both sender and receiver
      await database.accountTransaction.createMany({
        data: [
          {
            customer_id: senderCustomerId,
            transaction_type: "debit",
            transaction_amount: String(transferrableAmount),
          },
          {
            customer_id: receiverAccount.id,
            transaction_type: "credit",
            transaction_amount: String(transferrableAmount),
          },
        ],
      });

      res.json({
        message: "Money transfer successful.",
        newBalance: senderUpdatedBalance,
      });
    } catch (error) {
      return next(error);
    }
  }
}

export default AccountController;
