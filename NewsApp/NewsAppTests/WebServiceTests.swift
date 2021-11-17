//
//  WebServiceTests.swift
//  NewsAppTests
//
//  Created by Nilaakash Singh on 19/11/2021.
//

import XCTest
@testable import NewsApp

class WebServiceTests: XCTestCase {
    
    /// Method to test get method
    func testGetMethod() {

        // Given webservice
        let webServiceInstance = WebService()

        // When fetch all recipes
        let expect = XCTestExpectation(description: "callback")
        
        guard let url = URL(string: LinkConstant.newsPath) else {
            XCTFail()
            return
        }
        webServiceInstance.get(url: url, type: News.self) { result in
            expect.fulfill()
            switch result {
            case .success(let news):
                XCTAssertEqual(news.topNews?.count ?? .zero, 10)
                for new in news.topNews ?? [] {
                    XCTAssertNotNil(new.title)
                }
            case .failure(_):
                // Failure case
                XCTAssertFalse(false)
            }
            self.wait(for: [expect], timeout: 3.1)
        }
    }
}

