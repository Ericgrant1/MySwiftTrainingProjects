//
//  FeedViewController.swift
//  MyVKNewsFeed
//
//  Created by Eric Grant on 12.03.2020.
//  Copyright © 2020 Eric Grant. All rights reserved.
//

//import UIKit
//
//// 13.
//class FeedViewController: UIViewController {
//
////    // 24.
////    private let networkService: Networking = NetworkService() // подписали под Протокол
////    // 24.
//    // 39.
//    private var fetcher: DataFetcher = NetworkDataFetcher(networking: NetworkService())
//    // 39.
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        view.backgroundColor = .systemBlue
//        // 40.
//        fetcher.getFeed { (feedResponse) in
//            guard let feedResponse = feedResponse else { return }
//            feedResponse.items.map { (feedItem) in
//                print(feedItem.date)
//            }
//        }
//        // 40.
//
//
////        // 25.
////        // 32.
////        let parameters = ["filters": "post, photo"]
////        networkService.request(path: APIVK.newsFeed, parameters: parameters) { (data, error) in
////            if let error = error {
////                print("Error received requesting data: \(error.localizedDescription)")
////            }
////            // 34.
////            let decoder = JSONDecoder()
////            decoder.keyDecodingStrategy = .convertFromSnakeCase
////            // 34.
////
////            guard let data = data else { return }
//////            let json = try? JSONSerialization.jsonObject(with: data, options: [])
//////            print("json: \(json)")
////            // 35.
////            let response = try? decoder.decode(FeedResponseWrapped.self, from: data)
////            // 35.
////        // 32.
////        } // getFeed()
////        // 25.
//    }
//}
//// 13.
