//
//  DetailViewModel.swift
//  MyMVVM-2
//
//  Created by Eric Grant on 27.01.2020.
//  Copyright © 2020 Eric Grant. All rights reserved.
//

import Foundation

// 18.
class DetailViewModel: DetailViewModelType {
   
    private var profile: Profile
    
    var description: String {
        return String(describing: "\(profile.name) \(profile.secondName) is \(profile.age) old")
    }
    
    // 26.
    var age: Box<String?> = Box(nil)
    // 26.
    
    init(profile: Profile) {
        self.profile = profile
    }
    
}
// 18.
