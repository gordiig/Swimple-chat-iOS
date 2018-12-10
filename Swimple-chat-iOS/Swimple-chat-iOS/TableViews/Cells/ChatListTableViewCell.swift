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
        usernameLabel.text = username
        lastMsgLabel.text = lastMessage
        firstLetterLabel.text = String(username.first ?? Character("U"))
    }
}
