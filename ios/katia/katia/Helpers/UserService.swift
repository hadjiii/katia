//
//  UserService.swift
//  katia
//
//  Created by Hadji on 07/08/2020.
//  Copyright © 2020 Hadji. All rights reserved.
//

import Foundation

class UserService {
    static let shared = UserService()
    
    private init() {}
    
    func register(username: String, password: String, confirmPassword: String) -> Result<User, DataError> {
        var user = User(username: username, password: password, confirmPassword: confirmPassword)
        Data.addUser(&user)
        
        if let _ = user.id {
            return Result.success(user)
        }
        
        return Result.failure(.notFound)
    }
    
    func login(username: String, password: String)  -> Result<User, DataError> {
        let user = Data.getUser(username: username, password: password)
        
        if let user = user {
            do {
                try(UserDefaults.standard.setCustomObject(user, forKey: "currentUser"))
                UserDefaults.standard.set(true, forKey: "isLoggedIn")
                return Result.success(user)
            }
            catch {
                return Result.failure(.unknown)
            }
        }
        
        return Result.failure(.exists)
    }
    
    func logout() {
        UserDefaults.standard.removeObject(forKey: "isLoggedIn")
        UserDefaults.standard.removeObject(forKey: "currentUser")
    }
    
    func forgotPassword(username: String) {
        fatalError("forgotPassword has not been implemented")
    }
    
    func resetPassword(username: String, password: String, confirmPassword: String) {
        fatalError("resetPassword has not been implemented")
    }
    
    func isLoggedIn() -> Bool {
        UserDefaults.standard.bool(forKey: "isLoggedIn")
    }
}
