//
//  ViewController.swift
//  MyTableViewXib
//
//  Created by Eric on 07.01.2020.
//  Copyright © 2020 Eric Grant. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var eduTableView: UITableView!
    
    // 2.
    let eduData = [
        ["Princeton University", "Harvard University", "University of Chicago"],
        ["Columbia University", "Yale University", "Duke University", "Johns Hopkins University"],
        ["Massachusetts Institute of Technology", "Stanford University", "University of California – Berkeley"]
    ]
    
    let mottosData = [
        ["Dei Sub Numine Viget", "Veritas", "Crescat scientia; vita excolatur"],
        ["In lumine Tuo videbimus lumen", "Lux et veritas", "Eruditio et Religio", "Veritas vos liberabit"],
        ["Mens et Manus", "Die Luft der Freiheit weht", "Fiat lux"]
    ]
    // 2.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 3.
        // self.title = "UITableView"
        
        eduTableView.dataSource = self
        eduTableView.delegate = self
        
        let nibName = UINib(nibName: "TableViewCell", bundle: nil)
        eduTableView.register(nibName, forCellReuseIdentifier: "tableViewCell")
        
        // 3.
    }
    
    // 4.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var eduRows: Int!
        switch section {
        case 0:
            eduRows = 3
            break
        case 1:
            eduRows = 4
            break
        case 2:
            eduRows = 3
            break
        default:
            break
        }
        
        return eduRows
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var titleHeaderLabel: String!
        switch section {
        case 0:
            titleHeaderLabel = "Social Sciences and Management"
            break
        case 1:
            titleHeaderLabel = "Life Sciences and Medicine"
            break
        case 2:
            titleHeaderLabel = "Engineering and Technology"
            break
        default:
            break
        }
        
        return titleHeaderLabel
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! TableViewCell
        cell.generalInit("edu_\(indexPath.section)_\(indexPath.item)", title: eduData[indexPath.section][indexPath.item], motto: mottosData[indexPath.section][indexPath.item])
        return cell
    }
    // 4.
    
    // 5.
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    // 5.
    
    // 9.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newVC = ComponentVC()
        newVC.generalInit("edu_background_\(indexPath.section)_\(indexPath.item)", title: eduData[indexPath.section][indexPath.item])
        self.navigationController?.pushViewController(newVC, animated: true)
        self.eduTableView.deselectRow(at: indexPath, animated: true)
    }
    // 9.

}

