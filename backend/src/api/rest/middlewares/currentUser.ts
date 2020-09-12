import {Request, Response, NextFunction} from 'express';
import Container from 'typedi';
import UserService from '../../../services/user';

const bindCurrentUser = async (req: Request, res: Response, next: NextFunction) => {
    try {
        const userService = Container.get(UserService);
        const currentUser = await userService.fetchById(req.token._id);

        if(!currentUser) {
            return res.sendStatus(401);
        }
    
        req.currentUser = currentUser;
        return next();
    }
    catch(err) {
       return  next(err)
    }
}

export default bindCurrentUser;