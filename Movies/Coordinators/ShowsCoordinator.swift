//
//  ShowsCoordinator.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 01.12.22.
//

import UIKit
import SwiftUI

class ShowsCoordinator: Coordinator {
    
    //MARK: properties
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    //MARK: initializers
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    //MARK: methods
    
    func start() {
        let swiftUIViewController = UIHostingController(rootView: Text("Hello"))
        
        swiftUIViewController.tabBarItem = UITabBarItem(title: "Shows", image: UIImage(systemName: "tv.inset.filled"), tag: 1)
        navigationController.setViewControllers([swiftUIViewController], animated: false)
    }
    
}
