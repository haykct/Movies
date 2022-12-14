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
        let swiftUIViewController = ShowsHostingViewController(rootView: ShowsView(viewModel: ShowsViewModel(networkService: DefaultNetworkService())))
        
        swiftUIViewController.tabBarItem = UITabBarItem(title: "Shows", image: UIImage(systemName: "tv.inset.filled"), tag: 1)
        navigationController.setViewControllers([swiftUIViewController], animated: false)
    }
    
}

