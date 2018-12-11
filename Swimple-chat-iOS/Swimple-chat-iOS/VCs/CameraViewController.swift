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
    
    @IBOutlet weak var previewView: CameraPreviewView!
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
        
        guard let frameExtractor = FrameExtractor(alertDelegate: self) else
        {
            alert(title: "Error in camera", message: "Can't create frame extractor!")
            self.dismiss(animated: true)
            return
        }
        self.frameExtractor = frameExtractor
        self.frameExtractor.outputDelegate = self
        self.frameExtractor.registerPreviewView(previewView)
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
    }
    
    
    // MARK: - Pre-view setups
    func setupForIncomeCall()
    {
        
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
}
