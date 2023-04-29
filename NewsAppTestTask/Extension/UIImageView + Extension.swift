//
//  UIImageView + Extension.swift
//  NewsAppTestTask
//
//  Created by Артем Орлов on 28.04.2023.
//

import UIKit

extension UIImageView {
    private static let imageCache = NSCache<NSString, UIImage>()
    
    func loadImage(from url: URL, completion: @escaping (Bool) -> Void) {
        if let cachedImage = UIImageView.imageCache.object(forKey: url.absoluteString as NSString) {
            self.image = cachedImage
            completion(true)
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, let image = UIImage(data: data) else {
                completion(false)
                return
            }
            UIImageView.imageCache.setObject(image, forKey: url.absoluteString as NSString)
            DispatchQueue.main.async {
                self?.image = image
                completion(true)
            }
        }.resume()
    }
}
