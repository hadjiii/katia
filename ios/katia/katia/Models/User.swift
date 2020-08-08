//
//  User.swift
//  katia
//
//  Created by Hadji on 28/07/2020.
//  Copyright © 2020 Hadji. All rights reserved.
//

import Foundation

struct User: Codable {
    var id: Int?
    var username: String
    var password: String?
    var confirmPassword: String?
}
