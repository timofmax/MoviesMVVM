// SpecificDetailsTableViewCell.swift
// Copyright © timofmax. All rights reserved.

import UIKit

/// Here is class, which creating cell on second screen
final class SpecificDetailsTableViewCell: UITableViewCell {
    // MARK: - Public Properties

    var overviewLabel = UILabel()
    var movieDateLabel = UILabel()
    var budgetLabel = UILabel()
    var revenueLabel = UILabel()

    // MARK: - Initializer

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: - Private Methods

    private func setView() {
        createBudgetLabel()
        createRevenueLabel()
        createDateLabel()
        createOverview()
    }

    private func createBudgetLabel() {
        budgetLabel.textColor = .white
        budgetLabel.backgroundColor = .black
        budgetLabel.text = "Budget Budget"
        budgetLabel.textAlignment = .center
        budgetLabel.layer.masksToBounds = true
        budgetLabel.layer.cornerRadius = 9
        budgetLabel.layer.borderWidth = 5
        budgetLabel.layer.borderColor = UIColor.orange.cgColor

        contentView.addSubview(budgetLabel)

        budgetLabel.translatesAutoresizingMaskIntoConstraints = false
        budgetLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        budgetLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        budgetLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }

    private func createRevenueLabel() {
        revenueLabel.textColor = .white
        revenueLabel.backgroundColor = .black
        revenueLabel.text = "Revenue 1000$"
        revenueLabel.textAlignment = .center
        revenueLabel.layer.masksToBounds = true
        revenueLabel.layer.cornerRadius = 9
        revenueLabel.layer.borderWidth = 5
        revenueLabel.layer.borderColor = UIColor.orange.cgColor
        contentView.addSubview(revenueLabel)

        revenueLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        revenueLabel.translatesAutoresizingMaskIntoConstraints = false
        revenueLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        revenueLabel.leadingAnchor.constraint(equalTo: budgetLabel.trailingAnchor, constant: 20).isActive = true
        revenueLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1 / 3).isActive = true
        revenueLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }

    private func createDateLabel() {
        movieDateLabel.textColor = .white
        movieDateLabel.text = "Date Date"
        movieDateLabel.backgroundColor = .black
        movieDateLabel.textAlignment = .center
        movieDateLabel.layer.masksToBounds = true
        movieDateLabel.layer.cornerRadius = 9
        movieDateLabel.layer.borderWidth = 5
        movieDateLabel.layer.borderColor = UIColor.orange.cgColor
        contentView.addSubview(movieDateLabel)

        movieDateLabel.translatesAutoresizingMaskIntoConstraints = false
        movieDateLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        movieDateLabel.leadingAnchor.constraint(equalTo: revenueLabel.trailingAnchor, constant: 20).isActive = true
        movieDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        movieDateLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }

    private func createOverview() {
        overviewLabel.textColor = .black
        overviewLabel.backgroundColor = .clear
        overviewLabel.numberOfLines = 0
        overviewLabel.textColor = .white
        overviewLabel.textAlignment = .center
        overviewLabel.text = "A lot of text will be here"
        contentView.addSubview(overviewLabel)

        overviewLabel.translatesAutoresizingMaskIntoConstraints = false
        overviewLabel.topAnchor.constraint(equalTo: budgetLabel.bottomAnchor, constant: 15).isActive = true
        overviewLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        overviewLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
    }

    func innerCellConfigure(movie: MovieDetailRealm) {
        selectionStyle = .none
        self.backgroundColor = .black
        self.overviewLabel.text = movie.overview
        self.budgetLabel.text = "💵 \(movie.budget)"
        self.revenueLabel.text = "💵 \(movie.revenue)"
        guard let releaseDate = movie.releaseDate else { return }
        self.movieDateLabel.text = "\(releaseDate)"
    }

}
