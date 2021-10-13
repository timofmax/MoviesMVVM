//
//  DetailScreenViewModel.swift
//  NetworkingProject
//
//  Created by Timofey Privalov on 12.10.2021.
//

import Foundation

protocol DetailScreenViewModelProtocol {
    func fetchMovies(id: Int)
    var movieDetail: MovieDetails? { get set }
}

final class DetailViewModel {
    var movieDetail: MovieDetails?
    var movies: ((MovieDetails?)->())?
    func fetchMoviesFromViewModel(id: Int, complition: @escaping ((MovieDetails?)->())) {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let jsonUrlString =
            "https://api.themoviedb.org/3/movie/\(id)?api_key=3227cbb07711665d37db3b97df155838&language=en-US"
        guard let url = URL(string: jsonUrlString) else { return }
        let session = URLSession.shared.dataTask(with: url) { [self] data, _, error in
            guard let data = data else { return }
            do {
                let incomingData = try decoder.decode(MovieDetails.self, from: data)
                movieDetail.self = incomingData
                complition(incomingData)
            } catch {
                print("\(error)")
            }
        }
        session.resume()
    }
}
