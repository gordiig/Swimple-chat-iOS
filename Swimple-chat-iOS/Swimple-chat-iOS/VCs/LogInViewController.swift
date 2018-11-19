//
//  LogInViewController.swift
//  Swimple-chat-iOS
//
//  Created by Dmitry Gorin on 03/10/2018.
//  Copyright © 2018 gordiig. All rights reserved.
//

import UIKit

class LogInViewController: MyViewController
{
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    var usernameForLogin = ""
    var passwordForLogin = ""
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.authServerResponse), name: .webSocketAuthNotif, object: nil)
    }
    
    @IBAction func logInButtonPressed(_ sender: Any)
    {
        let username = usernameTextField.text ?? ""
        if username.isEmpty
        {
            alert(title: "Enter username", message: "You can't log in without username!")
            return
        }
        
        let password = passwordTextField.text ?? ""
        if password.isEmpty
        {
            alert(title: "Enter password", message: "You can't log in without password!")
            return
        }
        
        guard self.webSocketHandler.sendMessage(type: .auth, username: username, password: password) else
        {
            alert(title: "Web socket error", message: "Can't send auth message")
            return
        }
        self.logInButton.isEnabled = false
        self.usernameForLogin = username
        self.passwordForLogin = password
    }
    
    @objc func authServerResponse(notification: Notification)
    {
        self.logInButton.isEnabled = true
        
        let response = notification.userInfo!["type"] as! String
        if response == "AuthNotSuccsess"
        {
            alert(title: "Log in error", message: "Wrong username or password")
            return
        }
        
        let cUser = CurrentUser.current
        cUser.configure(username: usernameForLogin, password: passwordForLogin, avatarImg: UIImage(named: User.stdImageName))
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "MainTapBarController") as? UITabBarController else
        {
            print("Can't instatiate VC!")
            alert(title: "Error in instatiate", message: "Can't instatiate ChatListVC")
            return
        }
        self.present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func reconnectSocketButtonPressed(_ sender: Any)
    {
        self.webSocketHandler.socket.connect()
    }
}
