import e, { Request, Response, NextFunction } from "express";
import { database } from "../../services/database";
import { AccountService, CustomErrorHandler, JwtService } from "../../services";
import bcrypt from "bcrypt";
import Joi from "joi";

class AuthController {
  static async getOtp(
    req: Request,
    res: Response,
    next: NextFunction
  ): Promise<any> {
    const { email, password } = req.body;
    const { error } = Joi.object({
      email: Joi.string().required(),
      password: Joi.string().required(),
    }).validate(req.body);

    if (error) {
      return next(error);
    }

    console.log(req.body);
    let customer;
    try {
      customer = await database.customer.findUnique({
        where: {
          email: email,
        },
      });
      console.log(customer);
      if (!customer) {
        return next(CustomErrorHandler.wrongCredentials("Envalid email."));
      }
    } catch (error) {
      return next(error);
    }

    try {
      const match = await bcrypt.compare(password, customer.password);
      if (!match) {
        return next(CustomErrorHandler.wrongCredentials("Envalid password."));
      }
    } catch (error) {
      return next(error);
    }

    const opt = parseInt(await AccountService.generateRandomOtp());
    console.log(opt);
    try {
      await database.otp.deleteMany(); // Deleting old otps
      await database.otp.create({
        data: {
          otp: opt,
          email: customer.email,
        },
      });
    } catch (error) {
      console.log(error);
      return next(CustomErrorHandler.serverError());
    }

    AccountService.sendMailOnOtpRequest(customer.email, opt)
      .then(() => {
        res.status(200).json({ message: "Otp sent successfully." });
      })
      .catch((err) => {
        res.status(200).json({ message: "Otp sent successfully." });
        // return next(CustomErrorHandler.serverError("couldn't send otp."));
      });
  }

  static async verifyOtp(
    req: Request,
    res: Response,
    next: NextFunction
  ): Promise<any> {
    const { email, password, otp } = req.body;
    const { error } = Joi.object({
      email: Joi.string().required(),
      password: Joi.string().required(),
      otp: Joi.number().required(),
    }).validate(req.body);

    if (error) {
      return next(error);
    }

    let generatedOtp;
    try {
      generatedOtp = await database.otp.findUnique({
        where: {
          email: email,
        },
      });
      // console.log("Opt by email", { generatedOtp, otp });
      if (!generatedOtp) {
        return next(CustomErrorHandler.wrongCredentials("Generate Otp Again."));
      }

      if (parseInt(otp) !== generatedOtp.otp) {
        // console.log("not matched", {otp:parseInt(otp), generated: generatedOtp.otp})
        return next(CustomErrorHandler.wrongCredentials("Invalid Otp."));
      }
    } catch (error) {
      return next(error);
    }

    try {
      await database.otp.delete({
        where: { email: email },
      });
    } catch (error) {
      return next(CustomErrorHandler.serverError());
    }

    let customer;
    try {
      customer = await database.customer.findUnique({
        where: { email: email },
        include: {
          account: true,
          address: true,
          document: true,
          AccountTransaction: true,
        },
      });

      if (!customer) {
        return next(CustomErrorHandler.wrongCredentials());
      }
    } catch (error) {
      return next(error);
    }

    try {
      const matched = await bcrypt.compare(password, customer?.password);
      if (!matched) {
        return next(CustomErrorHandler.wrongCredentials());
      }
    } catch (error) {
      return next(error);
    }
    const access_token = JwtService.sign({
      id: customer.id,
      role: customer.role,
    });
    res.cookie("access_token", access_token, {
      maxAge: 30 * 24 * 60 * 60 * 1000,
      httpOnly: true,
    });

    res.status(200).json({ customer, access_token, role: customer.role });
  }

  static async logout(
    req: Request,
    res: Response,
    next: NextFunction
  ): Promise<any> {
    res.clearCookie("access_token");
    res.status(200).json({ message: "Logged out." });
  }

  static async changePassword(
    req: Request,
    res: Response,
    next: NextFunction
  ): Promise<any> {
    const resetSchema = Joi.object({
      old_password: Joi.string().required(),
      new_password: Joi.string().required(),
    });
    const { error } = resetSchema.validate(req.body);
    if (error) {
      return next(error);
    }
    const { old_password, new_password } = req.body;
    const exists = await database.customer.findUnique({
      where: { id: req.user.id },
    });
    if (!exists) {
      return next(CustomErrorHandler.notFound("Customer not found."));
    }
    // compare old password.
    const matched = await bcrypt.compare(old_password, exists.password);
    if (!matched) {
      return next(
        CustomErrorHandler.wrongCredentials("Wrong password entered.")
      );
    }

    const hashedPassword = await bcrypt.hash(new_password, 10);
    let customer;
    try {
      // Update password.
      customer = await database.customer.update({
        where: {
          id: req.user.id,
        },
        data: {
          password: hashedPassword,
        },
      });
    } catch (error) {
      return next(error);
    }
    res.status(200).json(customer);
  }

  static async requestForgotPasswordOtp(
    req: Request,
    res: Response,
    next: NextFunction
  ): Promise<any> {
    const { email } = req.body;
    console.log(req.body);
    const { error } = Joi.object({
      email: Joi.string().required(),
    }).validate(req.body);

    if (error) {
      return next(error);
    }
    let customer;
    try {
      customer = await database.customer.findUnique({
        where: { email: email },
      });
      if (!customer) {
        return next(CustomErrorHandler.wrongCredentials("wrong credentials"));
      }
    } catch (error) {
      return next(error);
    }

    try {
      await database.otp.deleteMany({
        where: {
          email: email,
        },
      });
    } catch (error) {
      return next(error);
    }

    const otp = await AccountService.generateRandomOtp();
    console.log("otp", otp);
    try {
      await database.otp.create({
        data: {
          email: email,
          otp: parseInt(otp),
        },
      });
    } catch (error) {
      return next(error);
    }
    // res.status(200).json({ message: "password reset otp sent." });
    // temp removed.
    AccountService.sendMailOnForgotPasswordRequest(email, otp)
      .then((results) => {
        console.log(results);
        res.status(200).json({ message: "password reset otp sent." });
      })
      .catch((error) => {
        return next(error);
      });
  }

  static async confirmForgotPasswordOtp(
    req: Request,
    res: Response,
    next: NextFunction
  ): Promise<any> {
    const { email, otp } = req.body;
    const { error } = Joi.object({
      email: Joi.string().required(),
      otp: Joi.string().required(),
    }).validate(req.body);
    console.log('by confirmation body', req.body);

    if (error) {
      return next(error);
    }
    let customer;
    try {
      customer = await database.customer.findUnique({
        where: { email: email },
      });
      if (!customer) {
        return next(CustomErrorHandler.wrongCredentials("wrong credentials"));
      }
    } catch (error) {
      return next(error);
    }

    // Check Otp.
    let generatedOtp;
    try {
      generatedOtp = await database.otp.findUnique({
        where: {
          email: email,
        },
      });
      // console.log("Opt by email", { generatedOtp, otp });
      if (!generatedOtp) {
        return next(CustomErrorHandler.wrongCredentials("Generate Otp Again."));
      }

      if (parseInt(otp) !== generatedOtp.otp) {
        // console.log("not matched", {otp:parseInt(otp), generated: generatedOtp.otp})
        return next(CustomErrorHandler.wrongCredentials("Invalid Otp."));
      }
    } catch (error) {
      return next(error);
    }

    // Create temp password.
    const randomPassword = await AccountService.generateRandomPassword();
    const hashedPassword = await bcrypt.hash(randomPassword, 10);
    try {
      await database.customer.update({
        where: { email: email },
        data: { password: hashedPassword },
      });
    } catch (error) {
      return next(error);
    }
    console.log('new password.',randomPassword)
    // res.status(200).json("temporary password send");

    // temp removed.
    AccountService.sendMailOnConfirmForgotPasswordOtp(email, randomPassword)
      .then((results) => {
        console.log(results);
        res.status(200).json("temporary password send");
      }).catch((errror) => {
        console.log(error);
        return next(error);
      })
  }

  static async profile(
    req: Request,
    res: Response,
    next: NextFunction
  ): Promise<any> {
    const user = req.user;

    try {
      await database.customer
        .findUnique({
          where: {
            id: user.id,
          },
          include: {
            account: true,
            document: true,
            address: true,
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

  static async transactions(
    req: Request,
    res: Response,
    next: NextFunction
  ): Promise<any> {
    try {
      await database.transaction
        .findMany({
          where: {
            sender_id: req.user.id,
          },
        })
        .then((transactions) => {
          res.status(200).json(transactions);
        })
        .catch((err) => {
          return next(err);
        });
    } catch (error) {
      return next(error);
    }
  }
}

export default AuthController;
