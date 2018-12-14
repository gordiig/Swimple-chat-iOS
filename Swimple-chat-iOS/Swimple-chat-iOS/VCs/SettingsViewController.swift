//
//  SettingsViewController.swift
//  Swimple-chat-iOS
//
//  Created by Dmitry Gorin on 04/10/2018.
//  Copyright © 2018 gordiig. All rights reserved.
//

import UIKit

class SettingsViewController: MyViewController
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
        
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "LogInVC") as? LogInViewController else
        {
            alert(title: "Error in instatiate", message: "Can't instatiate LogInVC")
            return
        }
        let navigationController = UINavigationController(rootViewController: vc)
        present(navigationController, animated: true, completion: nil)
    }
    
}
