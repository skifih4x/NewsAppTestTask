//
//  FavoritesPresenter.swift
//  NewsAppTestTask
//
//  Created by Артем Орлов on 28.04.2023.
//

import Foundation

protocol FavoritesView: AnyObject {
    func showFavorites(_ favorites: [Article])
}

final class FavoritesPresenter {
    
    // MARK: - Property
    
    private let favoritesManager: FavoritesManager
    weak var view: FavoritesView?
    var favorites: [Article] = []
    
    // MARK: - Init
    
    init(favoritesManager: FavoritesManager) {
        self.favoritesManager = favoritesManager
    }
    
    // MARK: - Methods
    
    func addToFavorites(_ article: Article) {
        favoritesManager.addToFavorites(article)
        favorites = favoritesManager.getFavorites()
        view?.showFavorites(favorites)
    }

    func viewDidLoad() {
        let favorites = favoritesManager.getFavorites()
        view?.showFavorites(favorites)
    }
    
    func removeFromFavorites(_ article: Article) {
        favoritesManager.removeFromFavorites(article)
        let favorites = favoritesManager.getFavorites()
        view?.showFavorites(favorites)
    }
}
