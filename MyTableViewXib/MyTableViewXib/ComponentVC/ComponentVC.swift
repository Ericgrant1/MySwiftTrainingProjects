//
//  ComponentVC.swift
//  MyTableViewXib
//
//  Created by Eric on 08.01.2020.
//  Copyright © 2020 Eric Grant. All rights reserved.
//

import UIKit

class ComponentVC: UIViewController {

    @IBOutlet weak var componentImage: UIImageView!
    
    // 6.
    var imageEDU: String!
    // 6.
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 7.
        componentImage.image = UIImage(named: self.imageEDU)
        // 7.
    }

    // 8.
    func generalInit(_ imageName: String, title: String) {
        self.imageEDU = imageName
        self.title = title 
    }
    // 8.
}
