//
//  BoundingBoxAnalyzer.swift
//  SparrowMLChallenge
//
//  Created by Austin Betzer on 9/21/23.
//

import Foundation

protocol BoundingBoxAnalyzerProtocol {
    var isObjectStationary: Bool {get}
    
    @discardableResult
    func isObjectMoving() -> Bool
    func addBoundingBox(_ box: BoundingBox)
}

class BoundingBoxAnalyzer: BoundingBoxAnalyzerProtocol {
    private(set) var boundingBoxes: [BoundingBox] = []
    private let movementThreshold: Double
    private let stationaryThreshold: Int = 5
    private var stationaryCount: Int = 0
    private let analysisQueue = DispatchQueue(label: "BoundingBoxAnalyzerQueue")
    
    // Semaphore for isObjectStationary
    private let isObjectStationarySemaphore = DispatchSemaphore(value: 1)
    
    private var _isObjectStationary: Bool = false

    var isObjectStationary: Bool {
        isObjectStationarySemaphore.wait()
        let value = _isObjectStationary
        isObjectStationarySemaphore.signal()
        return value
    }

    init(movementThreshold: Double = 0.02) {
        self.movementThreshold = movementThreshold
    }
    
    func addBoundingBox(_ box: BoundingBox) {
        analysisQueue.async { [weak self] in
            self?.boundingBoxes.append(box)
            
            // Optionally, limit the history to last 10 boxes (or any other number you prefer)
            while self?.boundingBoxes.count ?? 0 > 10 {
                self?.boundingBoxes.removeFirst()
            }
            
            _ = self?.isObjectMoving()
        }
    }
    
    @discardableResult
    func isObjectMoving() -> Bool {
        guard let distance = calculateDistanceBetweenLastBoxes() else {
            return false
        }
        
        let isMoving = distanceExceedsThreshold(distance)
        
        updateAndCheckStationaryCount(isMoving: isMoving)
        
        print("Is object moving: \(isMoving)")
        return isMoving
    }

    private func calculateDistanceBetweenLastBoxes() -> Double? {
        guard boundingBoxes.count >= 2 else {
            return nil
        }
        
        let previousBox = boundingBoxes[boundingBoxes.count - 2]
        let currentBox = boundingBoxes.last!
        
        let dx = currentBox.centerX - previousBox.centerX
        let dy = currentBox.centerY - previousBox.centerY
        return sqrt(dx*dx + dy*dy)
    }

    private func distanceExceedsThreshold(_ distance: Double) -> Bool {
        return distance > movementThreshold
    }

    private func updateAndCheckStationaryCount(isMoving: Bool) {
        if isMoving {
            stationaryCount = 0
        } else {
            stationaryCount += 1
            if stationaryCount >= stationaryThreshold {
                isObjectStationarySemaphore.wait()
                _isObjectStationary = true
                isObjectStationarySemaphore.signal()
            }
        }
    }
}
