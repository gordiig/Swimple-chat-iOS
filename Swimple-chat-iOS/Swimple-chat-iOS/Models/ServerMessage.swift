//
//  ServerMessage.swift
//  Swimple-chat-iOS
//
//  Created by Dmitry Gorin on 22/10/2018.
//  Copyright © 2018 gordiig. All rights reserved.
//

import Foundation


enum ServerMessageType: String, Codable
{
    case getMessagesForChatList = "getMessagesForChatList"
    case auth = "auth"
    case send = "send"
    case authNotSuccsess = "AuthNotSuccsess"
    case authSuccsess = "AuthSuccsess"
    case sendingSuccsess = "SendingSuccsess"
    case error = "Error"
}

struct ServerMessage: Codable
{
    var type: ServerMessageType
    var from: String?
    var to: String?
    var message: String?
    var username: String?
    var password: String?
    
    enum CodeKeys: String, CodingKey
    {
        case type
        case from = "from_who"
        case to = "to_who"
        case message
        case username
        case password
    }
}
