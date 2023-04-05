//
//  MoviesCoordinator.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 01.12.22.
//

import UIKit

final class MoviesCoordinator: Coordinator {
    
    //MARK: properties
    
    var childCoordinators: [Coordinator] = []
    let navigationController: UINavigationController
    
    //MARK: initializers
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    //MARK: methods
    
    func start() {
        let factory = MoviesViewControllerFactory(coordinator: self)
        let moviesViewController = factory.makeViewController()
        
        navigationController.setViewControllers([moviesViewController], animated: false)
    }
    
    func openDetail(withID id: String) {
        let factory = DetailViewControllerFactory(id: id)
        let detailHostingController = factory.makeViewController()
        
        navigationController.pushViewController(detailHostingController, animated: true)
    }
    
}
