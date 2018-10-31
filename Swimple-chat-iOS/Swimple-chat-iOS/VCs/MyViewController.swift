//
//  AlertableViewController.swift
//  Swimple-chat-iOS
//
//  Created by Dmitry Gorin on 05/10/2018.
//  Copyright © 2018 gordiig. All rights reserved.
//

import UIKit

class MyViewController: UIViewController, Alerable
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.onTap))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    func alert(title: String, message: String)
    {
        let vc = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        vc.addAction(alertAction)
        present(vc, animated: true, completion: nil)
    }
    
    @objc func onTap(_ sender: UITapGestureRecognizer)
    {
        self.view.endEditing(true)
    }
    
}
