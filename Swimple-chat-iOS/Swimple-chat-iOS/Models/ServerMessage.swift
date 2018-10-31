//
//  ServerMessage.swift
//  Swimple-chat-iOS
//
//  Created by Dmitry Gorin on 22/10/2018.
//  Copyright © 2018 gordiig. All rights reserved.
//

import Foundation


struct ServerMessage: Codable
{
    var type: String
    var from: String?
    var to: String?
    var contents: String?
    
    enum CodeKeys: String, CodingKey
    {
        case type
        case from
        case to
        case contents
    }
}
