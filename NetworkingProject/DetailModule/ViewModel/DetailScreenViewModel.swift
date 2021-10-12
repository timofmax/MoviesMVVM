//
//  DetailScreenViewModel.swift
//  NetworkingProject
//
//  Created by Timofey Privalov on 12.10.2021.
//

import Foundation

protocol DetailScreenViewModelProtocol {
    func getData()
    var movies: [Movie] { get set }
    var updateView: (() -> ())? { get set }
}

//final class DetailViewModel: DetailScreenViewModelProtocol {
//    func getData() {
//    }
//
//    var movies: [Movie]//
//    var updateView: (() -> ())?
//}
