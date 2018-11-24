//
//  WebSocketHandler.swift
//  Swimple-chat-iOS
//
//  Created by Dmitry Gorin on 22/10/2018.
//  Copyright © 2018 gordiig. All rights reserved.
//

import Foundation
import Starscream


class WebSocketHandler: WebSocketDelegate
{
    var socketURL: URL
    var socket: WebSocket
    
    private static var _handler: WebSocketHandler?
    
    static var main: WebSocketHandler
    {
        if WebSocketHandler._handler == nil
        {
            WebSocketHandler._handler = WebSocketHandler()
        }
        return WebSocketHandler._handler!
    }
    
    private init(url: URL = URL(string: "ws://85.255.1.214:8080/")!)
    {
        socketURL = url
        socket = WebSocket(url: socketURL)
        socket.delegate = self
        socket.connect()
    }
    
    var isConnected: Bool
    {
        return socket.isConnected
    }
    
    
    // MARK: - WebSocketDelegate
    func websocketDidConnect(socket: WebSocketClient)
    {
        print("WebSocket connected on \(socketURL.absoluteString)")
        NotificationCenter.default.post(name: .webSocketDidConnect, object: nil, userInfo: nil)
    }
    
    func websocketDidDisconnect(socket: WebSocketClient, error: Error?)
    {
        print("WebSocket disconnected!")
        NotificationCenter.default.post(name: .webSocketDidDisconnect, object: nil, userInfo: nil)
    }
    
    func websocketDidReceiveMessage(socket: WebSocketClient, text: String)
    {
        print("WebSocket recieved message! \(text)")
        
        let decoder = JSONDecoder()
        guard let serverMessage = try? decoder.decode(ServerMessageToRecieve.self, from: text.data(using: .utf8)!) else
        {
            print("Can't decode server message")
            return
        }
        
        switch serverMessage.type
        {
            case .newMessage:
                newMessage(serverMessage)
            case .getMessagesForChatListResult:
                getMessagesForChatList(serverMessage)
            case .getMessagesForChatResult:
                getMessagesForChat(serverMessage)
            case .getUsersResult:
                getUsersResult(serverMessage)
            case .registerSuccsess:
                registerSuccsess(serverMessage)
            case .authSuccsess:
                authSuccsess(serverMessage)
            case .sendingSuccsess:
                sendingSuccsess(serverMessage)
            case .registerNotSuccsess:
                registerNotSuccsess(serverMessage)
            case .authNotSuccsess:
                authSuccsess(serverMessage)
            case .error:
                gotError(serverMessage)
            default:
                gotUnknownError(serverMessage)
        }
    }
    
    func websocketDidReceiveData(socket: WebSocketClient, data: Data)
    {
        print("WebSocket recieved data!")
    }
    
    
    // MARK: - Functions by types
    func newMessage(_ serverMessage: ServerMessageToRecieve)
    {
        print(serverMessage.type.rawValue)
        ChatRooms.default.newMessages(serverMessage)
    }
    
    func getMessagesForChatList(_ serverMessage: ServerMessageToRecieve)
    {
        print(serverMessage.type.rawValue)
        ChatRooms.default.configureWithFetchedChatLists(serverMessage)
        NotificationCenter.default.post(name: .webSocketGetMessagesForChatList, object: nil, userInfo: nil)
    }
    
    func getMessagesForChat(_ serverMessage: ServerMessageToRecieve)
    {
        print(serverMessage.type.rawValue)
        ChatRooms.default.configureRoomWithFetchedChatLists(serverMessage)
        NotificationCenter.default.post(name: .webSocketGetMessagesForChat, object: nil)
    }
    
    func getUsersResult(_ serverMessage: ServerMessageToRecieve)
    {
        print(serverMessage.type.rawValue)
        var users: [String] = []
        for messageData in serverMessage.data!
        {
            users.append(messageData.username!)
        }
        NotificationCenter.default.post(name: .webSocketGetUsers, object: nil, userInfo: ["users": users])
    }
    
    func authSuccsess(_ serverMessage: ServerMessageToRecieve)
    {
        print(serverMessage.type.rawValue)
        NotificationCenter.default.post(name: .webSocketAuthNotif, object: nil, userInfo: ["type": serverMessage.type.rawValue])
    }
    
    func registerSuccsess(_ serverMessage: ServerMessageToRecieve)
    {
        print(serverMessage.type.rawValue)
        NotificationCenter.default.post(name: .webSocketRegistrationNotif, object: nil, userInfo: ["type": serverMessage.type.rawValue])
    }
    
    func sendingSuccsess(_ serverMessage: ServerMessageToRecieve)
    {
        print(serverMessage.type.rawValue)
    }
    
    func registerNotSuccsess(_ serverMessage: ServerMessageToRecieve)
    {
        print(serverMessage.type.rawValue)
        NotificationCenter.default.post(name: .webSocketRegistrationNotif, object: nil, userInfo: ["type": serverMessage.type.rawValue])
    }
    
    func authNotSuccsess(_ serverMessage: ServerMessageToRecieve)
    {
        print(serverMessage.type.rawValue)
        NotificationCenter.default.post(name: .webSocketAuthNotif, object: nil, userInfo: ["type": serverMessage.type.rawValue])
    }
    
    func gotError(_ ServerMessage: ServerMessageToRecieve)
    {
        print(ServerMessage.type.rawValue)
        NotificationCenter.default.post(name: .webSocketError, object: nil, userInfo: ["type": "known"])
    }
    
    func gotUnknownError(_ serverMessage: ServerMessageToRecieve)
    {
        print("Web socket got unknown error")
        NotificationCenter.default.post(name: .webSocketError, object: nil, userInfo: ["type": "unknown"])
    }
    
    
    // MARK: - Sending
    func sendMessage(type: ServerMessageType, from_who: String? = nil, to_who: String? = nil, text: String? = nil,
                           username: String? = nil, password: String? = nil) -> Bool
    {
        var serverMessage = ServerMessageToSend(type: type)
        switch type
        {
        case .auth:
            guard let username = username, let password = password else { return false }
            serverMessage.username = username
            serverMessage.passsword = password
        case .register:
            guard let username = username, let password = password else { return false }
            serverMessage.username = username
            serverMessage.passsword = password
        case .send:
            guard let from_who = from_who, let to_who = to_who, let text = text else { return false }
            serverMessage.from_who = from_who
            serverMessage.to_who = to_who
            serverMessage.message = text
        case .getMessagesForChatList:
            guard let username = username else { return false }
            serverMessage.username = username
        case .getMessagesForChat:
            guard let from_who = from_who, let to_who = to_who else { return false }
            serverMessage.from_who = from_who
            serverMessage.to_who = to_who
        default:
            break
        }
        
        guard let encoded = try? JSONEncoder().encode(serverMessage) else { return false }
        guard let encodedStr = String(data: encoded, encoding: .utf8) else { return false }
        print(encodedStr)
        self.socket.write(string: encodedStr)
        
        return true
    }
}
