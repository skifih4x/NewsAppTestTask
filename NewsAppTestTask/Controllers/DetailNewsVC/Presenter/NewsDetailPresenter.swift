//
//  NewsDetailPresenter.swift
//  NewsAppTestTask
//
//  Created by Артем Орлов on 28.04.2023.
//

import UIKit

protocol NewsDetailView: AnyObject {
    func showArticle(_ article: Article)
    func showFavoriteButton(_ isFavorite: Bool)
}

final class NewsDetailPresenter {
    
    // MARK: - Property
    
    weak var view: NewsDetailView?
    private let article: Article
    private var isFavorite: Bool = false
    
    // MARK: - Init
    
    init(article: Article) {
        self.article = article
    }
    
    // MARK: - Methods
    
    func viewDidLoad() {
        view?.showArticle(article)
        checkIsFavorite()
    }
    
    func addToFavorites() {
        FavoritesManager.shared.addToFavorites(article)
        isFavorite = true
        view?.showFavoriteButton(true)
    }
    
    func checkIsFavorite() {
        isFavorite = FavoritesManager.shared.isFavorite(article)
        view?.showFavoriteButton(isFavorite)
    }
}
