//
//  Api.swift
//  The Movies App
//
//  Created by Valentina Guarnizo on 29/03/22.
//

import Foundation

class Api {
    static let share = Api()
    
    func getListMovie(completion: @escaping (ResponseListMovie)->()) {

        let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=80e2304690072ba6502131415cdca327")
        
            
        guard url != nil else {
            print("Error al consumir el servicio")
            return
        }
        var request = URLRequest(url: url!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        
        let header = ["content-type": "application/json"]
        request.allHTTPHeaderFields = header
        
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { (data, response, error) in
        
            guard let data = data, error == nil else { return }
            
            do {
                let decoder = JSONDecoder()
                let responseList = try decoder.decode(ResponseListMovie.self, from: data)
                
                completion(responseList)
            }
            catch {
                print("Error parsing response data")
            }
        }
        
   
        dataTask.resume()
    }

}

