//
//  TabBarController.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 01.12.22.
//

import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBar()
    }
    
    private func setupTabBar() {
        tabBar.tintColor = UIColor(red: 110/255, green: 204/255, blue: 173/255, alpha: 1)
    }
   
}
