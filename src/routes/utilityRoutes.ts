import { Router } from "express";
import { UtilityController } from "../controllers";

const utilityRouter = Router();

utilityRouter.get('/location/states', UtilityController.getStates);
utilityRouter.get('/location/cities', UtilityController.getCities);
utilityRouter.get('/location/districts', UtilityController.getDistricts);


// utilityRouter.get('/departments', UtilityController.getDepartments);
// utilityRouter.get('/kyc', UtilityController.getKycList);

export default utilityRouter;