//
//  DetailViewModelType.swift
//  MyMVVM-2
//
//  Created by Eric Grant on 27.01.2020.
//  Copyright © 2020 Eric Grant. All rights reserved.
//

import Foundation

// 17.
protocol DetailViewModelType {
    var description: String { get }
    
    // 25.
    var age: Box<String?> { get }
    // 25.
}
// 17.
