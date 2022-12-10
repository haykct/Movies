//
//  ViewController.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 01.12.22.
//

import UIKit

class MoviesViewController: UIViewController {
    
    //MARK: lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        DefaultNetworkService().request(InTheatresMoviesRequest()) { result in
            switch result {
            case .success(let data):
                print(data.items)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    //MARK: methods
    
    func setupTabBarItem() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarItem = UITabBarItem(title: "Movies", image: UIImage(systemName: "film.fill"), tag: 0)
        tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [.font: UIFont.systemFont(ofSize: 13)]
        tabBarItem.standardAppearance = tabBarAppearance
        tabBarItem.scrollEdgeAppearance = tabBarAppearance
    }
}

