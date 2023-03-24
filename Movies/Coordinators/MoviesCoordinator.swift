//
//  MoviesCoordinator.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 01.12.22.
//

import UIKit
import SwiftUI

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
        let moviesVC = MoviesViewController.instantiate(fromStoryboard: .main)
        let title = "Movies"
        let filledFilmImage = UIImage(systemName: "film.fill")
        let tag = 0
        let isAnimated = false

        moviesVC.tabBarItem = UITabBarItem(title: title, image: filledFilmImage, tag: tag)
        moviesVC.viewModel = MoviesViewModel(withNetworkService: DefaultNetworkService())
        moviesVC.viewModel?.coordinator = self
        navigationController.setViewControllers([moviesVC], animated: isAnimated)
    }
    
    func openDetail(withID id: String) {
        let viewModel = MovieDetailViewModel(networkService: DefaultNetworkService(), id: id)
        let rootView = MovieDetailView().environmentObject(viewModel)
        let swiftUIViewController = UIHostingController(rootView: rootView)
        let isAnimated = true
        
        swiftUIViewController.navigationItem.largeTitleDisplayMode = .never
        navigationController.pushViewController(swiftUIViewController, animated: isAnimated)
    }
    
}
