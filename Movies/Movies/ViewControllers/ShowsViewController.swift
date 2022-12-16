//
//  ShowsViewController.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 02.12.22.
//

import UIKit
import SwiftUI

class ShowsViewController: UIHostingController<ShowsView> {

    //MARK: lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBarItem()
        setupNavigationBar()
    }
    
    //MARK: private methods
    
    private func setupTabBarItem() {
        let tabBarAppearance = UITabBarAppearance()

        tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [.font: UIFont(name: "NunitoSans-SemiBold",
                                                                                             size: 14) as Any]
        tabBarItem.standardAppearance = tabBarAppearance
        tabBarItem.scrollEdgeAppearance = tabBarAppearance
    }
    
    
    private func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        
        navigationItem.title = "Movies"
        navigationController?.navigationBar.prefersLargeTitles = true
        appearance.titleTextAttributes = [.foregroundColor: Colors.grey as Any,
                                          .font: UIFont(name: "NunitoSans-Black", size: 20) as Any]
        appearance.largeTitleTextAttributes = [.foregroundColor: Colors.grey as Any,
                                               .font: UIFont(name: "NunitoSans-Black", size: 32) as Any]
        appearance.buttonAppearance.normal.titleTextAttributes = [.foregroundColor: Colors.grey as Any,
                                                                  .font: UIFont(name: "NunitoSans-Bold", size: 18) as Any]
        appearance.setBackIndicatorImage(UIImage(systemName: "chevron.backward.circle.fill"),
                                         transitionMaskImage: UIImage(systemName: "chevron.backward.circle.fill"))
        navigationController?.navigationBar.tintColor = Colors.grey
        navigationController?.navigationBar.standardAppearance = appearance
    }
}
