//
//  User.swift
//  Swimple-chat-iOS
//
//  Created by Dmitry Gorin on 08/10/2018.
//  Copyright © 2018 gordiig. All rights reserved.
//

import Foundation
import UIKit

class User
{
    static let stdImageName = "angry"
    var username: String
    var avatarImg: UIImage
    var ip: String
    
    init(username: String, ip: String, avatarImg: UIImage? = nil)
    {
        self.username = username
        self.ip = ip
        if let img = avatarImg
        {
            self.avatarImg = img
        }
        else
        {
            self.avatarImg = UIImage(named: User.stdImageName)!
        }
    }
}
