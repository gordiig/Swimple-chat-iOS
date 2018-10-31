//
//  SignUpViewController.swift
//  Swimple-chat-iOS
//
//  Created by Dmitry Gorin on 31/10/2018.
//  Copyright © 2018 gordiig. All rights reserved.
//

import UIKit

class SignUpViewController: AlertableViewController
{
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTap))
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        view.addGestureRecognizer(tapRecognizer)
    }

    @objc func onTap(_ sender: Any)
    {
        self.resignFirstResponder()
        view.endEditing(true)
    }
    
    
    @IBAction func registerButtonPressed(_ sender: Any)
    {
        
    }
}
