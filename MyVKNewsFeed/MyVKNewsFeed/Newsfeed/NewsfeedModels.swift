//
//  NewsfeedModels.swift
//  MyVKNewsFeed
//
//  Created by Eric Grant on 14.03.2020.
//  Copyright (c) 2020 Eric Grant. All rights reserved.
//

import UIKit

enum Newsfeed {
  
    //
  enum Model {
    struct Request {
      enum RequestType {
//        case some
//        // 44.
//        case getFeed
//        // 44.
        // 62.
        case getNewsFeed
        // 62.
        // 227.
        case getUser
        // 227.
        // 161.
        case revealPostIds(postId: Int)
        // 161.
        // 254.
        case getNextBatch
        // 254.
      }
    }
    struct Response {
      enum ResponseType {
//        case some
        // 47.
        case presentNewsFeed(feed: FeedResponse, revealedPostIds: [Int]) // + (feed: FeedResponse) +  revealedPostIds: [Int]
        // 47.
        // 233.
        case presentUserInfo(user: UserResponse?)
        // 233.
        // 267.
        case presentFooterLoader
        // 2367.
      }
    }
    struct ViewModel {
      enum ViewModelData {
//        case some
        // 49.
        case displayNewsfeed(feedViewModel: FeedViewModel) // +(feedViewModel: FeedViewModel)
        // 49.
        // 236.
        case displayUser(userViewModel: UserViewModel)
        // 236.
        // 268.
        case displayFooterLoader
        // 268.
      }
    }
  }
}

// 232.
struct UserViewModel: TitleViewViewModel {
    var photoUrlString: String?
}
// 232.

// 58.
struct FeedViewModel {
    struct Cell: FeedCellViewModel {
        var postId: Int // 161.1
        var iconUrlString: String
        var name: String
        var date: String
        var text: String?
        var likes: String?
        var comments: String?
        var shares: String?
        var views: String?
        var photoAttachments: [FeedCellPhotoAttachmentViewModel]
        // var photoAttachment: FeedCellPhotoAttachmentViewModel? // 87.2
        var sizes: FeedCellSizes // 94.2
    }
    
    // 88.
    struct FeedCellPhotoAttachment: FeedCellPhotoAttachmentViewModel {
        var photoUrlString: String?
        var width: Int
        var height: Int
    }
    // 88.
    
    let cells: [Cell]
    // 273.
    let footerTitle: String?
    // 273.
    
}
// 58.
