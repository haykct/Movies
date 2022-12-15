//
//  Coordinator.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 01.12.22.
//

import UIKit

protocol BaseCoordinator {
    var childCoordinators: [Coordinator] { get set }
    
    func start()
}

protocol Coordinator: BaseCoordinator {
    var navigationController: UINavigationController { get set }
}

protocol TabBarCoordinator: BaseCoordinator {
    var tabBarController: TabBarController { get set }
}
