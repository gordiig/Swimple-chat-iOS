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
    
    // MARK: - Singleton work
    static var current: CurrentUser
    {
        if CurrentUser.instance == nil
        {
            CurrentUser.instance = CurrentUser()
        }
        return CurrentUser.instance
    }
    
    private init()
    {
        self.password = "init"
        super.init(username: "init", ip: "init")
    }

    func configure(username: String, password: String, ip: String, avatarImg: UIImage? = nil)
    {
        self.username = username
        self.password = password
        self.ip = ip
        if let img = avatarImg
        {
            self.avatarImg = img
        }
    }
    
    func clear()
    {
        username = ""
        password = ""
        ip = ""
        avatarImg = UIImage(named: User.stdImageName)!
    }
}
