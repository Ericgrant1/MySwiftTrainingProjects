//
//  TableViewCell.swift
//  MyMVVM-2
//
//  Created by Eric Grant on 26.01.2020.
//  Copyright © 2020 Eric Grant. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    // 4.
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    // 4.
    
    // 16.
    weak var viewModel: TableViewCellViewModelType? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            fullNameLabel.text = viewModel.fullName
            ageLabel.text = viewModel.age
        }
    }
    // 16.
}
