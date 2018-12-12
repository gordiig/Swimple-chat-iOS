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
    private var videoDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)
    private let micDevice = AVCaptureDevice.default(.builtInMicrophone, for: .audio, position: .unspecified)
    private var videoDeviceInput: AVCaptureDeviceInput!
    private var micDeviceInput: AVCaptureDeviceInput!
    private let extractorQueue = DispatchQueue(label: "extractorQueue")
    private var outputDevice = AVCaptureVideoDataOutput()
    
    private let context = CIContext()
    
    weak var alertDelegate: Alerable?
    weak var outputDelegate: FrameExtractorOutputDelegate?
    
    init?(alertDelegate: Alerable?)
    {
        super.init()
        self.alertDelegate = alertDelegate
        
        guard askPermissions(for: .video) else
        {
            alertDelegate?.alert(title: "Permissions error!", message: "Camera permissions denied!", completion: nil)
            return nil
        }
        guard askPermissions(for: .audio) else
        {
            alertDelegate?.alert(title: "Permissions error!", message: "Microphone permissions denied!", completion: nil)
            return nil
        }
        
        extractorQueue.async {
            self.configureCaptureSession()
        }
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
        
        captureSession.sessionPreset = AVCaptureSession.Preset.medium
        
        guard let videoDeviceInput = try? AVCaptureDeviceInput(device: videoDevice!), captureSession.canAddInput(videoDeviceInput) else
        {
            sendAlertInMainQueue(title: "Error in configuring session", message: "Can't create camera device input")
            return
        }
        self.videoDeviceInput = videoDeviceInput
        captureSession.addInput(self.videoDeviceInput)
        
        guard let micDeviceInput = try? AVCaptureDeviceInput(device: micDevice!), captureSession.canAddInput(micDeviceInput) else
        {
            sendAlertInMainQueue(title: "Error in configuring session", message: "Can't create microphone device input")
            return
        }
        self.micDeviceInput = micDeviceInput
        captureSession.addInput(self.micDeviceInput)
        
        self.outputDevice.setSampleBufferDelegate(self, queue: self.extractorQueue)
//        self.outputDevice.videoSettings = [AVVideoCodecKey: AVVideoCodecType.jpeg]
        if captureSession.canAddOutput(self.outputDevice)
        {
            captureSession.addOutput(self.outputDevice)
        }
        
        guard let connection = self.outputDevice.connection(with: AVMediaType.video) else { return }
        if connection.isVideoOrientationSupported
        {
            connection.videoOrientation = .portrait
        }
        if connection.isVideoMirroringSupported
        {
            connection.isVideoMirrored = self.videoDevice?.position == .front
        }
        
        captureSession.commitConfiguration()
    }
    
    func flipCamera()
    {
        self.captureSession.beginConfiguration()
        self.captureSession.removeInput(self.videoDeviceInput)
        
        if self.videoDevice?.position == .front
        {
            self.videoDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)
        }
        else
        {
            self.videoDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front)
        }
        
        guard let videoDeviceInput = try? AVCaptureDeviceInput(device: self.videoDevice!), captureSession.canAddInput(videoDeviceInput) else
        {
            sendAlertInMainQueue(title: "Error in configuring session", message: "Can't create camera device input")
            return
        }
        self.videoDeviceInput = videoDeviceInput
        captureSession.addInput(videoDeviceInput)
        
        guard let connection = self.outputDevice.connection(with: AVMediaType.video) else { return }
        if connection.isVideoOrientationSupported
        {
            connection.videoOrientation = .portrait
        }
        if connection.isVideoMirroringSupported
        {
            connection.isVideoMirrored = self.videoDevice?.position == .front
        }
        
        self.captureSession.commitConfiguration()
    }
    
    func registerPreviewView(_ view: CameraPreviewView)
    {
        view.videoPreviewLayer.session = self.captureSession
    }
    
    func start()
    {
        extractorQueue.async {
            self.captureSession.startRunning()
        }
    }
    
    func stop()
    {
        extractorQueue.async {
            self.captureSession.stopRunning()
        }
        self.extractorQueue.suspend()
    }
    
    
    // MARK: - Alert
    func sendAlertInMainQueue(title: String, message: String)
    {
        DispatchQueue.main.async {
            self.alertDelegate?.alert(title: title, message: message, completion: nil)
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
            self.stop()
            return
        }
        
        if let img = convertToUIImage(buffer: sampleBuffer)
        {
            let str64 = img.toBase64(quality: 0.8)
            DispatchQueue.main.async
            {
                outputDelegate.frameExtractor(didOutputFrame: img, base64: str64)
            }
        }
    }
    
    func captureOutput(_ output: AVCaptureOutput, didDrop sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection)
    {
        print("Dropped frame!")
    }
    
}
