import { Request, Response, NextFunction } from "express";
import Container from "typedi";
import DiscussionService from "../../../services/discussion";
import MessageService from "../../../services/message";
import discussion from "./discussion";

const bindMessageAndDiscussionId = async (req: Request, res: Response, next: NextFunction) => {
    const messageId = req.params['messageId'] || (req.query['messageId'] as string);

    try {
        const discussionService = Container.get(DiscussionService);
        const messageService = Container.get(MessageService);


        const message = await messageService.fetchOneById(messageId);
        req.discussionId =  message.discussion._id;
        req.message = message;
    }
    catch(err) { next(err) }
}

export default bindMessageAndDiscussionId;