//
//  MovieDetailDataModel.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 13.12.22.
//

import Foundation

struct MovieDetailDataModel: Decodable, Response {
    var id: String?
    var fullTitle: String?
    var image: String?
    var runtimeStr: String?
    var plot: String?
    var rating: String?
    var genres: String?
    var directors: String?
    var actorList: [Actor]?
    var errorMessage: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case fullTitle
        case image
        case runtimeStr
        case plot
        case rating = "imDbRating"
        case genres
        case directors
        case actorList
        case errorMessage
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.fullTitle = try container.decodeIfPresent(String.self, forKey: .fullTitle)
        self.image = try container.decodeIfPresent(String.self, forKey: .image)
        self.runtimeStr = try container.decodeIfPresent(String.self, forKey: .runtimeStr)
        self.plot = try container.decodeIfPresent(String.self, forKey: .plot)
        self.rating = try container.decodeIfPresent(String.self, forKey: .rating)
        self.genres = try container.decodeIfPresent(String.self, forKey: .genres)
        self.directors = try container.decodeIfPresent(String.self, forKey: .directors)
        self.actorList = try container.decodeIfPresent([Actor].self, forKey: .actorList)
        self.errorMessage = try container.decodeIfPresent(String.self, forKey: .errorMessage)
    }
}

struct Actor: Decodable, Identifiable {
    var id: String?
    var name: String?
    var image: String?
}
