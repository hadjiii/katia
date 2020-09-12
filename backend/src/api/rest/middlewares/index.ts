import isAuthorized from "./isAuthorized";
import currentUser from "./currentUser";
import discussion from "./discussion";
import message from "./message";
import story from "./story";

export default {
    isAuthorized: isAuthorized,
    bindCurrentUser: currentUser,
    discussion: discussion,
    bindMessageAndDiscussionId: message,
    isOwner: story
}