//
//  FeedResponse.swift
//  MyVKNewsFeed
//
//  Created by Eric Grant on 13.03.2020.
//  Copyright © 2020 Eric Grant. All rights reserved.
//

import Foundation

// 33. Описание формата в котором приходят данные
struct FeedResponseWrapped: Decodable {
    let response: FeedResponse
}

struct FeedResponse: Decodable {
    var items: [FeedItem]
    // 69.
    var profiles: [Profile]
    var groups: [Group]
    // 69.
    // 250.
    var nextFrom: String?
    // 250.
}

struct FeedItem: Decodable {
    let sourceId: Int
    let postId: Int
    let text: String?
    let date: Double
    let comments: CountableItem?
    let likes: CountableItem?
    let reposts: CountableItem?
    let views: CountableItem?
    // 83.
    let attachments: [Attachment]?
    // 83.
}

// 84.
struct Attachment: Decodable {
    let photo: Photo?
}

struct Photo: Decodable {
    let sizes: [PhotoSize]
    
    // 86.
    var height: Int {
        return getProperSize().height
    }
    
    var width: Int {
        return getProperSize().width
    }
    
    var scrBIG: String {
        return getProperSize().url
    }
    // 86.
    
    // 85.
    private func getProperSize() -> PhotoSize {
        if let sizeX = sizes.first(where: { $0.type == "x" }) {
            return sizeX
        } else if let fallBackSize = sizes.last {
            return fallBackSize
        } else {
            return PhotoSize(type: "wrong image", url: "wrong image", width: 0, height: 0)
        }
    }
    // 85.
}

struct PhotoSize: Decodable {
    let type: String
    let url: String
    let width: Int
    let height: Int
}
// 84.

struct CountableItem: Decodable {
    let count: Int
}
// 33.

// 71.
protocol ProfileRepresented {
    var id: Int { get }
    var name: String { get }
    var photo: String { get }
}
// 71.
// 70.
struct Profile: Decodable, ProfileRepresented {
    
    let id: Int
    let firstName: String
    let lastName: String
    let photo100: String

    var name: String { return firstName + " " + lastName}
    
    var photo: String { return photo100 }
}

struct Group: Decodable, ProfileRepresented {
    
    let id: Int
    let name: String
    let photo100: String

    var photo: String { return photo100 }
}
// 70.
