//
//  MovieDetailViewModel.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 12.12.22.
//

import Foundation

class MovieDetailViewModel: ObservableObject {
    
    private var id: String?
    private var networkService: NetworkService
    
    init(networkService: NetworkService, id: String?) {
        self.networkService = networkService
        self.id = id
    }
}
