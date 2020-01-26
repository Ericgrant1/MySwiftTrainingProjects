//
//  PictureCell.swift
//  MySearchImageApp
//
//  Created by Eric on 23.12.2019.
//  Copyright © 2019 Eric Grant. All rights reserved.
//

import UIKit
import Kingfisher

class PictureCell: UICollectionViewCell {
    @IBOutlet weak var pictureImageView: UIImageView!
    
    // Метод принимающий url и загружающий картинку
    var pictureURL: String? {
        didSet {
            if let pictureURL = pictureURL, let url = URL(string: pictureURL) {
                pictureImageView.kf.setImage(with: url)
            } else {
                pictureImageView.image = nil
                pictureImageView.kf.cancelDownloadTask()
            }
        }
    }
    // Метод используемый при скролинге collectionView для отображения картинок
    override func prepareForReuse() {
        super.prepareForReuse()
        pictureURL = nil
    }
}
