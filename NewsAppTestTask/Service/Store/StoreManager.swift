//
//  StoreManager.swift
//  NewsAppTestTask
//
//  Created by Артем Орлов on 29.04.2023.
//

import Foundation

class FavoritesManager {
    
    static let shared = FavoritesManager()
    private var favorites: [Article] = []
    
    init() {
        loadFavorites()
    }
    
    func addToFavorites(_ article: Article) {
        if !isFavorite(article) {
            favorites.append(article)
            saveFavorites()
        }
    }
    
    private func saveFavorites() {
        let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("favorites")
        let data = try! JSONEncoder().encode(favorites)
        try! data.write(to: fileURL)
        print(fileURL)
    }
    
    private func loadFavorites() {
        let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("favorites")
        let data = try? Data(contentsOf: fileURL)
        if let data = data, let articles = try? JSONDecoder().decode([Article].self, from: data) {
            favorites = articles
            print(favorites)
        }
    }
    
    func isFavorite(_ article: Article) -> Bool {
        return favorites.contains(where: { $0.title == article.title })
    }

    func removeFromFavorites(_ article: Article) {
        if let index = favorites.firstIndex(where: { $0.title == article.title }) {
            favorites.remove(at: index)
            saveFavorites()
        }
    }
    
    func getFavorites() -> [Article] {
        return favorites
    }
}
