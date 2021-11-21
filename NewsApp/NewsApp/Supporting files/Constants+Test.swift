//
//  Constants+Test.swift
//  NewsApp
//
//  Created by Nilaakash Singh on 21/11/21.
//

import Foundation

// Test data constant
struct TestData {
    static let article1 = Article(title: "GBP/USD Outlook - Sterling Propped Up by Data But US Dollar Strength Controls Cable",
                                 description: "Positive UK retail sales data are helping Sterling push forward but the US dollar is running the show against a range of USD-pairs, including GBP/USD.", url: "https://www.dailyfx.com/forex/market_alert/2021/11/19/GBPUSD-Outlook-Sterling-Propped-Up-by-Data-But-US-Dollar-Strength-Controls-Cable.html",
                                 headlineImageURL: "https://a.c-dn.net/b/25EjrE/headline_UK.jpg",
                                 videoType: nil,
                                 videoID: nil,
                                 videoURL: nil,
                                 videoThumbnail: nil,
                                 newsKeywords: "gbp/usd, sterling, us dollar",
                                 authors: [Authors(name: "Nick Cawley")],
                                 instruments: nil,
                                 tags: ["gbp/usd", "us dollar", "sterling"],
                                 categories: ["forex", "market_alert"],
                                 regionCode: nil,
                                 displayTimestamp: nil,
                                 lastUpdatedTimestamp: nil)
    
    static let article2 = Article(title: "Top News", description: nil, url: nil, headlineImageURL: nil, videoType: nil, videoID: nil, videoURL: nil, videoThumbnail: nil, newsKeywords: nil, authors: nil, instruments: nil, tags: nil, categories: nil, regionCode: nil, displayTimestamp: nil, lastUpdatedTimestamp: nil)
}
