//
//  NetworkService.swift
//  NetworkingProject
//
//  Created by Timofey Privalov on 05.10.2021.
//

import Alamofire
import Foundation

protocol MovieAPIServiceProtocol {
    func downloadMovies(completion: @escaping ([Movie], Error?) -> Void)
    func fetchDataDetail(id: Int?, complition: @escaping (MovieDetail?, Error?) -> Void)
}

final class MovieAPIService: MovieAPIServiceProtocol {
    // MARK: Public Properties

    var someData: Data?

    // MARK: Private Properties

    private let basePosterUrlString = "https://image.tmdb.org/t/p/w500"
    private let cats =
        "https://api.themoviedb.org/3/movie/top_rated?api_key=3227cbb07711665d37db3b97df155838&language=en-US"

    func getImageData(trailingLink: String, complition: @escaping (Data) -> Void) {
        AF.request(basePosterUrlString + trailingLink).responseData { response in
            debugPrint("Response: \(response)")
            guard let data = response.data else { return }
            complition(data)
        }
    }

    func downloadMovies(completion: @escaping ([Movie], Error?) -> Void) {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        AF.request(cats).responseJSON { response in
            switch response.result {
            case .success:
                do {
                    guard let data = response.data else { return }
                    let bestMovies = try decoder.decode(MoviesFavorite.self, from: data)
                    let movieList = bestMovies.results
                    completion(movieList, nil)
                } catch let error as NSError {
                    print("Failed to load: \(error.localizedDescription)")
                }
            case .failure:
                completion([], response.error)
            }
        }
    }

    func fetchDataDetail(id: Int?, complition: @escaping (MovieDetail?, Error?) -> Void) {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let movieNumber = id else { return }
        let jsonUrlString = "https://api.themoviedb.org/3/movie/\(movieNumber)?api_key=3227cbb07711665d37db3b97df155838&language=en-US"
        AF.request(jsonUrlString).responseJSON { response in
            switch response.result {
            case .success:
                do {
                    guard let data = response.data else { return }
                    let incomingData = try decoder.decode(MovieDetail.self, from: data)
                    let movie = incomingData
                    complition(movie, nil)
                } catch let error as NSError {
                    print("Failed to load \(error.localizedDescription)")
                }
            case .failure:
                complition(nil, response.error)
            }
        }
    }
}
