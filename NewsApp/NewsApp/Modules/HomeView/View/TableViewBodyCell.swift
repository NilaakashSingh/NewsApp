//
//  TableViewBodyCell.swift
//  NewsApp
//
//  Created by Nilaakash Singh on 19/11/2021.
//

import UIKit
import Kingfisher

class TableViewBodyCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var newsImage: UIImageView!
    @IBOutlet private weak var newsTitle: UILabel!
    
    // MARK: - Configure Method
    func configure(article: Article) {
        if let imageUrl = URL(string: article.headlineImageURL ?? .empty) {
            newsImage.kf.setImage(with: imageUrl)
        }
        newsTitle.text = article.title ?? .empty
    }
}
