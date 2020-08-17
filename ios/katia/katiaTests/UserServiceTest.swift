//
//  UserServiceTest.swift
//  katiaTests
//
//  Created by Hadji on 08/08/2020.
//  Copyright © 2020 Hadji. All rights reserved.
//

import XCTest
@testable import katia

class UserServiceTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRegister() {
        let result1 = UserService.shared.register(username: "Me", password: "test", confirmPassword: "test")
        switch result1 {
        case .success(_):
            XCTFail("testLogin Not implemented")
        case .failure(let error):
            print("error \(error)")
            XCTAssertTrue(error == DataError.exists, "")
        }
        
        let result2 = UserService.shared.register(username: "NewUser", password: "azerty", confirmPassword: "azerty")
        switch result2 {
        case .success(let user):
            XCTAssertNotNil(user.id, "")
        case .failure(_):
            XCTFail("testLogin Not implemented")
        }
    }
    
    func testLogin() {
        let result1 = UserService.shared.login(username: "Test", password: "test")
        switch result1 {
        case .success(_):
            XCTFail("testLogin Not implemented")
        case .failure(let error):
            XCTAssertTrue(error == DataError.notFound, "")
        }
        
        
        let result2 = UserService.shared.login(username: "Me", password: "test")
        switch result2 {
        case .success(let user):
            XCTAssertNotNil(user.id, "")
        case .failure(_):
            XCTFail("testLogin Not implemented")
        }
    }
    
    func testIsLoggedIn() {
        let isLogginIn = UserService.shared.isLoggedIn()
        XCTAssertTrue(isLogginIn)
    }
    
    func testLogout() {
        UserService.shared.logout()
        let isLogginIn = UserService.shared.isLoggedIn()
        XCTAssertFalse(isLogginIn, "")
    }
}
