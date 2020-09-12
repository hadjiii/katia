import * as users from "./user"

export const simpleDiscussion1 = { 
    "_id" : "5f459cb9635db27f8fe87b89", 
    "messages" : [], 
    "medias" : [], 
    "type" : "simple_discussion", 
    "participant1" : users.user1._id, 
    "participant2" : users.user2._id
}

export const simpleDiscussion2 = { 
    "_id" : "5f459cc48483694136df129b", 
    "messages" : [], 
    "medias" : [], 
    "type" : "simple_discussion", 
    "participant1" : users.user1._id, 
    "participant2" : users.user3._id
}

export const groupDiscussion1 = { 
    "_id" : "5f459cd1480ef178dbca2d36", 
    "messages" : [], 
    "medias" : [], 
    "type" : "group_discussion", 
    "creator": users.user4._id,
    "participants": []
}

export const groupDiscussion2 = { 
    "_id" : "5f459cdd4a8480559015bb60", 
    "messages" : [], 
    "medias" : [], 
    "type" : "group_discussion", 
    "creator": users.user3._id,
    "participants": [users.user2._id, users.user3._id, users.user4._id]
}

export default [simpleDiscussion1, simpleDiscussion2, groupDiscussion1, groupDiscussion2]