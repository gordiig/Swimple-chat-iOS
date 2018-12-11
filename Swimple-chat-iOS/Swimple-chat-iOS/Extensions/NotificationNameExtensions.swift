//
//  NotificationNameExtensions.swift
//  Swimple-chat-iOS
//
//  Created by Dmitry Gorin on 21/10/2018.
//  Copyright © 2018 gordiig. All rights reserved.
//

import Foundation

extension Notification.Name
{
    static let chatRoomsWereChanged = Notification.Name("chatRoomsWereChanged")
    static let newMessage = Notification.Name("newMessage")
    
    static let webSocketDidConnect = Notification.Name("webSocketDidConnect")
    static let webSocketDidDisconnect = Notification.Name("webSocketDidDisconnect")
    
    static let webSocketRegistrationNotif = Notification.Name("webSocketRegistrationNotif")
    static let webSocketAuthNotif = Notification.Name("webSocketAuthNotif")
    
    static let webSocketGetMessagesForChatList = Notification.Name("webSocketGetMessagesForChatList")
    static let webSocketGetMessagesForChat = Notification.Name("webSocketGetMessagesForChat")
    
    static let webSocketStartCallNotif = Notification.Name("webSocketStartCallNotif")
    static let webSocketCallCallingNotif = Notification.Name("webSocketCallCallingNotif")
    static let webSocketCancelCallNotif = Notification.Name("webSocketCancelCallNotif")
    static let webSocketAcceptCallNotif = Notification.Name("webSocketAcceptCallNotif")
    static let webSocketGotFrameBufferNotif = Notification.Name("webSocketGotFrameBufferNotif")
    static let webSocketEndCall = Notification.Name("webSocketEndCall")
    static let webSocketUserOffline = Notification.Name("webSocketUserOffline")
    
    static let webSocketGetUsers = Notification.Name("webSocketGetUsers")
    
    static let webSocketError = Notification.Name("webSocketError")
}
