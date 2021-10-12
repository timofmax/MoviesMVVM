//
//  MainViewModel.swift
//  NetworkingProject
//
//  Created by Timofey Privalov on 12.10.2021.
//

import Foundation

protocol MainScreenViewModelProtocol {
    var updateViewData: ((ViewData) -> Void)? { get set }
    func getData(groupId: Int)
}


final class MainScreenViewModel: MainScreenViewModelProtocol {
    var updateViewData: ((ViewData) -> Void)?

    func getData(groupId: Int) {

    }

 }
