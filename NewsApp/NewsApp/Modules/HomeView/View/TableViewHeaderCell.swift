//
//  TableViewHeaderCell.swift
//  NewsApp
//
//  Created by Nilaakash Singh on 19/11/2021.
//

import UIKit

// MARK: - Table view header cell view delegate
protocol TableViewHeaderCellDelegate: AnyObject {
    func didChangeSegment(section: NewsTypeSection)
}

class TableViewHeaderCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var newsTypeSegmentControl: UISegmentedControl!
    @IBOutlet private weak var regionCollectionView: UICollectionView!
    @IBOutlet private weak var breakingNewsLabel: UILabel!
    @IBOutlet private weak var breakingNewsView: UIView!
    @IBOutlet private weak var breakingNewsViewHeight: NSLayoutConstraint!
    
    // MARK: - Variables
    weak var headerCellDelegate: TableViewHeaderCellDelegate?
    private var articleArray = [Article]()
        
    // MARK: - Configure method
    func configure(breakingNewsString: String?) {
        setupBreakingNewsString(string: breakingNewsString)
        regionCollectionView.reloadData()
    }
    
    /// Setting up breaking news string label
    private func setupBreakingNewsString(string: String?) {
        if let breakingNewsString = string {
            breakingNewsLabel.text = breakingNewsString
            breakingNewsLabel.blink(duration: 2)
            breakingNewsView.isHidden = false
            breakingNewsViewHeight.constant = 70
        } else {
            breakingNewsView.isHidden = true
            breakingNewsViewHeight.constant = .zero
        }
    }
    
    // MARK: - User Action
    @IBAction func didChangeNewsSection(_ sender: UISegmentedControl) {
        guard let newSection = NewsTypeSection(rawValue: sender.selectedSegmentIndex) else { return }
        headerCellDelegate?.didChangeSegment(section: newSection)
    }
}
