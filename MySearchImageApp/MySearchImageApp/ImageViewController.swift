//
//  ImageViewController.swift
//  MySearchImageApp
//
//  Created by Eric on 22.12.2019.
//  Copyright © 2019 Eric Grant. All rights reserved.
//

import UIKit
import Kingfisher

class ImageViewController: UIViewController {

    var image: Model?
    
    @IBOutlet weak var pictureImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let image = image, let url = URL(string: image.bigPictureURL) {
            pictureImageView.kf.setImage(with: url)
        }
    }
}
