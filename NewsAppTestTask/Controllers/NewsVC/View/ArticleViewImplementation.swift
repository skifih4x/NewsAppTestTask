//
//  ArticleViewImplementation.swift
//  NewsAppTestTask
//
//  Created by Артем Орлов on 29.04.2023.
//

final class ArticleViewImplementation:  NewsView {
    
    weak var delegate:  NewsView?

    func setArticles(_ articles: [News]) {
        delegate?.setArticles(articles)
    }

    func showError(_ error: Error) {
        delegate?.showError(error)
    }
}
