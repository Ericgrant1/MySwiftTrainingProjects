//
//  NewsfeedCell.swift
//  MyVKNewsFeed
//
//  Created by Eric Grant on 15.03.2020.
//  Copyright © 2020 Eric Grant. All rights reserved.
//

import Foundation
import UIKit

// 56.
protocol FeedCellViewModel {
    var iconUrlString: String { get }
    var name: String { get }
    var date: String { get }
    var text: String? { get }
    var likes: String? { get }
    var comments: String? { get }
    var shares: String? { get }
    var views: String? { get }
    var photoAttachments: [FeedCellPhotoAttachmentViewModel] { get } // 87.1
    var sizes: FeedCellSizes { get } // 94.1
}
// 56.

// 94.
protocol FeedCellSizes {
    var postLabelFrame: CGRect { get }
    var attachmentFrame: CGRect { get }
    // 101.
    var bottomViewFrame: CGRect { get }
    var totalHeight: CGFloat { get }
    // 101.
    // 149.
    var moreTextButtonFrame: CGRect { get }
    // 149.
}
// 94.

// 87.
protocol FeedCellPhotoAttachmentViewModel {
    var photoUrlString: String? { get }
    var width: Int { get }
    var height: Int { get }
}
// 87.

// 51.
class NewsfeedCell: UITableViewCell {
    
    // 53.
    static let reuseId = "NewsfeedCell"
    // 53.
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var iconImageView: WebImageView! // UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var postLabel: UILabel!
    @IBOutlet weak var postImageView: WebImageView!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var sharesLabel: UILabel!
    @IBOutlet weak var viewsLabel: UILabel!
    @IBOutlet weak var bottomView: UIView!
    
    // 110.
    override func prepareForReuse() {
        iconImageView.set(imageURL: nil)
        postImageView.set(imageURL: nil)
    }
    // 110.
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 92.
        iconImageView.layer.cornerRadius = iconImageView.frame.width / 2
        iconImageView.clipsToBounds = true
        
        cardView.layer.cornerRadius = 10
        cardView.clipsToBounds = true
        
        backgroundColor = .clear
        selectionStyle = .none
        // 92.
    }
    
    // 57.
//    func set(viewModel: FeedCellViewModel) {
//        // 79.
//        iconImageView.set(imageURL: viewModel.iconUrlString)
//        // 79.
//        nameLabel.text = viewModel.name
//        dateLabel.text = viewModel.date
//        postLabel.text = viewModel.text
//        likesLabel.text = viewModel.likes
//        commentsLabel.text = viewModel.comments
//        sharesLabel.text = viewModel.shares
//        viewsLabel.text = viewModel.views
//        
//        // 100.
//        postLabel.frame = viewModel.sizes.postLabelFrame
//        postImageView.frame = viewModel.sizes.attachmentFrame
//        // 100.
//        
//        // 102.
//        bottomView.frame = viewModel.sizes.bottomViewFrame
//        // 102.
//        
//        // 91.
//        if let photoAttachment = viewModel.photoAttachment {
//            postImageView.set(imageURL: photoAttachment.photoUrlString)
//            postImageView.isHidden = false
//        } else {
//            postImageView.isHidden = true
//        }
//        // 91.
//    }
    // 57.
}
// 51.
