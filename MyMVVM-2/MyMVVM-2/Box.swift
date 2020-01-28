//
//  Box.swift
//  MyMVVM-2
//
//  Created by Eric Grant on 28.01.2020.
//  Copyright © 2020 Eric Grant. All rights reserved.
//

import Foundation

// 23. Обертка
class Box<T> {
    typealias Listener = (T) -> ()
    
    var listener: Listener? // наблюдатель
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    // 24. Связываем свойство с наблюдателем
    func bind(listener: @escaping Listener) {
        self.listener = listener
        listener(value)
    }
    // 24.
    
    init(_ value: T) {
        self.value = value
    }
}
// 23.
