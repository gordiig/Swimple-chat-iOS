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
                print("Send")
                newMessage(serverMessage)
            
            case .authSuccsess:
                print("Auth succsess")
                authSuccsess(serverMessage)
            
            case .sendingSuccsess:
                print("Sending succsess")
                sendingSuccsess(serverMessage)
            
            case .authNotSuccsess:
                print("Auth not succsess")
                authSuccsess(serverMessage)
            
            case .error:
                print("Error")
                gotError(serverMessage)
            
            default:
                print("Unknown error")
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
        print(serverMessage.data)
    }
    
    func authSuccsess(_ serverMessage: ServerMessageToRecieve)
    {
        print(serverMessage.type.rawValue)
    }
    
    func sendingSuccsess(_ serverMessage: ServerMessageToRecieve)
    {
        print(serverMessage.type.rawValue)
    }
    
    func authNotSuccsess(_ serverMessage: ServerMessageToRecieve)
    {
        print(serverMessage.type.rawValue)
    }
    
    func gotError(_ ServerMessage: ServerMessageToRecieve)
    {
        print(ServerMessage.type.rawValue)
    }
    
    func gotUnknownError(_ serverMessage: ServerMessageToRecieve)
    {
        
    }
}
