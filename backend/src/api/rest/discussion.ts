import {Router, Request, Response, NextFunction} from "express";
import DiscussionService from "../../services/discussion"
import Container from "typedi";
import {celebrate, Joi, errors, Segments} from "celebrate";
import middlewares from "./middlewares";
import { IUser } from "../../interfaces/user";

const router =  Router();

export default (app: Router) => {
    app.use('/discussions', router);

    router.use(middlewares.isAuthorized, middlewares.bindCurrentUser)

    router.get('/', 
    async (req: Request, res: Response, next: NextFunction) => {
        try {
            const discussionService = Container.get(DiscussionService);
            const discussions = await discussionService.fetchAllForUser(req.currentUser._id);
            
            res.send(discussions).status(discussions.length > 0 ? 200 : 201);
        }
        catch(err) { next(err); }
    })

    router.get('/:discussionId', celebrate({
        [Segments.PARAMS]: Joi.object({discussionId: Joi.string().required()})
    }), middlewares.discussion.hasCurrentUserAsMember, async (req: Request, res: Response, next: NextFunction) => {
        res.send(req.currentDiscussion).status(200);
    })

    router.get('/:discussionId/participants', celebrate({
        [Segments.PARAMS]: Joi.object({discussionId: Joi.string().required()})
        }), middlewares.discussion.hasCurrentUserAsMember, async (req: Request, res: Response, next: NextFunction) => {
        const currentDiscussion = req.currentDiscussion;
        let participants: IUser[] = [];
    
        switch(currentDiscussion.type) {
            case 'simple_discussion':
                participants.push(currentDiscussion.participant1);
                participants.push(currentDiscussion.participant2);
                break;
            case 'group_discussion':
                participants = currentDiscussion.participants as [IUser];
                break;
        }

        res.send({participants}).status(200);
    })

    router.get('/:discussionId/participants/:participantId', celebrate({
        [Segments.PARAMS]: Joi.object({discussionId: Joi.string().required(), participantId: Joi.string().required()})
        }), middlewares.discussion.hasCurrentUserAsMember, async (req: Request, res: Response, next: NextFunction) => {
            try {
                const discussionService = Container.get(DiscussionService);
                const type = req.query['type'];
                let discussion;
    
                switch(type) {
                    case 'simple_discussion':
                        discussion = {...req.body, type: type};
                    break;
                    case 'group_discussion':
                        discussion = {...req.body, creator: "current user id", type: type};
                    break;
                    default:
                    discussion = {...req.body, creator: "current user id"};
                    break;
                }
                
                const createdDiscussion = await discussionService.create(discussion)
    
                res.send(createdDiscussion).status(201);
            }
            catch(err) {
                next(err);
            }
    })
    
    router.post('/', celebrate({
    [Segments.QUERY]: Joi.object({type: Joi.string().required().equal("simple_discussion", "group_discussion")})
    }), middlewares.discussion.hasValidBodyType, async (req: Request, res: Response, next: NextFunction) => {
        try {
            const discussionService = Container.get(DiscussionService);
            const currentUser = req.currentUser
            const type = req.query['type'];
            let discussion;

            switch(type) {
                case 'simple_discussion':
                    discussion = {participant1: currentUser._id, participant2: req.body.participant, type: type };
                break;
                case 'group_discussion':
                    const name = req.body['name'];
                    const participants: Set<string> = new Set([currentUser._id.toString(), ...req.body['participants']]);
                    discussion = {creator: currentUser._id, type: type, participants: Array.from(participants), name};
                break;
                default:
                    const err = new Error('Discussion type is required');
                    err.status = 400;
                    return next(err);
            }
            
            const createdDiscussion = await discussionService.create(discussion)

            res.send(createdDiscussion).status(201);
        }
        catch(err) {
            next(err);
        }
    })

    router.post('/:discussionId/participants', celebrate({
        [Segments.PARAMS]: Joi.object({discussionId: Joi.string().required()}),
        [Segments.BODY]: Joi.object().keys({participant: Joi.string().required()})
        }), middlewares.discussion.hasCurrentUserAsMember, async (req: Request, res: Response, next: NextFunction) => {
            const discussion = req.currentDiscussion;

            if (discussion.type !== 'group_discussion') {
                return res.sendStatus(400);
            }

            const participants = discussion.participants as [IUser];
            const newParticipant = req.body['participant'];

            if(participants.find(participant => participant._id.toString() === newParticipant)) {
                res.sendStatus(409);
            }

            try {
                const discussionService = Container.get(DiscussionService);
                const createdDiscussion = await discussionService.create(discussion)
                res.send(createdDiscussion).status(201);
            }
            catch(err) {
                next(err);
            }
    })

    router.delete('/:discussionId/participants/:participantId', celebrate({
        [Segments.PARAMS]: Joi.object({participantId: Joi.string().required()})
        }), middlewares.discussion.hasCurrentUserAsMember, async (req: Request, res: Response, next: NextFunction) => {
            try {
                const discussionService = Container.get(DiscussionService);
                const type = req.query['type'];
                let discussion;
    
                switch(type) {
                    case 'simple_discussion':
                        discussion = {...req.body, type: type};
                    break;
                    case 'group_discussion':
                        discussion = {...req.body, creator: "current user id", type: type};
                    break;
                    default:
                    discussion = {...req.body, creator: "current user id"};
                    break;
                }
                
                const createdDiscussion = await discussionService.create(discussion)
    
                res.send(createdDiscussion).status(201);
            }
            catch(err) {
                next(err);
            }
    })

    app.use(errors())
}
