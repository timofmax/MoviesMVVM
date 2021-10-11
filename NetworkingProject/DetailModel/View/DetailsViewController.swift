// DetailsViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// DetailsViewController
final class DetailsViewController: UIViewController {
    // MARK: - Public Properties

    let detailsTableView = UITableView()
    var presenter: DetailMoviePresenterProtocol!

    // MARK: - Lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        detailsTableView.delegate = self
        detailsTableView.dataSource = self
        detailsTableView.accessibilityIdentifier = "MovieDetalTableView"
        detailsTableView.register(DetailsTableViewCell.self, forCellReuseIdentifier: "detailID")
        detailsTableView.register(SpecificDetailsTableViewCell.self, forCellReuseIdentifier: "specificID")
        view.backgroundColor = .brown
        setView()
        presenter.fetchDetails()
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
            cell.backgroundColor = .black
            cell.confCell(movie: presenter.movieDetails)
            return cell
        case 1:
            guard let cell = detailsTableView
                .dequeueReusableCell(withIdentifier: "specificID", for: indexPath) as? SpecificDetailsTableViewCell
            else { return UITableViewCell() }
            cell.confDescriptionCell(movie: presenter.movieDetails)
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

extension DetailsViewController: DetailMovieViewProtocol {
    func success() {
        DispatchQueue.main.async {
            self.detailsTableView.reloadData()
        }
    }
}
