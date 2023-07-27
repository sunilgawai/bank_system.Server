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
// authRouter.post("/login", AuthController.login);
authRouter.post("/reset-password",auth, AuthController.changePassword);
authRouter.post("/reset-password",auth, AuthController.changePassword);
authRouter.post('/logout', AuthController.logout);
authRouter.get('/me', auth, AuthController.profile);

// forget password links.
authRouter.get("/forget-password-otp", AuthController.requestForgotPasswordOtp);
authRouter.post("/confirm-password-otp", AuthController.confirmForgotPasswordOtp);

export default authRouter;
