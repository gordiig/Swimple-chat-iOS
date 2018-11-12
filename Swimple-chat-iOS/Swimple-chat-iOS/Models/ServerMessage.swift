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
    var from_who: String?
    var to_who: String?
    var text: String?
    var username: String?
    var password: String?
}


// MARK: - Server message that will be sent from server
struct RecievedData: Codable
{
    var id: Int?
    var from_who: String?
    var to_who: String?
    var text: String?
    var username: String?
    var password: String?
}

struct ServerMessageToRecieve: Codable
{
    var type: ServerMessageType
    var data: [RecievedData]?
}
