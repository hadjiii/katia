import { Router, Request, Response, NextFunction } from "express";
import Container from "typedi";
import StoryService from "../../services/story";
import { IStoryInputDTO } from "../../interfaces/story";
import { celebrate, Segments, Joi, errors } from "celebrate";
import middlewares from "./middlewares";

const router = Router()

export default (app: Router) => {
    app.use('/stories', router);

    router.use(middlewares.isAuthorized, middlewares.bindCurrentUser)

    router.get('/', async (req: Request, res: Response, next: NextFunction) => {
        try {
            const storyService = Container.get(StoryService);
            const stories = await storyService.fetchAll({});
            res.send(stories).status((stories.length > 0) ? 200 : 204);
        }
        catch(err) {
            next(err)
        }
    })

    router.get('/:storyId', 
    celebrate({[Segments.PARAMS]: Joi.object({storyId: Joi.string().required()})}), 
    async (req: Request, res: Response, next: NextFunction) => {
        try {
            const storyService = Container.get(StoryService);
            const storyId = req.params['storyId'];
            const story = await storyService.fetchOne({_id: storyId});

            res.send(story).status(200);
        }
        catch(err) {
            next(err)
        }
    })

    router.post('/', celebrate({[Segments.BODY]: Joi.object().keys({
        media: Joi.string().required().trim()
    })}), 
    async (req: Request, res: Response, next: NextFunction) => {
        try {
            const storyService = Container.get(StoryService);
            const media = req.body;
            const story: IStoryInputDTO = {
                media: media,
                user: req.currentUser._id
            }
            const createdStory = await storyService.create(story);

            res.send(createdStory).status(200);
        }
        catch(err) {
            next(err)
        }
    })

    router.delete('/:storyId', 
    celebrate({[Segments.PARAMS]: Joi.object({id: Joi.string().required().trim()})}),
    middlewares.isOwner,
    async (req: Request, res: Response, next: NextFunction) => {
        try {
            const storyService = Container.get(StoryService);
            const storyId = req.params['storyId'];
            const deletedStory = await storyService.deleteOne({_id: storyId});

            res.send(deletedStory).status(200);
        }
        catch(err) {
            next(err)
        }
    })

    app.use(errors())
}