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
        self.layer.cornerRadius = 20
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.lightGray.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
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
