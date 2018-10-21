//
//  ViewController.swift
//  Swimple-chat-iOS
//
//  Created by Dmitry Gorin on 03/10/2018.
//  Copyright © 2018 gordiig. All rights reserved.
//

import UIKit

class ChatListViewController: AlertableViewController, UITableViewDelegate
{
    @IBOutlet weak var tableView: UITableView!
    var chatRoomsMediator: ChatRoomsDataSourceMediator!
    
    var names = ["Username 1", "Long-long-long username", "And another name for testing notifications ans etc"]
    var msgs = ["Last message", "long-long-long last message", "Just show this text"]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        chatRoomsMediator = ChatRoomsDataSourceMediator(tableView)
        tableView.delegate = self
        
        ChatRooms.default.appendMessage(Message(id: 0, from: "hehe", to: "gege", msg: msgs[0]), toChat: names[0])
        ChatRooms.default.appendMessage(Message(id: 1, from: "hehehe", to: "gege", msg: msgs[1]), toChat: names[1])
        ChatRooms.default.appendMessage(Message(id: 2, from: "hehehe", to: "gege", msg: msgs[2]), toChat: names[2])
    }
    
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.isSelected = false
    }
    
    
    // MARK: - Prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let idx = tableView.indexPathForSelectedRow?.row ?? 0
        guard let vc = segue.destination as? ChatViewController else
        {
            alert(title: "Segue error", message: "Something wrong in pewpare for segue!")
            return
        }
        
        vc.navigationItem.title = ChatRooms.default.getRoom(at: idx).interlocutor
    }
    
}

