//
//  CameraViewController.swift
//  Swimple-chat-iOS
//
//  Created by Dmitry Gorin on 15/10/2018.
//  Copyright © 2018 gordiig. All rights reserved.
//

import UIKit
import AVFoundation

class CameraViewController: MyViewController, FrameExtractorOutputDelegate
{
    enum CallType: String
    {
        case income = "Income"
        case outcome = "Outcome"
    }
    
    @IBOutlet weak var userIsOfflineVIew: UIView!
    @IBOutlet weak var previewView: CameraPreviewView!
    @IBOutlet weak var incomeBufferImageView: UIImageView!
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var acceptButton: UIButton!
    @IBOutlet weak var changeCamButton: UIButton!
    @IBOutlet weak var changeCamBlurView: UIVisualEffectView!
    @IBOutlet weak var previewImageView: UIImageView!
    @IBOutlet weak var acceptButtonWidthConstraint: NSLayoutConstraint!
    
    override var prefersStatusBarHidden: Bool { return true } 
    
    var frameExtractor: FrameExtractor!
    var callType: CallType = .income
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.changeCamBlurView.layer.cornerRadius = 10
        self.changeCamBlurView.clipsToBounds = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.userIsOffline), name: .webSocketUserOffline, object: nil)
        
        guard let frameExtractor = FrameExtractor(alertDelegate: self) else
        {
            alert(title: "Error in camera", message: "Can't create frame extractor!")
            self.dismiss(animated: true)
            return
        }
        self.frameExtractor = frameExtractor
        self.frameExtractor.outputDelegate = self
//        self.frameExtractor.registerPreviewView(previewView)
        self.frameExtractor.start()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        if self.callType == .income
        {
            setupForIncomeCall()
        }
        else
        {
            setupForOutcomeCall()
        }
        self.userIsOfflineVIew.isHidden = true
        self.frameExtractor.start()
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        self.frameExtractor.stop()
    }
    
    
    // MARK: - Pre-view setups
    func setupForIncomeCall()
    {
        self.incomeBufferImageView.image = UIImage(named: "testcat")
    }
    
    func setupForOutcomeCall()
    {
        self.acceptButtonWidthConstraint.constant = 0
    }
    
    
    // MARK: - Buttons
    @IBAction func changeCamButtonPressed(_ sender: Any)
    {
        self.frameExtractor.flipCamera()
    }
    
    @IBAction func dismissButtonPressed(_ sender: Any)
    {
        self.frameExtractor.stop()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func acceptButtonPressed(_ sender: Any)
    {
        let username_from = CurrentUser.current.username
        let username_to = "HE"
        guard self.webSocketHandler.sendMessage(type: .acceptCall, from_who: username_from, to_who: username_to) else
        {
            alert(title: "Web socket error", message: "Can't send acceptCall")
            self.dismiss(animated: true, completion: nil)
            return
        }
        
        self.acceptButtonWidthConstraint.constant = 0
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    // MARK: - FrameExtractorOutputDelegate
    func frameExtractor(didOutputFrame frame: UIImage, base64: String? = nil)
    {
        self.previewImageView.image = frame
    }
    
    
    // MARK: - Selecors
    @objc func userIsOffline(_ notification: Notification)
    {
        self.frameExtractor.stop()
        self.userIsOfflineVIew.isHidden = false
       
    }
}
