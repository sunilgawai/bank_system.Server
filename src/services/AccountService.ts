import nodemailer from "nodemailer";
import { ADMIN_EMAIL, ETHERIAL_EMAIL, ETHERIAL_PASSWORD } from "../../config";
class AccountService {
  static async generateAccountNumber(length: number = 12): Promise<string> {
    return new Promise((res, rej) => {
      const digits = "0123456789";
      let accountNumber = "";

      for (let i = 0; i < length; i++) {
        const randomIndex = Math.floor(Math.random() * digits.length);
        accountNumber += digits.charAt(randomIndex);
      }
      return res(accountNumber);
    });
  }

  static async generateRandomPassword(length: number = 6): Promise<string> {
    return new Promise((res, rej) => {
      const digits =
        "abcdefghijjklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
      let password = "";

      for (let i = 0; i < length; i++) {
        const randomIndex = Math.floor(Math.random() * digits.length);
        password += digits.charAt(randomIndex);
      }
      return res(password);
    });
  }

  static async generateRandomOtp(length: number = 6): Promise<string> {
    return new Promise((res, rej) => {
      const digits =
        "7397973154";
      let otp = "";

      for (let i = 0; i < length; i++) {
        const randomIndex = Math.floor(Math.random() * digits.length);
        otp += digits.charAt(randomIndex);
      }
      return res(otp);
    });
  }

  static async sendMailOnAccountCreate(customer_email: string, password: string): Promise<any> {
    // const testAccount = nodemailer.createTestAccount();
    const transporter = nodemailer.createTransport({
      host: "smtp.ethereal.email",
      port: 587,
      auth: {
        user: ETHERIAL_EMAIL,
        pass: ETHERIAL_PASSWORD,
      },
    });

    let info = await transporter.sendMail({
      from: 'Admin.tdb@gmail.com',
      to: customer_email,
      subject: "🤞Welcome to The Developers Bank. ✌",
      html: `<h1>Yout Account is ready</h1> <h3>use password ${password} to login. Make sure to change it asap.</h3>`,
    });

    return info;
  }

  static async sendMailOnOtpRequest(customer_email: string, otp: number): Promise<any> {
    // const testAccount = nodemailer.createTestAccount();
    const transporter = nodemailer.createTransport({
      host: "smtp.ethereal.email",
      port: 587,
      auth: {
        user: ETHERIAL_EMAIL,
        pass: ETHERIAL_PASSWORD,
      },
    });

    let info = await transporter.sendMail({
      from: ADMIN_EMAIL,
      to: customer_email,
      subject: "🤞Welcome to The Developers Bank. ✌",
      html: `<h1>Your Login Otp is ${otp}</h1> <h3>visit ${'http://localhost:3000/login/verify'} to login.</h3>`,
    });

    return info;
  }
}

export default AccountService;
