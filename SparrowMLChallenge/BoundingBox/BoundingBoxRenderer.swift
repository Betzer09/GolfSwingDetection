//
//  BoundingBoxRenderer.swift
//  SparrowMLChallenge
//
//  Created by Austin Betzer on 9/21/23.
//

import UIKit

struct BoundingBoxRenderer {
    private var boundingBoxLayer: CAShapeLayer?
    private weak var parentView: UIView?

    init(parentView: UIView) {
        self.parentView = parentView
        setupBoundingBoxLayer() // Initialize the boundingBoxLayer once
    }

    mutating func renderBoundingBox(_ boundingBox: BoundingBox?,
                                    isPerson: Bool,
                                    isStationary: Bool,
                                    colors: Colors = (.red, .green)) {
        
        guard let boundingBox = boundingBox, let parentView = parentView else {
            print("Unexpected state: missing bounding box or parent view.")
            return
        }
        
        let coordinates = boundingBox.asArray
        guard coordinates.count == 4 else {
            print("Unexpected coordinates format: \(coordinates)")
            return
        }

        let videoWidth = parentView.bounds.width
        let videoHeight = parentView.bounds.height

        let centerX = CGFloat(coordinates[0]) * videoWidth
        let centerY = CGFloat(coordinates[1]) * videoHeight
        let width = CGFloat(coordinates[2]) * videoWidth
        let height = CGFloat(coordinates[3]) * videoHeight

        let rect = CGRect(
            x: centerX - width / 2.0,
            y: centerY - height / 2.0,
            width: width,
            height: height
        )

        let isActionCriteriaMet = boundingBox.isCentered() && isPerson && isStationary
        boundingBoxLayer!.strokeColor = isActionCriteriaMet ? colors.success.cgColor : colors.failure.cgColor
        let bezierPath = UIBezierPath(rect: rect)
        boundingBoxLayer!.path = bezierPath.cgPath
    }
    
    private mutating func setupBoundingBoxLayer() {
        if boundingBoxLayer == nil {
            boundingBoxLayer = CAShapeLayer()
            boundingBoxLayer!.fillColor = UIColor.blue.withAlphaComponent(0.3).cgColor
            boundingBoxLayer!.lineWidth = 2.0
            if let parentView = parentView {
                parentView.layer.addSublayer(boundingBoxLayer!)
                parentView.layer.bringSublayerToFront(boundingBoxLayer!)
            }
        }
    }
}
