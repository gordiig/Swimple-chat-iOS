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
    var interlocutor: User
    private(set) var messages: [Message] = []
    
    init(username interlocutor: User)
    {
        self.interlocutor = interlocutor
    }
    
    func appendMessage(_ msg: Message)
    {
        messages.append(msg)
        NotificationCenter.default.post(name: .newMessage, object: nil, userInfo: ["from_who": msg.from, "to_who": msg.to, "text": msg.msg])
    }
}
