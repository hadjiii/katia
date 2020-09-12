import {Request, Response, NextFunction} from "express";
import Container from "typedi";
import StoryService from "../../../services/story";

const isOwner = async (req: Request, res: Response, next: NextFunction) => {
    try {
        const storyService = Container.get(StoryService);
        const storyId = req.params['storyId']
        await storyService.fetchOne({_id: storyId, user: req.currentUser._id});
        return true;
    }
    catch(err) {
        if(err) {
            return false;
        }
        next(err);
    }
}

export default isOwner;