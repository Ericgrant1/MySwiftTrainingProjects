//
//  TableViewModelType.swift
//  MyMVVM-2
//
//  Created by Eric Grant on 26.01.2020.
//  Copyright © 2020 Eric Grant. All rights reserved.
//

import Foundation

// 8. Все требоваия к вьюмодели помещены в протоколы
protocol TableViewViewModelType {
    // var numberOfRows: Int { get } // удаляем
    // 15.
    func numberOfRows() -> Int
    // 15.
    // var profiles: [Profile] { get } // убираем
    
    // 9.
    func cellViewModel(forIndexPath indexPath: IndexPath) -> TableViewCellViewModelType?
    // 9.
    
    // 20.
    func viewModelForSelectedRow() -> DetailViewModelType?
    func selectRow(atIndexPath indexPath: IndexPath)
    // 20.
}
// 8.
