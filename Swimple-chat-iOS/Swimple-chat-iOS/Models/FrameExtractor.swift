//
//  FrameExtractor.swift
//  Swimple-chat-iOS
//
//  Created by Dmitry Gorin on 01/11/2018.
//  Copyright © 2018 gordiig. All rights reserved.
//

import Foundation
import AVFoundation

class FrameExtractor: NSObject, AVCaptureVideoDataOutputSampleBufferDelegate
{
    private let captureSession = AVCaptureSession()
    private var videoDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)
    private let micDevice = AVCaptureDevice.default(.builtInMicrophone, for: .audio, position: .unspecified)
    private var videoDeviceInput: AVCaptureDeviceInput!
    private var micDeviceInput: AVCaptureDeviceInput!
    private let extractorQueue = DispatchQueue(label: "extractorQueue")
    
    override init()
    {
        super.init()
    }
    
    private func askPermissions(for device: AVMediaType) -> Bool
    {
        switch AVCaptureDevice.authorizationStatus(for: device)
        {
        case .authorized:
            return true
        case .denied, .restricted:
            return false
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: device)
            { (result) in
                return result
            }
        }
    }
    
    private func configureAV()
    {
        
    }
    
    
}
