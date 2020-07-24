//
//  Message.swift
//  katia
//
//  Created by Hadji on 24/07/2020.
//  Copyright © 2020 Hadji. All rights reserved.
//

import Foundation

struct Message {
    var id: Int?
    var senderId: Int
    var recipientId: Int
    var text: String
    var mediaType: MediaType?
    var mediaLink: String?
    var date: String?
}
