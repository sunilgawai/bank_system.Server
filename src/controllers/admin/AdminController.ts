import { Request, Response, NextFunction } from "express";
import { CustomerValidator } from "../../validators";
import { database } from "../../services/database";
import { ICustomer } from "../../types";
import { AccountService, CustomErrorHandler, JwtService } from "../../services";
import bcrypt from "bcrypt";

class AdminController {
  static async storeCustomer(
    req: Request,
    res: Response,
    next: NextFunction
  ): Promise<any> {
    console.log("body", req.body);
    // Request Validation.
    const { error } = CustomerValidator.store_request(req.body);
    if (error) {
      return next(error);
    }
    const {
      first_name,
      middle_name,
      last_name,
      email,
      phone,
      gender,
      date_of_birth,
      document_type,
      document_number,
      state,
      city,
      district,
      landmark,
      account_type,
      account_balance,
      country,
    } = req.body as ICustomer;

    // Database Validation.
    try {
      const exists = await database.customer.findFirst({
        where: {
          OR: [{ phone: phone }, { email: email }],
        },
      });

      if (exists) {
        return next(
          CustomErrorHandler.alreadyExists("Credentials are already in use.")
        );
      }
    } catch (error) {
      return next(error);
    }

    // Getting random password;
    const randomPassword = await AccountService.generateRandomPassword();
    console.log("randomPassword", randomPassword);

    // Hasing password.
    const password = await bcrypt.hash(randomPassword, 10);

    // Creating document.
    let document;
    try {
      document = await database.document.create({
        data: {
          document_type,
          document_number,
        },
      });
    } catch (error) {
      return next(error);
    }

    // Account Creationg.
    let account_number = await AccountService.generateAccountNumber();
    console.log("account_number", account_number);
    let account;
    try {
      account = await database.account.create({
        data: {
          account_number,
          account_balance,
          account_type,
          document_id: document.id,
        },
      });
    } catch (error) {
      return next(error);
    }

    let address;
    try {
      address = await database.address.create({
        data: {
          state,
          city,
          district,
          landmark,
          type: "current",
        },
      });
    } catch (error) {
      return next(error);
    }

    // Creating document for customer.
    let customer_document;
    try {
      customer_document = await database.document.create({
        data: {
          document_type,
          document_number,
        },
      });
    } catch (error) {
      return next(error);
    }

    // Database Submissions.
    let customer;
    try {
      customer = await database.customer.create({
        data: {
          first_name,
          last_name,
          middle_name,
          phone,
          email,
          password,
          date_of_birth,
          gender,
          role: "customer",
          account_id: account.id,
          address_id: address.id,
          document_id: customer_document.id,
        },
        include: {
          account: true,
          address: true,
          document: true,
        },
      });
    } catch (error) {
      console.log("error saving customer", error);
      return next(error);
    }

    // await AccountService.sendMailOnAccountCreate(customer.email, randomPassword)
    //   .then((response) => {
    //     console.log("response", response);
    //   })
    //   .catch((err) => console.log(err));
    res.status(200).json(customer);
  }

  static async deleteCustomer(
    req: Request,
    res: Response,
    next: NextFunction
  ): Promise<any> {
    const customerId = req.params.id;

    try {
      const customer = await database.customer.findUnique({
        where: { id: customerId },
        include: {
          document: true,
          account: {
            include: {
              Document: true,
            },
          },
          address: true,
        },
      });

      if (!customer) {
        return next(CustomErrorHandler.notFound("Customer not found."));
      }

      // Delete accounts of customer (which will also delete the associated documents).
      if (customer.account) {
        await database.account.delete({ where: { id: customer.account.id } });
      }

      if (customer.account?.Document) {
        await database.document.delete({
          where: { id: customer.account.Document.id },
        });
      }

      // Delete document of customer.
      if (customer.document) {
        await database.document.delete({ where: { id: customer.document.id } });
      }

      // Delete address of customer.
      if (customer.address) {
        await database.address.delete({ where: { id: customer.address.id } });
      }

      // Delete customer.
      const deletedCustomer = await database.customer.delete({
        where: { id: customerId },
      });

      res.status(200).json(deletedCustomer);
    } catch (error) {
      console.error(error);
      return next(error);
    }
  }

  static async getCustomers(
    req: Request,
    res: Response,
    next: NextFunction
  ): Promise<any> {
    try {
      await database.customer
        .findMany({
          include: {
            account: true,
            address: true,
            document: true,
          },
        })
        .then((results) => {
          res.status(200).json(results);
        })
        .catch((err) => {
          return next(err);
        });
    } catch (error) {
      return next(error);
    }
  }

  static async updateCustomer(
    req: Request,
    res: Response,
    next: NextFunction
  ): Promise<any> {
    console.log("cusomter", req.body);
    const {
      first_name,
      middle_name,
      last_name,
      email,
      phone,
      gender,
      date_of_birth,
    } = req.body as ICustomer;
    const id = req.params.id;
    let customer;
    try {
      customer = await database.customer.findUnique({
        where: { id: id },
        include: { address: true, account: true },
      });
    } catch (error) {}

    try {
      await database.customer
        .update({
          where: {
            id: id,
          },
          data: {
            first_name,
            last_name,
            middle_name,
            phone,
            email,
            date_of_birth,
            gender,
          },
          include: {
            account: true,
            address: true,
            document: true,
          },
        })
        .then((customer) => {
          res.status(200).json(customer);
        })
        .catch((err) => {
          return next(err);
        });
    } catch (error) {
      return next(error);
    }
  }

  static async viewCustomer(
    req: Request,
    res: Response,
    next: NextFunction
  ): Promise<any> {
    try {
      const customer = await database.customer.findUnique({
        where: {
          id: req.params.id,
        },
        include: {
          account: true,
          address: true,
          document: true,
        },
      });

      if (!customer) {
        return next(CustomErrorHandler.notFound("Customer not found."));
      }
      // for testing purpose.
      // const access_token = JwtService.sign({ id: customer.id });
      // res.cookie("access_token", access_token, {
      //   expires: new Date(Date.now() + 900000),
      //   httpOnly: true,
      // });
      console.log("user", req.user);
      res.status(200).json(customer);
    } catch (error) {
      return next(error);
    }
  }

  static async getAllAccountHistory(
    req: Request,
    res: Response,
    next: NextFunction
  ): Promise<any> {
    let transactions;
    try {
      transactions = await database.accountTransaction.findMany({
        include: {
          customer: true,
        },
      });
    } catch (error) {
      return next(error);
    }

    res.status(200).json(transactions);
  }

  static async getAllDetails(
    req: Request,
    res: Response,
    next: NextFunction
  ): Promise<any> {
    let transactions, accounts, customers, documents;
    try {
      transactions = await database.accountTransaction.count();
      accounts = await database.account.count();
      customers = await database.customer.count();
      documents = await database.document.count();
    } catch (error) {
      return next(error);
    }
    let logs;
    try {
      logs = await database.logs.findMany({
        take: 15,
        orderBy: {
          createdAt: 'desc'
        }
      });
    } catch (error) {
      console.log("error by logs", error);
      return next(error);
    }

    res.status(200).json({
      transactions,
      accounts,
      customers,
      documents,
      logs
    });
  }
}

export default AdminController;
