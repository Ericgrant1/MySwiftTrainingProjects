//
//  User.swift
//  MyTaskListFirebase
//
//  Created by Eric Grant on 30.01.2020.
//  Copyright © 2020 Eric Grant. All rights reserved.
//

import Foundation
import Firebase

// 14. Используем struct так как ни отчего не наследуемся
struct UserList {
    
    let uid: String
    let email: String
    
    init(authUser: User) {
        self.uid = authUser.uid
        self.email = authUser.email!
    }
}
// 14.
