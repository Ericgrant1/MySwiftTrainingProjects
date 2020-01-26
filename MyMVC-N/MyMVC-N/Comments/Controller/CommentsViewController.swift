//
//  ViewController.swift
//  MyMVC-N
//
//  Created by Eric Grant on 25.01.2020.
//  Copyright © 2020 Eric Grant. All rights reserved.
//

import UIKit

class CommentsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    // 9.
    var comments = [Comment]()
    // 9.
    
    // 6.
    override func viewDidLoad() {
        super.viewDidLoad()
            
        // 9.
        CommentNetworkService.getComments { (response) in
            self.comments = response.comments
            self.tableView.reloadData()
            }
        // 9.
        }
    }
    // 6.

// 1. Подписываемся под протоколы для отображения TableView во ViewController
extension CommentsViewController: UITableViewDelegate {}

extension CommentsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CommentCell
        // 10.
        let comment = comments[indexPath.row]
        cell.configure(with: comment)
        // 10.
        return cell
    }
}
// 1.
