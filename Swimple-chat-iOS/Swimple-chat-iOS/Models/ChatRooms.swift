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
    private func addNewRoom(withUser user: User, andAppendMessage msg: Message? = nil)
    {
        rooms.append(ChatRoom(username: user))
        
        if let msg = msg
        {
            rooms.last?.appendMessage(msg)
        }
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
            addNewRoom(withUser: user, andAppendMessage: msg)
        }
    }
    
    func numberOfRooms() -> Int
    {
        return rooms.count
    }
    
    func getRoom(at idx: Int) -> ChatRoom
    {
        return rooms[idx]
    }
    
    func clear()
    {
        rooms = []
    }
}
