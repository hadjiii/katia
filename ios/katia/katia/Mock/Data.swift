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
        "myStories": [],
        "recent": [
            [
                Story(username: "Username1", mediaType: MediaType.image, medialink: "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/250px-Image_created_with_a_mobile_phone.png", date: "today", status: Status.unread),
                Story(username: "Username1", mediaType: MediaType.image, medialink: "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/250px-Image_created_with_a_mobile_phone.png", date: "yesterday", status: Status.read)
            ],
            [
                Story(username: "Username2", mediaType: MediaType.video, medialink: "https://katiapp.s3.amazonaws.com/test.mp4", date: "yesterday", status: Status.read),
                Story(username: "Username2", mediaType: MediaType.video, medialink: "https://katiapp.s3.amazonaws.com/test.mp4", date: "yesterday", status: Status.read),
            ],
            [
                Story(username: "Username3", mediaType: MediaType.image, medialink: "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/250px-Image_created_with_a_mobile_phone.png", date: "yesterday", status: Status.unread),
                Story(username: "Username3", mediaType: MediaType.video, medialink: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4", date: "yesterday", status: Status.read),
                Story(username: "Username3", mediaType: MediaType.video, medialink: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4", date: "yesterday", status: Status.read),
                Story(username: "Username3", mediaType: MediaType.image, medialink: "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/250px-Image_created_with_a_mobile_phone.png", date: "yesterday", status: Status.unread),
                Story(username: "Username3", mediaType: MediaType.video, medialink: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4", date: "yesterday", status: Status.read),
                Story(username: "Username3", mediaType: MediaType.image, medialink: "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/250px-Image_created_with_a_mobile_phone.png", date: "yesterday", status: Status.read)
            ]
        ],
        "read": [
            [
                Story(username: "Username4", mediaType: MediaType.image, medialink: "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/250px-Image_created_with_a_mobile_phone.png", date: "today", status: Status.unread),
                Story(username: "Username4", mediaType: MediaType.image, medialink: "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/250px-Image_created_with_a_mobile_phone.png", date: "yesterday", status: Status.read)
            ],
            [
                Story(username: "Username5", mediaType: MediaType.image, medialink: "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/250px-Image_created_with_a_mobile_phone.png", date: "yesterday", status: Status.unread),
                Story(username: "Username5", mediaType: MediaType.video, medialink: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4", date: "yesterday", status: Status.read),
                Story(username: "Username5", mediaType: MediaType.video, medialink: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4", date: "yesterday", status: Status.read),
                Story(username: "Username5", mediaType: MediaType.image, medialink: "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/250px-Image_created_with_a_mobile_phone.png", date: "yesterday", status: Status.unread),
                Story(username: "Username5", mediaType: MediaType.video, medialink: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4", date: "yesterday", status: Status.read),
                Story(username: "Username5", mediaType: MediaType.image, medialink: "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/250px-Image_created_with_a_mobile_phone.png", date: "yesterday", status: Status.read)
            ]
        ]
    ]
}
