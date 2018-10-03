//
//  ViewController.swift
//  Swimple-chat-iOS
//
//  Created by Dmitry Gorin on 03/10/2018.
//  Copyright © 2018 gordiig. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    @IBOutlet weak var tableView: ChatListTableView!
    
    var names = ["Username 1", "Long-long-long username"]
    var msgs = ["Last message", "long-long-long last message"]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableView.appendChats(names: names, msgs: msgs)
    }
    
}

