//
//  ViewController.swift
//  Swimple-chat-iOS
//
//  Created by Dmitry Gorin on 03/10/2018.
//  Copyright © 2018 gordiig. All rights reserved.
//

import UIKit

class ChatListViewController: MyViewController, UITableViewDelegate
{
    @IBOutlet weak var tableView: UITableView!
    var chatRoomsMediator: ChatRoomsDataSourceMediator!
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        refreshControl.addTarget(self, action: #selector(self.refreshControlValueChanged), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
        chatRoomsMediator = ChatRoomsDataSourceMediator(tableView)
        tableView.delegate = self
        self.testSetUp()
    }
    
    
    // MARK: - Test
    func testSetUp()
    {
        var names = [
            User(username: "Username1"),
            User(username: "Long-long-long username"),
            User(username: "And another name for testing notifications ans etc")
        ]
        var msgs = [
            Message(id: 0, from: "hehe", to: "gege", msg: "Last message"),
            Message(id: 1, from: "hehehe", to: "gege", msg: "long-long-long last message"),
            Message(id: 2, from: "hehehe", to: "gege", msg: "Just show this text")
        ]
        
        let chatList = ChatRooms.default
        for i in 0 ..< names.count
        {
            chatList.appendMessage(msgs[i], toChat: names[i])
        }
    }
    
    
    // MARK: - RefreshControl
    @objc func refreshControlValueChanged(_ sender: Any?)
    {
        self.refreshControl.endRefreshing()
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
        
        guard let room = ChatRooms.default.getRoom(at: idx) else
        {
            alert(title: "Index error", message: "Wrong index of chat room is given (\(idx))")
            return
        }
        
        vc.user = room.interlocutor
        vc.roomNum = idx
    }
    
}

