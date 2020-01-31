//
//  Task.swift
//  MyTaskListFirebase
//
//  Created by Eric Grant on 30.01.2020.
//  Copyright © 2020 Eric Grant. All rights reserved.
//

import Foundation
import Firebase

// 15.
struct Task {
    let title: String
    let userId: String
    let ref: DatabaseReference?
    var completed: Bool = false
    
    init(title: String, userID: String) {
        self.title = title
        self.userId = userID
        self.ref = nil
    }
    
    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        title = snapshotValue["title"] as! String
        userId = snapshotValue["userId"] as! String
        completed = snapshotValue["completed"] as! Bool
        ref = snapshot.ref
    }
    // 18.1
    func convertToDictionary() -> Any {
        return ["title": title, "userId": userId, "completed": completed]
    }
    // 18.1
}
// 15.
