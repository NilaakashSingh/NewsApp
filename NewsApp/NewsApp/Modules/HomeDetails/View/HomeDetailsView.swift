//
//  HomeDetailsView.swift
//  NewsApp
//
//  Created by Nilaakash Singh on 19/11/2021.
//

import SwiftUI
import Kingfisher

struct HomeDetailsView: View {
    
    var viewModel: HomeDetailViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                KFImage(URL(string: viewModel.article.headlineImageURL ?? .empty))
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width, alignment: .center)
                
                VStack(alignment: .leading) {
                    contentBody
                    sourceBody
                }
                .padding([.leading, .trailing, .bottom])
            }
            .frame(width: UIScreen.main.bounds.width)
        }
    }
    
    private var contentBody: some View {
        VStack(alignment: .leading, spacing: .zero) {
            Text(viewModel.article.title ?? .empty)
                .font(.title2)
                .foregroundColor(.blue)
            
            if let tagline = viewModel.article.newsKeywords {
                Text(tagline)
                    .font(.subheadline)
                    .foregroundColor(.yellow)
                    .padding(.top, 5)
            }
            
            Text(viewModel.article.description ?? .empty)
                .font(.body)
                .padding(.top)
                .foregroundColor(.gray)
        }
        .padding(.top)
    }
    
    private var sourceBody: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                genreView
                languageView
            }
            
            if !viewModel.allAuthors().isEmpty {
                Text("Authors: \(viewModel.allAuthors())")
                    .padding(.top, 20)
            }
            
            HStack(alignment: .top) {
                if let newsLink = viewModel.article.url,
                   newsLink != .empty {
                    Text("Read More:")
                        .foregroundColor(.white)
                    Button(action: { openURL(urlString: newsLink) },
                           label: { Text(newsLink).multilineTextAlignment(.leading) })
                }
            }
            .padding(.top, 5)
        }
        .padding([.top, .bottom])
    }
}

// MARK: - Supporting Views
extension HomeDetailsView {
    private var genreView: some View {
        VStack {
            if let tags = viewModel.article.tags {
                coloredTitle(title: "Tags")
                ForEach(tags, id: \.self) { tag in
                    coloredSubtitle(subtitle: tag)
                }
            }
        }
    }
    
    private var languageView: some View {
        VStack {
            if let categories = viewModel.article.categories {
                coloredTitle(title: "News Type")
                ForEach(categories, id: \.self) { category in
                    coloredSubtitle(subtitle: category)
                }
            }
        }
    }
    
    private func coloredTitle(title: String) -> some View {
        Text(title)
            .font(.title3)
    }
    
    private func coloredSubtitle(subtitle: String) -> some View {
        Text(subtitle)
            .font(.body)
            .padding()
            .frame(width: UIScreen.main.bounds.width / 2 - 30)
            .background(Color.random())
            .cornerRadius(5)
    }
}

// MARK: - Action Method
extension HomeDetailsView {
    private func openURL(urlString: String?) {
        if let url = URL(string: urlString ?? .empty) {
            UIApplication.shared.open(url)
        }
    }
}

struct HomeDetailsView_Previews: PreviewProvider {
    
    static let article = Article(title: "GBP/USD Outlook - Sterling Propped Up by Data But US Dollar Strength Controls Cable",
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
    
    static var previews: some View {
        HomeDetailsView(viewModel: HomeDetailViewModel(article: article))
    }
}
