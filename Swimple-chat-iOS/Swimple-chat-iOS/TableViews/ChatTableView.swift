//
//  ChatTableView.swift
//  Swimple-chat-iOS
//
//  Created by Dmitry Gorin on 04/10/2018.
//  Copyright © 2018 gordiig. All rights reserved.
//

import UIKit

class ChatTableView: UITableView, UITableViewDataSource, UITableViewDelegate
{
    var messages1 = [
        "Hello world!",
        "Wonderful!",
        "I'd like to see it!\nHowAbout now?"
    ]
    var messages2 = [
        "Hohoho! Id'like to code for iOS for as long as i want!!! So I'll be doing it for a long time now!",
        "Hohoho! Id'like to code for iOS for as long as i want!!! So I'll be doing it for a long time now!\nHEHEHEHEHEHE",
        "Hohoho! Id'like to code for iOS for as long as i want!!! So I'll be doing it for a long time now!\nUHVYGUDUTIVHKUVHJKCYIIYCGCIYFGCKHGYKCG"
    ]
    
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
        delegate = self
        dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return messages1.count + messages2.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        guard let cell = self.dequeueReusableCell(withIdentifier: "ChatTableViewCell") as? ChatTableViewCell else
        {
            print("NO ERROR")
            return UITableViewCell()
        }
        
        let msgs = messages1 + messages2
        cell.messageLabel.text = msgs[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        cellForRow(at: indexPath)?.isSelected = false
    }
    
}
