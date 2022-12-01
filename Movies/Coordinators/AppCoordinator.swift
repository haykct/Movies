//
//  AppCoordinator.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 01.12.22.
//

import Foundation
import UIKit

class AppCoordinator: TabBarCoordinator {
    
    //MARK: properties
    
    var childCoordinators: [Coordinator] = []
    var tabBarController: TabBarController
    weak var window: UIWindow?
    
    //MARK: initializers
    
    init(window: UIWindow) {
        self.window = window
        tabBarController = TabBarController()
    }
    
    //MARK: methods
    
    func start() {
        
    }
}
