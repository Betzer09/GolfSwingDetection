//
//  MainCoordinator.swift
//  SparrowMLChallenge
//
//  Created by Austin Betzer on 9/21/23.
//

import UIKit

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController
    var window: UIWindow?
    
    init(window: UIWindow?) {
        self.window = window
        self.navigationController = UINavigationController()
    }
    
    func start() {
        let viewController = VideoSelectionViewController(coordinator: self)
        navigationController.pushViewController(viewController, animated: false)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    func navigateToSwingAnalysis(forVideoWith url: URL) {
        let swingVC = SwingAnalysisViewController(mediaPlayer: MediaPlayer(url: url))
        navigationController.pushViewController(swingVC, animated: true)
    }
}
