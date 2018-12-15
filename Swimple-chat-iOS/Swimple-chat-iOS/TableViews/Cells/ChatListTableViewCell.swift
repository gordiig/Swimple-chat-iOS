//
//  ChatListTableViewCell.swift
//  Swimple-chat-iOS
//
//  Created by Dmitry Gorin on 03/10/2018.
//  Copyright © 2018 gordiig. All rights reserved.
//

import UIKit

class ChatListTableViewCell: UITableViewCell
{
    @IBOutlet weak var firstLetterLabel: UILabel!
    @IBOutlet weak var chatImgView: UIView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var lastMsgLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(username: String, lastMessage: String)
    {
        firstLetterLabel.text = String(username.first ?? Character("U"))
        
        if !username.isEmpty
        {
            var shownUsername = ""
            var i = 0
            for chr in username
            {
                shownUsername.append(chr)
                i += 1
                if i >= 15
                {
                    shownUsername += "..."
                    break
                }
            }
            usernameLabel.text = username
        }
        
        if !lastMessage.isEmpty
        {
            var shownMessage = ""
            var i = 0
            for chr in lastMessage
            {
                shownMessage.append(chr)
                i += 1
                if i >= 20
                {
                    shownMessage += "..."
                    break
                }

            }
            lastMsgLabel.text = shownMessage
        }
    }
}
