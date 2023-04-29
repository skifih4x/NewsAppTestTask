//
//  SceneDelegate.swift
//  NewsAppTestTask
//
//  Created by Артем Орлов on 27.04.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        let tabBar = TabBarController()
        let navigationController = UINavigationController(rootViewController: tabBar)
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
