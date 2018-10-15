//
//  ChatViewController.swift
//  Swimple-chat-iOS
//
//  Created by Dmitry Gorin on 04/10/2018.
//  Copyright © 2018 gordiig. All rights reserved.
//

import UIKit

class ChatViewController: AlertableViewController, UITableViewDataSource, UITableViewDelegate
{
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var msgTextField: UITextView!
    @IBOutlet weak var chatTableView: UITableView!
    
    var messages = [
        "Hi, glad to see you again! How is your head?",
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
        
        let rightButton = UIBarButtonItem(title: "Camera", style: .plain, target: self, action: #selector(cameraButtonPressed))
        self.navigationItem.rightBarButtonItem = rightButton
    }
    
    
    // MARK: - Transition to camera
    @objc func cameraButtonPressed(sender: AnyObject)
    {
        self.alert(title: "Camera pressed", message: "Camera button was pressed!")
        
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
        let row = indexPath.section
        
        if row % 2 == 1
        {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ChatBubbleTableViewCell") as? ChatBubbleTableViewCell else
            {
                print("Can't dequeue ChatBubbleTableViewCell")
                alert(title: "Dequeue error", message: "Can't dequeue ChatBubbleTableViewCell")
                return UITableViewCell()
            }
            cell.configure(message: messages[row])
            return cell
        }
        else
        {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyChatBubbleTableViewCell") as? MyChatBubbleTableViewCell else
            {
                print("Can't dequeue MyChatBubbleTableViewCell")
                alert(title: "Dequeue error", message: "Can't dequeue MyChatBubbleTableViewCell")
                return UITableViewCell()
            }
            cell.configure(message: messages[row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let selected = tableView.cellForRow(at: indexPath)
        selected?.isSelected = false
    }
    
    @IBAction func sendButtonPressed(_ sender: Any)
    {
        let text = msgTextField.text ?? ""
        if text.isEmpty
        {
            alert(title: "No message", message: "You can't send empty message!")
            return
        }
        
        messages.append(text)
    }
}
