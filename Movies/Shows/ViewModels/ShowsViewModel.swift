//
//  ShowsViewModel.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 16.12.22.
//

import Foundation
import Combine

final class ShowsViewModel: ObservableObject {
    
    private typealias ShowsPublisher = AnyPublisher<ShowsDataModel, RequestError>
    
    private var networkService: NetworkService
    private var cancellable: AnyCancellable?
    
    @Published private(set) var shows: [Show] = []
    @Published var error: LocalizedError?
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func requestTop250Shows() {
        let request = ShowsRequest()
        let publisher: ShowsPublisher = networkService.request(request)
        
        cancellable = publisher
            .map { $0.items }
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.error = error
                }
            } receiveValue: { [weak self] show in
                guard let self else { return }
                
                self.shows = show
            }
    }
}
