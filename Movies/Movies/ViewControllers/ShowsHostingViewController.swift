//
//  ShowsViewController.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 02.12.22.
//

import UIKit
import SwiftUI

final class ShowsHostingViewController: UIHostingController<ShowsView> {

    //MARK: lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBarItem()
        setupNavigationBar()
    }
    
    //MARK: private methods
    
    private func setupTabBarItem() {
        typealias NunitoSans = Constants.Fonts.NunitoSans
        
        let tabBarAppearance = UITabBarAppearance()
        let titleFontSize: CGFloat = 14
        let font = UIFont(name: NunitoSans.semiBold, size: titleFontSize) as Any

        tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [.font: font]
        tabBarItem.standardAppearance = tabBarAppearance
        tabBarItem.scrollEdgeAppearance = tabBarAppearance
    }
    
    
    private func setupNavigationBar() {
        typealias NunitoSans = Constants.Fonts.NunitoSans
        
        let appearance = UINavigationBarAppearance()
        let titleFontSize: CGFloat = 20
        let largeTitleFontSize: CGFloat = 32
        let buttonTitleFontSize: CGFloat = 18
        let image = Constants.Images.System.filledCircle
        let color = Constants.Colors.grey as Any
        let titleFont = UIFont(name: NunitoSans.black, size: titleFontSize) as Any
        let largeTitleFont = UIFont(name: NunitoSans.black, size: largeTitleFontSize) as Any
        let buttonTitleFont = UIFont(name: NunitoSans.bold, size: buttonTitleFontSize) as Any
        let title = "Movies"
        
        navigationItem.title = title
        navigationController?.navigationBar.prefersLargeTitles = true
        appearance.titleTextAttributes = [.foregroundColor: color, .font: titleFont]
        appearance.largeTitleTextAttributes = [.foregroundColor: color, .font: largeTitleFont]
        appearance.buttonAppearance.normal.titleTextAttributes = [.foregroundColor: color,
                                                                  .font: buttonTitleFont]
        appearance.setBackIndicatorImage(image, transitionMaskImage: image)
        navigationController?.navigationBar.tintColor = Constants.Colors.grey
        navigationController?.navigationBar.standardAppearance = appearance
    }
}
