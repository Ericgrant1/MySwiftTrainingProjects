//
//  WebImageView.swift
//  MyVKNewsFeed
//
//  Created by Eric Grant on 16.03.2020.
//  Copyright © 2020 Eric Grant. All rights reserved.
//

import UIKit

// 78.
class WebImageView: UIImageView {
    
    // 245.
    private var currentUrlString: String?
    // 245.
    
    func set(imageURL: String?) {
        // 246. доступ к ссыке на фотографию
        currentUrlString = imageURL
        // 246.
        guard let imageURL = imageURL, let url = URL(string: imageURL) else {
            // 111.
            self.image = nil
            // 111.
            return }
        
        // 80. Проверка изображения в Кэш
        if let cachedResponse = URLCache.shared.cachedResponse(for: URLRequest(url: url)) {
            self.image = UIImage(data: cachedResponse.data)
            print("from cache")
            return
        }
        
        print("from internet")
        // 80.
        
        let dataTask = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            
            DispatchQueue.main.async {
                if let data = data, let response = response {
                    // self?.image = UIImage(data: data)
                    // 82.
                    self?.handleLoadedImage(data: data, response: response)
                    // 82.
                }
            }
        }
        dataTask.resume()
    }
    
    // 81.
    private func handleLoadedImage(data: Data, response: URLResponse) {
        guard let responseURL = response.url else { return }
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: URLRequest(url: responseURL))
        
        // 247.
        if responseURL.absoluteString == currentUrlString {
            self.image = UIImage(data: data)
        }
        // 247.
    }
    // 81.
}
// 78.
