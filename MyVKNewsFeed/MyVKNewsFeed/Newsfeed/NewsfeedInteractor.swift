//
//  NewsfeedInteractor.swift
//  MyVKNewsFeed
//
//  Created by Eric Grant on 14.03.2020.
//  Copyright (c) 2020 Eric Grant. All rights reserved.
//

import UIKit

protocol NewsfeedBusinessLogic {
  func makeRequest(request: Newsfeed.Model.Request.RequestType)
}

class NewsfeedInteractor: NewsfeedBusinessLogic {

  var presenter: NewsfeedPresentationLogic?
  var service: NewsfeedService?
    
//    // 162.
//    private var revealedPostIds = [Int]()
//    // 162.
//    // 164.
//    private var feedResponse: FeedResponse?
//    // 164.
    
//    // 64.
//    private var fetcher: DataFetcher = NetworkDataFetcher(networking: NetworkService())
//    // 64.
  
  func makeRequest(request: Newsfeed.Model.Request.RequestType) {
    if service == nil {
        service = NewsfeedService()
    }
//    // 46.
//    switch request {
////    case .some:
////        print(".some Interactor")
////    case .getFeed:
////        print(".getFeed Interactor")
////        presenter?.presentData(response: .presentNewsFeed)
////    }
//    // 63.
//    case .getNewsFeed:
//        fetcher.getFeed { [weak self] (feedResponse) in
//
//            // print("feedResponse?.nextFrom: \(feedResponse?.nextFrom)")
////            // 71.
////            feedResponse?.groups.map({ (group) in
////                print("\(group) \n\n")
////            })
////            // 71.
////            // 73
////            feedResponse?.items.map({ (feedItem) in
////                print(feedItem.sourceId)
////            })
////            // 73.
//            // guard let feedResponse = feedResponse else { return }
//            // self?.presenter?.presentData(response: Newsfeed.Model.Response.ResponseType.presentNewsFeed)
//            // self?.presenter?.presentData(response: Newsfeed.Model.Response.ResponseType.presentNewsFeed(feed: feedResponse))
//            self?.feedResponse = feedResponse
//            self?.presentFeed()
//            // print(self?.feedResponse?.nextFrom)
//        }
//    // 63.
//    // 46.
//
//    // 163.
//    case .revealPostIds(let postId):
//        revealedPostIds.append(postId)
//        presentFeed()
//    // 163.
//    // 229.
//    case .getUser:
//        fetcher.getUser { (userResponse) in
//            // 234.
//            self.presenter?.presentData(response: Newsfeed.Model.Response.ResponseType.presentUserInfo(user: userResponse))
//            // 234.
//        }
//    }
//    // 229.
    
    // 253.
    switch request {
    case .getNewsFeed:
        service?.getFeed(completion: { [weak self] (revealedPostIds, feed) in
            self?.presenter?.presentData(response: Newsfeed.Model.Response.ResponseType.presentNewsFeed(feed: feed, revealedPostIds: revealedPostIds))
        })
    case .getUser:
        service?.getUser(completion: { [weak self] (user) in
            self?.presenter?.presentData(response: Newsfeed.Model.Response.ResponseType.presentUserInfo(user: user))
        })
    case .revealPostIds(let postId):
        service?.revealPostIds(forPostId: postId, completion: { [weak self] (revealedPostIds, feed) in
            self?.presenter?.presentData(response: Newsfeed.Model.Response.ResponseType.presentNewsFeed(feed: feed, revealedPostIds: revealedPostIds))
        })
    case .getNextBatch:
        // 269.
        self.presenter?.presentData(response: Newsfeed.Model.Response.ResponseType.presentFooterLoader)
        // 269.
        // 259.
        service?.getNextBatch(completion: { (revealedPostIds, feed) in
            self.presenter?.presentData(response: Newsfeed.Model.Response.ResponseType.presentNewsFeed(feed: feed, revealedPostIds: revealedPostIds))
        })
        // 259.
    }
    // 253.
    }
    
//    // 166.
//    private func presentFeed() {
//        // 165.
//        guard let feedResponse = feedResponse else { return }
//        presenter?.presentData(response: Newsfeed.Model.Response.ResponseType.presentNewsFeed(feed: feedResponse, revealedPostIds: revealedPostIds))
//        // 165.
//    }
//    // 166.
}
