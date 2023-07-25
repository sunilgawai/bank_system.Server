import { Request, Response, Router } from "express";
import { AuthController } from "../controllers";
import { auth } from "../middlewares";
import { database } from "../services/database";

const authRouter = Router();

/**
 * Get OPT
 * @body(email,password)
 */
authRouter.post("/generate-otp", AuthController.getOtp);
authRouter.post("/verify-otp", AuthController.verifyOtp);

// authRouter.post('/register', AuthController.register);
authRouter.post("/login", AuthController.login);
authRouter.post("/auth", async (req: Request, res: Response, next: any) => {
  try {
    await database.customer
      .findUnique({ where: { email: req.body.email } })
      .then((customer) => {
        res.cookie("access_token", "s", {
          expires: new Date(Date.now() + 900000),
          httpOnly: true,
        });
        res.status(200).json(customer);
      })
      .catch((err) => next(err));
  } catch (error) {
    return next(error);
  }
});

authRouter.get('/me', auth, AuthController.profile);
// authRouter.post('/logout', AuthController.logout);
// authRouter.get('/me', auth, AuthController.me);
// authRouter.post('/refresh', AuthController.refresh);

export default authRouter;
