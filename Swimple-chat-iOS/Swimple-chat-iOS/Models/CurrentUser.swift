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
        let defaults = UserDefaults.standard
        
        let username = defaults.object(forKey: "username") as? String
        let password = defaults.object(forKey: "password") as? String
        let avatarImg = defaults.object(forKey: "avatarImg") as? Data
        
        if username == nil || password == nil || avatarImg == nil
        {
            self.password = "init"
            super.init(username: "init")
        }
        else
        {
            self.password = password!
            super.init(username: username!, avatarImg: UIImage(data: avatarImg!))
        }
    }

    func configure(username: String, password: String, avatarImg: UIImage? = nil)
    {
        self.username = username
        self.password = password
        if let img = avatarImg
        {
            self.avatarImg = img
        }
    }
    
    func saveToUserDefaults()
    {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "username")
        defaults.removeObject(forKey: "password")
        defaults.removeObject(forKey: "avatarImg")
        
        defaults.set(self.username, forKey: "username")
        defaults.set(self.password, forKey: "password")
        defaults.set(self.avatarImg.pngData(), forKey: "avatarImg")
    }
    
    func clear()
    {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "username")
        defaults.removeObject(forKey: "password")
        defaults.removeObject(forKey: "avatarImg")
        
        username = ""
        password = ""
        avatarImg = UIImage(named: User.stdImageName)!
    }
}
