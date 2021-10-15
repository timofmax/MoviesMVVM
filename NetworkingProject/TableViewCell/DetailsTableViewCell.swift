// DetailsTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// DetailsTableViewCell is cell for Table
final class DetailsTableViewCell: UITableViewCell {
    // MARK: - Public Properties
    var posterImageView = UIImageView()
    var titleLabel = UILabel()

    // MARK: - Private Properties
    private let imageAPIService = ImageAPIService()

    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setView()
    }

    // MARK: - LifeCycle Methods
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

    func configInCell(id: Int) {
        imageAPIService.downloadDetailedMovies(id: id) { movieFromInternet in
            let basePosterUrlString = "https://image.tmdb.org/t/p/w500"
            let backColorView = UIView()
            backColorView.backgroundColor = .clear
            self.titleLabel.text = movieFromInternet.originalTitle
            let trailLink = movieFromInternet.backdropPath
            guard let tryLink = trailLink else { return }
            guard let url = URL(string: basePosterUrlString + tryLink ?? "/3KwAmIKMaDcBMonF5wmyNTL0SR6.jpg") else { return }
            guard let imageData = try? Data(contentsOf: url) else { return }
            self.posterImageView.image = UIImage(data: imageData)
        }
    }
}
