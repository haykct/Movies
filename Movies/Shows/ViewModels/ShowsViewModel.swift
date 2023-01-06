//
//  ShowsViewModel.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 16.12.22.
//

import Foundation

class ShowsViewModel: ObservableObject {
    
    @Published private(set) var shows: [Show] = []
    
    private var networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func requestTop250Shows() {
        let request = ShowsRequest()
        
        networkService.request(request) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let data):
                self.shows = data.items
            case .failure(let error):
                // Show error screen in ShowsView
                print(error.localizedDescription)
            }
        }
    }
}
