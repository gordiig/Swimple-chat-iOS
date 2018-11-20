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
    @IBOutlet weak var addChatButton: UIBarButtonItem!
    var chatRoomsMediator: ChatRoomsDataSourceMediator!
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // For is_online flag on server (this VC is entry point from login, signup VCs and from start of an app if already signed in
        _ = self.webSocketHandler.sendMessage(type: .auth, username: CurrentUser.current.username, password: CurrentUser.current.password)
        
        refreshControl.addTarget(self, action: #selector(self.refreshControlValueChanged), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
        chatRoomsMediator = ChatRoomsDataSourceMediator(tableView)
        tableView.delegate = self
        self.testSetUp()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.gotChatList), name: .webSocketGetMessagesForChatList, object: nil)
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
        guard self.webSocketHandler.sendMessage(type: .getMessagesForChatList, username: CurrentUser.current.username) else
        {
            self.refreshControl.endRefreshing()
            alert(title: "Web socket error", message: "Can't send message for fetching messages")
            return
        }
    }
    @objc func gotChatList(_ sender: Any?)
    {
        self.refreshControl.endRefreshing()
        self.tableView.reloadData()
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
        if segue.identifier == "addNewChatSegue" { return }
        
        let idx = tableView.indexPathForSelectedRow?.row ?? 0
        guard let vc = segue.destination as? ChatViewController else
        {
            alert(title: "Segue error", message: "Something wrong in pepare for segue!")
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

