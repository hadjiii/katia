import { Router, Request, Response, NextFunction } from "express";
import Container from "typedi";
import MediaService from "../../services/media";
import { celebrate, Segments, Joi, errors } from "celebrate";
import middlewares from "./middlewares";
import { IMediaInputDTO } from "../../interfaces/media";
import discussion from "./middlewares/discussion";
import DiscussionService from "../../services/discussion";

const router = Router()

export default (app: Router) => {
    app.use('/medias', router);

    router.use(middlewares.isAuthorized, middlewares.bindCurrentUser)

    router.get('/', 
    celebrate({[Segments.QUERY]: Joi.object({discussionId: Joi.string().required()})}), 
    discussion.hasCurrentUserAsMember, 
    async (req: Request, res: Response, next: NextFunction) => {
        const discussionId = req.query['discussionId'];

        try {
            const discussionService = Container.get(DiscussionService);
            const discussion = await discussionService.fetchOne({_id: discussionId});
            const medias = discussion.medias;
            res.send(medias).status((medias.length > 0) ? 200 : 204);
        }
        catch(err) {
            next(err)
        }
    })

    router.get('/:mediaId', 
    celebrate({[Segments.PARAMS]: Joi.object({mediaId: Joi.string().required()})}), 
    async (req: Request, res: Response, next: NextFunction) => {
        try {
            const mediaService = Container.get(MediaService);
            const mediaId = req.params['mediaId'];
            const media = await mediaService.fetchOne({_id: mediaId});

            res.send(media).status(200);
        }
        catch(err) {
            next(err)
        }
    })

    // userId
    // discussionId
    router.post('/', celebrate({[Segments.BODY]: Joi.object().keys({
        media: Joi.string().required().trim()
    })}), 
    async (req: Request, res: Response, next: NextFunction) => {
        try {
            const mediaService = Container.get(MediaService);
            const media: IMediaInputDTO = req.body;
            const createdStory = await mediaService.create(media);

            res.send(createdStory).status(200);
        }
        catch(err) {
            next(err)
        }
    })

    router.delete('/:mediaId', 
    celebrate({[Segments.PARAMS]: Joi.object({id: Joi.string().required().trim()})}), 
    async (req: Request, res: Response, next: NextFunction) => {
        try {
            const mediaService = Container.get(MediaService);
            const mediaId = req.params['mediaId'];
            const deletedMedia = await mediaService.deleteOne({_id: mediaId});

            res.send(deletedMedia).status(200);
        }
        catch(err) {
            next(err)
        }
    })

    app.use(errors())
}