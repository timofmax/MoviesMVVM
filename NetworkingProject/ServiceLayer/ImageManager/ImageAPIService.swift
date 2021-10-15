//
//  ImageAPIService.swift
//  NetworkingProject
//
//  Created by Timofey Privalov on 13.10.2021.
//

import UIKit

protocol ImageAPIServiceProtocol {
    func loadImage(url: URL, handler: @escaping HandlerImage)
    func downloadDetailedMovies(id: Int, complition: @escaping ((MovieDetails)->()))
}

typealias HandlerImage = ((UIImage)->())

final class ImageAPIService: ImageAPIServiceProtocol {

    func loadImage(url: URL, handler: @escaping HandlerImage) {
        guard let imageData = try? Data(contentsOf: url) else { return }
        guard let image = UIImage(data: imageData) else { return }
        handler(image)
    }

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
