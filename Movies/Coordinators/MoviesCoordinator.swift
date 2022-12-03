//
//  MoviesCoordinator.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 01.12.22.
//

import Foundation
import UIKit

class MoviesCoordinator: Coordinator {
    
    //MARK: properties
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    //MARK: initializers
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    //MARK: methods
    
    func start() {
        let moviesVC = MoviesViewController.instantiate(fromStoryboard: .main)
        
        moviesVC.tabBarItem = UITabBarItem(title: "Movies", image: UIImage(systemName: "film.fill"), tag: 0)
        navigationController.setViewControllers([moviesVC], animated: false)
    }
    
}
