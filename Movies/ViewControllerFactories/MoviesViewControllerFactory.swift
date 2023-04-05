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
        let viewModel = MoviesViewModel(withNetworkService: DefaultNetworkService(), coordinator: coordinator)
        let creator = { MoviesViewController(coder: $0, viewModel: viewModel) }
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let moviesViewController = storyboard.instantiateViewController(identifier: "MoviesViewController", creator: creator)
        let filmImage = UIImage(systemName: "film.fill")
            
        moviesViewController.tabBarItem = UITabBarItem(title: "Movies", image: filmImage, tag: 0)
        
        return moviesViewController
    }
    
}
