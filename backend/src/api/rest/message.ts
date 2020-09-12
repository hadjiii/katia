import { Router, Request, Response, NextFunction } from "express";
import Container from "typedi";
import { celebrate, Segments, Joi, errors } from "celebrate";
import MessageService from "../../services/message";
import middlewares from "./middlewares";
import { IMessageInputDTO } from "../../interfaces/message";

const router = Router()

export default (app: Router) => {
    app.use('/messages', router);

    router.use(middlewares.isAuthorized, middlewares.bindCurrentUser)

    /**
     * @description Get a list of comments for a given discussion id
     * @param {string} discussionId The id of the discussion
     * @param {callback} hasCurrentUserAsMember A middleware that verifies if the current user is a member of the discusion
     * @returns {HttpResponse} The list of found messages
     */
    router.get('/', 
    celebrate({[Segments.QUERY]: Joi.object({discussionId: Joi.string().required()})}), 
    middlewares.discussion.hasCurrentUserAsMember, 
    async (req: Request, res: Response, next: NextFunction) => {
        try {
            const messageService = Container.get(MessageService);
            const discussionId = req.query['discussionId'] as string;
            const messages = await messageService.fetchByDiscussionId(discussionId);
            res.send(messages).status((messages.length > 0) ? 200 : 204);
        }
        catch(err) {
            next(err)
        }
    })

    /**
     * @description Get a comment by its id
     * @param {string} commentId The id of the comment
     * @param {callback} hasCurrentUserAsMember A middleware that verifies if the current user is a member of the discusion
     * @returns {HttpResponse} The found message
     */
    router.get('/:messageId', 
    celebrate({[Segments.PARAMS]: Joi.object({messageId: Joi.string().required()})}), 
    middlewares.bindMessageAndDiscussionId, 
    middlewares.discussion.hasCurrentUserAsMember, 
    async (req: Request, res: Response, next: NextFunction) => {
        res.send(req.message).status(200);
    })

    /**
     * @description Add a comment to a discussion
     * @param {string} commentId The id of the comment
     * @param {callback} hasCurrentUserAsMember A middleware that verifies if the current user is a member of the discusion
     * @returns {HttpResponse} The found message
     */
    router.post('/', 
    celebrate({
        [Segments.QUERY]: Joi.object({discussionId: Joi.string().required().trim()}),
        [Segments.BODY]: Joi.object().keys(
            {
                media: Joi.string().trim(),
                text: Joi.string().trim()
            })
    }), 
    middlewares.discussion.hasCurrentUserAsMember,
    async (req: Request, res: Response, next: NextFunction) => {
        try {
            const messageService = Container.get(MessageService);
            const discussionId = req.query['discussionId'] as string;
            const content = req.body;
            const message: IMessageInputDTO = {
                discussion: discussionId, 
                sender: req.currentUser._id,
                content: content
            }

            const createdMessage = await messageService.create(message);

            res.send(createdMessage).status(200);
        }
        catch(err) {
            next(err);
        }
    })

    /**
     * @description Delete a comment
     * @param {string} messageId The id of the message
     * @param {callback} hasCurrentUserAsMember A middleware that verifies if the current user is a member of the discusion
     * @returns {HttpResponse} The found message
     */
    router.delete('/:messageId', 
    celebrate({[Segments.PARAMS]: Joi.object().keys({messageId: Joi.string().required()})}), 
    middlewares.bindMessageAndDiscussionId, 
    middlewares.discussion.hasCurrentUserAsMember, 
    async (req: Request, res: Response, next: NextFunction) => {
        try {
            const messageService = Container.get(MessageService);
            const messageId = req.params['messageId'];
            const deletedMessage = await messageService.deleteById(messageId);

            res.send(deletedMessage).status(200);
        }
        catch(err) {
            next(err)
        }
    })

    app.use(errors())
}