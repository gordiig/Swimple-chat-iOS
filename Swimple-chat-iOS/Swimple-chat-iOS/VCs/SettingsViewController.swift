//
//  SettingsViewController.swift
//  Swimple-chat-iOS
//
//  Created by Dmitry Gorin on 04/10/2018.
//  Copyright © 2018 gordiig. All rights reserved.
//

import UIKit

class SettingsViewController: AlertableViewController
{
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var logOutButton: UIButton!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        let cUser = CurrentUser.current
        usernameLabel.text = cUser.username
        passwordLabel.text = cUser.password
        avatarImageView.image = cUser.avatarImg
    }
    

    @IBAction func logOutButtonPressed(_ sender: Any)
    {
        let cUser = CurrentUser.current
        cUser.clear()
        
//        let defaults = UserDefaults.standard
//        defaults.removeObject(forKey: "username")
//        defaults.removeObject(forKey: "password")
//        defaults.removeObject(forKey: "ip")
//        defaults.removeObject(forKey: "avatarImg")
        
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "LogInVC") as? LogInViewController else
        {
            alert(title: "Error in instatiate", message: "Can't instatiate LogInVC")
            return
        }
        present(vc, animated: true, completion: nil)
    }
}
