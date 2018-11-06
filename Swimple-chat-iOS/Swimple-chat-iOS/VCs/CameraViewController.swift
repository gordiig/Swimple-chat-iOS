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
    @IBOutlet weak var previewView: CameraPreviewView!
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var changeCamButton: UIButton!
    @IBOutlet weak var changeCamBlurView: UIVisualEffectView!
    
    override var prefersStatusBarHidden: Bool { return true } 
    
    var frameExtractor: FrameExtractor!
    
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
        self.frameExtractor.registerPreviewView(previewView)
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
    
    
    // MARK: - FrameExtractorOutputDelegate
    func frameExtractor(didOutputFrame frame: UIImage)
    {
        print("hello")
    }
}
