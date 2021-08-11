//
//  Predictor.swift
//  MC3PoseEstimation
//
//  Created by Sri Endah Ramurti on 16/07/21.
//

import Foundation
import Vision
import CoreML


typealias Drink = Panggil2

protocol PredictorDelegate: AnyObject {
    func predictor(_ predictor: Predictor, didFindNewRecognizedPoints points: [CGPoint])
    func predictor(_ predictor: Predictor, didLabelAction action: String, with confidence: Double)
}

class Predictor  {
    
    weak var delegate: PredictorDelegate?
    
    let predictionwindowSize = 120
    var posesWindow: [VNHumanBodyPoseObservation] = []
    
    init(){
        posesWindow.reserveCapacity(predictionwindowSize)
    }
    
    func estimation(sampleBuffer: CMSampleBuffer){
        
        let requestHandler = VNImageRequestHandler(cmSampleBuffer: sampleBuffer, orientation: .up)
        
        let request = VNDetectHumanBodyPoseRequest(completionHandler: bodyPoseHandler)
        do {
            try requestHandler.perform([request])
        } catch {
            print("Unable perform the request, with error: \(error)")
        }
    }
    func bodyPoseHandler(request: VNRequest, erro: Error?){
        guard let observations = request.results as? [VNHumanBodyPoseObservation] else {return}
        
        observations.forEach{
        processObservation($0)
        }
        
        if let result = observations.first{
            storeObservation(result)
            
        labelActionType()
        }
    }
    func labelActionType(){
        guard let drink = try? Drink(configuration: MLModelConfiguration()),
              let poseMultiArray = prepareInputWithObservations(posesWindow),
              let predictions = try? drink.prediction(poses: poseMultiArray) else{
            return
        }
        let label = predictions.label
        let confidence = predictions.labelProbabilities[label] ?? 0
        delegate?.predictor(self, didLabelAction: label, with: confidence)
        
        
    }
    func prepareInputWithObservations(_ observations: [VNHumanBodyPoseObservation]) -> MLMultiArray?{
        let numAvailabeFrames = observations.count
        let observationsNeeded = predictionwindowSize
        var multiArrayBuffer = [MLMultiArray]()
        
        for frameIndex in 0 ..< min(numAvailabeFrames, observationsNeeded) {
            let pose = observations[frameIndex]
            do{
                let oneFrameMultiArray = try pose.keypointsMultiArray()
                multiArrayBuffer.append(oneFrameMultiArray)
            }catch{
                continue
            }
        }
        if numAvailabeFrames < observationsNeeded{
            for _ in 0 ..< (observationsNeeded - numAvailabeFrames) {
                do{
                    let oneFrameMutiArray = try MLMultiArray(shape: [120, 3, 8], dataType: .double)
                    try resetMultiArray(oneFrameMutiArray)
                    multiArrayBuffer.append(oneFrameMutiArray)
                }catch{
                    continue
                }
            }
        }
        return MLMultiArray(concatenating: [MLMultiArray](multiArrayBuffer), axis: 0, dataType: .float)
    }
    func resetMultiArray(_ predictionWindow: MLMultiArray, with value: Double = 0.0) throws {
        let pointer = try UnsafeMutableBufferPointer<Double>(predictionWindow)
        pointer.initialize(repeating: value)
    }
    func storeObservation(_ observation: VNHumanBodyPoseObservation){
        if posesWindow.count >= predictionwindowSize {
            posesWindow.removeFirst()
        }
        
        posesWindow.append(observation)
    }
    func processObservation(_ observation: VNHumanBodyPoseObservation){
        do {
            let recognizedPoints = try observation.recognizedPoints(forGroupKey: .all)
            let displayedPoints = recognizedPoints.map {
                CGPoint(x: $0.value.x, y: 1 - $0.value.y)
            }
            
            delegate?.predictor(self, didFindNewRecognizedPoints: displayedPoints)
        }catch{
            print("error finding recognized ponts")
        }
    }
}

