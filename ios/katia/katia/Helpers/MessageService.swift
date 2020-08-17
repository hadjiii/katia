//
//  MessageService.swift
//  katia
//
//  Created by Hadji on 09/08/2020.
//  Copyright © 2020 Hadji. All rights reserved.
//

import Foundation

class MessageService {
    static let shared = MessageService()
    
    private init() {}
    
    func fetchDiscussions(for userId: Int) -> Result<[Message], DataError> {
        let discussions = Data.getDiscussionsForUserId(userId)
        return Result.success(discussions)
    }
    
    func fetchMessages(for userId: Int) -> Result<[Message], DataError> {
        let discussions = Data.getMessagesWithUserId(userId)
        return Result.success(discussions)
    }
    
    func sendMessage(_ message: Message)  -> Result<Int, DataError> {
        let messageId = Data.addMessage(message)
        if let messageId = messageId {
            return Result.success(messageId)
        }
        return Result.failure(DataError.unknown)
    }
}
