//
//  MLMultiArray.swift
//  SparrowMLChallenge
//
//  Created by Austin Betzer on 9/20/23.
//

import Foundation
import CoreML

extension MLMultiArray {
    var values: [Double] {
        print("Shape of MLMultiArray: \(self.shape)")
        
        guard self.shape.count == 2, self.shape[1] == 4, self.shape[0] != 0 else {
            return []
        }
        
        var coordinates: [Double] = []
        
        for i in 0..<4 {
            let index = self.strides[0].intValue * 0 + self.strides[1].intValue * i
            coordinates.append(self[index].doubleValue)
        }
        
        return coordinates
    }
    
    
    var boundingBox: BoundingBox? {
        
        guard self.shape.count == 2, self.shape[1] == 4, self.shape[0] != 0 else {
            return nil
        }
        
        let xIndex = self.strides[0].intValue * 0 + self.strides[1].intValue * 0
        let yIndex = self.strides[0].intValue * 0 + self.strides[1].intValue * 1
        let widthIndex = self.strides[0].intValue * 0 + self.strides[1].intValue * 2
        let heightIndex = self.strides[0].intValue * 0 + self.strides[1].intValue * 3
        
        let x = self[xIndex].doubleValue
        let y = self[yIndex].doubleValue
        let width = self[widthIndex].doubleValue
        let height = self[heightIndex].doubleValue
        
        return BoundingBox(x: x, y: y, width: width, height: height)
    }
    
    
    subscript(safe index: Int) -> NSNumber? {
        return index >= 0 && index < count ? self[index] : nil
    }
}
