import { Router } from "express";
import auth from "./auth";
import discussion from "./discussion";
import story from "./story";
import message from "./message";

export default () => {
    const app = Router();
    
    auth(app);
    discussion(app);
    message(app);
    story(app);

    return app;
}