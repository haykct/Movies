//
//  MoviesViewControllerFactory.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 31.03.23.
//

import UIKit

class MoviesViewControllerFactory: ViewControllerFactory {
    
    private weak var coordinator: MoviesCoordinator?
    
    init(coordinator: MoviesCoordinator) {
        self.coordinator = coordinator
    }
    
    func makeViewController() -> UIViewController {
        let moviesViewController = MoviesViewController.instantiate(fromStoryboard: .main)
        let filmImage = UIImage(systemName: "film.fill")

        moviesViewController.tabBarItem = UITabBarItem(title: "Movies", image: filmImage, tag: 0)
        moviesViewController.viewModel = MoviesViewModel(withNetworkService: DefaultNetworkService())
        moviesViewController.viewModel?.coordinator = coordinator
        
        return moviesViewController
    }
    
}
