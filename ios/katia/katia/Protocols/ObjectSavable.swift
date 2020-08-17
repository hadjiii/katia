//
//  ObjectSavable.swift
//  katia
//
//  Created by Hadji on 08/08/2020.
//  Copyright © 2020 Hadji. All rights reserved.
//

import Foundation

protocol ObjectSavable {
    func setCustomObject<T>(_ object: T, forKey: String) throws where T: Encodable
    func getCustomObject<T>(forKey: String, castTo type: T.Type) throws -> T where T: Decodable
}
