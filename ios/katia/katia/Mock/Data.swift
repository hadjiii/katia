//
//  Data.swift
//  katia
//
//  Created by Hadji on 14/07/2020.
//  Copyright © 2020 Hadji. All rights reserved.
//

import Foundation

class Data: NSObject {
    static var stories = [
        // current Username1's stories
        Story(id: 1, userId: 2, username: "Username1", mediaType: MediaType.image, medialink: "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/250px-Image_created_with_a_mobile_phone.png", date: "today", status: Status.read),
        Story(id: 2, userId: 2, username: "Username1", mediaType: MediaType.image, medialink: "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/250px-Image_created_with_a_mobile_phone.png", date: "yesterday", status: Status.read),
        
        // Username2's stories
        Story(id: 3, userId: 3, username: "Username2", mediaType: MediaType.video, medialink: "https://katiapp.s3.amazonaws.com/test.mp4", date: "yesterday", status: Status.read),
        Story(id: 4, userId: 3, username: "Username2", mediaType: MediaType.video, medialink: "https://katiapp.s3.amazonaws.com/test.mp4", date: "yesterday", status: Status.unread),
        
        // Username3's stories
        Story(id: 5, userId: 4, username: "Username3", mediaType: MediaType.image, medialink: "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/250px-Image_created_with_a_mobile_phone.png", date: "yesterday", status: Status.unread),
        Story(id: 6, userId: 4, username: "Username3", mediaType: MediaType.video, medialink: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4", date: "yesterday", status: Status.read),
        Story(id: 7, userId: 4, username: "Username3", mediaType: MediaType.video, medialink: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4", date: "yesterday", status: Status.read),
        Story(id: 8, userId: 4, username: "Username3", mediaType: MediaType.image, medialink: "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/250px-Image_created_with_a_mobile_phone.png", date: "yesterday", status: Status.unread),
        Story(id: 9, userId: 4, username: "Username3", mediaType: MediaType.video, medialink: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4", date: "yesterday", status: Status.read),
        Story(id: 10, userId: 4, username: "Username3", mediaType: MediaType.image, medialink: "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/250px-Image_created_with_a_mobile_phone.png", date: "yesterday", status: Status.read),
        
        // Username4's stories
        Story(id: 11, userId: 5, username: "Username4", mediaType: MediaType.image, medialink: "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/250px-Image_created_with_a_mobile_phone.png", date: "today", status: Status.read),
        Story(id: 12, userId: 5, username: "Username4", mediaType: MediaType.image, medialink: "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/250px-Image_created_with_a_mobile_phone.png", date: "yesterday", status: Status.read),
        
        // Username5's stories
        Story(id: 13, userId: 6, username: "Username5", mediaType: MediaType.image, medialink: "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/250px-Image_created_with_a_mobile_phone.png", date: "yesterday", status: Status.unread),
        Story(id: 14, userId: 6, username: "Username5", mediaType: MediaType.video, medialink: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4", date: "yesterday", status: Status.read),
        Story(id: 15, userId: 6, username: "Username5", mediaType: MediaType.video, medialink: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4", date: "yesterday", status: Status.read),
        Story(id: 16, userId: 6, username: "Username5", mediaType: MediaType.image, medialink: "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/250px-Image_created_with_a_mobile_phone.png", date: "yesterday", status: Status.unread),
        Story(id: 17, userId: 6, username: "Username5", mediaType: MediaType.video, medialink: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4", date: "yesterday", status: Status.read),
        Story(id: 18, userId: 6, username: "Username5", mediaType: MediaType.image, medialink: "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/250px-Image_created_with_a_mobile_phone.png", date: "yesterday", status: Status.read)
    ]
    
    static func getOrderedStories() -> [String: [[Story]]] {
        var currentUserStories = [[Story]]()
        var recentStories = [[Story]]()
        var readStories = [[Story]]()
        
        let storiesGroupedByUserId = Dictionary(grouping: stories, by: {$0.userId})
        
        storiesGroupedByUserId.forEach { (groupedStoriesDict) in
            
            let (userId, groupedStories) = groupedStoriesDict
            
            if userId == 1 {
                currentUserStories.append(groupedStories)
                return
            }
            
            let containsUnreadStory = groupedStories.contains { (story) -> Bool in
                return story.status == Status.unread
            }
            
            if containsUnreadStory {
                recentStories.append(groupedStories)
            }
            else {
                readStories.append(groupedStories)
            }
        }
        
        let res = ["myStories": currentUserStories, "recent": recentStories, "read": readStories]
        
        return res
    }
    
    static func addStory(_ story: inout Story) {
        if let lastStory = stories.last {
            let id = lastStory.id
            story.id = (id ?? 0) + 1
        }
        else {
            story.id = 1
        }
        
        stories.append(story)
    }
    
    static func setStoryAsRead(id: Int) {
        stories = stories.map { (story) -> Story in
            var readStory = story
            if story.id == id {
                readStory.status = Status.read
            }
            
            return readStory
        }
    }
    
    static var messages = [
        Message(id: 1, senderId: 1, recipientId: 2, text: "Hello", date: "Saturday, 19 AM"),
        Message(id: 2, senderId: 2, recipientId: 1, text: "Hi", date: "Saturday, 19 AM"),
        Message(id: 3, senderId: 1, recipientId: 2, text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", date: "Saturday, 19 AM"),
        Message(id: 4, senderId: 2, recipientId: 1, text: "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.", date: "Saturday, 19 AM"),
        Message(id: 5, senderId: 1, recipientId: 2, text: "Et harum quidem rerum facilis est et expedita distinctio. Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus, omnis voluptas assumenda est, omnis dolor repellendus.", date: "Saturday, 19 AM"),
        Message(id: 6, senderId: 2, recipientId: 1, text: "Sed ut lectus porta augue tempor ornare. Nulla vel nisi sit amet lectus rhoncus aliquet. Donec placerat gravida laoreet.", date: "Saturday, 19 AM"),
        Message(id: 7, senderId: 1, recipientId: 3, text: "Hello", date: "Saturday, 19 AM"),
        Message(id: 8, senderId: 1, recipientId: 3, text: "Hello!!!", date: "Saturday, 19 AM"),
    ]
    
    static func addMessage(_ message: Message) {
        messages.append(message)
    }
    
    static func getMessagesWithUserId(_ userId: Int) -> [Message] {
        return messages.filter({$0.senderId == userId || $0.recipientId == userId})
    }
    
    static func getDiscussions() -> [Message] {
        let groupedDiscussion = Dictionary.init(grouping: messages) { (message) -> Int in
            return message.senderId + message.recipientId
        }
        
        return groupedDiscussion.map({$0.value.last!}) 
    }
    
    static var users = [
        User(id: 1, name: "Me"),
        User(id: 2, name: "User2"),
        User(id: 3, name: "User3"),
        User(id: 4, name: "User4"),
    ]
    
    static func getCurrentUser() -> User {
        return users.first!
    }
    
    static func getUsers() -> [User] {
        return users
    }
    
    static func addUser(_ user: inout User) {
        let id = users.capacity + 1
        user.id = id
        users.append(user)
    }
    
    static func getUser(id: Int) -> User? {
        return users.filter({$0.id == id}).first
    }
    
    static func getUsers(name: String) -> [User]{
        return users.filter({$0.name == name})
    }
    
    static func getUsers(keyword: String) -> [User] {
        return users.filter({$0.name.lowercased().contains(keyword.lowercased())})
    }
}
