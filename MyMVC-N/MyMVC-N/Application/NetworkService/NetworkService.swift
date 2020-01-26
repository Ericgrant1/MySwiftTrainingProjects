//
//  NetworkService.swift
//  MyMVC-N
//
//  Created by Eric Grant on 25.01.2020.
//  Copyright © 2020 Eric Grant. All rights reserved.
//

import Foundation

// 4. Singleton. Общий менеджер не имеющий конкретного представления
class NetworkService {
    
    private init() {}
    static let shared = NetworkService()
    
    public func getData(url: URL, completion: @escaping (Any) -> ()) {
        let session = URLSession.shared
        
        session.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                // print(json)
                // 11. Обновление интерфейса в главном потоке
                DispatchQueue.main.async {
                    completion(json)
                }
                // 11.
            } catch {
                print(error)
            }
        }.resume()
    }
}
// 4.
