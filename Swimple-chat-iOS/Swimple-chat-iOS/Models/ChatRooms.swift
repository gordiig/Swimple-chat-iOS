//
//  ChatRooms.swift
//  Swimple-chat-iOS
//
//  Created by Dmitry Gorin on 21/10/2018.
//  Copyright © 2018 gordiig. All rights reserved.
//

import Foundation

class ChatRooms
{
    private(set) var rooms: [ChatRoom] = []
    private static var _instance: ChatRooms?
    
    private init()
    {
        
    }
    
    
    // MARK: - Singleton work
    static var `default`: ChatRooms
    {
        if _instance == nil
        {
            _instance = ChatRooms()
        }
        return _instance!
    }
    
    
    // MARK: - Private
    private func addNewRoom(withUser user: User, andAppendMessage msg: Message? = nil) -> ChatRoom
    {
        let newRoom = ChatRoom(username: user)
        rooms.append(newRoom)
        
        if let msg = msg
        {
            newRoom.appendMessage(msg)
        }
        
        NotificationCenter.default.post(name: .chatRoomsWereChanged, object: nil)
        return newRoom
    }
    
    private func searchForRoom(withName searchName: String) -> ChatRoom?
    {
        let filtered = rooms.filter { (room) -> Bool in
            room.interlocutor.username == searchName
        }
        
        return filtered.last
    }
    
    private func searchForRoom(withUser user: User) -> ChatRoom?
    {
        return searchForRoom(withName: user.username)
    }
    
    
    // MARK: - Public
    func appendMessage(_ msg: Message, toChat user: User)
    {
        if let room = searchForRoom(withUser: user)
        {
            room.appendMessage(msg)
        }
        else
        {
            _ = addNewRoom(withUser: user, andAppendMessage: msg)
        }
    }
    
    var numberOfRooms: Int
    {
        return rooms.count
    }
    
    func getRoom(at idx: Int) -> ChatRoom?
    {
        if idx >= numberOfRooms
        {
            return nil
        }
        return rooms[idx]
    }
    
    func getRoom(for user: User, createIfNone: Bool = true) -> ChatRoom?
    {
        guard let room = searchForRoom(withUser: user) else
        {
            if createIfNone
            {
                let newRoom = self.addNewRoom(withUser: user)
                return newRoom
            }
            return nil
        }
        return room
    }
    
    func clear()
    {
        rooms = []
        NotificationCenter.default.post(name: .chatRoomsWereChanged, object: nil)
    }
    
    func configureWithFetchedChatLists(_ serverMessage: ServerMessageToRecieve)
    {
        guard let serverMessageData = serverMessage.data else
        {
            print("Error, data is empty!")
            return
        }
        
        self.clear()
        for _serverMessage in serverMessageData
        {
            let user = User(username: _serverMessage.chat_name!)
            let message = Message(id: _serverMessage.id!, from: _serverMessage.from_who!, to: _serverMessage.chat_name!, msg: _serverMessage.text!)
            self.appendMessage(message, toChat: user)
        }
    }
    func configureRoomWithFetchedChatLists(_ serverMessage: ServerMessageToRecieve)
    {
        guard let serverMessageData = serverMessage.data else
        {
            print("Error, data is empty!")
            return
        }
        
        if serverMessageData.count == 0 { return }
        let user = (serverMessageData[0].from_who! == CurrentUser.current.username) ? User(username: serverMessageData[0].to_who!) : User(username: serverMessageData[0].from_who!)
        self.getRoom(for: user)?.clear()
        for _serverMessage in serverMessageData
        {
            let message = Message(id: _serverMessage.id!, from: _serverMessage.from_who!, to: _serverMessage.to_who!, msg: _serverMessage.text!)
            self.appendMessage(message, toChat: user)
        }
    }
    
    func newMessages(_ serverMessage: ServerMessageToRecieve)
    {
        guard let messageData = serverMessage.data else { return }
        for message in messageData
        {
            let newMessage = Message(id: message.id!, from: message.from_who!, to: message.to_who!, msg: message.text!)
            let user = (message.from_who! == CurrentUser.current.username) ? User(username: message.to_who!) : User(username: message.from_who!)
            self.appendMessage(newMessage, toChat: user)
        }
    }
}
