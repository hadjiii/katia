import {Router, Request, Response, NextFunction} from "express";
import AuthService from "../../services/auth"
import Container from "typedi";
import { IUserInputDTO } from "../../interfaces/user";
import {celebrate, Joi, errors, Segments} from "celebrate"

const router =  Router();

export default (app: Router) => {
    app.use('/auth', router);
    
    router.post('/register', celebrate({
        [Segments.BODY]: Joi.object().keys({
            username: Joi.string().required().trim().regex(/^(?=.*[0-9])(?=.*[a-z]).{3,30}$/),
            password: Joi.string().required().trim().regex(/^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[*.!@$%^&(){}[\]:;<>,.?\/~_+-=|]).{8,32}$/),
            avatar: Joi.string().required().trim()
    })
    }), async (req: Request, res: Response, next: NextFunction) => {
        try {
            const authService = Container.get(AuthService)
            const user: IUserInputDTO = req.body;
            const createdUser = await authService.register(user);

            res.send(createdUser).status(201);
        }
        catch(err) {
            next(err);
        }
    })

    router.post('/login', celebrate({
        [Segments.BODY]: Joi.object().keys({
            username: Joi.string().required().trim().regex(/^(?=.*[0-9])(?=.*[a-z]).{3,30}$/),
            password: Joi.string().required().trim().regex(/^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[*.!@$%^&(){}[\]:;<>,.?\/~_+-=|]).{8,32}$/),
    })
    }), async (req: Request, res: Response, next: NextFunction) => {
        try {
            const authService = Container.get(AuthService)
            const {username, password} = req.body;
            const loggedUser = await authService.login(username, password);

            res.send(loggedUser).status(200);
        }
        catch(err) {
            next(err);
        }
    })

    router.put('/update-password', celebrate({
        [Segments.BODY]: Joi.object().keys({
            username: Joi.string().required().trim().regex(/^(?=.*[0-9])(?=.*[a-z]).{3,30}$/),
            oldPassword: Joi.string().required().trim().regex(/^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[*.!@$%^&(){}[\]:;<>,.?\/~_+-=|]).{8,32}$/),
            newPassword: Joi.string().required().trim().regex(/^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[*.!@$%^&(){}[\]:;<>,.?\/~_+-=|]).{8,32}$/)
    })
    }), async (req: Request, res: Response, next: NextFunction) => {
        try {
            const authService = Container.get(AuthService)
            const {username, oldPassword, newPassword} = req.body;
            const updatedUser = await authService.updatePassword(username, oldPassword, newPassword);

            res.send(updatedUser).status(200);
        }
        catch(err) {
            next(err);
        }
    })

    app.use(errors())
}
