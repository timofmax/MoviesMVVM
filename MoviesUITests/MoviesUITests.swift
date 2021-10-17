//
//  MoviesUITests.swift
//  MoviesUITests
//
//  Created by Timofey Privalov on 18.10.2021.
//

import XCTest

class MoviesUITests: XCTestCase {
    var application: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        application = XCUIApplication()
        application.launch()
    }

    func testMovieTableView() {
        let movieTableView = application.tables["MainTableView"]
        XCTAssertTrue(movieTableView.exists)
        XCTAssertTrue(movieTableView.isEnabled)
        XCTAssertTrue(movieTableView.isHittable)
        XCTAssertFalse(movieTableView.isSelected)
        movieTableView.swipeUp()
        movieTableView.swipeDown()
    }

    func testCellMovieViewController() {
        let movieTableView = application.tables["MainTableView"]
        let cell = movieTableView.cells["MovieTableViewCell"]
        XCTAssertTrue(cell.exists)
        XCTAssertTrue(cell.firstMatch.isHittable)
        cell.firstMatch.tap()
    }

    func testDetailMovieControllerTableView() {
        showDetailScreen()
        let tableView = application.tables["DetailTableView"]
        tableView.swipeUp()
        tableView.swipeDown()
        XCTAssertTrue(tableView.exists)
        XCTAssertTrue(tableView.isEnabled)
    }

    func testCellDetailViewController() {
        showDetailScreen()
        let tableView = application.tables["DetailTableView"]
        let cell = tableView.cells["MovieDetalTableViewCell"]
        XCTAssertTrue(cell.exists)
        XCTAssertTrue(cell.isHittable)
        XCTAssertFalse(cell.isSelected)
        XCTAssertTrue(cell.isEnabled)
    }

    func showDetailScreen() {
        let movieTableView = application.tables["MainTableView"]
        let cell = movieTableView.cells["MovieTableViewCell"]
        cell.firstMatch.tap()
    }
}
