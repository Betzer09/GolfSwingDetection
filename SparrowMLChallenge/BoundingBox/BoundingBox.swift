//
//  BoundingBox.swift
//  SparrowMLChallenge
//
//  Created by Austin Betzer on 9/21/23.
//

import Foundation

struct BoundingBox {
    var x: Double // the x coordinate of the top-left corner
    var y: Double // the y coordinate of the top-left corner
    var width: Double // the width of the bounding box
    var height: Double // the height of the bounding box
    
    var centerX: Double {
        return x + width/2
    }
    
    var centerY: Double {
        return y + height/2
    }
    
    var asArray: [Double] {
        return [x, y, width, height]
    }
    
    // This function will check if the bounding box is approximately centered
    // `tolerance` will define how much off-center is acceptable
    func isCentered(withinTolerance tolerance: Double = 0.3) -> Bool {
        let frameCenter = 0.5 // Since it's normalized to [0, 1]
        let isCenteredHorizontally = abs(centerX - frameCenter) <= tolerance
        let isCenteredVertically = abs(centerY - frameCenter) <= tolerance
        return isCenteredHorizontally && isCenteredVertically
    }
}
