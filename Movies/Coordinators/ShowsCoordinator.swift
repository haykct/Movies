//
//  ShowsCoordinator.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 01.12.22.
//

import UIKit

final class ShowsCoordinator: Coordinator {
    
    //MARK: properties
    
    var childCoordinators: [Coordinator] = []
    let navigationController: UINavigationController
    
    //MARK: initializers
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    //MARK: methods
    
    func start() {
        let factory = ShowsViewControllerFactory()
        let showsHostingController = factory.makeViewController()
        
        navigationController.setViewControllers([showsHostingController], animated: false)
    }
    
}

