import * as avatars from "./media"

export const user1: mockUser = { 
    "_id" : "5f4566bf254311132570168d", 
    "discussions" : [], 
    "username" : "user1", 
    "password" : "Test-1111",
    "avatar": avatars.user1Avatar._id
};

export const user2: mockUser = { 
    "_id" : "5f4566bf2543111325701693", 
    "discussions" : [], 
    "username" : "user2", 
    "password" : "Test-2222",
    "avatar": avatars.user2Avatar._id
};

export const user3: mockUser = { 
    "_id" : "5f4566bf2543111325701695", 
    "discussions" : [], 
    "username" : "user3", 
    "password" : "Test-3333",
    "avatar": avatars.user3Avatar._id
};

export const user4: mockUser = { 
    "_id" : "56cb91bdc3464f14678934ca", 
    "discussions" : [], 
    "username" : "user4", 
    "password" : "Test-4444",
    "avatar": avatars.user4Avatar._id
};

type mockUser = {_id: string, discussions: [], username: string, password: string, avatar: string}

export default [user1, user2, user3, user4];