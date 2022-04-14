//
//  ResponseListMovie.swift
//  The Movies App
//
//  Created by Valentina Guarnizo on 29/03/22.
//

import Foundation

struct ResponseListMovie: Codable {
    let listOfMovies: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case listOfMovies = "results"
    }
   
}

