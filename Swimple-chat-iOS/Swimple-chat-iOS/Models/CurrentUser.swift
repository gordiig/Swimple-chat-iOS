//
//  CurrentUser.swift
//  Swimple-chat-iOS
//
//  Created by Dmitry Gorin on 08/10/2018.
//  Copyright © 2018 gordiig. All rights reserved.
//

import Foundation
import UIKit

class CurrentUser: User
{
    private static var instance: CurrentUser! = nil
    var password: String
    
    private init()
    {
        self.password = "init"
        super.init(username: "init", ip: "init")
    }

    
    // MARK: - Singleton work
    class func getInstance() -> CurrentUser
    {
        if CurrentUser.instance == nil
        {
            CurrentUser.instance = CurrentUser()
        }
        return CurrentUser.instance
    }

    func configure(username: String, password: String, ip: String, avatarImg: UIImage? = nil)
    {
        self.username = username
        self.password = password
        self.ip = ip
        self.avatarImg = avatarImg
    }
}
