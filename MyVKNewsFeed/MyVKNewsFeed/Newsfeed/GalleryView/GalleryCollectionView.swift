//
//  GalleryCollectionView.swift
//  MyVKNewsFeed
//
//  Created by Eric Grant on 22.03.2020.
//  Copyright © 2020 Eric Grant. All rights reserved.
//

import Foundation
import UIKit

// 172.
class GalleryCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // 176.
    var photos = [FeedCellPhotoAttachmentViewModel]()
    // 176.
    
    init() {
//        // отвечают за flowLayout
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
        // 188.
        let rowLayout = RowLayout()
        // 188.
        super.init(frame: .zero, collectionViewLayout: rowLayout) // layout
        
        delegate = self
        dataSource = self
        
        backgroundColor = UIColor.white
        
        // 205.
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        // 205.
        
        // 174.
        register(GalleryCollectionViewCell.self, forCellWithReuseIdentifier: GalleryCollectionViewCell.reuseId)
        // 174.
        
        // 201.
        if let rowLayout = collectionViewLayout as? RowLayout {
            rowLayout.delegate = self
        }
        // 201.
    }
    
    // 177. заполнение фотографиями
    func set(photos: [FeedCellPhotoAttachmentViewModel]) {
        self.photos = photos
        // 200. при переиспользовании появляется первая фотография
        contentOffset = CGPoint.zero
        // 200.
        reloadData()
    }
    // 177.
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: GalleryCollectionViewCell.reuseId, for: indexPath) as! GalleryCollectionViewCell
        // 182.
        cell.set(imageUrl: photos[indexPath.row].photoUrlString)
        // 182.
        return cell
    }
    
    // 186.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: frame.height)
    }
    // 186.
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// 172.

// 198.
extension GalleryCollectionView: RowLayoutDelegate {
   
    func collectionView(_ collectionView: UICollectionView, photoAtIndexPath indexPath: IndexPath) -> CGSize {
        let width = photos[indexPath.row].width
        let height = photos[indexPath.row].height
        
        return CGSize(width: width, height: height)
    }
    
}
// 198.
