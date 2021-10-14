// MenuViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// MEGA documentation
final class MainViewController: UIViewController {
    // MARK: - Public Properties
    
    var mainViewModel: MainScreenViewModelProtocol!

    // MARK: - Private Properties

    private let moviesTableView = UITableView()

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
        cell.backgroundColor = .black
        let moviesList = mainViewModel.movies
        cell.configCell(movie: moviesList[indexPath.row])
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
        let detailedViewModel = DetailViewModel(movieID: mainViewModel.movies[indexPath.row].id)
        withDetailViewController.setupViewModel(viewModel: detailedViewModel)
        navigationController?.pushViewController(withDetailViewController, animated: true)
    }
}
