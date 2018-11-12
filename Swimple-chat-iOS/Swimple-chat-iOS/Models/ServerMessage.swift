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
    case register = "register"
    case send = "send"
    case newMessage = "newMessage"
    case authNotSuccsess = "AuthNotSuccsess"
    case authSuccsess = "AuthSuccsess"
    case sendingSuccsess = "SendingSuccsess"
    case error = "Error"
}

// MARK: - Server message that will be send to server
struct ServerMessageToSend: Codable
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


// MARK: - Server message that will be sent from server
struct RecievedData: Codable
{
    var from: String?
    var to: String?
    var message: String?
    var username: String?
    var password: String?
    
    enum CodeKeys: String, CodingKey
    {
        case from = "from_who"
        case to = "to_who"
        case message
        case username
        case password
    }
}

struct ServerMessageToRecieve: Codable
{
    var type: ServerMessageType
    var data: [RecievedData]?
}
