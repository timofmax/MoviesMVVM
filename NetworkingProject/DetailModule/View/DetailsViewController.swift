// DetailsViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// DetailsViewController
final class DetailsViewController: UIViewController {
    // MARK: - Public Properties

    var id = Int()
    var movieDetail: MovieDetails?
    let detailsTableView = UITableView()
    
    var viewModel: DetailScreenViewModelProtocol = DetailViewModel()

    // MARK: - Lifecycle methods

    override func viewDidLoad() {
        setView()
    }

    // MARK: - Private Methods

    private func setView() {
        detailsTableView.delegate = self
        detailsTableView.dataSource = self
        detailsTableView.register(DetailsTableViewCell.self, forCellReuseIdentifier: "detailID")
        detailsTableView.register(SpecificDetailsTableViewCell.self, forCellReuseIdentifier: "specificID")
        view.backgroundColor = .black
        createTable()
        viewModel.fetchMoviesFromViewModel(id: id) { movieDetailFromViewModel in
            self.movieDetail = movieDetailFromViewModel
        }
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
            cell.configInCell(id: id)
            return cell
        case 1:
        super.viewDidLoad()
            guard let cell = detailsTableView
                    .dequeueReusableCell(withIdentifier: "specificID", for: indexPath) as? SpecificDetailsTableViewCell
            else { return UITableViewCell() }
            viewModel.movies = { movieDetailFromClosure in
                self.movieDetail = movieDetailFromClosure
            }
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
