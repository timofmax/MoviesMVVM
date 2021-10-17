//
//  MovieDetailViewModelTest.swift
//  MoviesTest
//
//  Created by Timofey Privalov on 17.10.2021.
//

@testable import NetworkingProject
import XCTest

final class MovieDetailViewModelTest: XCTestCase {
    var movieViewModel: MovieDetailViewModelProtocol!
    var movieAPIservice: MovieAPIServiceProtocol!
    var repository = RealmRepository<MovieDetailRealm>()
    var movieDetail: MovieDetailRealm?

    override func tearDown() {
        movieViewModel = nil
        movieAPIservice = nil
    }

    func testGetDetailMovie() {
        movieDetail = MovieDetailRealm()
        movieDetail?.posterPath = "/123FizzBuzz"
        movieDetail?.id = 44

        var moviesDetail: [MovieDetailRealm] = []

        moviesDetail.append(movieDetail ?? MovieDetailRealm())

        let movieAPIService = MockNetworkService(movie: moviesDetail)

        let movieViewModel = MovieDetailViewModel(movieAPIService: movieAPIService, repository: repository)

        XCTAssertNotNil(movieViewModel)

        var catchMovieDetail: MovieDetailRealm?

        movieAPIService.fetchDetailsFromAPI(id: 44) { result in
            catchMovieDetail = result
        }
        XCTAssertNotNil(catchMovieDetail)
    }

}
