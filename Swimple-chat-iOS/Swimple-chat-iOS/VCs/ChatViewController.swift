//
//  ChatViewController.swift
//  Swimple-chat-iOS
//
//  Created by Dmitry Gorin on 04/10/2018.
//  Copyright © 2018 gordiig. All rights reserved.
//

import UIKit

class ChatViewController: MyViewController, UITableViewDataSource, UITableViewDelegate, UITextViewDelegate
{
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var msgTextField: UITextView!
    @IBOutlet weak var chatTableView: UITableView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    var user: User!
//    var roomNum: Int!
    var room: ChatRoom!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        msgTextField.layer.cornerRadius = 10
        
        chatTableView.delegate = self
        chatTableView.dataSource = self
        chatTableView.rowHeight = UITableView.automaticDimension
        chatTableView.estimatedRowHeight = 70
        chatTableView.keyboardDismissMode = .interactive
        
        let rightButton = UIBarButtonItem(title: "Camera", style: .plain, target: self, action: #selector(cameraButtonPressed))
        self.navigationItem.rightBarButtonItem = rightButton
        
        self.msgTextField.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.newMessage), name: .newMessage, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.getMessagesForChat), name: .webSocketGetMessagesForChat, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        self.title = user.username
        guard self.webSocketHandler.sendMessage(type: .getMessagesForChat, from_who: self.user.username, to_who: CurrentUser.current.username) else
        {
            alert(title: "Web socket error", message: "Can't get messages for chat, try to refresh later!")
            return
        }
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
        self.chatTableView.scrollToRow(at: IndexPath(row: 0, section: room.messages.count-1), at: .bottom, animated: true)
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
    
    func textViewDidChange(_ textView: UITextView)
    {
        let text = textView.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        self.sendButton.isEnabled = !text.isEmpty
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
        return room.messages.count
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
        let message = room.messages[row]
        if message.from == CurrentUser.current.username
        {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyChatBubbleTableViewCell") as? MyChatBubbleTableViewCell else
            {
                print("Can't dequeue MyChatBubbleTableViewCell")
                alert(title: "Dequeue error", message: "Can't dequeue MyChatBubbleTableViewCell")
                return UITableViewCell()
            }
            cell.configure(message: room.messages[row].msg)
            return cell
        }
        else
        {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ChatBubbleTableViewCell") as? ChatBubbleTableViewCell else
            {
                print("Can't dequeue ChatBubbleTableViewCell")
                alert(title: "Dequeue error", message: "Can't dequeue ChatBubbleTableViewCell")
                return UITableViewCell()
            }
            cell.configure(message: room.messages[row].msg)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let selected = tableView.cellForRow(at: indexPath)
        selected?.isSelected = false
    }
    
    
    // MARK: - Button pressed
    @IBAction func sendButtonPressed(_ sender: Any)
    {
        let text = msgTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let newMessage = Message(id: -1, from: CurrentUser.current.username, to: room.interlocutor.username, msg: text)
        
        guard self.webSocketHandler.sendMessage(type: .send, from_who: newMessage.from, to_who: newMessage.to, text: newMessage.msg) else
        {
            alert(title: "Web socket error", message: "Can't send message!")
            return
        }
        room.appendMessage(newMessage)
    }
    
    
    // MARK: - Selectors
    @objc func newMessage(notification: Notification)
    {
        self.chatTableView.reloadData()
        self.chatTableView.scrollToRow(at: IndexPath(row: 0, section: room.messages.count-1), at: .bottom, animated: true)
    }
    
    @objc func getMessagesForChat(notification: Notification)
    {
    }
}
