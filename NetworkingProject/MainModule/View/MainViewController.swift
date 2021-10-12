// MenuViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// MEGA documentation
final class MainViewController: UIViewController {
    // MARK: - Public Properties
    var mainViewModel = MainScreenViewModel()
//    var mainViewModel: MainScreenViewModelProtocol?

    // MARK: - Private Properties

    private let moviesTableView = UITableView()
    private let basePosterUrlString = "https://image.tmdb.org/t/p/w500"

    // MARK: - Lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        moviesTableView.dataSource = self
        moviesTableView.delegate = self
        moviesTableView.register(MovieTableViewCell.self, forCellReuseIdentifier: "myCell")
        setView()
        updateViewController()
        mainViewModel.getData()
    }

    // MARK: - Private Methods

    private func setView() {
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.isTranslucent = false
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = attributes
        title = "Movies"
        createTableView()
    }

    private func updateViewController() {
        mainViewModel.updateView = {
            DispatchQueue.main.async {
                self.moviesTableView.reloadData()
            }
        }
    }

    private func createTableView() {
        moviesTableView.backgroundColor = .black
        moviesTableView.separatorColor = .orange
        view.addSubview(moviesTableView)
        moviesTableView.translatesAutoresizingMaskIntoConstraints = false
        moviesTableView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        moviesTableView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }

    private func configureCell(cell: MovieTableViewCell, indexPath: IndexPath) {
        cell.backgroundColor = .black
        if mainViewModel.movies.isEmpty {
            return
        }
        let backColorView = UIView()
        backColorView.backgroundColor = .clear
        cell.selectedBackgroundView = backColorView
        cell.overviewLabel.text = mainViewModel.movies[indexPath.row].overview
        cell.titleMovieLabel.text = mainViewModel.movies[indexPath.row].title
        cell.ratingLabel.text = "\(mainViewModel.movies[indexPath.row].voteAverage) ⭐️"
        guard let url = URL(string: basePosterUrlString + mainViewModel.movies[indexPath.row].posterPath) else { return }
        guard let imageData = try? Data(contentsOf: url) else { return }
        cell.posterImageView.image = UIImage(data: imageData)
    }
}

// MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        mainViewModel.movies.count
    }

    func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = moviesTableView.dequeueReusableCell(
            withIdentifier: "myCell",
            for: indexPath
        ) as? MovieTableViewCell
        else { return UITableViewCell() }
        configureCell(cell: cell, indexPath: indexPath)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension MainViewController: UITableViewDelegate {
    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        300
    }

    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        let withDetailViewController = DetailsViewController()
        withDetailViewController.id = mainViewModel.movies[indexPath.row].id
        navigationController?.pushViewController(withDetailViewController, animated: true)
    }
}
