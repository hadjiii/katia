import { model } from "mongoose";
import userDataset from "./user";
import discussionDataset from "./discussion";
import messageDataset from "./message";
import mediaDataset from "./media";
import storyDataset from "./story2";


async function load() {
    const users = await loadUsers();
    const discusions = await loadDiscussions();
    const messages = await loadMessages();
    const stories = await loadStories();
    const medias = await loadMedias();
}

function loadUsers() {
    return model('User').insertMany(userDataset)
}

function loadDiscussions() {
    return model('Discussion').insertMany(discussionDataset)
 }

 function loadMessages() {
    return model('Message').insertMany(messageDataset);
 }

 function loadStories() {
    return model('Story').insertMany(storyDataset);
 }

 function loadMedias() {
    return model('Media').insertMany(mediaDataset);
 }

export default {
    load
}