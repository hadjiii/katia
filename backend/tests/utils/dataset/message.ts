import * as users from "./user"
import * as discussions from "./discussion"
import * as medias from "./media"

export const simpleDiscussion1Message1 = {
    "_id": "5f45c228a47d5fd704ed7193",
    "discussion": discussions.simpleDiscussion1._id,
    "sender": users.user1._id,
    "content": "First message.",
    "media": medias.simpleDiscussion1Message1Media._id
 };

 export const simpleDiscussion1Message2 = {
    "_id": "5f45c232f0433476f538d964",
    "discussion": discussions.simpleDiscussion1._id,
    "sender": users.user1._id,
    "content": "Second message.",
    "media": medias.simpleDiscussion1Message2Media._id
 }

 export const groupDiscussion2Message1 = {
    "_id": "5f45c23eaa447f018d12e326",
    "discussion": discussions.groupDiscussion2._id,
    "sender": users.user4._id,
    "content": "Third message.",
    "media": medias.groupDiscussion2Message1Media._id
 }

 export const groupDiscussion2Message2 = {
    "_id": "5f45c24a0ec9e6e756c43954",
    "discussion": discussions.groupDiscussion2._id,
    "sender": users.user4._id,
    "content": "Fourth message.",
    "media": medias.groupDiscussion2Message2Media._id
 }

 export const groupDiscussion2Message3 = {
    "_id": "5f45c255c7b54cc90b4930c9",
    "discussion": discussions.groupDiscussion2._id,
    "sender": users.user3._id,
    "content": "Fifth message.",
    "media": medias.groupDiscussion2Message3Media._id
 }

 export const groupDiscussion2Message4 = {
    "_id": "5f45c25fd6d5a298ec7a7d44",
    "discussion": discussions.groupDiscussion2._id,
    "sender": users.user2._id,
    "content": "Sixth message.",
    "media": medias.groupDiscussion2Message4Media._id
 }

 export default [simpleDiscussion1Message1, simpleDiscussion1Message2, groupDiscussion2Message1, groupDiscussion2Message2, groupDiscussion2Message3, groupDiscussion2Message4];