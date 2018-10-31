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
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
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
        
        alert(title: "Not implemented yet!", message: "Username: \(username) \nPassword: \(password)")
    }
}
