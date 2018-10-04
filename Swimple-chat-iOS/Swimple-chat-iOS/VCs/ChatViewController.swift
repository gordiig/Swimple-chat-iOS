//
//  ChatViewController.swift
//  Swimple-chat-iOS
//
//  Created by Dmitry Gorin on 04/10/2018.
//  Copyright © 2018 gordiig. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController
{
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var msgTextField: UITextView!
    
    let messages = [
        "Ji, glad to see you again! How is your ancle?",
        "Long-long-long-long-long-long-long-long-long-long-long-long-long-long-long-long-long message",
        "Q, GG, WP"
    ]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        msgTextField.layer.cornerRadius = 10
    }
    
    
    @IBAction func sendButtonPressed(_ sender: Any)
    {
        
    }
}
