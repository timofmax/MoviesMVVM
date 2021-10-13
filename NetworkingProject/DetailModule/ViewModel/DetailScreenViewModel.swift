//
//  DetailScreenViewModel.swift
//  NetworkingProject
//
//  Created by Timofey Privalov on 12.10.2021.
//

import Foundation

protocol DetailScreenViewModelProtocol {
    var movies: ((MovieDetails?)->())? { get set }
    func fetchMoviesFromViewModel(id: Int, complition: @escaping ((MovieDetails?)->()))
}

final class DetailViewModel: DetailScreenViewModelProtocol {
    var movieDetail: MovieDetails?
    var movies: ((MovieDetails?)->())?
    var movieAPIService: MovieAPIServiceProtocol = MovieAPIService()

//    func fetchMoviesFromViewModel(id: Int, complition: @escaping ((MovieDetails?) -> ())) {
//        // Это для View
//    }
//
//    func fetchMoviesFromApiService() {
//        movieAPIService.fetchDetailsFromAPI(id: <#T##Int#>, complition: <#T##((MovieDetails?) -> ())##((MovieDetails?) -> ())##(MovieDetails?) -> ()#>)
//    }


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
