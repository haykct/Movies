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
        let titleFontSize: CGFloat = 14
        let font = UIFont(name: NunitoSans.semiBold, size: titleFontSize) as Any

        tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [.font: font]
        tabBarItem.standardAppearance = tabBarAppearance
        tabBarItem.scrollEdgeAppearance = tabBarAppearance
    }
    
    
    func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        let titleFontSize: CGFloat = 20
        let largeTitleFontSize: CGFloat = 32
        let buttonTitleFontSize: CGFloat = 18
        let filledCircleImage = UIImage(systemName: "chevron.backward.circle.fill")
        let color = Constants.Colors.grey as Any
        let titleFont = UIFont(name: NunitoSans.black, size: titleFontSize) as Any
        let largeTitleFont = UIFont(name: NunitoSans.black, size: largeTitleFontSize) as Any
        let buttonTitleFont = UIFont(name: NunitoSans.bold, size: buttonTitleFontSize) as Any
        
        navigationItem.title = navigationTitle
        navigationController?.navigationBar.prefersLargeTitles = true
        appearance.titleTextAttributes = [.foregroundColor: color, .font: titleFont]
        appearance.largeTitleTextAttributes = [.foregroundColor: color, .font: largeTitleFont]
        appearance.buttonAppearance.normal.titleTextAttributes = [.foregroundColor: color,
                                                                  .font: buttonTitleFont]
        appearance.setBackIndicatorImage(filledCircleImage, transitionMaskImage: filledCircleImage)
        navigationController?.navigationBar.tintColor = Constants.Colors.grey
        navigationController?.navigationBar.standardAppearance = appearance
    }

}
