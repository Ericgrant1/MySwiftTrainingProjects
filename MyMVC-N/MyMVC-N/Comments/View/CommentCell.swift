//
//  CommentCell.swift
//  MyMVC-N
//
//  Created by Eric Grant on 25.01.2020.
//  Copyright © 2020 Eric Grant. All rights reserved.
//

import UIKit

// 2.
class CommentCell: UITableViewCell {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    func configure(with comment: Comment) {
        self.label.text = comment.name
        self.textView.text = comment.body 
    }
}
// 2.
