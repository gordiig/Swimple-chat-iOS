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
    
    init(url: URL = URL(string: "ws://85.255.1.214:8082")!)
    {
        socketURL = url
        socket = WebSocket(url: socketURL)
    }
    init?(urlAsString str: String = "ws://85.255.1.214:8082")
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
    }
    
    func websocketDidReceiveData(socket: WebSocketClient, data: Data)
    {
        print("WebSocket recieved data!")
    }
}
