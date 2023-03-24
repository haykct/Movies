//
//  TabBarController.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 01.12.22.
//

import UIKit
import SwiftHEXColors

final class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBar()
    }
    
    //MARK: private methods
    
    private func setupTabBar() {
        tabBar.tintColor = Constants.Colors.cyan
    }
   
}
