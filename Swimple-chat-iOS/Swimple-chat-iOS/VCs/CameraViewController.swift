//
//  CameraViewController.swift
//  Swimple-chat-iOS
//
//  Created by Dmitry Gorin on 15/10/2018.
//  Copyright © 2018 gordiig. All rights reserved.
//

import UIKit
import AVFoundation

class CameraViewController: AlertableViewController
{
    @IBOutlet weak var previewView: CameraPreviewView!
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var changeCamButton: UIButton!
    @IBOutlet weak var changeCamBlurView: UIVisualEffectView!
    
    override var prefersStatusBarHidden: Bool { return true } 
    
    var captureSession = AVCaptureSession()
    var videoDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)
    let micDevice = AVCaptureDevice.default(.builtInMicrophone, for: .audio, position: .unspecified)
    var videoDeviceInput: AVCaptureDeviceInput!
    var micDeviceInput: AVCaptureDeviceInput!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.changeCamBlurView.layer.cornerRadius = 10
        self.changeCamBlurView.clipsToBounds = true
        
        self.configureCaptureSession()
        self.previewView.videoPreviewLayer.session = self.captureSession
        
        captureSession.startRunning()
    }
    
    
    // MARK: - AVFoundation
    func configureCaptureSession()
    {
        self.captureSession.beginConfiguration()
        
        self.checkPrivacyStatus(for: .video)
        guard let videoDeviceInput = try? AVCaptureDeviceInput(device: videoDevice!), captureSession.canAddInput(videoDeviceInput) else
        {
            self.alert(title: "Error configuring capture session", message: "Can't create videoDeviceInput!")
            return
        }
        self.videoDeviceInput = videoDeviceInput
        captureSession.addInput(videoDeviceInput)
        
        self.checkPrivacyStatus(for: .audio)
        guard let micDeviceInput = try? AVCaptureDeviceInput(device: micDevice!), captureSession.canAddInput(micDeviceInput) else
        {
            self.alert(title: "Error configuring capture session", message: "Can't create micDeviceInput!")
            return
        }
        self.micDeviceInput = micDeviceInput
        captureSession.addInput(micDeviceInput)
        
        captureSession.commitConfiguration()
    }
    
    func checkPrivacyStatus(for type: AVMediaType)
    {
        switch AVCaptureDevice.authorizationStatus(for: type)
        {
        case .authorized:
            return
            
        case .denied:
            self.alert(title: "Media type is denied", message: "Privacy status for media \(type.rawValue) is denied")
            self.dismiss(animated: true, completion: nil)
            
        case .restricted:
            self.alert(title: "Media type is denied", message: "Privacy status for media \(type.rawValue) is restricted")
            self.dismiss(animated: true, completion: nil)
            
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: type)
            { granted in
                if granted
                {
                    return
                }
                else
                {
                    self.alert(title: "Media type is denied", message: "Privacy status for media \(type.rawValue) is denied")
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    func changeCamera()
    {
        self.captureSession.beginConfiguration()
        self.captureSession.removeInput(videoDeviceInput)
        
        if videoDevice?.position == .front
        {
            self.videoDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)
        }
        else
        {
            self.videoDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front)
        }
        
        guard let videoDeviceInput = try? AVCaptureDeviceInput(device: videoDevice!), captureSession.canAddInput(videoDeviceInput) else
        {
            self.alert(title: "Error configuring capture session", message: "Can't create videoDeviceInput!")
            return
        }
        self.videoDeviceInput = videoDeviceInput
        captureSession.addInput(videoDeviceInput)
        
        self.captureSession.commitConfiguration()
    }
    
    
    // MARK: - Buttons
    @IBAction func changeCamButtonPressed(_ sender: Any)
    {
        self.changeCamera()
    }
    
    @IBAction func dismissButtonPressed(_ sender: Any)
    {
        captureSession.stopRunning()
        self.dismiss(animated: true, completion: nil)
    }
}
