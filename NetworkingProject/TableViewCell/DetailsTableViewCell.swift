// DetailsTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import UIKit

/// DetailsTableViewCell is cell for Table
final class DetailsTableViewCell: UITableViewCell {
    // MARK: - Public Properties

    var someData: Data!
    var posterImageView = UIImageView()
    var titleLabel = UILabel()

    // MARK: - Private Properties

    var networkService = MovieAPIService()
    private let basePosterUrlString = "https://image.tmdb.org/t/p/w500"
    private let imageService = ImageService()

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: - Public Methods

    func confCell(movie: MovieDetail?) {
        titleLabel.text = movie?.originalTitle
        backgroundColor = .black
        guard let trailLink = movie?.backdropPath else { return }
        guard let tryLink = URL(string: basePosterUrlString + trailLink) else { return }
        imageService.getImage(url: tryLink) { [weak self] image in
            self?.posterImageView.image = image
        }
    }

    // MARK: - Private Methods

    func setView() {
        accessibilityIdentifier = "MovieDetalTableViewCell"
        createPoster()
        createTitle()
        createPosterConstraint()
        createTitleContstraint()
    }

    func createTitle() {
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

    func createPoster() {
        posterImageView.image = UIImage(named: "imdb")
        contentView.addSubview(posterImageView)
    }

    func createPosterConstraint() {
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        posterImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        posterImageView.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 10).isActive = true
    }

    func createTitleContstraint() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1 / 2).isActive = true
        titleLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 1 / 4).isActive = true
    }
}
