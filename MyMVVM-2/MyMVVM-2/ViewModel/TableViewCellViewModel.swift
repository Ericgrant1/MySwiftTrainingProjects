//
//  TableViewCellViewModel.swift
//  MyMVVM-2
//
//  Created by Eric Grant on 27.01.2020.
//  Copyright © 2020 Eric Grant. All rights reserved.
//

import Foundation

// 12.
class TableViewCellViewModel: TableViewCellViewModelType {
    
    private var profile: Profile
    
    // 13.
    var fullName: String {
        return profile.name + " " + profile.secondName
    }
    
    var age: String {
        return String(describing: profile.age)
    }
    
    init(profile: Profile) {
        self.profile = profile 
    }
    
    // 13.
    
}
// 12.
