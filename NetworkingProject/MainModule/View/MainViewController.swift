// MenuViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// MEGA documentation
final class MainViewController: UIViewController {
    // MARK: - Private Properties

    private var getMovie = MoviesManager()
    private var moviesList: [Movie] = []
    private let moviesTableView = UITableView()
    private let basePosterUrlString = "https://image.tmdb.org/t/p/w500"

    // MARK: - Lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        moviesTableView.dataSource = self
        moviesTableView.delegate = self
        moviesTableView.register(MovieTableViewCell.self, forCellReuseIdentifier: "myCell")
        setView()
        fetchMovies()
    }

    // MARK: - Private Methods

    private func setView() {
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.isTranslucent = false
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = attributes
        title = "Movies"
        createTableView()
    }

    private func createTableView() {
        moviesTableView.backgroundColor = .black
        moviesTableView.separatorColor = .orange
        view.addSubview(moviesTableView)
        moviesTableView.translatesAutoresizingMaskIntoConstraints = false
        moviesTableView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        moviesTableView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }

    private func configureCell(cell: MovieTableViewCell, indexPath: IndexPath) {
        cell.backgroundColor = .black
        if moviesList.isEmpty {
            return
        }
        let backColorView = UIView()
        backColorView.backgroundColor = .clear
        cell.selectedBackgroundView = backColorView
        cell.overviewLabel.text = moviesList[indexPath.row].overview
        cell.titleMovieLabel.text = moviesList[indexPath.row].title
        cell.ratingLabel.text = "\(moviesList[indexPath.row].voteAverage) ⭐️"
        guard let url = URL(string: basePosterUrlString + moviesList[indexPath.row].posterPath) else { return }
        guard let imageData = try? Data(contentsOf: url) else { return }
        cell.posterImageView.image = UIImage(data: imageData)
    }

    private func fetchMovies() {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let urlMovie =
            "https://api.themoviedb.org/3/movie/top_rated?api_key=3227cbb07711665d37db3b97df155838&language=en-US&page=1#"
        guard let url = URL(string: urlMovie) else { return }
        URLSession.shared.dataTask(with: url) { [self] data, _, error in
            guard let data = data else { return }
            do {
                let mv = try decoder.decode(IncomingJson.self, from: data)
                self.moviesList = mv.results
                DispatchQueue.main.async {
                    self.moviesTableView.reloadData()
                }
            } catch {
                print("\(error.localizedDescription)")
            }
        }.resume()
    }
}

// MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        moviesList.count
    }

    func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = moviesTableView.dequeueReusableCell(
            withIdentifier: "myCell",
            for: indexPath
        ) as? MovieTableViewCell
        else { return UITableViewCell() }
        configureCell(cell: cell, indexPath: indexPath)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension MainViewController: UITableViewDelegate {
    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        300
    }

    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        let withDetailViewController = DetailsViewController()
        withDetailViewController.id = moviesList[indexPath.row].id
        navigationController?.pushViewController(withDetailViewController, animated: true)
    }
}
