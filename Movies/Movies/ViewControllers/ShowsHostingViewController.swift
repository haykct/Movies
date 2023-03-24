//
//  ShowsViewController.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 02.12.22.
//

import UIKit
import SwiftUI

final class ShowsHostingViewController: UIHostingController<ShowsView>, BaseConfiguration {

    //MARK: lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBarItem()
        setupNavigationBar()
    }
    
}
