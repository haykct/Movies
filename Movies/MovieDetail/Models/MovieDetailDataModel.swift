//
//  MovieDetailDataModel.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 13.12.22.
//

import Foundation

struct MovieDetailDataModel: Decodable, Response {
    var id: String
    var fullTitle: String?
    var image: String?
    var runtimeStr: String?
    var imDbRating: String?
    var genres: String?
    var directors: String?
    var actorList: [Actor]?
    var errorMessage: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case fullTitle
        case image
        case runtimeStr
        case imdbRating = "imDbRating"
        case genres
        case directors
        case actorList
        case errorMessage
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(String.self, forKey: .id)
        self.fullTitle = try container.decodeIfPresent(String.self, forKey: .fullTitle)
        self.image = try container.decodeIfPresent(String.self, forKey: .image)
        self.runtimeStr = try container.decodeIfPresent(String.self, forKey: .runtimeStr)
        self.imDbRating = try container.decodeIfPresent(String.self, forKey: .imdbRating)
        self.genres = try container.decodeIfPresent(String.self, forKey: .genres)
        self.directors = try container.decodeIfPresent(String.self, forKey: .directors)
        self.actorList = try container.decodeIfPresent([Actor].self, forKey: .actorList)
        self.errorMessage = try container.decode(String.self, forKey: .errorMessage)
    }
}

struct Actor: Decodable {
    var name: String?
    var image: String?
}
