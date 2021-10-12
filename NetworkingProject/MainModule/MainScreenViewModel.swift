//
//  MainViewModel.swift
//  NetworkingProject
//
//  Created by Timofey Privalov on 12.10.2021.
//

import Foundation

protocol MainScreenViewModelProtocol {
    func getData()
    var movies: [Movie] { get set }
    var updateView: (() -> ())? { get set }
}

final class MainScreenViewModel: MainScreenViewModelProtocol {
    var updateView: (() -> ())?

    var movies: [Movie] = []

    func getData() {
        fetMovies()
    }

    private func fetMovies() {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let urlMovie =
            "https://api.themoviedb.org/3/movie/top_rated?api_key=3227cbb07711665d37db3b97df155838&language=en-US&page=1#"
        guard let url = URL(string: urlMovie) else { return }
        URLSession.shared.dataTask(with: url) { [self] data, _, error in
            guard let data = data else { return }
            do {
                let mv = try decoder.decode(IncomingJson.self, from: data)
                self.movies = mv.results
                self.updateView?()
            } catch {
                print("\(error.localizedDescription)")
            }
        }.resume()
    }
 }
