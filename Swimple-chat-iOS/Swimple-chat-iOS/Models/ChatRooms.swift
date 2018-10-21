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
    private func addNewRoom(withName name: String, andAppendMessage msg: Message? = nil)
    {
        rooms.append(ChatRoom(username: name))
        
        if let msg = msg
        {
            rooms.last?.appendMessage(msg)
        }
    }
    
    private func searchForRoom(withName searchName: String) -> ChatRoom?
    {
        let filtered = rooms.filter { (room) -> Bool in
            room.interlocutor == searchName
        }
        
        return filtered.last
    }
    
    
    // MARK: - Public
    func appendMessage(_ msg: Message, toChat chatName: String)
    {
        if let room = searchForRoom(withName: chatName)
        {
            room.appendMessage(msg)
        }
        else
        {
            addNewRoom(withName: chatName, andAppendMessage: msg)
        }
    }
    
    func numberOfRooms() -> Int
    {
        return rooms.count
    }
}
