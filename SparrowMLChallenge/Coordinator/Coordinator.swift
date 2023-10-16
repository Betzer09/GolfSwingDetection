//
//  Coordinator.swift
//  SparrowMLChallenge
//
//  Created by Austin Betzer on 9/21/23.
//

import Foundation

protocol Coordinator: AnyObject {
    func start()
    func navigateToSwingAnalysis(forVideoWith url: URL)
}
