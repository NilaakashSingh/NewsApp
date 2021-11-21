//
//  HomeDetailsViewModelTests.swift
//  NewsAppTests
//
//  Created by Nilaakash Singh on 21/11/21.
//

import XCTest
@testable import NewsApp

class HomeDetailsViewModelTests: XCTestCase {
    
    /// View model instance
    var viewModel: HomeDetailViewModel?

    // MARK: - Override methods
    override func setUp() {
        viewModel = HomeDetailViewModel(article: TestData.article1)
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    // Method to test all authors
    func testAllAuthors() {
        viewModel = HomeDetailViewModel(article: TestData.article1)
        XCTAssertEqual(viewModel?.allAuthors(), "Nick Cawley")
        viewModel = HomeDetailViewModel(article: TestData.article2)
        XCTAssertEqual(viewModel?.allAuthors(), StringLiteralType.empty)
    }

}
