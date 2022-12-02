//
//  ShowsCoordinator.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 01.12.22.
//

import Foundation
import UIKit

class ShowsCoordinator: Coordinator {
    
    //MARK: properties
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    //MARK: initializers
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    //MARK: methods
    
    func start() {
        let showsVC = ShowsViewController.instantiate(fromStoryboard: .main)
        
        navigationController.setViewControllers([showsVC], animated: false)
    }
    
}
