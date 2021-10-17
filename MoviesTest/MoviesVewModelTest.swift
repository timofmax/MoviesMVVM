//
//  MoviesVewModelTest.swift
//  MoviesTest
//
//  Created by Timofey Privalov on 17.10.2021.
//

@testable import NetworkingProject
import XCTest

final class MockNetworkService: MovieAPIServiceProtocol {
    var movies: [MovieRealm]?
    var movieDetail: [MovieDetailRealm]?

    init() {}

    convenience init(movie: [MovieDetailRealm]) {
        self.init()
        self.movieDetail = movie
    }

    convenience init(movies: [MovieRealm]) {
        self.init()
        self.movies = movies
    }

    func fetMovies(complition: @escaping (([MovieRealm]) -> Void)) {
        if let movies = movies {
            complition(movies)
        }
    }

    func fetchDetailsFromAPI(id: Int, complition: @escaping ((MovieDetailRealm?) -> ())) {
        if let movieDetail = movieDetail {
            let filteredDetailMovies = movieDetail.filter { $0.id == id }
            guard let filteredDetailMovie = filteredDetailMovies.first else {
                return
            }
            complition(filteredDetailMovie)
            return
        }
    }
}

final class MovieViewModelTest: XCTestCase {
    var movieViewModel: MovieDetailViewModelProtocol!
    var movieAPIservice: MovieAPIServiceProtocol!
    var repository = RealmRepository<MovieRealm>()
    var movies: [MovieRealm] = []

    override func tearDown() {
        movieViewModel = nil
        movieAPIservice = nil
    }

    func testGetMovies() {
        let movieOne = MovieRealm()
        movieOne.id = 44
        movieOne.title = "Test Movie"
        movies.append(movieOne)

        let movieAPIService = MockNetworkService(movies: movies)

        let movieViewModel = MainScreenViewModel(movieAPIService: movieAPIService, repository: repository)

        XCTAssertNotNil(movieViewModel)

        var catchMovies: [MovieRealm]?

        movieAPIService.fetMovies() { result in
            catchMovies = result
            XCTAssertEqual(catchMovies, result)
        }

        let value = catchMovies?.first
        XCTAssertEqual(value?.id, 44)

        XCTAssertNotNil(catchMovies)
        XCTAssertEqual(catchMovies?.count, 1)

        var detailedMovie: MovieDetailRealm?

        movieAPIService.fetchDetailsFromAPI(id: 0) { result in
            detailedMovie = result
            XCTAssertEqual(detailedMovie, result)
        }
    }
}
