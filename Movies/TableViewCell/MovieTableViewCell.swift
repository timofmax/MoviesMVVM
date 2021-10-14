// MovieTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit
/// Here is own MovieTableViewCell  - separtated for style and customization.
final class MovieTableViewCell: UITableViewCell {
    // MARK: - Public Properties

    var logoMovieImageView = UIImageView()
    var posterImageView = UIImageView()
    var titleMovieLabel = UILabel()
    var overviewLabel = UILabel()
    var ratingLabel = UILabel()
    var backView = UIView()

    // MARK: - Initinilizers

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
        createOverview()
        createTitle()
        createRating()
        createPosterConstraint()
        createOverviewConstraint()
        createTitleConstraint()
        createRatingConstraint()
    }

    private func createPoster() {
        posterImageView.image = UIImage(named: "imdb")
        posterImageView.layer.masksToBounds = true
        posterImageView.layer.cornerRadius = 10
        contentView.addSubview(posterImageView)
    }

    private func createOverview() {
        overviewLabel.text = "here is some text"
        overviewLabel.textColor = .white
        overviewLabel.backgroundColor = .black
        overviewLabel.layer.masksToBounds = true
        overviewLabel.layer.cornerRadius = 10
        overviewLabel.lineBreakMode = .byTruncatingTail
        overviewLabel.numberOfLines = 0
        contentView.addSubview(overviewLabel)
    }

    private func createTitle() {
        titleMovieLabel.text = "      "
        titleMovieLabel.textColor = .white
        titleMovieLabel.backgroundColor = .black
        titleMovieLabel.textAlignment = .center
        titleMovieLabel.layer.masksToBounds = true
        titleMovieLabel.numberOfLines = 0
        contentView.addSubview(titleMovieLabel)
    }

    private func createRating() {
        ratingLabel.text = "      "
        ratingLabel.textAlignment = .center
        ratingLabel.textColor = .white
        ratingLabel.layer.masksToBounds = true
        ratingLabel.numberOfLines = 0
        contentView.addSubview(ratingLabel)
    }

    private func createPosterConstraint() {
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        posterImageView.contentMode = .scaleAspectFit
        posterImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        posterImageView.topAnchor.constraint(equalTo: titleMovieLabel.topAnchor, constant: 0).isActive = true
        posterImageView.bottomAnchor.constraint(equalTo: ratingLabel.topAnchor, constant: 0).isActive = true
        posterImageView.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4).isActive = true
    }

    private func createRatingConstraint() {
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
        ratingLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25).isActive = true
        ratingLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }

    private func createTitleConstraint() {
        titleMovieLabel.translatesAutoresizingMaskIntoConstraints = false
        titleMovieLabel.contentMode = .scaleAspectFit
        titleMovieLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 10).isActive = true
        titleMovieLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        titleMovieLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }

    private func createOverviewConstraint() {
        overviewLabel.translatesAutoresizingMaskIntoConstraints = false
        overviewLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 10).isActive = true
        overviewLabel.topAnchor.constraint(equalTo: titleMovieLabel.bottomAnchor, constant: 10).isActive = true
        overviewLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        overviewLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
    }

    func configCell(movie: Movie) {
        let basePosterUrlString = "https://image.tmdb.org/t/p/w500"
        let backColorView = UIView()
        backColorView.backgroundColor = .clear
        self.selectionStyle = .none
        self.overviewLabel.text = movie.overview
        self.titleMovieLabel.text = movie.title
        self.ratingLabel.text = "\(movie.voteAverage) ⭐️"
        guard let url = URL(string: basePosterUrlString + movie.posterPath) else { return }
        if let data = try? Data(contentsOf: url) {
            guard let image = UIImage(data: data) else { return }
            self.posterImageView.image = image
        }
    }

}
