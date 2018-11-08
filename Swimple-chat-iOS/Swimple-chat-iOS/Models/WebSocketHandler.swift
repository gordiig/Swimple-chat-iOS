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
    
    init(url: URL = URL(string: "ws://85.255.1.214:8080")!)
    {
        socketURL = url
        socket = WebSocket(url: socketURL)
    }
    init?(urlAsString str: String = "ws://85.255.1.214:8080")
    {
        let _url = URL(string: str)
        if _url == nil
        {
            return nil
        }
            
        socketURL = _url!
        socket = WebSocket(url: socketURL)
    }
    
    func websocketDidConnect(socket: WebSocketClient)
    {
        print("WebSocket connected on \(socketURL.absoluteString)")
    }
    
    func websocketDidDisconnect(socket: WebSocketClient, error: Error?)
    {
        print("WebSocket disconnected!")
    }
    
    func websocketDidReceiveMessage(socket: WebSocketClient, text: String)
    {
        print("WebSocket recieved message! \(text)")
        
        let decoder = JSONDecoder()
        guard let serverMessage = try? decoder.decode(ServerMessage.self, from: text.data(using: .utf8)!) else
        {
            print("Can't decode server message")
            return
        }
        
        switch serverMessage.type
        {
            case .authSuccsess:
                // authSuccsess
                let a = 1
            case .sendingSuccsess:
                // sendingSeccsess
                let a = 2
            case .authNotSuccsess:
                // authNotSuccsess
                let a = 3
            case .error:
                // Error
                let a = 4
            default:
                // unknownError
                let a = 5
        }
    }
    
    func websocketDidReceiveData(socket: WebSocketClient, data: Data)
    {
        print("WebSocket recieved data!")
    }
}
