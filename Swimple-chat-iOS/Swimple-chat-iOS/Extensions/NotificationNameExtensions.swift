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
}
