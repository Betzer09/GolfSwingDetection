//
//  ObjectDetectionStrategy.swift
//  SparrowMLChallenge
//
//  Created by Austin Betzer on 9/20/23.
//

import Foundation
import CoreVideo

protocol ObjectDetectionStrategy {
    func processBuffer(_ buffer: CVPixelBuffer) -> ObjectDetailsContract?
}


