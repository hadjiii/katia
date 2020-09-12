import { Request, Response, NextFunction } from "express";
import { Joi } from "celebrate";
import Container from "typedi";
import DiscussionService from "../../../services/discussion";

const simpleDiscussionSchema = Joi.object().keys({
    participant: Joi.string().trim().required()
})

const groupDiscussionSchema = Joi.object({
    name: Joi.string().required(),
    participants: Joi.array().items(Joi.string().required()).required().min(1)
})

const hasValidBodyType =  (req: Request, res: Response, next: NextFunction) => {
    const discussionType = req.query['type'];

    switch(discussionType) {
        case 'simple_discussion':
            let res = simpleDiscussionSchema.validate(req.body)
            if(res.error) { return next(res.error) }
            else{ return next(); }
        case 'group_discussion':
            const res1 = groupDiscussionSchema.validate(req.body)
            if(res1.error) { return next(res1.error) }
            else{ return next(); }
    }
}

const hasCurrentUserAsMember = async (req: Request, res: Response, next: NextFunction) => {
    const discussionId = req.params['discussionId'] || (req.query['discussionId'] as string) || req.discussionId;
    const participantId = req.token._id;

    try {
        const discussionService = Container.get(DiscussionService);
        const discussion = await discussionService.fetchByIdIfHasMember(discussionId, participantId);
        if(discussion) { req.currentDiscussion = discussion ; next(); } 
        else { res.sendStatus(403) }
    }
    catch(err) { next(err); }
}

export default {
    hasValidBodyType,
    hasCurrentUserAsMember
}
