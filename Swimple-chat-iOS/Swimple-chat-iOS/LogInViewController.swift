//
//  LogInViewController.swift
//  Swimple-chat-iOS
//
//  Created by Dmitry Gorin on 03/10/2018.
//  Copyright © 2018 gordiig. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController
{
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func logInButtonPressed(_ sender: Any)
    {
        let username = usernameTextField.text ?? ""
        if username.isEmpty
        {
            // Alertable
        }
        
        let password = passwordTextField.text ?? ""
        if password.isEmpty
        {
            // Alertable
        }
        
        let defaults = UserDefaults.standard
        defaults.set(username, forKey: "username")
        defaults.set(password, forKey: "password")
        
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "ChatListVC") as? ViewController else
        {
            print("Can't instatiate VC!")
            return
        }
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func signUpButtonPressed(_ sender: Any)
    {
        
    }
}
