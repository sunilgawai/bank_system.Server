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
          account_id: account.id,
          document_id: document.id,
          address_id: address.id,
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

    await AccountService.sendMailOnAccountCreate(customer.email, randomPassword)
      .then((response) => {
        console.log(response);
      })
      .catch((err) => console.log(err));
    res.status(200).json(customer);
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

  static async deleteCustomer(
    req: Request,
    res: Response,
    next: NextFunction
  ): Promise<any> {
    try {
      const customer = await database.customer.delete({
        where: {
          id: req.params.id,
        },
      });

      if (!customer) {
        return next(CustomErrorHandler.notFound("Customer not found."));
      }

      res.status(200).json(customer);
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
      console.log('user', req.user);
      res.status(200).json(customer);
    } catch (error) {
      return next(error);
    }
  }
}

export default AdminController;