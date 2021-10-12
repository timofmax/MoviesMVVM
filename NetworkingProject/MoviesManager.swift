// MoviesManager.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import UIKit

// Some Movies
struct MoviesManager {
    // MARK: - Private Properties

    private let urlString = "https://api.themoviedb.org/3/movie/550?api_key=3227cbb07711665d37db3b97df155838"
    let urlImage = "https://image.tmdb.org/t/p/w500/"
    weak var delegate: MoviesMangerDelegate?

    // MARK: - Private Methods

    private func fetchMovies() {
        performRequest()
    }

    func getMovies(moviesTableView: UITableView) {
        var moviesList: [Movie] = []
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let urlMovie =
            "https://api.themoviedb.org/3/movie/top_rated?api_key=3227cbb07711665d37db3b97df155838&language=en-US&page=1#"
        guard let url = URL(string: urlMovie) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else { return }
            do {
                let mv = try decoder.decode(IncomingJson.self, from: data)
                moviesList = mv.results
                DispatchQueue.main.async {
                    moviesTableView.reloadData()
                }
            } catch {
                print("\(error.localizedDescription)")
            }
        }.resume()
    }

    private func performRequest() {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)

            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error ?? "Error")
                    return
                }
                if let safeData = data {
                    let wellParsed: () = self.parseJSON(dataMovie: safeData)
                }
                if response != nil {}
            }
            task.resume()
        }
    }

    private func parseJSON(dataMovie _: Data) {
        let decoder = JSONDecoder()
        do {
            decoder.keyDecodingStrategy = .convertFromSnakeCase
        } catch {
            print(error)
        }
    }
}

protocol MoviesMangerDelegate: AnyObject {
    func getMovieList(movie: MoviesManager)
}
