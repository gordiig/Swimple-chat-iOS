//
//  CameraViewController.swift
//  Swimple-chat-iOS
//
//  Created by Dmitry Gorin on 15/10/2018.
//  Copyright © 2018 gordiig. All rights reserved.
//

import UIKit

class CameraViewController: AlertableViewController
{
    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var dismissButton: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func dismissButtonPressed(_ sender: Any)
    {
        
    }
}
