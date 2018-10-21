//
//  ChatRoomsAsTableViewDataSource.swift
//  Swimple-chat-iOS
//
//  Created by Dmitry Gorin on 21/10/2018.
//  Copyright © 2018 gordiig. All rights reserved.
//

import Foundation
import UIKit


extension ChatRooms: UITableViewDataSource
{
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return ChatRooms.rooms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ChatListTableViewCell") as? ChatListTableViewCell else
        {
            return UITableViewCell()
        }
        
        let room = ChatRooms.rooms[indexPath.row]
        cell.configure(username: room.interlocutor, lastMessage: room.messages.last?.msg ?? "<#NO MESSAGES#>")
        return cell
    }
}
