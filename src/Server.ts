import express, { Application } from "express";
import { errorHandler } from "./middlewares";
import cookieParser from "cookie-parser";
import { authRouter, customerRouter, utilityRouter, adminRouter } from "./routes";
import bodyParser from "body-parser";
import cors from "cors";
import path from "path";

// Application init.
const app: Application = express();

// Middlewares.
app.use(cors({
    origin: "http://localhost:3000",
    methods: ["POST", "PUT", "DELETE", "GET"],
    credentials: true
}));
app.use(express.json());
app.use(bodyParser.json());
app.use(cookieParser());
app.use(express.urlencoded({ extended: true }));

// Init Routes.
app.use('/api/admin', adminRouter);
app.use('/api/auth', authRouter);
app.use('/api', customerRouter);
app.use('/api', utilityRouter);

app.use(express.static("build"))
app.use(function (req, res, next) {
    return res.sendFile(path.join(__dirname, "..", "build", "index.html"))
})

// Error Handler.
app.use(errorHandler);

app.listen(4000, () => console.log(`listening on http://localhost:${4000}`));