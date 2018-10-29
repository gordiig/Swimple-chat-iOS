//
//  Swimple_chat_iOSTests.swift
//  Swimple-chat-iOSTests
//
//  Created by Dmitry Gorin on 03/10/2018.
//  Copyright © 2018 gordiig. All rights reserved.
//

import XCTest
@testable import Swimple_chat_iOS

class Swimple_chat_iOSTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
    
    // MARK: - 1 Unit test, class User
    func testUser()
    {
        let user1 = User(username: "User1", ip: "129.0.0.1")
        let user2 = User(username: "User2", ip: "129.0.0.2", avatarImg: UIImage(named: "send"))
        
        XCTAssert(user1.username == "User1", "First user's name is not \"User1\"!")
        XCTAssert(user2.username == "User2", "Second user's name is not \"User2\"!")
        
        XCTAssert(user1.ip == "129.0.0.1", "First user's ip is not \"192.0.0.1\"!")
        XCTAssert(user2.ip == "129.0.0.2", "Second user's ip is not \"192.0.0.2\"!")
        
        XCTAssert(user1.avatarImg == UIImage(named: User.stdImageName), "First user has wrong avatar!")
        XCTAssert(user2.avatarImg != UIImage(named: User.stdImageName), "Second user has wrong avatar!")
    }
    
    // MARK: - 2 Unit test, class CurrentUser
    func testCurrentUser()
    {
        let cUser = CurrentUser.current
        let ccUser = CurrentUser.current
        XCTAssert(cUser === ccUser, "CurrentUser.current gives different instances!")
        
        cUser.configure(username: "User1", password: "Password", ip: "129.0.0.1")
        XCTAssert(cUser.username == "User1", "Current user's username is not \"User1\"!")
        XCTAssert(cUser.password == "Password", "Current user's password is not \"Password\"!")
        XCTAssert(cUser.ip == "129.0.0.1", "Current user's ip is not 129.0.0.1!")
        XCTAssert(cUser.avatarImg == UIImage(named: CurrentUser.stdImageName), "Current user's avatar is not standart!")
        
        cUser.configure(username: cUser.username, password: cUser.password, ip: cUser.ip, avatarImg: UIImage(named: "send"))
        XCTAssert(cUser.avatarImg != UIImage(named: CurrentUser.stdImageName), "Current user's avatar is still the same!")
    }

}
