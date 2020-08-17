//
//  DataError.swift
//  katia
//
//  Created by Hadji on 08/08/2020.
//  Copyright © 2020 Hadji. All rights reserved.
//

import Foundation

enum DataError: Error {
    case exists
    case notFound
    case unknown
}
