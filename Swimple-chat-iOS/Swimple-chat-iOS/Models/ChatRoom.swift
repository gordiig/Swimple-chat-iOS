//
//  ChatRoom.swift
//  Swimple-chat-iOS
//
//  Created by Dmitry Gorin on 21/10/2018.
//  Copyright © 2018 gordiig. All rights reserved.
//

import Foundation

class ChatRoom
{
    var interlocutor: String
    private(set) var messages: [Message] = []
    
    init(username interlocutor: String)
    {
        self.interlocutor = interlocutor
    }
    
    func appendMessage(_ msg: Message)
    {
        messages.append(msg)
    }
}
