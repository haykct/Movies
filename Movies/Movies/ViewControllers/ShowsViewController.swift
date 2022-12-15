//
//  ShowsViewController.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 02.12.22.
//

import UIKit

class ShowsViewController: UIViewController {

    //MARK: lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBarItem()
    }
    
    //MARK: methods

    func setupTabBarItem() {
        let tabBarAppearance = UITabBarAppearance()

        tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [.font: UIFont(name: "NunitoSans-SemiBold",
                                                                                             size: 14) as Any]
        tabBarItem.standardAppearance = tabBarAppearance
        tabBarItem.scrollEdgeAppearance = tabBarAppearance
    }
}
