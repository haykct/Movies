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

        moviesVC.tabBarItem = UITabBarItem(title: "Movies", image: UIImage(systemName: "film.fill"), tag: 0)
        moviesVC.viewModel = MoviesViewModel(withNetworkService: DefaultNetworkService())
        moviesVC.viewModel?.coordinator = self
        navigationController.setViewControllers([moviesVC], animated: false)
    }
    
    func openDetail(withID id: String?) {
        let viewModel = MovieDetailViewModel(networkService: DefaultNetworkService(), id: id)
        let swiftUIViewController = UIHostingController(rootView: MovieDetailView().environmentObject(viewModel))
        
        swiftUIViewController.navigationItem.largeTitleDisplayMode = .never
        navigationController.pushViewController(swiftUIViewController, animated: true)
    }
    
}
