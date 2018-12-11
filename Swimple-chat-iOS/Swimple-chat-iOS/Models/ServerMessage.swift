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
    case getMessagesForChatListResult = "getMessagesForChatListResult"
    case getMessagesForChat = "getMessagesForChat"
    case getMessagesForChatResult = "getMessagesForChatResult"
    case auth = "auth"
    case register = "register"
    case registerSuccsess = "registerSuccess"
    case registerNotSuccsess = "registerNotSuccess"
    case send = "send"
    case newMessage = "newMessage"
    case authNotSuccsess = "authNotSuccess"
    case authSuccsess = "authSuccess"
    case sendingSuccsess = "sendingSuccess"
    case error = "error"
    case getUsers = "getUsers"
    case getUsersResult = "getUsersResult"
    case startCall = "startCall"
    case cancelCall = "cancelCall"
    case acceptCall = "acceptCall"
    case sendImageFrame = "sendImageFrame"
    case callNewBuffer = "callNewBuffer"
    case endCall = "endCall"
    case callUserIsOffline = "callUserIsOffline"
}

// MARK: - Server message that will be send to server
struct ServerMessageToSend: Codable
{
    var type: ServerMessageType
    var from_who: String? = nil
    var to_who: String? = nil
    var text: String? = nil
    var username: String? = nil
    var passsword: String? = nil
    var message: String? = nil
    
    init(type: ServerMessageType)
    {
        self.type = type
    }
}


// MARK: - Server message that will be sent from server
struct RecievedData: Codable
{
    var id: Int?
    var from_who: String?
    var to_who: String?
    var text: String?
    var username: String?
    var passsword: String?
    var chat_name: String?
    var is_read: Bool?
    var when_sent: String?
}

struct ServerMessageToRecieve: Codable
{
    var type: ServerMessageType
    var data: [RecievedData]?
}
