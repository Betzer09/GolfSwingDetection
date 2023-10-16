//
//  VideoSelectionViewController.swift
//  SparrowMLChallenge
//
//  Created by Austin Betzer on 9/21/23.
//

import Foundation
import UIKit

class VideoSelectionViewController: UIViewController {
    private let coordinator: Coordinator
    
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPlayButtons()
        view.backgroundColor = .white
    }
    
    private func setupPlayButtons() {
        for index in 1...3 {
            let playButton = UIButton(type: .system)
            playButton.setTitle("Play Video \(index)", for: .normal)
            playButton.tag = index // Assign a tag to differentiate the buttons
            playButton.addTarget(self, action: #selector(playVideoTapped(_:)), for: .touchUpInside)
            playButton.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(playButton)
            
            NSLayoutConstraint.activate([
                playButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                playButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: CGFloat(index - 2) * 50)
            ])
        }
    }
    
    @objc func playVideoTapped(_ sender: UIButton) {
        guard let path = Bundle.main.path(forResource: "video_\(sender.tag)", ofType: "mp4") else {
            print("Failed to navigate to video with id: \(sender.tag)")
            return
        }
        
        coordinator.navigateToSwingAnalysis(forVideoWith: URL(fileURLWithPath: path))
    }
}
