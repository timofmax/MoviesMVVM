// DetailsViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// DetailsViewController
final class DetailsViewController: UIViewController {
    // MARK: - Public Properties
    var movieDetail: MovieDetails?
    let detailsTableView = UITableView()

    // MARK: - Private Properties
    private var viewModel: DetailScreenViewModelProtocol?
    private let movieAPIService = MovieAPIService()
    // MARK: - Lifecycle methods

    override func viewDidLoad() {
        setView()
        updateViewController()
    }

    // MARK: - Internal Methods

    func setupViewModel(viewModel: DetailScreenViewModelProtocol) {
        self.viewModel = viewModel
    }

    // MARK: - Private Methods

    private func updateViewController() {
        viewModel?.updateViewData = {
            DispatchQueue.main.async {
                self.detailsTableView.reloadData()
            }
        }
    }

    private func setView() {
        detailsTableView.delegate = self
        detailsTableView.dataSource = self
        detailsTableView.register(DetailsTableViewCell.self, forCellReuseIdentifier: "detailID")
        detailsTableView.register(SpecificDetailsTableViewCell.self, forCellReuseIdentifier: "specificID")
        view.backgroundColor = .black
        createTable()
        viewModel?.fetchMoviesFromViewModel(id: viewModel?.id ?? 0)
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
            cell.configInCell(id: viewModel?.id ?? 0)
            return cell
        case 1:
        super.viewDidLoad()
            guard let cell = detailsTableView
                    .dequeueReusableCell(withIdentifier: "specificID", for: indexPath) as? SpecificDetailsTableViewCell
            else { return UITableViewCell() }
            self.movieDetail = viewModel?.movieDetail
            guard let movieParams = movieDetail else { return UITableViewCell() }
            DispatchQueue.main.async {
                cell.innerCellConfigure(movie: movieParams)
            }
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
