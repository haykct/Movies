//
//  BaseViewController.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 24.03.23.
//

import UIKit

protocol BaseConfiguration {
    var navigationTitle: String? { get }
    
    func setupTabBarItem()
    func setupNavigationBar()
}

extension BaseConfiguration where Self: UIViewController {
    
    private typealias NunitoSans = Constants.Fonts.NunitoSans
    
    var navigationTitle: String? { nil }
    
    func setupTabBarItem() {
        let tabBarAppearance = UITabBarAppearance()
        let titleFont = UIFont(name: NunitoSans.semiBold, size: 14) as Any

        tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [.font: titleFont]
        tabBarItem.standardAppearance = tabBarAppearance
        tabBarItem.scrollEdgeAppearance = tabBarAppearance
    }
    
    
    func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        let filledCircleImage = UIImage(systemName: "chevron.backward.circle.fill")
        let greyColor = Constants.Colors.grey as Any
        let titleFont = UIFont(name: NunitoSans.black, size: 20) as Any
        let largeTitleFont = UIFont(name: NunitoSans.black, size: 32) as Any
        let buttonTitleFont = UIFont(name: NunitoSans.bold, size: 18) as Any
        
        navigationItem.title = navigationTitle
        navigationController?.navigationBar.prefersLargeTitles = true
        appearance.titleTextAttributes = [.foregroundColor: greyColor, .font: titleFont]
        appearance.largeTitleTextAttributes = [.foregroundColor: greyColor, .font: largeTitleFont]
        appearance.buttonAppearance.normal.titleTextAttributes = [.foregroundColor: greyColor,
                                                                  .font: buttonTitleFont]
        appearance.setBackIndicatorImage(filledCircleImage, transitionMaskImage: filledCircleImage)
        navigationController?.navigationBar.tintColor = Constants.Colors.grey
        navigationController?.navigationBar.standardAppearance = appearance
    }

}
