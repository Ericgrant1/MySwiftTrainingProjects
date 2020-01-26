//
//  GetCommentResponse.swift
//  MyMVC-N
//
//  Created by Eric Grant on 25.01.2020.
//  Copyright © 2020 Eric Grant. All rights reserved.
//

import Foundation

// 7.
struct GetCommentResponse {
    
    typealias JSON = [String: AnyObject]
    let comments: [Comment]
    
    init(json: Any) throws {
        guard let array = json as? [JSON] else { throw NetworkError.failInterentError }
        
        var comments = [Comment]()
        for dictionary in array {
            guard let comment = Comment(dict: dictionary) else { continue }
            comments.append(comment)
        }
        self.comments = comments
    }
}
// 7.
