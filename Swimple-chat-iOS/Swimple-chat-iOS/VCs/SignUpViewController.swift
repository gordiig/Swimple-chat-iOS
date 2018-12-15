//
//  SignUpViewController.swift
//  Swimple-chat-iOS
//
//  Created by Dmitry Gorin on 31/10/2018.
//  Copyright © 2018 gordiig. All rights reserved.
//

import UIKit

class SignUpViewController: MyViewController
{
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    var usernameForLogIn: String = ""
    var passwordForLogIn: String = ""
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.serverAns), name: .webSocketRegistrationNotif, object: nil)
    }
    
    @IBAction func registerButtonPressed(_ sender: Any)
    {
        let username = usernameTextField.text ?? ""
        if username.isEmpty
        {
            alert(title: "Enter username!", message: "You can't register without username")
            return
        }
        
        let password = passwordTextField.text ?? ""
        if password.isEmpty
        {
            alert(title: "Enter password!", message: "You can't register without password")
            return
        }
        
        guard self.webSocketHandler.sendMessage(type: .register, username: username, password: password) else
        {
            self.alert(title: "Web socket error", message: "Registration message wasn't sent!")
            return 
        }
        self.usernameForLogIn = username
        self.passwordForLogIn = password
        self.registerButton.isEnabled = false
    }
    
    @objc func serverAns(notification: Notification)
    {
        self.registerButton.isEnabled = true
//
        let ans = notification.userInfo!["type"] as! String
        if ans != "registerSuccess"
        {
            alert(title: "Web socket error", message: "Can't register")
        }
        
        alert(title: "Register success", message: "You can log in now")
    }
}
