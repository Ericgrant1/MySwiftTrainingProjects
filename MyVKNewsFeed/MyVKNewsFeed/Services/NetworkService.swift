//
//  NetworkService.swift
//  MyVKNewsFeed
//
//  Created by Eric Grant on 12.03.2020.
//  Copyright © 2020 Eric Grant. All rights reserved.
//

import Foundation

// 28.
protocol Networking {
    func request(path: String, parameters: [String: String], completion: @escaping (Data?, Error?) -> Void)
}
// 28.

// 16.
final class NetworkService: Networking { // 28.1 подписали под Протокол
    
    // 20.
    private let authenticationService: AuthenticationService
    
    init(authenticationService: AuthenticationService = SceneDelegate.shared().authenticationService) {
        self.authenticationService = authenticationService
    }
    // 20.
    
    // 29. Получение данных
    func request(path: String, parameters: [String : String], completion: @escaping (Data?, Error?) -> Void) {
        // 21.
        guard let token = authenticationService.token else { return }
        // 21.
        // 18.
        // let parameters = ["filters": "post,photo"]
        var allParameters = parameters
        allParameters["access_token"] = token // 21.1 = token
        allParameters["v"] = APIVK.version
        // 18.
        // 27.
        let url = self.url(from: path, parameters: allParameters) // заменяем APIVK.newsFeed на path
        // 27.
        // 30.
        // let session = URLSession.init(configuration: .default) - delete
        let request = URLRequest(url: url)
        let task = createDataTask(from: request, completion: completion)// session.dataTask(with: request) { (data, response, error) in
//            DispatchQueue.main.async {
//                completion(data, error)
//            }
//        }
        task.resume()
        // 30.
        // 23.
        // let url = components.url!
        print(url)
        // 23.
    }
    // 29.
    
//    func getFeed() {
//        // https://api.vk.com/method/users.get?user_ids=210700286&fields=bdate&access_token=533bacf01e11f55b536a565b57531ac114461ae8736d6506a3&v=5.103
//
//    }
    
    // 31.
    private func createDataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
    }

    // 31.
    
    // 26.
    private func url(from path: String, parameters: [String: String]) -> URL {
        var components = URLComponents()
        components.scheme = APIVK.scheme
        components.host = APIVK.host
        components.path = path // APIVK.newsFeed
        // 22.
        components.queryItems = parameters.map { URLQueryItem(name: $0, value: $1) } // изменили allParameters на parameters
        // 22.
        
        return components.url!
    }
    // 26.
}
// 16.
