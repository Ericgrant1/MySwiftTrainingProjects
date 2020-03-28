//
//  UserResponse.swift
//  MyVKNewsFeed
//
//  Created by Eric Grant on 24.03.2020.
//  Copyright © 2020 Eric Grant. All rights reserved.
//

import Foundation
import UIKit

// 222.
struct UserResponseWrapper: Decodable {
    let response: [UserResponse]
}

struct UserResponse: Decodable {
    let photo100: String
}
// 222.
