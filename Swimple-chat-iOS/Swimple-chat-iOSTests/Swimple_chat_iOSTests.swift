//
//  Swimple_chat_iOSTests.swift
//  Swimple-chat-iOSTests
//
//  Created by Dmitry Gorin on 03/10/2018.
//  Copyright © 2018 gordiig. All rights reserved.
//

import XCTest
@testable import Swimple_chat_iOS

class Swimple_chat_iOSTests: XCTestCase
{
    let user1 = User(username: "user1")
    let user2 = User(username: "user2")
    let user3 = User(username: "user3")
    
    let msg1 = Message(id: 0, from: "user0", to: "user1", msg: "msg1")
    let msg2 = Message(id: 1, from: "user0", to: "user2", msg: "msg2")
    let msg3 = Message(id: 2, from: "user1", to: "user0", msg: "msg3")
    let msg4 = Message(id: 3, from: "user2", to: "user0", msg: "msg4")
    let msg5 = Message(id: 4, from: "user3", to: "user0", msg: "msg5")
    
    override class func setUp()
    {
        ChatRooms.default.clear()
    }

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    
    // MARK: - 1 Unit test, class User
    func testUser()
    {
        let user1 = User(username: "User1")
        let user2 = User(username: "User2", avatarImg: UIImage(named: "send"))
        
        XCTAssert(user1.username == "User1", "First user's name is not \"User1\"!")
        XCTAssert(user2.username == "User2", "Second user's name is not \"User2\"!")
        
        XCTAssert(user1.avatarImg == UIImage(named: User.stdImageName), "First user has wrong avatar!")
        XCTAssert(user2.avatarImg != UIImage(named: User.stdImageName), "Second user has wrong avatar!")
    }
    
    // MARK: - 2 Unit test, class CurrentUser
    func testCurrentUser()
    {
        let cUser = CurrentUser.current
        let ccUser = CurrentUser.current
        XCTAssert(cUser === ccUser, "CurrentUser.current gives different instances!")
        
        cUser.configure(username: "User1", password: "Password")
        XCTAssert(cUser.username == "User1", "Current user's username is not \"User1\"!")
        XCTAssert(cUser.password == "Password", "Current user's password is not \"Password\"!")
        XCTAssert(cUser.avatarImg == UIImage(named: CurrentUser.stdImageName), "Current user's avatar is not standart!")
        
        cUser.configure(username: cUser.username, password: cUser.password, avatarImg: UIImage(named: "send"))
        XCTAssert(cUser.avatarImg != UIImage(named: CurrentUser.stdImageName), "Current user's avatar is still the same!")
    }
    
    // MARK: - 3 Unit test, class ChatRooms
    func testChatRooms()
    {
        CurrentUser.current.username = "user0"
        
        let rooms = ChatRooms.default
        let rooms2 = ChatRooms.default
        XCTAssert(rooms === rooms2, "ChatRooms.default gives different instances!")
        XCTAssertNil(rooms.getRoom(at: 0), "Getting room from empty rooms array!")
        
        rooms.appendMessage(msg1, toChat: user1)
        XCTAssert(rooms.numberOfRooms == 1, "Didn't append room to the rooms!")
        
        rooms.appendMessage(msg2, toChat: user2)
        XCTAssert(rooms.numberOfRooms == 2, "Didn't appent second room to the rooms!")
        
        rooms.appendMessage(msg3, toChat: user1)
        XCTAssert(rooms.numberOfRooms == 2, "Appended room when that room is already exist!")
        
        rooms.appendMessage(msg4, toChat: user2)
        XCTAssert(rooms.numberOfRooms == 2, "Appended room when that room is already exist!")
        
        rooms.appendMessage(msg5, toChat: user3)
        XCTAssert(rooms.numberOfRooms == 3, "Didn't appent third room to the rooms!")
    }

}
