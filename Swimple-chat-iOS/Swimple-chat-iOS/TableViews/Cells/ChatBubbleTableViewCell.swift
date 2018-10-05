//
//  ChatBubbleTableViewCell.swift
//  Swimple-chat-iOS
//
//  Created by Dmitry Gorin on 05/10/2018.
//  Copyright © 2018 gordiig. All rights reserved.
//

import UIKit

class ChatBubbleTableViewCell: UITableViewCell
{
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var messageLabel: UILabel!
    
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
        isSelected = false
    }
    
    func configure(message: String, img: UIImage? = nil)
    {
        messageLabel.text = message
        if let img = img
        {
            avatarImageView.image = img
        }
    }

}
