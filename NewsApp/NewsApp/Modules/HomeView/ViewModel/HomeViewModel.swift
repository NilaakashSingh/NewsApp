//
//  HomeViewModel.swift
//  NewsApp
//
//  Created by Nilaakash Singh on 19/11/2021.
//

import Foundation

// MARK: - Home view delegate
protocol HomeViewModelDelegate: AnyObject {
    /// Delegate method can be used once array is successfully fetched
    func didFetchNewsSuccess()
    /// Delegate method to handle array
    func didFetchNewsFailure(error: Error)
}

// MARK: - Home view news type segment section
enum NewsTypeSection: Int {
    case topNews
    case technicalAnalysis
    case specialReport
}

// MARK: - Home View Model
class HomeViewModel {
    
    // MARK: - Variables
    /// Recipe array
    var news: News?
    /// API Service Protocol
    let apiService: APIServiceProtocol
    /// Home view delegate
    weak var delegate: HomeViewModelDelegate?
    /// Segment section
    var selectedSegment: NewsTypeSection = .topNews
    /// Region Wise Article Array
    var regionWiseArticles = [Article]()
    
    // MARK: - Initializer
    /// Intializer
    init(apiService: APIServiceProtocol = WebService()) {
        self.apiService = apiService
        fetchNews()
    }
    
    // MARK: - User Defined Methods
    func bodyDataSource() -> [Article] {
        switch selectedSegment {
        case .topNews:
            return news?.topNews ?? []
        case .technicalAnalysis:
            return news?.technicalAnalysis ?? []
        default:
            return news?.specialReport ?? []
        }
    }
    
    private func generateRegionWiseArticle() {
        var article = [Article]()
        news?.dailyBriefings.keys.forEach({ key in
            if let regionArticleArray = news?.dailyBriefings[key],
               var unwrappedArticle = regionArticleArray?.first {
                unwrappedArticle.regionCode = key
                article.append(unwrappedArticle)
            }
        })
        regionWiseArticles = article
    }
}

// MARK: - Extension to fetch news data
extension HomeViewModel {
    /// Method to fetch news data
    func fetchNews(path: String = LinkConstant.newsPath) {
        guard let recipeURLComponent = URL(string: path) else { return }
        apiService.get(url: recipeURLComponent, type: News.self) { [weak self] result in
            switch result {
            case .success(let news):
                self?.news = news
                self?.generateRegionWiseArticle()
                self?.delegate?.didFetchNewsSuccess()
            case .failure(let error):
                self?.delegate?.didFetchNewsFailure(error: error)
            }
        }
    }
}
