//
//  ShowsViewControllerFactory.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 31.03.23.
//

import UIKit

struct ShowsViewControllerFactory: ViewControllerFactory {
    
    func makeViewController() -> UIViewController {
        let tvImage = UIImage(systemName: "tv.inset.filled")
        let viewModel = ShowsViewModel(networkService: DefaultNetworkService())
        let showsView = ShowsView(viewModel: viewModel)
        let hostingController = ShowsHostingViewController(rootView: showsView)
        
        hostingController.tabBarItem = UITabBarItem(title: "Shows", image: tvImage, tag: 1)
        
        return hostingController
    }
    
}
