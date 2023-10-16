//
//  MediaPlayer.swift
//  SparrowMLChallenge
//
//  Created by Austin Betzer on 9/21/23.
//

import Foundation
import AVKit
import AVFoundation
import UIKit


class MediaPlayer {
    var player: AVPlayer!
    private var playerItem: AVPlayerItem!
    private var videoOutput: AVPlayerItemVideoOutput!
    
    init(url: URL) {
        // Create an AVPlayer and AVPlayerItem
        playerItem = AVPlayerItem(url: url)

        // Setup the video output to capture pixel buffers
        let pixelBufferAttributes: [String: Any] = [
            kCVPixelBufferPixelFormatTypeKey as String: Int(kCVPixelFormatType_32BGRA)
        ]
        videoOutput = AVPlayerItemVideoOutput(pixelBufferAttributes: pixelBufferAttributes)
        playerItem.add(videoOutput)

        player = AVPlayer(playerItem: playerItem)
    }
    
    func play() {
        player.play()
    }
    
    func capturePixelBuffer() -> CVPixelBuffer? {
        let itemTime = playerItem.currentTime()
        if videoOutput.hasNewPixelBuffer(forItemTime: itemTime) {
            return videoOutput.copyPixelBuffer(forItemTime: itemTime, itemTimeForDisplay: nil)
        }
        return nil
    }
    
    func addPlayerToView(_ view: UIView) {
        // Add the AVPlayer to an AVPlayerLayer for playback
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = view.bounds
        view.layer.addSublayer(playerLayer)
    }
}


