//
//  HomeViewController.swift
//  NewsApp
//
//  Created by Nilaakash Singh on 19/11/2021.
//

import UIKit
import SwiftUI

class HomeViewController: UIViewController {
    
    // MARK: - Home Section Enum
    private enum HomeSection: Int, CaseIterable {
        case header
        case body
    }
    
    // MARK: - IBOutlet
    @IBOutlet private weak var homeTableView: UITableView!
    
    // MARK: - Variables
    private var viewModel = HomeViewModel()
    private let activityIndicator = UIActivityIndicatorView(style: .medium)
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        setupActivityIndicator()
    }
    
    // MARK: - User Defined Methods
    /// Method to set up activity indicator
    private func setupActivityIndicator() {
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
    }
    
    /// Method to navigate from news list to detail screen
    private func navigateToDetailScreen(article: Article) {
        let homeDetailView = UIHostingController(rootView: HomeDetailsView(viewModel: HomeDetailViewModel(article: article)))
        homeDetailView.title = "Detail"
        navigationController?.pushViewController(homeDetailView, animated: true)
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return HomeSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = HomeSection(rawValue: section) else { return .zero }
        return section == .header ? 1 : viewModel.bodyDataSource().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = HomeSection(rawValue: indexPath.section) else { return UITableViewCell() }
        switch section {
        case .header:
            let cell: TableViewHeaderCell = tableView.dequeueReusableCell(for: indexPath)
            cell.headerCellDelegate = self
            cell.configure(breakingNewsString: viewModel.news?.breakingNews)
            return cell
        case .body:
            let cell: TableViewBodyCell = tableView.dequeueReusableCell(for: indexPath)
            cell.configure(article: viewModel.bodyDataSource()[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let section = HomeSection(rawValue: indexPath.section) else { return }
        if section == .body {
            navigateToDetailScreen(article: viewModel.bodyDataSource()[indexPath.row])
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let section = HomeSection(rawValue: indexPath.section) else { return .zero }
        return section == .header ? 300 : 160
    }
}

// MARK: - Header table view cell Delegate
extension HomeViewController: TableViewHeaderCellDelegate {
    func didChangeSegment(section: NewsTypeSection) {
        viewModel.selectedSegment = section
        homeTableView.reloadSections(IndexSet(integer: HomeSection.body.rawValue), with: .fade)
    }
}

// MARK: - HomeViewModel Delegates
extension HomeViewController: HomeViewModelDelegate {
    func didFetchNewsSuccess() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.removeFromSuperview()
            self.homeTableView.reloadData()
        }
    }
    
    func didFetchNewsFailure(error: Error) {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.removeFromSuperview()
            let alert = UIAlertController(title: "Error!",
                                          message: error.localizedDescription,
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK",
                                          style: .default,
                                          handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.regionWiseArticles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CollectionViewBodyCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.configure(article: viewModel.regionWiseArticles[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width / 1.3, height: 140)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigateToDetailScreen(article: viewModel.regionWiseArticles[indexPath.item])
    }
}
