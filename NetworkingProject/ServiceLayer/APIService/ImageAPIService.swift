//
//  ImageAPIService.swift
//  NetworkingProject
//
//  Created by Timofey Privalov on 13.10.2021.
//

import Foundation

protocol ImageAPIServiceProtocol {
    func downloadDetailedMovies(id: Int, complition: @escaping ((MovieDetails)->()))
}

final class ImageAPIService: ImageAPIServiceProtocol {


    // MARK: - Public methods
    func downloadDetailedMovies(id: Int, complition: @escaping ((MovieDetails)->())) {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let jsonUrlString =
            "https://api.themoviedb.org/3/movie/\(id)?api_key=3227cbb07711665d37db3b97df155838&language=en-US"
        guard let url = URL(string: jsonUrlString) else { return }
        let session = URLSession.shared.dataTask(with: url) { [self] data, _, error in
            guard let data = data else { return }
            do {
                let specifiMovie = try decoder.decode(MovieDetails.self, from: data)
                DispatchQueue.main.async {
                    complition(specifiMovie)
                }
            } catch {
                print("\(error)")
            }
        }
        session.resume()
    }
}
