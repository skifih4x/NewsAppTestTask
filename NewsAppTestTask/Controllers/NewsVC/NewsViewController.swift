//
//  NewsViewController.swift
//  NewsAppTestTask
//
//  Created by Артем Орлов on 27.04.2023.
//

import UIKit

final class NewsViewController: UIViewController {
    
    // MARK: - UI
    
    private let tableView = UITableView()
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    // MARK: - Property
    
    private let articlePresenter = NewsPresenter(view: ArticleViewImplementation())
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        articlePresenter.view = self
        articlePresenter.viewDidLoad()
        setupUI()

    }
    
    // MARK: - Private methods
    
    private func startLoading() {
        activityIndicator.startAnimating()
    }
    
    private func stopLoading() {
        activityIndicator.stopAnimating()
    }
}

// MARK: - UITableViewDataSource

extension NewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articlePresenter.articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as? NewsCell else {
            return UITableViewCell()
        }
        let article = articlePresenter.articles[indexPath.row]
        cell.configure(with: article)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension NewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let article = articlePresenter.articles[indexPath.row]
        let vc = DetailNewsViewController(article: article)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: footerView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: footerView.centerYAnchor)
        ])
        return footerView
    }
}

// MARK: - UIScrollView

extension NewsViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let frameHeight = scrollView.frame.height
        
        if let lastIndexPath = tableView.indexPathsForVisibleRows?.last {
            let currentIndex = lastIndexPath.row
            let totalArticles = articlePresenter.articles.count
            
            if offsetY > contentHeight - frameHeight {
                startLoading()
                articlePresenter.loadMoreArticlesIfNeeded(currentIndex: currentIndex, totalArticles: totalArticles)
            } else {
                stopLoading()
            }
        }
    }
}

// MARK: - ArticleViewProtocol

extension NewsViewController:  NewsView {
    func setArticles(_ articles: [News]) {
        DispatchQueue.main.async {
            self.articlePresenter.articles = articles
            self.tableView.reloadData()
        }
    }
    
    func showError(_ error: Error) {
        let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}

// MARK: - SetLayout

extension NewsViewController {
    private func setupUI() {
        view.addSubview(tableView)
        view.addSubview(activityIndicator)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(NewsCell.self, forCellReuseIdentifier: "ArticleCell")
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}
