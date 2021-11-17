//
//  News.swift
//  NewsApp
//
//  Created by Nilaakash Singh on 19/11/2021.
//

import Foundation

// MARK: - Welcome
struct News: Codable {
    let breakingNews: String?
    let topNews: [Article]?
    let dailyBriefings: [String: [Article]?]
    let technicalAnalysis: [Article]?
    let specialReport: [Article]?
}

// MARK: - Article
struct Article: Codable {
    let title: String?
    let description: String?
    let url: String?
    let headlineImageURL: String?
    let videoType, videoID: String?
    let videoURL: String?
    let videoThumbnail: String?
    let newsKeywords: String?
    let authors: [Authors]?
    let instruments: [String]?
    let tags: [String]?
    let categories: [String]?
    var regionCode: String?
    let displayTimestamp, lastUpdatedTimestamp: Int?
    
    enum CodingKeys: String, CodingKey {
        case videoThumbnail, newsKeywords, authors, instruments, tags, categories, displayTimestamp, lastUpdatedTimestamp, title, url, videoType, description, regionCode
        case headlineImageURL = "headlineImageUrl"
        case videoID = "videoId"
        case videoURL = "videoUrl"
    }
}

// MARK: - Authors
struct Authors: Codable {
    let name: String?
}
