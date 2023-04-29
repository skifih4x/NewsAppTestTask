//
//  NewsPresenter.swift
//  NewsAppTestTask
//
//  Created by Артем Орлов on 27.04.2023.
//

import Foundation

protocol  NewsView: AnyObject {
    func setArticles(_ articles: [News])
    func showError(_ error: Error)
}

final class NewsPresenter {
    
    private let networkService = NetworkService()
    weak var view:  NewsView?
    
    private var currentPage = 1
    private var totalPage = 1
    private var isLoading = false
    var articles: [News] = []
    
    init(view:  NewsView) {
        self.view = view
    }
    
    func viewDidLoad() {
        fetchArticles()
    }
    
    func fetchArticles() {
        guard !isLoading else { return }
        isLoading = true
        networkService.fetchArticles(page: currentPage) { [weak self] result in
            guard let self = self else { return }
            self.isLoading = false
            switch result {
            case .success(let response):
                self.totalPage = response.totalResults / 10 + (response.totalResults % 20 == 0 ? 0 : 1)
                self.currentPage += 1
                self.articles += response.articles
                self.view?.setArticles(self.articles)
            case .failure(let error):
                self.view?.showError(error)
            }
        }
    }
    
    func loadMoreArticlesIfNeeded(currentIndex: Int, totalArticles: Int) {
        
        guard currentIndex == totalArticles - 1 && currentPage <= totalPage else { return }
        fetchArticles()
    }
}
