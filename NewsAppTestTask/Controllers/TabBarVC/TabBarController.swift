//
//  TabBarController.swift
//  NewsAppTestTask
//
//  Created by Артем Орлов on 27.04.2023.
//

import UIKit

final class TabBarController: UITabBarController {
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTabBarItem()
    }
}

// MARK: - SetupUI layout

extension TabBarController {
    private func setupTabBarItem() {
        let newsVC = NewsViewController()
        let favoritesPresenter = FavoritesPresenter(favoritesManager: FavoritesManager.shared)
        let favoritesVC = FavoritesNewsViewController(presenter: favoritesPresenter)
        
        newsVC.tabBarItem = UITabBarItem(title: "News", image: UIImage(systemName: "newspaper"), selectedImage: UIImage(systemName: "newspaper.fill"))
        favoritesVC.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "star"), selectedImage: UIImage(systemName: "star.fill"))
        
        self.viewControllers = [newsVC, favoritesVC]
    }
    
    private func setupUI() {
        title = "News App"
        tabBar.isTranslucent = false
        tabBar.backgroundColor = .systemBackground
    }
}
