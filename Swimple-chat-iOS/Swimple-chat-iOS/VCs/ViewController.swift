//
//  ViewController.swift
//  Swimple-chat-iOS
//
//  Created by Dmitry Gorin on 03/10/2018.
//  Copyright © 2018 gordiig. All rights reserved.
//

import UIKit

class ViewController: UIViewController, Alerable
{
    @IBOutlet weak var tableView: ChatListTableView!
    
    var names = ["Username 1", "Long-long-long username"]
    var msgs = ["Last message", "long-long-long last message"]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableView.appendChats(names: names, msgs: msgs)
    }
    
    
    
    func alert(title: String, message: String)
    {
        let vc = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        vc.addAction(alertAction)
        present(vc, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let idx = tableView.indexPathForSelectedRow?.row ?? 0
        guard let vc = segue.destination as? ChatViewController else
        {
            alert(title: "Segue error", message: "Something wrong in pewpare for segue!")
            return
        }
        
        vc.navigationItem.title = names[idx]
    }
    
}

