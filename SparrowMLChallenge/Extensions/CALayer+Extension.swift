//
//  CALayer+Extension.swift
//  SparrowMLChallenge
//
//  Created by Austin Betzer on 9/21/23.
//

import UIKit

extension CALayer {
    func bringSublayerToFront(_ layer: CALayer) {
        layer.removeFromSuperlayer()
        self.addSublayer(layer)
    }
}
