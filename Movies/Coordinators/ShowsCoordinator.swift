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
        let title = "Shows"
        let tvImage = UIImage(systemName: "tv.inset.filled")
        let tag = 1
        let viewModel = ShowsViewModel(networkService: DefaultNetworkService())
        let showsView = ShowsView(viewModel: viewModel)
        let hostingViewController = ShowsHostingViewController(rootView: showsView)
        let isAnimated = false
        
        hostingViewController.tabBarItem = UITabBarItem(title: title, image: tvImage, tag: tag)
        navigationController.setViewControllers([hostingViewController], animated: isAnimated)
    }
    
}

