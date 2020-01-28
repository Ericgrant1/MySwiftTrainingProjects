//
//  ViewModel.swift
//  MyMVVM-2
//
//  Created by Eric Grant on 26.01.2020.
//  Copyright © 2020 Eric Grant. All rights reserved.
//

import Foundation

// 7.
class ViewModel: TableViewViewModelType {
    
    // 20.
    private var selectedIndexPath: IndexPath?
    // 20.
    
    var profiles = [
        Profile(name: "Eric", secondName: "Grant", age: 32),
        Profile(name: "Aron", secondName: "Freedman", age: 25),
        Profile(name: "Jacob", secondName: "Zenn", age: 44)
    ]
    
    // исправили на func - var numberOfRows: Int
    func numberOfRows() -> Int {
        return profiles.count
    }
    
    // 11.
    func cellViewModel(forIndexPath indexPath: IndexPath) -> TableViewCellViewModelType? {
        let profile = profiles[indexPath.row]
        return TableViewCellViewModel(profile: profile) // модель для заполнения ячейки, а не всей таблицы
    }
    // 11.
    
    
    // 21.
    func viewModelForSelectedRow() -> DetailViewModelType? {
        guard let selectedIndexPath = selectedIndexPath else { return nil }
        return DetailViewModel(profile: profiles[selectedIndexPath.row])
    }
    
    func selectRow(atIndexPath indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
    }
    // 21.
    
}
// 7.
