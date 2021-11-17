//
//  HomeDetailViewModel.swift
//  NewsApp
//
//  Created by Nilaakash Singh on 19/11/2021.
//

import Foundation

// MARK: - Home Detail View Model Class
class HomeDetailViewModel {
    // MARK: - Variables
    let article: Article
    
    // MARK: - Initialiser
    init(article: Article) {
        self.article = article
    }
    
    // Method to get all authors of article
    func allAuthors() -> String {
        guard let authorsName = article.authors?.compactMap({ $0.name }) else { return .empty }
        return authorsName.joined(separator: .commaWithSpace)
    }
}

