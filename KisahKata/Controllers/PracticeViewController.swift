//
//  PracticeViewController.swift
//  KisahKata
//
//  Created by Dimas Putro on 12/08/21.
//

import UIKit
import AVFoundation
import CoreML

class PracticeViewController: UIViewController, PredictorDelegate {

    @IBOutlet weak var titleSignLanguageLabel: UILabel!
    @IBOutlet weak var containerStatusPraktikView: UIView!
    @IBOutlet weak var statusPraktikLabel: UILabel!
    @IBOutlet weak var openHintButton: UIButton!
    @IBOutlet weak var containerPreviewVideoView: UIView!
    
    let videoCapture = VideoCapture()
    
    var previewLayer: AVCaptureVideoPreviewLayer?
    
    var pointsLayer = CAShapeLayer()
    
    var isMinumdetected = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        let value = UIInterfaceOrientation.portrait.rawValue
//        UIDevice.current.setValue(value, forKey: "orientation")
        
        openHintButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        
        containerStatusPraktikView.layer.cornerRadius = containerStatusPraktikView.frame.height / 2
        
        setupVideoPreview()
        
        videoCapture.predictor.delegate = self
    }
    
//    override public var shouldAutorotate: Bool {
//      return false
//    }
//
//    override public var supportedInterfaceOrientations: UIInterfaceOrientationMask {
//      return .portrait
//    }
//
//    override public var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
//      return .portrait
//    }
    
    func predictor(_ predictor: Predictor, didLabelAction action: String, with confidence: Double) {
        if action == "Panggil" && isMinumdetected == false {
            print("action : \(action), confidence: \(confidence)")
//            label.text = "\(action)"


            isMinumdetected = true


            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.isMinumdetected = false
            }
            
            DispatchQueue.main.async {
//                AudioServicesPlayAlertSound(SystemSoundID(1322))
                self.isMinumdetected = false

                self.videoCapture.stopRunning()
                
                self.dismiss(animated: true, completion: nil)
            }

        } else {
            print("action : \(action)")
            print("confidence masih kecil")
//          label.text = "Other"

//            DispatchQueue.main.async {
////                AudioServicesPlayAlertSound(SystemSoundID(1322))
//                self.isMinumdetected = false
//
//                self.videoCapture.stopRunning()
//            }

        }
    }

    func predictor(_ predictor: Predictor, didFindNewRecognizedPoints points: [CGPoint]) {
        guard let previewLayer = previewLayer else {return}



        let convertedPoints = points.map{
            previewLayer.layerPointConverted(fromCaptureDevicePoint: $0)
        }

        let combinedPath = CGMutablePath()
        for point in convertedPoints{
            let dotPath = UIBezierPath(ovalIn: CGRect(x: point.x, y: point.y, width: 10, height: 10))
            combinedPath.addPath(dotPath.cgPath)
        }
        pointsLayer.path = combinedPath
        DispatchQueue.main.async {
            self.pointsLayer.didChangeValue(for: \.path)
        }
    }

    
    private func setupVideoPreview(){
        
        videoCapture.startCaptureSession()
        previewLayer = AVCaptureVideoPreviewLayer(session: videoCapture.captureSession)
        guard let previewLayer = previewLayer else {return}
        
        containerPreviewVideoView.layer.addSublayer(previewLayer)
        previewLayer.frame = containerPreviewVideoView.frame
        previewLayer.videoGravity = .resizeAspectFill
        previewLayer.connection?.videoOrientation = .portrait
        
        previewLayer.addSublayer(pointsLayer)
        pointsLayer.frame = view.frame
        pointsLayer.strokeColor = UIColor.red.cgColor
    }
    
    

}


//extension ViewController: PredictorDelegate {
//
//    func predictor(_ predictor: Predictor, didLabelAction action: String, with confidence: Double) {
//        if action == "Selamat Pagi" && isMinumdetected == false {
//            print("action : \(action), confidence: \(confidence)")
////            label.text = "\(action)"
//
//
//            isMinumdetected = true
//
//
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                self.isMinumdetected = false
//            }
//            DispatchQueue.main.async {
////                AudioServicesPlayAlertSound(SystemSoundID(1322))
//                self.isMinumdetected = false
//
//                self.videoCapture.stopRunning()
//            }
//
//        } else {
//            print("action : \(action)")
//            print("confidence masih kecil")
////          label.text = "Other"
//
////            DispatchQueue.main.async {
//////                AudioServicesPlayAlertSound(SystemSoundID(1322))
////                self.isMinumdetected = false
////
////                self.videoCapture.stopRunning()
////            }
//
//        }
//    }
//
//    func predictor(_ predictor: Predictor, didFindNewRecognizedPoints points: [CGPoint]) {
//        guard let previewLayer = previewLayer else {return}
//
//
//
//        let convertedPoints = points.map{
//            previewLayer.layerPointConverted(fromCaptureDevicePoint: $0)
//        }
//
//        let combinedPath = CGMutablePath()
//        for point in convertedPoints{
//            let dotPath = UIBezierPath(ovalIn: CGRect(x: point.x, y: point.y, width: 10, height: 10))
//            combinedPath.addPath(dotPath.cgPath)
//        }
//        pointsLayer.path = combinedPath
//        DispatchQueue.main.async {
//            self.pointsLayer.didChangeValue(for: \.path)
//        }
//    }
//}
