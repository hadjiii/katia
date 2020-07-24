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
}
