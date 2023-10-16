//
//  CVPixelBuffer+Extension.swift
//  SparrowMLChallenge
//
//  Created by Austin Betzer on 9/20/23.
//

import CoreVideo
import CoreImage

extension CVPixelBuffer {

    func resized(to width: Int, height: Int) -> CVPixelBuffer? {
        var ciImage = CIImage(cvPixelBuffer: self, options: nil)
        let transform = CGAffineTransform(scaleX: CGFloat(width) / CGFloat(CVPixelBufferGetWidth(self)),
                                          y: CGFloat(height) / CGFloat(CVPixelBufferGetHeight(self)))
        ciImage = ciImage.transformed(by: transform)
        let ciContext = CIContext()
        guard let resizedPixelBuffer = createPixelBuffer(width: width, height: height) else {
            return nil
        }
        ciContext.render(ciImage, to: resizedPixelBuffer)
        return resizedPixelBuffer
    }

    private func createPixelBuffer(width: Int, height: Int) -> CVPixelBuffer? {
        var pixelBuffer: CVPixelBuffer? = nil
        let options: [String: Any] = [
            kCVPixelBufferCGImageCompatibilityKey as String: true,
            kCVPixelBufferCGBitmapContextCompatibilityKey as String: true,
            kCVPixelBufferWidthKey as String: width,
            kCVPixelBufferHeightKey as String: height,
            kCVPixelBufferPixelFormatTypeKey as String: kCVPixelFormatType_32BGRA
        ]
        let status = CVPixelBufferCreate(kCFAllocatorDefault, width, height, kCVPixelFormatType_32BGRA, options as CFDictionary, &pixelBuffer)
        if status != kCVReturnSuccess {
            print("Failed to create pixel buffer")
            return nil
        }
        return pixelBuffer
    }

}
