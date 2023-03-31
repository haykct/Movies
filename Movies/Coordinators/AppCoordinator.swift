//
//  AppCoordinator.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 01.12.22.
//

import UIKit

final class AppCoordinator: TabBarCoordinator {
    
    //MARK: properties
    
    var childCoordinators: [Coordinator] = []
    lazy var tabBarController = { TabBarController.instantiate(fromStoryboard: .main) }()
    
    //MARK: private properties
    
    private weak var window: UIWindow?
    
    //MARK: initializers
    
    init(window: UIWindow) {
        self.window = window
    }
    
    //MARK: methods
    
    func start() {
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        let moviesNavigationController = UINavigationController()
        let moviesCoordinator = MoviesCoordinator(navigationController: moviesNavigationController)
        let showsNavigationController = UINavigationController()
        let showsCoordinator = ShowsCoordinator(navigationController: showsNavigationController)
        
        childCoordinators.append(moviesCoordinator)
        
                //We can comment this line(or remove ShowsCoordinator fully)
                //since I made shows screen with swiftUI and didn't use coordinators for navigation
//        childCoordinators.append(showsCoordinator)
        
        tabBarController.viewControllers = [moviesNavigationController, showsNavigationController]
        moviesCoordinator.start()
        showsCoordinator.start()
    }
}
