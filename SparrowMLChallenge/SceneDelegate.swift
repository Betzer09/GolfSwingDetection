//
//  SceneDelegate.swift
//  SparrowMLChallenge
//
//  Created by Austin Betzer on 9/20/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var mainCoordinator: MainCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // This makes sure we're dealing with a window scene
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        // Create a new window for the window scene
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        
        // Set up the coordinator
        mainCoordinator = MainCoordinator(window: window)
        mainCoordinator?.start()
    }
}

