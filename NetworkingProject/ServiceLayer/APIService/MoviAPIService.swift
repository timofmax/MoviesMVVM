// MoviesManager.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import UIKit

// Some Movies
struct MoviAPIService {
}

protocol MoviesMangerDelegate: AnyObject {
    func getMovieList(movie: MoviAPIService)
}
