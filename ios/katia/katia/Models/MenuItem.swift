//
//  MenuItem.swift
//  katia
//
//  Created by Hadji on 05/08/2020.
//  Copyright © 2020 Hadji. All rights reserved.
//

import Foundation

enum MenuItem: Int, CustomStringConvertible {
    case Profile
    case Settings
    case Logout
    
    var description: String {
        switch self {
        case .Profile:
            return "Profile"
        case .Settings:
            return "Settings"
        case .Logout:
            return "Logout"
        }
    }
    
    var iconName: String {
        switch self {
        case .Profile:
            return "person"
        case .Settings:
            return "printer"
        case .Logout:
            return "printer"
        }
    }
}
