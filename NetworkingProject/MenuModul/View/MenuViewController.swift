// MenuViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// MEGA documentation
final class MenuViewController: UIViewController {
    // MARK: - Public Properties

    var presenter: MoviePresenterProtocol!

    // MARK: - Private Properties

    private let moviesTableView = UITableView()

    // MARK: - Lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        moviesTableView.dataSource = self
        moviesTableView.delegate = self
        moviesTableView.register(MovieTableViewCell.self, forCellReuseIdentifier: "myCell")
        setView()
        DispatchQueue.main.async {
            self.presenter.fetchMovies()
        }
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

    private func createTableView() {
        moviesTableView.backgroundColor = .black
        moviesTableView.separatorColor = .orange
        moviesTableView.accessibilityIdentifier = "MovieTableView"
        view.addSubview(moviesTableView)
        moviesTableView.translatesAutoresizingMaskIntoConstraints = false
        moviesTableView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        moviesTableView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
}

// MARK: - UITableViewDataSource

extension MenuViewController: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        presenter.moviesList?.count ?? 0
    }

    func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = moviesTableView.dequeueReusableCell(
            withIdentifier: "myCell",
            for: indexPath
        ) as? MovieTableViewCell
        else { return UITableViewCell() }
        cell.backgroundColor = .black
        guard let moviesList = presenter.moviesList else { return UITableViewCell() }
        guard !moviesList.isEmpty else { return UITableViewCell() }
        cell.configCell(movie: moviesList[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate

extension MenuViewController: UITableViewDelegate {
    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        300
    }

    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let movieId = presenter.moviesList?[indexPath.row].id else { return }
        presenter.tapOnTheCell(moveId: movieId)
    }
}

// MARK: - MenuViewController

extension MenuViewController: MovieViewProtocol {
    func success() {
        DispatchQueue.main.async {
            self.moviesTableView.reloadData()
        }
    }
}
