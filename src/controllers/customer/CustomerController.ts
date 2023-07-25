import { Request, Response, NextFunction } from "express";
import { database } from "../../services/database";
import { CustomErrorHandler } from "../../services";

class CustomerController {
  static async getMyProfile(
    req: Request,
    res: Response,
    next: NextFunction
  ): Promise<any> {
    let profile;
    try {
      profile = await database.customer.findUnique({
        where: {
            id: req.user.id
        },
        include: {
          account: true,
          address: true,
          document: true,
          AccountTransaction: true
        },
      });
    } catch (error) {
      return next(error);
    }

    res.status(200).json(profile);
  }

  static async getMyAccount(
    req: Request,
    res: Response,
    next: NextFunction
  ): Promise<any> {
    let account;
    try {
      account = await database.customer.findUnique({
        where: {
          id:req.user.id
        },
        select: {
            account: true
        }
      });
    } catch (error) {
      return next(error);
    }

    res.status(200).json(account);
  }

  static async getMyAccountStatements(
    req: Request,
    res: Response,
    next: NextFunction
  ): Promise<any> {
    let account;
    try {
      account = await database.customer.findUnique({
        where: {
          id:req.user.id
        },
        select: {
            account: {
                include: {
                    received_transactions: true,
                    sent_transactions: true
                }
            }
        }
      });
    } catch (error) {
      return next(error);
    }

    res.status(200).json(account);
  }

  static async getMyAccountTransactions(
    req: Request,
    res: Response,
    next: NextFunction
  ): Promise<any> {
    let transactions;
    try {
      transactions = await database.transaction.findMany({
        where: {
          sender_id: req.user.id
        },
        include: {
         Receiver: true
        },
      });
    } catch (error) {
      return next(error);
    }

    res.status(200).json(transactions);
  }

  static async getMyAccountHistory(
    req: Request,
    res: Response,
    next: NextFunction
  ): Promise<any> {
    let transactions;
    try {
      transactions = await database.transaction.findMany({
        where: {
          sender_id: req.user.id
        },
        include: {
         Receiver: true
        },
      });
    } catch (error) {
      return next(error);
    }

    res.status(200).json(transactions);
  }

  static async depositMyAccount(
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

  static async withdrawMyAccount(
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

export default CustomerController;
