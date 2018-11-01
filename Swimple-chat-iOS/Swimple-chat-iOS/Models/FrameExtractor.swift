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
    private let backVideoDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)
    private let frontVideoDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front)
    private let micDevice = AVCaptureDevice.default(.builtInMicrophone, for: .audio, position: .unspecified)
    private var backVideoDeviceInput: AVCaptureDeviceInput!
    private var frontVideoDeviceInput: AVCaptureDeviceInput!
    private var micDeviceInput: AVCaptureDeviceInput!
    private let extractorQueue = DispatchQueue(label: "extractorQueue")
    
    private weak var alertDelegate: MyViewController!
    
    init?(devices: [AVCaptureDevice], alertDelegate: MyViewController)
    {
        super.init()
        self.alertDelegate = alertDelegate
        
        guard askPermissions(for: .video) else
        {
            alertDelegate.alert(title: "Permissions error!", message: "Camera permissions denied!")
            return nil
        }
        guard askPermissions(for: .audio) else
        {
            alertDelegate.alert(title: "Permissions error!", message: "Microphone permissions denied!")
            return nil
        }
        
        self.configureAV()
    }
    
    private func askPermissions(for device: AVMediaType) -> Bool
    {
        var ans = false
        switch AVCaptureDevice.authorizationStatus(for: device)
        {
        case .authorized:
            ans = true
        case .denied, .restricted:
            ans = false
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: device)
            { result in
                ans = result
            }
        }
        
        return ans
    }
    
    private func configureAV()
    {
        
    }
    
    
}
