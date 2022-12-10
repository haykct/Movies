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

    }
    
    //MARK: methods

    func setupTabBarItem() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarItem = UITabBarItem(title: "Shows", image: UIImage(systemName: "tv.inset.filled"), tag: 1)
        tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [.font: UIFont.systemFont(ofSize: 13)]
        tabBarItem.standardAppearance = tabBarAppearance
        tabBarItem.scrollEdgeAppearance = tabBarAppearance
    }
}
