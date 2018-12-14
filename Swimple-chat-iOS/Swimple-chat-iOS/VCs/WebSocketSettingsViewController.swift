//
//  WebSocketSettingsViewController.swift
//  Swimple-chat-iOS
//
//  Created by Dmitry Gorin on 10/12/2018.
//  Copyright © 2018 gordiig. All rights reserved.
//

import UIKit

class WebSocketSettingsViewController: MyViewController
{
    @IBOutlet weak var activeLabel: UILabel!
    @IBOutlet weak var hostTextField: UITextField!
    @IBOutlet weak var portTextField: UITextField!
    @IBOutlet weak var applyButton: UIButton!
    @IBOutlet weak var connectButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var dismissButton: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.socketConnected), name: .webSocketDidConnect, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.socketDisconnected), name: .webSocketDidDisconnect, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        activeLabel.text = WebSocketHandler.main.isConnected ? "Active" : "Inactive"
    }
    
    @objc func socketConnected(_ sender: Any?)
    {
        activeLabel.text = "Active"
    }
    @objc func socketDisconnected(_ sender: Any?)
    {
        activeLabel.text = "Inactive"
    }
    
    
    @IBAction func applyButtonPressed(_ sender: Any)
    {
        let host = hostTextField.text ?? ""
        if host.isEmpty
        {
            alert(title: "Enter host", message: "Can't connect without host")
            return
        }
        
        let port = portTextField.text ?? ""
        if port.isEmpty
        {
            alert(title: "Enter port", message: "Can't connect without port")
            return
        }
        
        if !WebSocketHandler.main.changeHost(host: host, port: port)
        {
            alert(title: "Wrong input", message: "Can't change socket address with entered input")
            return
        }
    }
    
    @IBAction func connectButtonPressed(_ sender: Any)
    {
        WebSocketHandler.main.socket.connect()
    }
    
    @IBAction func stopButtonPressed(_ sender: Any)
    {
        WebSocketHandler.main.socket.disconnect()
    }
    
    
    @IBAction func dismissButoonPressed(_ sender: Any)
    {
        self.dismiss(animated: true, completion: nil)
    }
}
