//
//  ChatViewController.swift
//  Swimple-chat-iOS
//
//  Created by Dmitry Gorin on 04/10/2018.
//  Copyright © 2018 gordiig. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var msgTextField: UITextView!
    @IBOutlet weak var chatTableView: UITableView!
    
    var messages = [
        "Ji, glad to see you again! How is your head?",
        "Long-long-long-long-long-long-long-long-long-long-long-long-long-long-long-long-long message",
        "Q, GG, WP",
        "Anoteher long-long-long-long-long-long-long-long-long-long-long-long-long-long-long-long-long-long-long-long-long-long-long-long-long-long-long-long-long-long-long-long-long-long-long-long-long-long-long-long-long-long-long-long-long-long-long-long-long-long-long-long message"
    ]
    {
        didSet(val)
        {
            chatTableView.reloadData()
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        msgTextField.layer.cornerRadius = 10
        
        chatTableView.delegate = self
        chatTableView.dataSource = self
        chatTableView.rowHeight = UITableView.automaticDimension
        chatTableView.estimatedRowHeight = 70
    }
    
    // MARK: - UITableView
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 4
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ChatBubbleTableViewCell") as? ChatBubbleTableViewCell else
        {
            print("Can't dequeue ChatBubbleTableViewCell")
            return UITableViewCell()
        }
        
        let row = indexPath.section
        cell.configure(message: messages[row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let selected = tableView.cellForRow(at: indexPath)
        selected?.isSelected = false
    }
    
    
    @IBAction func sendButtonPressed(_ sender: Any)
    {
        let text = msgTextField.text ?? ""
        if text.isEmpty { return }
        messages.append(text)
    }
}
