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
    
    private weak var alertDelegate: Alerable!
    
    init?(devices: [AVCaptureDevice], alertDelegate: Alerable)
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
        
        self.configureCaptureSession()
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
    
    private func configureCaptureSession()
    {
        captureSession.beginConfiguration()
        
        guard let backVideoDeviceInput = try? AVCaptureDeviceInput(device: backVideoDevice!), captureSession.canAddInput(backVideoDeviceInput) else
        {
            alertDelegate.alert(title: "Error in configuring session", message: "Can't create back video device input")
            return
        }
        self.backVideoDeviceInput = backVideoDeviceInput
        captureSession.addInput(self.backVideoDeviceInput)
        
        guard let frontVideoDeviceInput = try? AVCaptureDeviceInput(device: frontVideoDevice!), captureSession.canAddInput(frontVideoDeviceInput) else
        {
            alertDelegate.alert(title: "Error in configuring session", message: "Can't create front video device input")
            return
        }
        self.frontVideoDeviceInput = frontVideoDeviceInput
        captureSession.addInput(self.frontVideoDeviceInput)
        
        guard let micDeviceInput = try? AVCaptureDeviceInput(device: micDevice!), captureSession.canAddInput(micDeviceInput) else
        {
            alertDelegate.alert(title: "Error in configuring session", message: "Can't create microphone device input")
            return
        }
        self.micDeviceInput = micDeviceInput
        captureSession.addInput(self.micDeviceInput)
        
        
        
        captureSession.commitConfiguration()
    }
    
    
    // MARK: AVCaptureVideoDataOutputSampleBufferDelegate
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection)
    {
        print("")
    }
    
    func captureOutput(_ output: AVCaptureOutput, didDrop sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection)
    {
        print("Dropped frame!")
    }
    
}
