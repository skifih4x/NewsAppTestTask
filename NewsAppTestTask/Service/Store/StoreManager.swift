//
//  StoreManager.swift
//  NewsAppTestTask
//
//  Created by Артем Орлов on 29.04.2023.
//

import Foundation

class FavoritesManager {
    
    static let shared = FavoritesManager()
    private var favorites: [News] = []
    
    init() {
        loadFavorites()
    }
    
    func addToFavorites(_ article: News) {
        if !isFavorite(article) {
            favorites.append(article)
            saveFavorites()
        }
    }
    
    private func saveFavorites() {
        guard let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("favorites") else {
            return
        }
        do {
            let data = try JSONEncoder().encode(favorites)
            try data.write(to: fileURL)
            print(fileURL)
        } catch {
            print("Error saving favorites: \(error.localizedDescription)")
        }
    }

    private func loadFavorites() {
        guard let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("favorites") else {
            return
        }
        do {
            let data = try Data(contentsOf: fileURL)
            if let articles = try? JSONDecoder().decode([News].self, from: data) {
                favorites = articles
                print(favorites)
            }
        } catch {
            print("Error loading favorites: \(error.localizedDescription)")
        }
    }

    
    func isFavorite(_ article: News) -> Bool {
        return favorites.contains(where: { $0.title == article.title })
    }

    func removeFromFavorites(_ article: News) {
        if let index = favorites.firstIndex(where: { $0.title == article.title }) {
            favorites.remove(at: index)
            saveFavorites()
        }
    }
    
    func getFavorites() -> [News] {
        return favorites
    }
}
