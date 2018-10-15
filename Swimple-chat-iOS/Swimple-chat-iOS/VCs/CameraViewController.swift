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
    
    var captureSession = AVCaptureSession()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.configureCaptureSession()
        self.previewView.videoPreviewLayer.session = self.captureSession
        
        captureSession.startRunning()
    }
    
    func configureCaptureSession()
    {
        self.captureSession.beginConfiguration()
        
        self.checkPrivacyStatus(for: .video)
        let videoDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .unspecified)
        guard let videoDeviceInput = try? AVCaptureDeviceInput(device: videoDevice!), captureSession.canAddInput(videoDeviceInput) else
        {
            self.alert(title: "Error configuring capture session", message: "Can't create videoDeviceInput!")
            return
        }
        captureSession.addInput(videoDeviceInput)
        
        self.checkPrivacyStatus(for: .audio)
        let micDevice = AVCaptureDevice.default(.builtInMicrophone, for: .audio, position: .unspecified)
        guard let micDeviceInput = try? AVCaptureDeviceInput(device: micDevice!), captureSession.canAddInput(micDeviceInput) else
        {
            self.alert(title: "Error configuring capture session", message: "Can't create micDeviceInput!")
            return
        }
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
    
    @IBAction func dismissButtonPressed(_ sender: Any)
    {
        captureSession.stopRunning()
        self.dismiss(animated: true, completion: nil)
    }
}
