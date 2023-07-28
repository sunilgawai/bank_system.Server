import { Request, Response, NextFunction } from "express";
import { CustomerValidator } from "../validators";
import { database } from "../services/database";
import { CustomErrorHandler } from "../services";

class AdminController {
  static async getLocation(
    req: Request,
    res: Response,
    next: NextFunction
  ): Promise<any> {
    let states, cities, districts;
    try {
      states = await database.state.findMany();
      cities = await database.city.findMany();
      districts = await database.district.findMany();
    } catch (error) {
      return next(error);
    }

    res.status(200).json({ states, cities, districts });
  }

  static async getStates(
    req: Request,
    res: Response,
    next: NextFunction
  ): Promise<any> {
    try {
      const states = await database.state.findMany();

      if (!states) {
        return next(CustomErrorHandler.notFound("States not found."));
      }
      res.status(200).json(states);
    } catch (error) {
      return next(error);
    }
  }

  static async getCities(
    req: Request,
    res: Response,
    next: NextFunction
  ): Promise<any> {
    const { state_id } = req.body;
    try {
      const cities = await database.city.findMany({
        where: {
          state_id: state_id,
        },
      });

      if (!cities) {
        return next(CustomErrorHandler.notFound("Cities not found."));
      }
      res.status(200).json(cities);
    } catch (error) {
      return next(error);
    }
  }

  static async getDistricts(
    req: Request,
    res: Response,
    next: NextFunction
  ): Promise<any> {
    try {
      const districts = await database.district.findMany({
        where: {
          state_id: req.body.state_id,
        },
      });
      if (!districts) {
        return next(CustomErrorHandler.notFound("Districts not found."));
      }
      res.status(200).json(districts);
    } catch (error) {
      return next(error);
    }
  }
}

export default AdminController;
