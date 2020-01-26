//
//  TableViewCell.swift
//  MyTableViewXib
//
//  Created by Eric on 07.01.2020.
//  Copyright © 2020 Eric Grant. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var logoEDU: UIImageView!
    
    @IBOutlet weak var titleEDULabel: UILabel!
    
    @IBOutlet weak var mottoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // 1.
    func generalInit(_ logoImageName: String, title: String, motto: String) {
        logoEDU.image = UIImage(named: logoImageName)
        titleEDULabel.text = title
        mottoLabel.text = motto
    }
    // 1.
}
