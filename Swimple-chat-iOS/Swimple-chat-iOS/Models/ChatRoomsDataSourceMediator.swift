//
//  ChatRoomsDataSourceMediator.swift
//  Swimple-chat-iOS
//
//  Created by Dmitry Gorin on 21/10/2018.
//  Copyright © 2018 gordiig. All rights reserved.
//

import Foundation
import UIKit


class ChatRoomsDataSourceMediator: NSObject, UITableViewDataSource
{
    var dataTableView: UITableView?
    
    init(_ tableView: UITableView)
    {
        super.init()
        
        dataTableView = tableView
        tableView.dataSource = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableViewData), name: .chatRoomsWereChanged, object: nil)
    }
    
    
    // MARK: - Notifications
    @objc func reloadTableViewData(notification: Notification)
    {
        dataTableView?.reloadData()
    }
    
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return ChatRooms.default.numberOfRooms()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ChatListTableViewCell") as? ChatListTableViewCell else
        {
            return UITableViewCell()
        }
        
        let room = ChatRooms.default.getRoom(at: indexPath.row)
        cell.configure(username: room.interlocutor, lastMessage: room.messages.last?.msg ?? "No message!")
        return cell
    }
}
