//
//  YOLOv3TinyFP16Strategy.swift
//  SparrowMLChallenge
//
//  Created by Austin Betzer on 9/20/23.
//

import Foundation
import CoreML

class YOLOv3TinyFP16Strategy: ObjectDetectionStrategy {
    
    private var model: YOLOv3TinyFP16?
    
    init() {
        loadModel()
    }

    func loadModel() {
        let config = MLModelConfiguration()
        config.computeUnits = .all

        do {
            let modelURL = YOLOv3TinyFP16.urlOfModelInThisBundle
            model = try YOLOv3TinyFP16(contentsOf: modelURL, configuration: config)
        } catch {
            print("Error loading YOLOv3FP16 model: \(error)")
        }
    }

    func processBuffer(_ buffer: CVPixelBuffer) -> ObjectDetailsContract? {
        if let resizedBuffer = buffer.resized(to: 416, height: 416), let model = model {
            do {
                let result = try model.prediction(input: YOLOv3TinyFP16Input(image: resizedBuffer))
                // Intenintaely left in for debugging
//                print("prediction.confidence \(result.confidence)")
//                print("prediction.confidenceShapedArray \(result.confidenceShapedArray)")
//                print("prediction.coordinates \(result.coordinates)")
//                print("prediction.coordinatesShapedArray \(result.coordinatesShapedArray)")
                return ObjectDetails(mlMultiArray: result.coordinates, confidence: result.confidence)
            } catch {
                print("Error capturing prediction: \(error)")
                return nil
            }
        }
        return nil
    }
}
