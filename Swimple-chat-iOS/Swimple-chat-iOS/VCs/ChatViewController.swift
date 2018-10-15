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
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
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
            self.chatTableView.scrollToRow(at: IndexPath(row: 0, section: self.messages.count-1), at: .bottom, animated: true)
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    
    // MARK: - TextView work
    @objc func keyboardWillShow(notification: Notification)
    {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else
        {
            alert(title: "Error in keyboard size!", message: "Can't get keyboard size!")
            return
        }
        let height = keyboardFrame.cgRectValue.height
        
        self.bottomConstraint.constant = -height
        UIView.animate(withDuration: 0.5)
        {
            self.view.layoutIfNeeded()
        }
        self.chatTableView.scrollToRow(at: IndexPath(row: 0, section: self.messages.count-1), at: .bottom, animated: true)
    }
    
    @objc func keyboardWillHide(notification: Notification)
    {
        self.bottomConstraint.constant = 0
        UIView.animate(withDuration: 0.5)
        {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func hideKeyboard(_ sender: UITapGestureRecognizer)
    {
        self.msgTextField.resignFirstResponder()
    }
    
    
    // MARK: - Transition to camera
    @objc func cameraButtonPressed(sender: AnyObject)
    {
        let storyboard = self.storyboard!
        guard let destVC = storyboard.instantiateViewController(withIdentifier: "CameraViewController") as? CameraViewController else
        {
            print("Can't instatiate VC!")
            alert(title: "Error in instatiate", message: "Can't instatiate CameraVC")
            return
        }
        
        self.present(destVC, animated: true, completion: nil)
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
