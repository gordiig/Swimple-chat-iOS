//
//  ChatListTableView.swift
//  Swimple-chat-iOS
//
//  Created by Dmitry Gorin on 03/10/2018.
//  Copyright © 2018 gordiig. All rights reserved.
//

import UIKit

class ChatListTableView: UITableView, UITableViewDataSource, UITableViewDelegate
{
    var names: [String] = ["Username"]
    var msgs: [String] = ["Last message"]
    var imgs: [UIImage] = [UIImage(named: "angry")!]
    
    override init(frame: CGRect, style: UITableView.Style)
    {
        super.init(frame: frame, style: style)
        _init()
    }
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        _init()
    }
    func _init()
    {
        self.delegate = self
        self.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        guard let cell = self.dequeueReusableCell(withIdentifier: "ChatListTableViewCell") as? ChatListTableViewCell else
        {
            print("Can't dequeue!")
            return UITableViewCell()
        }
        
        cell.usernameLabel.text = names[indexPath.row]
        cell.lastMsgLabel.text = msgs[indexPath.row]
        return cell
    }
    
    
    func appendChats(names: [String], msgs: [String], imgs: [UIImage]? = nil)
    {
        self.names += names
        self.msgs += msgs
        if let imgs = imgs
        {
            self.imgs += imgs
        }
        self.reloadData()
    }
    
}
