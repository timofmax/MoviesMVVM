// DetailsViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// DetailsViewController
final class DetailsViewController: UIViewController {
    // MARK: - Public Properties

    var id = Int()
    var movieDetail: MovieDetails?
    let detailsTableView = UITableView()

    // MARK: - Private Properties

    let basePosterUrlString = "https://image.tmdb.org/t/p/w500"

    // MARK: - Lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        detailsTableView.delegate = self
        detailsTableView.dataSource = self
        detailsTableView.register(DetailsTableViewCell.self, forCellReuseIdentifier: "detailID")
        detailsTableView.register(SpecificDetailsTableViewCell.self, forCellReuseIdentifier: "specificID")
        view.backgroundColor = .brown
        setView()
        fetchMovies()
    }

    // MARK: - Private Methods

    private func setView() {
        view.backgroundColor = .black
        createTable()
    }

    private func createTable() {
        detailsTableView.backgroundColor = .black
        view.addSubview(detailsTableView)
        detailsTableView.separatorColor = .clear
        detailsTableView.translatesAutoresizingMaskIntoConstraints = false
        detailsTableView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        detailsTableView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }

    private func configurePosterCell(cell: DetailsTableViewCell) {
        cell.titleLabel.text = movieDetail?.originalTitle
        cell.backgroundColor = .black
        guard let trailingLink = movieDetail?.backdropPath,
              let url = URL(string: basePosterUrlString + trailingLink),
              let imageData = try? Data(contentsOf: url) else { return }
        cell.posterImageView.image = UIImage(data: imageData)
    }

    private func fetchMovies() {
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
                DispatchQueue.main.async {
                    self.detailsTableView.reloadData()
                }
            } catch {
                print("\(error)")
            }
        }
        session.resume()
    }
}

// MARK: - UITableViewDataSource

extension DetailsViewController: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        2
    }

    func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch indexPath.row {
        case 0:
            guard let cell = detailsTableView
                    .dequeueReusableCell(withIdentifier: "detailID", for: indexPath) as? DetailsTableViewCell
            else { return UITableViewCell() }
            cell.configInCell(id: id)
            return cell
        case 1:
            guard let cell = detailsTableView
                    .dequeueReusableCell(withIdentifier: "specificID", for: indexPath) as? SpecificDetailsTableViewCell
            else { return UITableViewCell() }
            guard let movieDetail = movieDetail else { return UITableViewCell() }
            cell.innerCellConfigure(movie: movieDetail)
            return cell
        default:
            return UITableViewCell()
        }
    }
}

// MARK: - UITableViewDelegate

extension DetailsViewController: UITableViewDelegate {
    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        300
    }
}

