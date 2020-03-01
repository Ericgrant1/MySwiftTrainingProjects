//
//  ProgLanguageVC.swift
//  MyTableViewWithoutStoryboard
//
//  Created by Eric Grant on 24.02.2020.
//  Copyright © 2020 Eric Grant. All rights reserved.
//

import UIKit

class ProgLanguageVC: UIViewController {

    // 27.
    lazy var languageFounder: [LanguagesFounders] = {
        return LanguagesFounders.languageFounder()
    }()
    // 27.
    
    // 6.
    let tableView: UITableView = {
        let tabV = UITableView()
        tabV.separatorStyle = .none
        // tabV.allowsSelection = false
        return tabV
    }()
    // 6.
    
    let cellID = "cellID" // 10.1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBar() // 5.1
        setTableView() // 6.1
    }
    
    // 39.
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    // 39.
    
    // 5.
    func setNavigationBar() {
        navigationItem.title = "TopLanguages"
        navigationController?.navigationBar.barTintColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1.0)
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 23)
        ]
    }
    // 5.

    // 6.
    func setTableView() {
        setTableViewDelegates() // 8.1
        
        // 15.
        tableView.register(CustomViewCell.self, forCellReuseIdentifier: cellID)
        // 15.
        
        view.addSubview(tableView)
        tableView.setAnchor(top: view.topAnchor, paddingTop: 0, bottom: view.bottomAnchor, paddingBottom: 0, left: view.leftAnchor, paddingLeft: 0, right: view.rightAnchor, paddingRight: 0, height: 0, width: 0)
    }
    // 6.
    
    // 8.
    func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    // 8.
}

// 7.
extension ProgLanguageVC: UITableViewDelegate, UITableViewDataSource {
    
    // 9.
    func numberOfSections(in tableView: UITableView) -> Int {
        // 29.
        return languageFounder.count
        // 29.
    }
    // 9.
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 30.
        let langFounders = languageFounder[section]
        return langFounders.fetchData.count
        // 30.
        // return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 10.
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as! CustomViewCell // 12.1
        
        // 31.
        let langFounders = languageFounder[indexPath.section]
        let fetchData = langFounders.fetchData[indexPath.row]
        
        cell.set(configure: fetchData)
        // 31.
        
        return cell
        // 10.
    }
    
    // 11.
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    // 11.
    
    // 38.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let langFounders = languageFounder[indexPath.section]
            langFounders.fetchData.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    // 38.
    
    // 37.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let langFounders = languageFounder[indexPath.section]
        let title = langFounders.fetchData[indexPath.row].title

        navigationController?.pushViewController(SecondLanguageVC(title: title), animated: true)
    }
    // 37.
    
    // 16.
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // 32.
        let langFounders = languageFounder[section]
        return langFounders.name
        // 32.
    // 16.
    }
// 7.
}
