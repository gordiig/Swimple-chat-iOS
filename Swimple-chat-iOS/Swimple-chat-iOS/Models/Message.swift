//
//  Message.swift
//  Swimple-chat-iOS
//
//  Created by Dmitry Gorin on 21/10/2018.
//  Copyright © 2018 gordiig. All rights reserved.
//

import Foundation

struct Message
{
    let id: Int
    let from: String
    let to: String
    let msg: String
    
    init(id: Int, from: String, to: String, msg: String)
    {
        self.id = id
        self.from = from
        self.to = to
        self.msg = msg
    }
}
