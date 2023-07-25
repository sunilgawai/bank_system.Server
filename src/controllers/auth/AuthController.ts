import { Request, Response, NextFunction } from "express";
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
        return next(CustomErrorHandler.notFound("Envalid email."));
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
      await database.otp.create({
        data: {
          otp: opt,
          email: customer.email,
        },
      });
    } catch (error) {
      return next(CustomErrorHandler.serverError("couldn't send otp."));
    }

    AccountService.sendMailOnOtpRequest(customer.email, opt)
      .then(() => {
        res.status(200).json({ message: "Otp sent successfully." });
      })
      .catch((err) => {
        return next(CustomErrorHandler.serverError("couldn't send otp."));
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
      console.log('Opt bt email', {generatedOtp, otp});
      if (!generatedOtp) {
        return next(CustomErrorHandler.wrongCredentials("Envalid Otp."));
      }

      if (parseInt(otp) !== generatedOtp.otp) {
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

    res.status(200).json(customer);
  }

  static async resetPassword(
    req: Request,
    res: Response,
    next: NextFunction
  ): Promise<any> {
    const resetSchema = Joi.object({
      email: Joi.string().email().required(),
      old_password: Joi.string().required(),
      new_password: Joi.ref("old_password"),
    });
    const { error } = resetSchema.validate(req.body);
    if (error) {
      return next(error);
    }
    const { email, old_password, new_password } = req.body;
    const exists = await database.customer.findUnique({ where: { email } });
    if (!exists) {
      return next(CustomErrorHandler.notFound("Customer not found."));
    }
    // compare old password.
    const matched = await bcrypt.compare(old_password, exists.password);
    if (!matched) {
      return next(
        CustomErrorHandler.wrongCredentials("Password does not match.")
      );
    }

    const hashedPassword = await bcrypt.hash(new_password, 10);
    let customer;
    try {
      // Update password.
      customer = await database.customer.update({
        where: {
          email,
        },
        data: {
          password: hashedPassword,
        },
      });
    } catch (error) {
      return next(error);
    }

    let jwt_token;
    try {
      jwt_token = JwtService.sign({ id: customer.id });
    } catch (error) {
      return next(error);
    }
    res.cookie("jwt_token", jwt_token, {
      expires: new Date(Date.now() + 900000),
      httpOnly: true,
    });
    res.status(200).json(customer);
  }

  static async login(
    req: Request,
    res: Response,
    next: NextFunction
  ): Promise<any> {
    const loginSchema = Joi.object({
      email: Joi.string().email().required(),
      password: Joi.string().required(),
    });

    const { error } = loginSchema.validate(req.body);
    if (error) {
      return next(error);
    }
    const { email, password } = req.body;
    let customer;
    try {
      customer = await database.customer.findUnique({
        where: {
          email: email,
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
    } catch (error) {
      return next(error);
    }
    let jwt_token;
    try {
      jwt_token = await JwtService.sign({ id: customer.id });
    } catch (error) {
      return next(error);
    }
    res.cookie("jwt_token", jwt_token, {
      expires: new Date(Date.now() + 900000),
      httpOnly: true,
    });
    res.status(200).json(customer);
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
