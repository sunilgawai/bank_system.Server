import dotenv from "dotenv";
dotenv.config();

export const {
    APP_PORT,
    DEBUG_MODE,
    JWT_TOKEN_SECRET,
    REFRESH_TOKEN_SECRET,
    ADMIN_EMAIL,
    ETHERIAL_PASSWORD,
    ETHERIAL_EMAIL
} = process.env;