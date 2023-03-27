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
        let tvImage = UIImage(systemName: "tv.inset.filled")
        let viewModel = ShowsViewModel(networkService: DefaultNetworkService())
        let showsView = ShowsView(viewModel: viewModel)
        let hostingViewController = ShowsHostingViewController(rootView: showsView)
        
        hostingViewController.tabBarItem = UITabBarItem(title: "Shows", image: tvImage, tag: 1)
        navigationController.setViewControllers([hostingViewController], animated: false)
    }
    
}

