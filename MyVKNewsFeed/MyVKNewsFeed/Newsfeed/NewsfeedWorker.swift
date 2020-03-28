//
//  NewsfeedWorker.swift
//  MyVKNewsFeed
//
//  Created by Eric Grant on 14.03.2020.
//  Copyright (c) 2020 Eric Grant. All rights reserved.
//

import UIKit

class NewsfeedService {
    
    // 252.
    var authService: AuthenticationService
    var networking: Networking
    var fetcher: DataFetcher
    
    private var revealedPostIds = [Int]()
    private var feedResponse: FeedResponse?
    // 257.
    private var newFromInProcess: String?
    // 257.
    
    init() {
        self.authService = SceneDelegate.shared().authenticationService
        self.networking = NetworkService(authenticationService: authService)
        self.fetcher = NetworkDataFetcher(networking: networking)
    }
    
    func getUser(completion: @escaping (UserResponse?) -> Void) {
        fetcher.getUser { (userResponse) in
            completion(userResponse)
        }
    }
    
    func getFeed(completion: @escaping ([Int], FeedResponse) -> Void) {
        fetcher.getFeed(nextBatchFrom: nil) { [weak self] (feed) in
            self?.feedResponse = feed
            guard let feedResponse = self?.feedResponse else { return }
            completion(self!.revealedPostIds, feedResponse)
        }
    }
    
    func revealPostIds(forPostId postId: Int, completion: @escaping ([Int], FeedResponse) -> Void) {
        revealedPostIds.append(postId)
        guard let feedResponse = self.feedResponse else { return }
        completion(revealedPostIds, feedResponse)
    }
    // 252.
    
    // 256.
    func getNextBatch(completion: @escaping ([Int], FeedResponse) -> Void) {
        newFromInProcess = feedResponse?.nextFrom
        fetcher.getFeed(nextBatchFrom: newFromInProcess) { [weak self] (feed) in
            guard let feed = feed else { return }
            // 260. проверка совпадения ключей загрузки новой ленты с предыдущей
            guard self?.feedResponse?.nextFrom != feed.nextFrom else { return }
            
            if self?.feedResponse == nil {
                self?.feedResponse = feed
            } else {
                self?.feedResponse?.items.append(contentsOf: feed.items)
//                self?.feedResponse?.profiles = feed.profiles
//                self?.feedResponse?.groups = feed.groups
                
                var profiles = feed.profiles
                if let oldProfiles = self?.feedResponse?.profiles {
                    let oldProfilesFiltered = oldProfiles.filter { (oldProfile) -> Bool in
                        !feed.profiles.contains(where: { $0.id == oldProfile.id })
                    }
                    profiles.append(contentsOf: oldProfilesFiltered)
                }
                self?.feedResponse?.profiles = profiles
                
                var groups = feed.groups
                if let oldGroups = self?.feedResponse?.groups {
                    let oldGroupsFiltered = oldGroups.filter { (oldGroup) -> Bool in
                        !feed.groups.contains(where: { $0.id == oldGroup.id })
                    }
                    groups.append(contentsOf: oldGroupsFiltered)
                }
                self?.feedResponse?.groups = groups
                self?.feedResponse?.nextFrom = feed.nextFrom
            }
            
            guard let feedResponse = self?.feedResponse else { return }
            completion(self!.revealedPostIds, feedResponse)
            // 260.
        }
    }
    // 256.

}
