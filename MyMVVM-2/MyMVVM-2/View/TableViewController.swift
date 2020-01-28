//
//  TableViewController.swift
//  MyMVVM-2
//
//  Created by Eric Grant on 26.01.2020.
//  Copyright © 2020 Eric Grant. All rights reserved.
//

import UIKit

// наш основной класс
class TableViewController: UITableViewController {

    // 2.
    // var profiles: [Profile]!
    // 2.
    // 5.
    private var viewModel: TableViewViewModelType? // изменили с ViewModel?
    // 5.
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 6.
        viewModel = ViewModel()
        // 6.
        
        // 3.
//        profiles = [
//            Profile(name: "Eric", secondName: "Grant", age: 32),
//            Profile(name: "Aron", secondName: "Freedman", age: 25),
//            Profile(name: "Jacob", secondName: "Zenn", age: 44)
//        ]
        // 3.
    }

    // MARK: - Table view data source

    // можно удалить numberOfSections
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRows() ?? 0 // заменили с profiles.count
    }

    // 5. Отрисовываем ячейки
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell
        guard let tableViewCell = cell, let viewModel = viewModel else { return UITableViewCell() }
        // 14.
        let cellViewModel = viewModel.cellViewModel(forIndexPath: indexPath)
        
        tableViewCell.viewModel = cellViewModel
        // 14.
        
//        let result = viewModel.profiles[indexPath.row] // добавили viewModel
//
//        tableViewCell.ageLabel.text = "\(result.age)"
//        tableViewCell.fullNameLabel.text = "\(result.name) \(result.secondName)"
        
        return tableViewCell
    }
    // 5.
    
    // 22. При нажатии переход на экран с более подробной информацией
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let viewModel = viewModel else { return }
        viewModel.selectRow(atIndexPath: indexPath)
        
        performSegue(withIdentifier: "detailSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier, let viewModel = viewModel else { return }
        
        if identifier == "detailSegue" {
            if let destinationVC = segue.destination as? DetailViewController {
                destinationVC.viewModel = viewModel.viewModelForSelectedRow()
            }
        }
    }
    // 22.

}
