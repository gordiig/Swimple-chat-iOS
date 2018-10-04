//
//  FriendMessageBubbleTableViewCell.swift
//  Swimple-chat-iOS
//
//  Created by Dmitry Gorin on 04/10/2018.
//  Copyright © 2018 gordiig. All rights reserved.
//

import UIKit

class FriendMessageBubbleTableViewCell: UITableViewCell
{
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var messageLabel: UILabel!
    
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
        super.isSelected = false
    }

    func setMessageText(text: String)
    {
        messageLabel.text = text
    }
    
    func setAvatarImage(img: UIImage)
    {
        avatarImage.image = img
    }
    
}
