//
//  ViewController.swift
//  SparrowMLChallenge
//
//  Created by Austin Betzer on 9/20/23.
//

import UIKit
import AVKit

typealias Colors = (failure: UIColor, success: UIColor)

class SwingAnalysisViewController: UIViewController {
    
    private var boundingBoxLayer: CAShapeLayer?
    private let detectionModel: ObjectDetectionStrategy
    private var boundingBoxAnalyzer: BoundingBoxAnalyzerProtocol
    private let mediaPlayer: MediaPlayer
    private lazy var boundingBoxRenderer: BoundingBoxRenderer = {
        return BoundingBoxRenderer(parentView: self.view)
    }()

    private var frameCounter = 0
    
    init(mediaPlayer: MediaPlayer,
         detectionModel: ObjectDetectionStrategy = YOLOv3FP16Strategy(),
         boundingBoxAnalyzer: BoundingBoxAnalyzerProtocol = BoundingBoxAnalyzer()) {
        self.detectionModel = detectionModel
        self.boundingBoxAnalyzer = boundingBoxAnalyzer
        self.mediaPlayer = mediaPlayer
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startPlayingVideo()
        view.backgroundColor = .white
    }
    
    @objc func startPlayingVideo() {
        mediaPlayer.addPlayerToView(self.view)
        mediaPlayer.play()
        
        setupObserver()
    }

    private func setupObserver() {
        // Adjust this value based on how many frames you want to skip.
        let frameSkipInterval = 3

        mediaPlayer.player.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 1), queue: .main) { [weak self] _ in
            guard let strongSelf = self else { return }
            
            strongSelf.frameCounter += 1
            
            if strongSelf.frameCounter % frameSkipInterval != 0 {
                return  // Skip this frame
            }

            guard let pixelBuffer = strongSelf.mediaPlayer.capturePixelBuffer(),
                  let object = strongSelf.detectionModel.processBuffer(pixelBuffer),
                  let box = object.boundingBox else {
                print("Failed to process buffer")
                return
            }

            strongSelf.boundingBoxAnalyzer.addBoundingBox(box)
            let isStationary = strongSelf.boundingBoxAnalyzer.isObjectStationary
            strongSelf.boundingBoxRenderer.renderBoundingBox(object.boundingBox, isPerson: object.isPerson, isStationary: isStationary)
        }
    }
}

