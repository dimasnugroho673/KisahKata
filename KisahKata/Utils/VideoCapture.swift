//
//  VideoCapture.swift
//  MC3PoseEstimation
//
//  Created by Sri Endah Ramurti on 16/07/21.
//

import Foundation
import AVFoundation

class VideoCapture: NSObject{
    let captureSession = AVCaptureSession()
    let videoOutput = AVCaptureVideoDataOutput()

    let predictor = Predictor()
    
    override init(){
        super.init()
        guard let captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front),
             let input = try? AVCaptureDeviceInput(device: captureDevice) else {return
            
        }
        captureSession.sessionPreset = AVCaptureSession.Preset.high
        captureSession.addInput(input)
        
        captureSession.addOutput(videoOutput)
        videoOutput.alwaysDiscardsLateVideoFrames = true
    }
    func startCaptureSession(){
        captureSession.startRunning()
        videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoDispatchQueue"))
    }
    
    func stopRunning() {
        captureSession.stopRunning()
        print("stop capture")
    }
   
    }
extension VideoCapture: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
    
        predictor.estimation(sampleBuffer: sampleBuffer)
    }
}
