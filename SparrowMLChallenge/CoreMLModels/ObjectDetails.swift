//
//  ObjectDetails.swift
//  SparrowMLChallenge
//
//  Created by Austin Betzer on 9/21/23.
//

import Foundation
import CoreML

protocol ObjectDetailsContract {
    var boundingBox: BoundingBox? {get}
    var isPerson: Bool {get}
}

struct ObjectDetails: ObjectDetailsContract {
    let boundingBox: BoundingBox?
    let personsConfidence: NSNumber?
    
    var isPerson: Bool {
        guard let confidenceValue = personsConfidence?.doubleValue else {
            return false
        }
        
        return confidenceValue > 0.9
    }
    
    init(mlMultiArray: MLMultiArray, confidence: MLMultiArray) {
        boundingBox = mlMultiArray.boundingBox
        personsConfidence = confidence[safe: 0]
    }
}
