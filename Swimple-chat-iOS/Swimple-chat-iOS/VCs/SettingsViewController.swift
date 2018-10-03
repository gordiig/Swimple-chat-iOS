//
//  SettingsViewController.swift
//  Swimple-chat-iOS
//
//  Created by Dmitry Gorin on 04/10/2018.
//  Copyright © 2018 gordiig. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, Alerable
{
    
    @IBOutlet weak var logOutButton: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func logOutButtonPressed(_ sender: Any)
    {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "username")
        defaults.removeObject(forKey: "password")
        
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "LogInVC") as? LogInViewController else
        {
            alert(title: "Error in instatiate", message: "Can't instatiate LogInVC")
            return
        }
        present(vc, animated: true, completion: nil)
    }
    
    func alert(title: String, message: String)
    {
        let vc = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        vc.addAction(alertAction)
        present(vc, animated: true, completion: nil)
    }
}
