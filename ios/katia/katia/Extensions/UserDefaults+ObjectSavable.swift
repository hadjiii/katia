//
//  UserDefaults+ObjectSavable.swift
//  katia
//
//  Created by Hadji on 08/08/2020.
//  Copyright © 2020 Hadji. All rights reserved.
//

import Foundation

extension UserDefaults: ObjectSavable {
    func setCustomObject<T>(_ object: T, forKey: String) throws where T : Encodable {
        let encoder = JSONEncoder()
        
        do {
            let data = try(encoder.encode(object))
            setValue(data, forKey: forKey)
        }
        catch {
            throw ObjectSavableError.unableToEncode
        }
    }
    
    func getCustomObject<T>(forKey: String, castTo type: T.Type) throws -> T where T : Decodable {
        let decoder = JSONDecoder()
        
        do {
            guard let data = data(forKey: forKey) else { throw ObjectSavableError.noValue}
            let object = try(decoder.decode(type, from: data))
            return object
        }
        catch {
            throw ObjectSavableError.unableToDecode
        }
    }
}
