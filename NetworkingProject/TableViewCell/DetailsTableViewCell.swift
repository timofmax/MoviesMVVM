// DetailsTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// DetailsTableViewCell is cell for Table
final class DetailsTableViewCell: UITableViewCell {
    // MARK: - Public Properties

    var posterImageView = UIImageView()
    var titleLabel = UILabel()

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: - Private Methods

    private func setView() {
        createPoster()
        createTitle()
        createPosterConstraint()
        createTitleContstraint()
    }

    private func createTitle() {
        titleLabel.text = "Some Title is HERE"
        titleLabel.textColor = .orange
        titleLabel.backgroundColor = .black
        titleLabel.textAlignment = .center
        titleLabel.layer.masksToBounds = true
        titleLabel.layer.cornerRadius = 9
        titleLabel.layer.borderWidth = 3
        titleLabel.layer.borderColor = UIColor.white.cgColor
        titleLabel.numberOfLines = 0
        contentView.addSubview(titleLabel)
    }

    private func createPoster() {
        posterImageView.image = UIImage(named: "imdb")
        contentView.addSubview(posterImageView)
    }

    private func createPosterConstraint() {
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        posterImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        posterImageView.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 10).isActive = true
    }

    private func createTitleContstraint() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1 / 2).isActive = true
        titleLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 1 / 4).isActive = true
    }

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

    func configInCell(id: Int) {
        downloadDetailedMovies(id: id) { [weak self ] movieFromInternet in
            let basePosterUrlString = "https://image.tmdb.org/t/p/w500"
            let backColorView = UIView()
            backColorView.backgroundColor = .black
            self?.titleLabel.text = movieFromInternet.originalTitle
            let trailLink = movieFromInternet.backdropPath
            let tryLink = URL(string: basePosterUrlString + trailLink)
            guard let url = URL(string: basePosterUrlString + trailLink) else { return }
            guard let imageData = try? Data(contentsOf: url) else { return }
            self?.posterImageView.image = UIImage(data: imageData)
        }
    }


    /*
    func configCell(movie: Movie) {
        let basePosterUrlString = "https://image.tmdb.org/t/p/w500"
        let backColorView = UIView()
        backColorView.backgroundColor = .clear
        self.overviewLabel.text = movie.overview
        self.titleMovieLabel.text = movie.title
        self.ratingLabel.text = "\(movie.voteAverage) ⭐️"
        guard let url = URL(string: basePosterUrlString + movie.posterPath) else { return }
        // Fetch Image Data
        if let data = try? Data(contentsOf: url) {
            guard let image = UIImage(data: data) else { return }
            self.posterImageView.image = image
        }
    } */
}
