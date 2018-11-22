//
//  Swimple_chat_iOSTests.swift
//  Swimple-chat-iOSTests
//
//  Created by Dmitry Gorin on 03/10/2018.
//  Copyright © 2018 gordiig. All rights reserved.
//

import XCTest
import UIKit
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
    
    var notificationCounter = 0
    
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
        
        rooms.clear()
        XCTAssert(rooms.numberOfRooms == 0, "Didn't clear rooms by .clear() command!")
    }
    
    // MARK: - 4 Unit test, class ChatRoom
    func testChatRoom()
    {
        let chatRoom = ChatRoom(username: user1)
        XCTAssert(chatRoom.interlocutor.username == user1.username, "Chat room has been creates with wrong user")
        XCTAssert(chatRoom.messages.count == 0, "Chat room has been created with messages")
        
        chatRoom.appendMessage(msg1)
        XCTAssert(chatRoom.messages.count == 1, "Chat room appended more or less than 1 message")
        XCTAssert(chatRoom.messages.last!.msg == msg1.msg, "Chat room appended wrong message")
    }
    
    // MARK: - 5 Unit test, class ChatRoomsDataMediador
    func testChatRoomsDataMediator()
    {
        self.notificationCounter = 0
        let tableView = UITableView()
        let mediator = ChatRoomsDataSourceMediator(tableView)
        XCTAssert(tableView.dataSource === mediator, "TableView's data source is not mediator!")
        
        NotificationCenter.default.addObserver(self, selector: #selector(notificationCounterIncrement), name: .chatRoomsWereChanged, object: nil)
        let rooms = ChatRooms.default
        
        rooms.appendMessage(msg1, toChat: user1)
        XCTAssert(notificationCounter == 1, "Notification didn't came to self")
        XCTAssert(tableView.numberOfRows(inSection: 0) == 1, "Data mediator didn't put new chat to table view!")
        
        rooms.clear()
        XCTAssert(notificationCounter == 2, "Notification didn't came to self")
        XCTAssert(tableView.numberOfRows(inSection: 0) == 0, "Data mediator didn't delete chat from table view!")
        
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func notificationCounterIncrement()
    {
        self.notificationCounter += 1
    }
    
    
    // MARK: - Integrity test 1, chat rooms data mediator (2 tests)
    func testChatRoomsWereChanged()
    {
        let chatRooms = ChatRooms.default
        let counterPrev = self.notificationCounter
        NotificationCenter.default.addObserver(self, selector: #selector(self.notificationCounterIncrement), name: .chatRoomsWereChanged, object: nil)
        
        chatRooms.appendMessage(self.msg1, toChat: self.user1)
        XCTAssert(counterPrev < self.notificationCounter, "ChatRooms didn't post notification!")
        
        NotificationCenter.default.removeObserver(self)
        let tableView = UITableView()
        let chatRoomsDataMediator = ChatRoomsDataSourceMediator(tableView)
        let tableViewCntPrev = tableView.numberOfRows(inSection: 0)
        chatRooms.appendMessage(self.msg1, toChat: self.user2)
        XCTAssert(tableViewCntPrev < tableView.numberOfRows(inSection: 0), "ChatRoomsDataMediator didn't get notification")
    }
    
    // MARK: - Integrity test 2, authNotif (2 tests)
    func testAuthSuccess()
    {
        NotificationCenter.default.addObserver(self, selector: #selector(self.notificationCounterIncrement), name: .webSocketAuthNotif, object: nil)
        let counterPrev = self.notificationCounter
        let webSocketHandler = WebSocketHandler.main
        
        let serverMessage = ServerMessageToRecieve(type: .newMessage, data: nil)
        webSocketHandler.authSuccsess(serverMessage)
        XCTAssert(counterPrev < self.notificationCounter, "authNotif notification didn't come")
        
        webSocketHandler.authNotSuccsess(serverMessage)
        XCTAssert(counterPrev < self.notificationCounter, "authNotif notification didn't come")
        
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Integrity test 3, registrationNotif (2 tests)
    func testRegistrationNotif()
    {
        NotificationCenter.default.addObserver(self, selector: #selector(self.notificationCounterIncrement), name: .webSocketRegistrationNotif, object: nil)
        let counterPrev = self.notificationCounter
        let webSocketHandler = WebSocketHandler.main
        
        let serverMessage = ServerMessageToRecieve(type: .newMessage, data: nil)
        webSocketHandler.registerSuccsess(serverMessage)
        XCTAssert(counterPrev < self.notificationCounter, "registerNotif notification didn't come")
        
        webSocketHandler.registerNotSuccsess(serverMessage)
        XCTAssert(counterPrev < self.notificationCounter, "registerNotif notification didn't come")
        
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Integrity test 4, errorsNotif (2 tests)
    func testErrorNotif()
    {
        NotificationCenter.default.addObserver(self, selector: #selector(self.notificationCounterIncrement), name: .webSocketError, object: nil)
        let counterPrev = self.notificationCounter
        let webSocketHandler = WebSocketHandler.main
        
        let serverMessage = ServerMessageToRecieve(type: .newMessage, data: nil)
        webSocketHandler.gotError(serverMessage)
        XCTAssert(counterPrev < self.notificationCounter, "errorNotif notification didn't come")
        
        webSocketHandler.gotUnknownError(serverMessage)
        XCTAssert(counterPrev < self.notificationCounter, "errorNotif notification didn't come")
        
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: Integrity test 5, gotNewMessage (1 test)
    func testGotNewMessage()
    {
        NotificationCenter.default.addObserver(self, selector: #selector(self.notificationCounterIncrement), name: .newMessage, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.notificationCounterIncrement), name: .chatRoomsWereChanged, object: nil)
        let counterPrev = self.notificationCounter
        let webSocketHandler = WebSocketHandler.main
        
        let serverMessage = ServerMessageToRecieve(type: .newMessage, data: [RecievedData(id: 1, from_who: "User", to_who: "user", text: "text", username: nil, passsword: nil, chat_name: nil, is_read: 1)])
        webSocketHandler.newMessage(serverMessage)
        XCTAssert(counterPrev < self.notificationCounter, "newMessageNotif or chatRoomsWereChangedNotif notification didn't come")
        
        NotificationCenter.default.removeObserver(self)
    }
}
