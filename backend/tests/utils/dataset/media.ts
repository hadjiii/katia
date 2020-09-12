import * as users from "./user"

export const user1Avatar = { 
    "_id" : "5f4566bf254311132570168e", 
    "name" : "avatar1.jpg", 
    "owner" : users.user1._id
}

export const user2Avatar = { 
    "_id" : "5f4566bf2543111325701694", 
    "name" : "avartar2.jpg", 
    "owner" : users.user2._id
}

export const user3Avatar = { 
    "_id" : "5f4566bf2543111325701696", 
    "name" : "avartar3.jpg", 
    "owner" : users.user3._id
}

export const user4Avatar = { 
    "_id" : "5cabe64dcf0d4447fa60f5e2", 
    "name" : "avartar4.jpg", 
    "owner" : users.user4._id
};

export const simpleDiscussion1Message1Media = { 
    "_id" : "5f45c5fc31ac872829beaab9", 
    "name" : "first_message_image.jpg", 
    "owner" : users.user1._id
}

export const simpleDiscussion1Message2Media = { 
    "_id" : "5f45c606b79c10e4573ca300", 
    "name" : "second_message_image.jpg", 
    "owner" : users.user1._id
}

export const groupDiscussion2Message1Media = { 
    "_id" : "5f45c613937a99c4e88f648c", 
    "name" : "third_message_image.jpg", 
    "owner" : users.user4._id
}

export const groupDiscussion2Message2Media = { 
    "_id" : "5f45c61cd0dce6bd38461e1e", 
    "name" : "fourth_message_image.jpg", 
    "owner" : users.user4._id
}

export const groupDiscussion2Message3Media = { 
    "_id" : "5f45c626d1d66a3cae80d625", 
    "name" : "fifth_message_image.jpg", 
    "owner" : users.user3._id
}

export const groupDiscussion2Message4Media = { 
    "_id" : "5f45c6302363268270917453", 
    "name" : "sixth_message_image.jpg", 
    "owner" : users.user2._id
}

export const user1Story1Media = { 
    "_id" : "5f46899dbf06d7237b44b7eb", 
    "name" : "first_story_image.jpg", 
    "owner" : users.user1._id
}

export const user1Story2Media = { 
    "_id" : "5f4689aaf7f56d425936f228", 
    "name" : "second_story_image.jpg", 
    "owner" : users.user1._id
}

export const user2Story1Media = { 
    "_id" : "5f4689b3955602df60efd218", 
    "name" : "third_story_image.jpg", 
    "owner" : users.user2._id
}

export const user2Story2Media = { 
    "_id" : "5f4689bb1c94f5a0e13a3d80", 
    "name" : "fourth_story_image.jpg", 
    "owner" : users.user2._id
}

export const user3Story1Media = { 
    "_id" : "5f4689c46a6b2f6bcef08ef7", 
    "name" : "fifth_story_image.jpg", 
    "owner" : users.user3._id
}

export default [
    user1Avatar, 
    user2Avatar, 
    user3Avatar, 
    user4Avatar, 
    simpleDiscussion1Message1Media, 
    simpleDiscussion1Message2Media, 
    groupDiscussion2Message1Media, 
    groupDiscussion2Message2Media, 
    groupDiscussion2Message3Media, 
    groupDiscussion2Message4Media
]