//
//  AppDelegate.swift
//  Swimple-chat-iOS
//
//  Created by Dmitry Gorin on 03/10/2018.
//  Copyright © 2018 gordiig. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    {
        let cUser = CurrentUser.current
        if cUser.username.isEmpty || cUser.password.isEmpty
        {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            guard let vc = storyboard.instantiateViewController(withIdentifier: "LogInVC") as? LogInViewController else
            {
                print("Can't instatiate LogInVC!")
                return false
            }
            window?.rootViewController = vc
        }
        
//        let defaults = UserDefaults.standard
//        let username = defaults.string(forKey: "username") ?? ""
//        let password = defaults.string(forKey: "password") ?? ""
//        let imgData = defaults.data(forKey: "avatarImg")
//        let img = (imgData == nil) ? (UIImage(named: User.stdImageName)) : (UIImage(data: imgData!))
//
//        if username.isEmpty || password.isEmpty
//        {
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            guard let vc = storyboard.instantiateViewController(withIdentifier: "LogInVC") as? LogInViewController else
//            {
//                print("Can't instatiate LogInVC!")
//                return false
//            }
//            window?.rootViewController = vc
//        }
//        else
//        {
//            let cUser = CurrentUser.current
//            cUser.configure(username: username, password: password, avatarImg: img)
//        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
        let cUser = CurrentUser.current
        cUser.saveToUserDefaults()
//        let defaults = UserDefaults.standard
//        defaults.set(cUser.username, forKey: "username")
//        defaults.set(cUser.password, forKey: "password")
//        defaults.set(cUser.avatarImg.pngData(), forKey: "avatarImg")
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

