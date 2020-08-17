//
//  ObjectSavableError.swift
//  katia
//
//  Created by Hadji on 08/08/2020.
//  Copyright © 2020 Hadji. All rights reserved.
//

import Foundation

enum ObjectSavableError: String, LocalizedError {
    case noValue = "No value found for the given key"
    case unableToEncode = "Unable to encode object"
    case unableToDecode = "Unable to decode object"
    
    var errorDescription: String? {
        rawValue
    }
}
