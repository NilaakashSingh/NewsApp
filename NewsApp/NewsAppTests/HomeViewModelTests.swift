//
//  HomeViewModelTests.swift
//  NewsAppTests
//
//  Created by Nilaakash Singh on 19/11/2021.
//

import XCTest
@testable import NewsApp
import Foundation

class HomeViewModelTests: XCTestCase {
    
    /// View model instance
    var viewModel: HomeViewModel?
    
    // MARK: - Override methods
    override func setUp() {
        viewModel = HomeViewModel(apiService: MockApiServiceSuccess())
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    // MARK: - Test methods
    /// Method to test success case for service layer
    func testFetchRecipeSuccess() throws {
        viewModel = HomeViewModel(apiService: MockApiServiceSuccess())
        guard let url = URL(string: LinkConstant.newsPath) else {
            XCTFail()
            return
        }
        viewModel?.apiService.get(url: url, type: News.self, completion: { result in
            switch result {
            case .success(let news):
                XCTAssertEqual(news.topNews?.count ?? .zero, 2)
            case .failure(_):
                XCTFail()
            }
        })
    }
    
    /// Method to test failure case for service layer
    func testFetchRecipeFailure() throws {
        viewModel = HomeViewModel(apiService: MockApiServiceFailure())
        guard let url = URL(string: LinkConstant.newsPath) else {
            XCTFail()
            return
        }
        viewModel?.apiService.get(url: url, type: News.self, completion: { result in
            switch result {
            case .success(let news):
                XCTAssertEqual(news.topNews?.count ?? .zero, 2)
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, APIError.emptyData.localizedDescription)
            }
        })
    }
    
    /// Method to check wrong url
    func testWrongURL() {
        viewModel = HomeViewModel(apiService: MockApiServiceFailure())
        viewModel?.fetchNews(path: .empty)
    }
    
    // Methods to test body data source method
    func testTechnicalAnalysisBodyDataSourceCase() {
        viewModel = HomeViewModel()
        // Check for zero articles in technical analysis
        viewModel?.selectedSegment = .technicalAnalysis
        XCTAssertEqual(viewModel?.bodyDataSource().count, .zero)
    }
    
    func testSpecialReportBodyDataSourceCase() {
        // Check for some articles in special report
        viewModel = HomeViewModel()
        let news = News(breakingNews: "Breaking News", topNews: nil, dailyBriefings: ["EU" : nil], technicalAnalysis: nil, specialReport: [TestData.article1, TestData.article2])
        viewModel?.news = news
        viewModel?.selectedSegment = .specialReport
        XCTAssertEqual(viewModel?.bodyDataSource().count, 2)
    }
}

// MARK: - MockApiServiceSuccess Class
/// Success Mock class for APIServiceProtocol
class MockApiServiceSuccess: APIServiceProtocol {
    func get<T>(url: URL, type: T.Type, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable, T : Encodable {
        // The other way to populate data is via local json for quick concept demo, I took making instance of article objects approach        
        let news = News(breakingNews: "Breaking News", topNews: [TestData.article1, TestData.article2], dailyBriefings: ["EU" : [TestData.article1]], technicalAnalysis: nil, specialReport: nil)
        
        let result = news.self
        completion(.success(result as! T))
    }
}

// MARK: - MockApiServiceSuccess Class
/// Failure Mock class for APIServiceProtocol
class MockApiServiceFailure: APIServiceProtocol {
    func get<T>(url: URL, type: T.Type, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable, T : Encodable {
        completion(.failure(APIError.emptyData))
    }
}
