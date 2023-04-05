//
//  DetailViewControllerFactory.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 31.03.23.
//

import UIKit
import SwiftUI

struct DetailViewControllerFactory: ViewControllerFactory {
    
    private let id: String
    
    init(id: String) {
        self.id = id
    }
    
    func makeViewController() -> UIViewController {
        let viewModel = MovieDetailViewModel(networkService: DefaultNetworkService(), id: id)
        let movieDetailView = MovieDetailView().environmentObject(viewModel)
        let hostingController = UIHostingController(rootView: movieDetailView)
        
        hostingController.navigationItem.largeTitleDisplayMode = .never
        
        return hostingController
    }
    
}
