//
//  NewsfeedCodeCell.swift
//  MyVKNewsFeed
//
//  Created by Eric Grant on 19.03.2020.
//  Copyright © 2020 Eric Grant. All rights reserved.
//

import Foundation
import UIKit

// 157.
protocol NewsfeedCodeCellDelegate: class {
    func revealPost(for cell: NewsfeedCodeCell)
}
// 157.

// 115.
final class NewsfeedCodeCell: UITableViewCell {
    
    static let reuseId = "NewsfeedCodeCell"
    
    // 158.
    weak var delegate: NewsfeedCodeCellDelegate?
    // 158.
    
    // 118. First layer
    let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    // 118.
    
    // 124. Second layer
    let topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        // view.backgroundColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
        return view
    }()
    // 124.
    
    // 125.
//    let postLabel: UILabel = {
//        let label = UILabel()
//        label.numberOfLines = 0
//        // label.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
//        label.font = Constants.postLabelFont
//        label.textColor = #colorLiteral(red: 0.227329582, green: 0.2323184013, blue: 0.2370472848, alpha: 1)
//        return label
//    }()
    // 248.
    let postLabel: UITextView = {
        let textView = UITextView()
        textView.font = Constants.postLabelFont
        textView.isScrollEnabled = false
        textView.isSelectable = true
        textView.isUserInteractionEnabled = true
        textView.isEditable = false
        
        // отступы до краев становятся как и по умолчанию у labels
        let padding = textView.textContainer.lineFragmentPadding
        textView.textContainerInset = UIEdgeInsets.init(top: 0, left: -padding, bottom: 0, right: -padding)
        
        textView.dataDetectorTypes = UIDataDetectorTypes.all // вычисление ссылок  ипереход по ним
        return textView
    }()
    // 248.
    
    // 146.
    let moreTextButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        button.setTitleColor(#colorLiteral(red: 0.4, green: 0.6235294118, blue: 0.831372549, alpha: 1), for: .normal)
        button.contentHorizontalAlignment = .left
        button.contentVerticalAlignment = .center
        button.setTitle("Show all...", for: .normal)
        return button
    }()
    // 146.
    
    // 175.
    let galleryCollectionView = GalleryCollectionView()
    // 175.
    
    let postImageView: WebImageView = {
        let imageView = WebImageView()
        imageView.backgroundColor = #colorLiteral(red: 0.8235294118, green: 0.3098039216, blue: 0.3294117647, alpha: 1)
        return imageView
    }()
    
    let bottomView: UIView = {
        let view = UIView()
        // view.backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        return view
    }()
    // 125.
    
    // 129. Third layer on topView
    let iconImageView: WebImageView = {
        let imageView = WebImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        // imageView.backgroundColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.numberOfLines = 0
        label.textColor = #colorLiteral(red: 0.227329582, green: 0.2323184013, blue: 0.2370472848, alpha: 1)
        // label.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.5058823529, green: 0.5490196078, blue: 0.6, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 12)
        // label.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        return label
    }()
    // 129.
    
    // 133. Third layer on bottomView
    let likesView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        // view.backgroundColor = #colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1)
        return view
    }()
    
    let commentsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        // view.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        return view
    }()
    
    let sharesView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        // view.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        return view
    }()
    
    let viewsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        // view.backgroundColor = #colorLiteral(red: 0.3098039329, green: 0.2039215714, blue: 0.03921568766, alpha: 1)
        return view
    }()
    // 133.
    
    // 137. Fourth layer on bottomView
    let likesImage: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "like")
        return imageView
    }()
    
    let commentsImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "comment")
        return imageView
    }()
    
    let sharesImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "share")
        return imageView
    }()
    
    let viewsImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "eye")
        return imageView
    }()
    
    let likesLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        // label.text = "789k"
        label.textColor = #colorLiteral(red: 0.5768421292, green: 0.6187390685, blue: 0.664434731, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.lineBreakMode = .byClipping
        return label
    }()
    
    let commentsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.5768421292, green: 0.6187390685, blue: 0.664434731, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.lineBreakMode = .byClipping
        return label
    }()
    
    let sharesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.5768421292, green: 0.6187390685, blue: 0.664434731, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.lineBreakMode = .byClipping
        return label
    }()
    
    let viewsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.5768421292, green: 0.6187390685, blue: 0.664434731, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.lineBreakMode = .byClipping
        return label
    }()
    // 137.
    
    // 145.
    override func prepareForReuse() {
        iconImageView.set(imageURL: nil)
        postImageView.set(imageURL: nil)
    }
    // 145.
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // 144.
        iconImageView.layer.cornerRadius = Constants.topViewHeight / 2
        iconImageView.clipsToBounds = true
        // 144.
        
        // 143.
        backgroundColor = .clear
        selectionStyle = .none
        
        cardView.layer.cornerRadius = 10
        cardView.clipsToBounds = true
        // 143.
        
        // 155. Reveal text
        moreTextButton.addTarget(self, action: #selector(moreTextButtonTouch), for: .touchUpInside)
        // 155.
            
        // 122. First layer
        overlayFirstLayer()
        // 122.
        // 127. Second layer
        overlaySecondLayer()
        // 127.
        // 131. Third layer on topView
        overlayThirdLayerOnTopView()
        // 131.
        // 135. Third layer on bottomView
        overlayThirdLayerOnBottom()
        // 135.
        // 139. Fourth layer on bottomViewViews
        overlayFourthLayerOnBottomViewViews()
        // 139.
    }
    // 128.
    
    // 156.
    @objc func moreTextButtonTouch() {
        print("123")
        delegate?.revealPost(for: self)
    }
    // 156.
    
    func set(viewModel: FeedCellViewModel) {
        // 132.
        iconImageView.set(imageURL: viewModel.iconUrlString)
        nameLabel.text = viewModel.name
        dateLabel.text = viewModel.date
        postLabel.text = viewModel.text
        likesLabel.text = viewModel.likes
        commentsLabel.text = viewModel.comments
        sharesLabel.text = viewModel.shares
        viewsLabel.text = viewModel.views
        // 132.
        
        postLabel.frame = viewModel.sizes.postLabelFrame
        bottomView.frame = viewModel.sizes.bottomViewFrame
        // 148.
        moreTextButton.frame = viewModel.sizes.moreTextButtonFrame
        // 148.
        
//        if let photoAttachment = viewModel.photoAttachment {
//            postImageView.set(imageURL: photoAttachment.photoUrlString)
//            postImageView.isHidden = false
//        } else {
//            postImageView.isHidden = true
//        }
        // 171.
        if let photoAttachment = viewModel.photoAttachments.first, viewModel.photoAttachments.count == 1 {
            postImageView.set(imageURL: photoAttachment.photoUrlString)
            postImageView.isHidden = false
            // 184.
            galleryCollectionView.isHidden = true
            postImageView.frame = viewModel.sizes.attachmentFrame
            // 184.
        // 185.
        } else if viewModel.photoAttachments.count > 1 {
            galleryCollectionView.frame = viewModel.sizes.attachmentFrame
            postImageView.isHidden = true
            galleryCollectionView.isHidden = false
            galleryCollectionView.set(photos: viewModel.photoAttachments)
        // 185.
        } else {
            postImageView.isHidden = true
            galleryCollectionView.isHidden = true
        }
        // 171.
        
    }
    // 128.
    
    // 138.
    private func overlayFourthLayerOnBottomViewViews() {
        likesView.addSubview(likesImage)
        likesView.addSubview(likesLabel)
        
        commentsView.addSubview(commentsImage)
        commentsView.addSubview(commentsLabel)
        
        sharesView.addSubview(sharesImage)
        sharesView.addSubview(sharesLabel)
        
        viewsView.addSubview(viewsImage)
        viewsView.addSubview(viewsLabel)
        
        // 142.
        helpInFourhLayer(view: likesView, imageView: likesImage, label: likesLabel)
        helpInFourhLayer(view: commentsView, imageView: commentsImage, label: commentsLabel)
        helpInFourhLayer(view: sharesView, imageView: sharesImage, label: sharesLabel)
        helpInFourhLayer(view: viewsView, imageView: viewsImage, label: viewsLabel)
        // 142.
    }
    // 138.
    
    // 140.
    private func helpInFourhLayer(view: UIView, imageView: UIImageView, label: UILabel) {
        
        // imageView constraints
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: Constants.bottomViewViewsIconSize).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: Constants.bottomViewViewsIconSize).isActive = true
        
        // label constraints
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 4).isActive = true
        label.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    // 140.
    
    // 134.
    private func overlayThirdLayerOnBottom() {
        bottomView.addSubview(likesView)
        bottomView.addSubview(commentsView)
        bottomView.addSubview(sharesView)
        bottomView.addSubview(viewsView)
        
        // likesView constraints
        likesView.anchor(top: bottomView.topAnchor,
                         leading: bottomView.leadingAnchor,
                         bottom: nil,
                         trailing: nil,
                         size: CGSize(width: Constants.bottomViewViewWidth, height: Constants.bottomViewViewHeight))
        
        // commentsView constraints
        commentsView.anchor(top: bottomView.topAnchor,
                            leading: likesView.trailingAnchor,
                            bottom: nil,
                            trailing: nil,
                            size: CGSize(width: Constants.bottomViewViewWidth, height: Constants.bottomViewViewHeight))
        
        // sharesView constraints
        sharesView.anchor(top: bottomView.topAnchor,
                          leading: commentsView.trailingAnchor,
                          bottom: nil,
                          trailing: nil,
                          size: CGSize(width: Constants.bottomViewViewWidth, height: Constants.bottomViewViewHeight))
        
        // viewsView constraints
        viewsView.anchor(top: bottomView.topAnchor,
                          leading: nil,
                          bottom: nil,
                          trailing: bottomView.trailingAnchor,
                          size: CGSize(width: Constants.bottomViewViewWidth, height: Constants.bottomViewViewHeight))
    }
    // 134.
    
    // 130.
    private func overlayThirdLayerOnTopView() {
        topView.addSubview(iconImageView)
        topView.addSubview(nameLabel)
        topView.addSubview(dateLabel)
        
        // iconImageView constraints
        iconImageView.leadingAnchor.constraint(equalTo: topView.leadingAnchor).isActive = true
        iconImageView.topAnchor.constraint(equalTo: topView.topAnchor).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: Constants.topViewHeight).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: Constants.topViewHeight).isActive = true
        
        // nameLabel constraints
        nameLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 8).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -8).isActive = true
        nameLabel.topAnchor.constraint(equalTo: topView.topAnchor, constant: 2).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: Constants.topViewHeight / 2 - 2).isActive = true
        
        // dateLabel constraints
        dateLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 8).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -8).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -2).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: 14).isActive = true
    }
    // 130.
    
    // 126.
    private func overlaySecondLayer() {
        cardView.addSubview(topView)
        cardView.addSubview(postLabel)
        // 147.
        cardView.addSubview(moreTextButton)
        // 147.
        cardView.addSubview(postImageView)
        // 183.
        cardView.addSubview(galleryCollectionView)
        // 183.
        cardView.addSubview(bottomView)
        
        // topView constraints
        topView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 8).isActive = true
        topView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -8).isActive = true
        topView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 8).isActive = true
        topView.heightAnchor.constraint(equalToConstant: Constants.topViewHeight).isActive = true
        
        // postLabel constraints
        // not necessary, dimensions are created dynamically
        
        // moreTextButton constraints
        // not necessary, dimensions are created dynamically
        
        // postImageView constraints
        // not necessary, dimensions are created dynamically
        
        // bottomView constraints
        // not necessary, dimensions are created dynamically
        
    }
    // 126.
    
    // 121.
    private func overlayFirstLayer() {
        // 119.
        addSubview(cardView)
        // 119.
        
        // 123. cardView constraints
        cardView.fillSuperview(padding: Constants.cardInsets)
        // 123.
    }
    // 121.
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// 115.
