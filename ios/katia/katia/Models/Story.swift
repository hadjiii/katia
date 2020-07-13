//
//  Story.swift
//  katia
//
//  Created by Hadji on 12/07/2020.
//  Copyright © 2020 Hadji. All rights reserved.
//

import Foundation

struct Story {
    var username: String
    var mediaType: MediaType
    var medialink: String
    var date: String
    var status: Status
}

enum MediaType {
    case image
    case video
}

enum Status {
    case unread
    case read
}
