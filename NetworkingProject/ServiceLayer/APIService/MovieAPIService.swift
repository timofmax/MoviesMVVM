// MoviesManager.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import UIKit

protocol MovieAPIServiceProtocol {
    func fetMovies(complition: @escaping (([Movie])->()))
    func fetchDetailsFromAPI(id: Int, complition: @escaping ((MovieDetails?)->()))
}

/// MovieAPIService
final class MovieAPIService: MovieAPIServiceProtocol {
    
    func fetMovies(complition: @escaping (([Movie])->())) {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let urlMovie =
            "https://api.themoviedb.org/3/movie/top_rated?api_key=3227cbb07711665d37db3b97df155838&language=en-US&page=1#"
        guard let url = URL(string: urlMovie) else { return }
        URLSession.shared.dataTask(with: url) { [self] data, _, error in
            guard let data = data else { return }
            do {
                let mv = try decoder.decode(IncomingJson.self, from: data)
                let moviesss = mv.results
                complition(moviesss)
            } catch {
                print("\(error.localizedDescription)")
            }
        }.resume()
    }

    func fetchDetailsFromAPI(id: Int, complition: @escaping ((MovieDetails?)->())) {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let jsonUrlString =
            "https://api.themoviedb.org/3/movie/\(id)?api_key=3227cbb07711665d37db3b97df155838&language=en-US"
        guard let url = URL(string: jsonUrlString) else { return }
        let session = URLSession.shared.dataTask(with: url) { [self] data, _, error in
            guard let data = data else { return }
            do {
                let incomingData = try decoder.decode(MovieDetails.self, from: data)
                complition(incomingData)
            } catch {
                print("\(error)")
            }
        }
        session.resume()
    }
}
