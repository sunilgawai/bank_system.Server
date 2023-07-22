import { Request, Response, NextFunction } from 'express';
import { CustomerValidator } from '../validators';
import { database } from '../services/database';
import { CustomErrorHandler } from '../services';

class AdminController {
    static async getStates(req: Request, res: Response, next: NextFunction): Promise<any> {
        try {
            const states = await database.state.findMany({
                select: {
                    state_title: true,
                    state_id: true,
                    status: true
                }
            })

            if (!states) {
                return next(CustomErrorHandler.notFound("States not found."));
            }
            res.status(200).json(states);
        } catch (error) {
            return next(error);
        }
    }

    static async getCities(req: Request, res: Response, next: NextFunction): Promise<any> {
        try {
            const cities = await database.city.findMany({
                select: {
                    name: true,
                    id: true,
                    status: true
                }
            })

            if (!cities) {
                return next(CustomErrorHandler.notFound("Cities not found."));
            }
            res.status(200).json(cities);
        } catch (error) {
            return next(error);
        }
    }

    static async getDistricts(req: Request, res: Response, next: NextFunction): Promise<any> {
        try {
            const districts = await database.district.findMany({
                select: {
                    district_title: true,
                    districtid: true,
                    district_status: true
                }
            })

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