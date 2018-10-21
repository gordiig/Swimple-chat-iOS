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
    private(set) static var rooms: [ChatRoom] = []
    
    
    // MARK: - Private
    private static func addNewRoom(withName name: String, andAppendMessage msg: Message? = nil)
    {
        rooms.append(ChatRoom(username: name))
        
        if let msg = msg
        {
            rooms.last?.appendMessage(msg)
        }
    }
    
    private static func searchForRoom(withName searchName: String) -> ChatRoom?
    {
        let filtered = ChatRooms.rooms.filter { (room) -> Bool in
            room.interlocutor == searchName
        }
        
        return filtered.last
    }
    
    
    // MARK: - Public
    static func appendMessage(_ msg: Message, toChat chatName: String)
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
}
