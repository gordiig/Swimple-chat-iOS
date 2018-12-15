//
//  MyChatBubbleTableViewCell.swift
//  Swimple-chat-iOS
//
//  Created by Dmitry Gorin on 05/10/2018.
//  Copyright © 2018 gordiig. All rights reserved.
//

import UIKit

class MyChatBubbleTableViewCell: UITableViewCell
{
    @IBOutlet weak var firstLetterLabel: UILabel!
    @IBOutlet weak var imgView: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var firstLetterView: UIView!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        self.layer.cornerRadius = 20
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.backgroundColor = UIColor.cyan
        self.firstLetterView.layer.cornerRadius = 20
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }

    func configure(message: String, username: String)
    {
        messageLabel.text = message
        firstLetterLabel.text = String(username.first ?? Character("U"))
    }
    
}
