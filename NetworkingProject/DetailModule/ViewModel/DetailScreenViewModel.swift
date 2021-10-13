//
//  DetailScreenViewModel.swift
//  NetworkingProject
//
//  Created by Timofey Privalov on 12.10.2021.
//

import Foundation

protocol DetailScreenViewModelProtocol {
    func getData()
    var movies: MovieDetails? { get set }
    var updateView: (() -> ())? { get set }
}

final class DetailViewModel {
    func getData() {
    }
    var updateView: (() -> ())?
}
