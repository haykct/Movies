//
//  ShowsDataModel.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 16.12.22.
//

import Foundation

struct ShowsDataModel: Decodable, Response {
    var items: [Show]
    var errorMessage: String?
}

struct Show: Decodable, Identifiable {
    var id: String
    var rank: String
    var fullTitle: String
    var image: String
    var rating: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case rank
        case fullTitle
        case image
        case rating = "imDbRating"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(String.self, forKey: .id)
        self.rank = try container.decode(String.self, forKey: .rank)
        self.fullTitle = try container.decode(String.self, forKey: .fullTitle)
        self.image = try container.decode(String.self, forKey: .image)
        self.rating = try container.decode(String.self, forKey: .rating)
    }
}
