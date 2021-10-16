// DetailsViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// DetailsViewController
final class MovieDetailViewController: UIViewController {

    private enum Constants {
        static let cellQuantity = 2
    }


    // MARK: - Public Properties

    var movieDetail: MovieDetailRealm?

    // MARK: - Private Properties

    private let detailsTableView = UITableView()
    private var viewModel: MovieDetailViewModelProtocol?

    // MARK: - Lifecycle methods

    convenience init(viewModel: MovieDetailViewModelProtocol) {
        self.init()
        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        updateViewController()
        setView()
    }

    // MARK: - Internal Methods

    func setupViewModel(viewModel: MovieDetailViewModelProtocol) {
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

extension MovieDetailViewController: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        Constants.cellQuantity
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

extension MovieDetailViewController: UITableViewDelegate {
    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
//        UITableView.automaticDimension
        300
    }
}
