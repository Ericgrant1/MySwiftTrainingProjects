//
//  NetworkDataFetcher.swift
//  MyVKNewsFeed
//
//  Created by Eric Grant on 13.03.2020.
//  Copyright © 2020 Eric Grant. All rights reserved.
//

import Foundation

// 36. Преобразование данных JSON в формат который нам нужен
protocol DataFetcher {
    func getFeed(nextBatchFrom: String?, response: @escaping (FeedResponse?) -> Void) // + nextBatchFrom: String?
    
    // 224.
    func getUser(response: @escaping (UserResponse?) -> Void)
    // 224.
}

struct NetworkDataFetcher: DataFetcher {
    
    // 226.
    private let authenticationService: AuthenticationService
    // 226.
    
    let networking: Networking
    
    init(networking: Networking, authenticationService: AuthenticationService = SceneDelegate.shared().authenticationService) {
        self.networking = networking
        self.authenticationService = authenticationService
    } // + authenticationService:
    
    // 225.
    func getUser(response: @escaping (UserResponse?) -> Void) {
        guard let userId = authenticationService.userId else { return }
        let parameters = ["user_ids": userId, "fields": "photo_100"]
        networking.request(path: APIVK.user, parameters: parameters) { (data, error) in
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
                response(nil)
            }
            
            let decoded = self.decodeJSON(type: UserResponseWrapper.self, from: data)
            response(decoded?.response.first)
        }
    }
    // 225.
    
    func getFeed(nextBatchFrom: String?, response: @escaping (FeedResponse?) -> Void) {
        
        var parameters = ["filters": "post, photo"]
        // 258.
        parameters["start_from"] = nextBatchFrom
        // 258.
        networking.request(path: APIVK.newsFeed, parameters: parameters) { (data, error) in
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
                response(nil)
            }
            // 38.
            let decoded = self.decodeJSON(type: FeedResponseWrapped.self, from: data)
            response(decoded?.response)
            // 38.
        } // + nextBatchFrom: String?
    }
    // 37.
    private func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let data = from, let response = try? decoder.decode(type.self, from: data) else { return nil }
        return response
    }
    // 37.
}
// 36.
