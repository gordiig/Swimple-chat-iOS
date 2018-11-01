//
//  FrameExtractor.swift
//  Swimple-chat-iOS
//
//  Created by Dmitry Gorin on 01/11/2018.
//  Copyright © 2018 gordiig. All rights reserved.
//

import Foundation
import UIKit
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
    
    private let context = CIContext()
    
    weak var alertDelegate: Alerable?
    weak var outputDelegate: FrameExtractorOutputDelegate?
    
    init?(alertDelegate: Alerable?)
    {
        super.init()
        self.alertDelegate = alertDelegate
        
        guard askPermissions(for: .video) else
        {
            alertDelegate?.alert(title: "Permissions error!", message: "Camera permissions denied!")
            return nil
        }
        guard askPermissions(for: .audio) else
        {
            alertDelegate?.alert(title: "Permissions error!", message: "Microphone permissions denied!")
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
            sendAlertInMainQueue(title: "Error in configuring session", message: "Can't create back camera device input")
            return
        }
        self.backVideoDeviceInput = backVideoDeviceInput
        captureSession.addInput(self.backVideoDeviceInput)
        
        guard let frontVideoDeviceInput = try? AVCaptureDeviceInput(device: frontVideoDevice!), captureSession.canAddInput(frontVideoDeviceInput) else
        {
            sendAlertInMainQueue(title: "Error in configuring session", message: "Can't create front camera device input")
            return
        }
        self.frontVideoDeviceInput = frontVideoDeviceInput
        captureSession.addInput(self.frontVideoDeviceInput)
        
        guard let micDeviceInput = try? AVCaptureDeviceInput(device: micDevice!), captureSession.canAddInput(micDeviceInput) else
        {
            sendAlertInMainQueue(title: "Error in configuring session", message: "Can't create microphone device input")
            return
        }
        self.micDeviceInput = micDeviceInput
        captureSession.addInput(self.micDeviceInput)
        
        let outputDevice = AVCaptureVideoDataOutput()
        outputDevice.setSampleBufferDelegate(self, queue: self.extractorQueue)
        outputDevice.videoSettings = [AVVideoCodecKey: AVVideoCodecType.jpeg]
        if captureSession.canAddOutput(outputDevice)
        {
            captureSession.addOutput(outputDevice)
        }
        
        captureSession.commitConfiguration()
    }
    
    
    // MARK: - Alert
    func sendAlertInMainQueue(title: String, message: String)
    {
        DispatchQueue.main.async {
            self.alertDelegate?.alert(title: title, message: message)
        }
    }
    
    
    // MARK: - Converting buffer to UIImage
    private func convertToUIImage(buffer: CMSampleBuffer) -> UIImage?
    {
        guard let imageBuffer = CMSampleBufferGetImageBuffer(buffer) else
        {
            print("Error in captureOutput!")
            return nil
        }
        let ciImage = CIImage(cvImageBuffer: imageBuffer)
        guard let cgImage = context.createCGImage(ciImage, from: ciImage.extent) else
        {
            print("Can't get cgImage")
            return nil
        }
        let img = UIImage(cgImage: cgImage)
        
        return img
    }
    
    
    // MARK: - AVCaptureVideoDataOutputSampleBufferDelegate
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection)
    {
        guard let outputDelegate = self.outputDelegate else
        {
            sendAlertInMainQueue(title: "Error in output delegate", message: "Output delegate is missing")
            return
        }
        
        if let img = convertToUIImage(buffer: sampleBuffer)
        {
            DispatchQueue.main.async
            {
                outputDelegate.frameExtractor(didOutputFrame: img)
            }
        }
    }
    
    func captureOutput(_ output: AVCaptureOutput, didDrop sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection)
    {
        print("Dropped frame!")
    }
    
}
