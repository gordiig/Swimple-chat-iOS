//
//  LogInViewController.swift
//  Swimple-chat-iOS
//
//  Created by Dmitry Gorin on 03/10/2018.
//  Copyright © 2018 gordiig. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController, Alerable
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
            alert(title: "Enter username", message: "You can't log in without username!")
            return
        }
        
        let password = passwordTextField.text ?? ""
        if password.isEmpty
        {
            alert(title: "Enter password", message: "You can't log in without password!")
            return
        }
        
        let defaults = UserDefaults.standard
        defaults.set(username, forKey: "username")
        defaults.set(password, forKey: "password")
        
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "ChatListVC") as? ViewController else
        {
            print("Can't instatiate VC!")
            alert(title: "Error in instatiate", message: "Can't instatiate ChatListVC")
            return
        }
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func signUpButtonPressed(_ sender: Any)
    {
        alert(title: "Not implemented yet", message: "Not implemented yet!")
    }
    
    
    func alert(title: String, message: String)
    {
        let vc = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        vc.addAction(alertAction)
        present(vc, animated: true, completion: nil)
    }
}
