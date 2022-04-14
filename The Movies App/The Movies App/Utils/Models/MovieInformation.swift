//
//  MovieInformation.swift
//  The Movies App
//
//  Created by Valentina Guarnizo on 29/03/22.
//

import Foundation

struct Movie: Codable {
    let title: String
    let popularity: Double
    let movieID: Int
    let voteCount: Int
    let originalTitle: String
    let voteAverage: Double
    let sinopsis: String
    let realseDate: String
    let image: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case popularity 
        case movieID = "id"
        case voteCount = "vote_count"
        case originalTitle = "original_title"
        case voteAverage = "vote_average"
        case sinopsis = "overview"
        case realseDate = "release_date"
        case image = "poster_path"
        
      }
}
