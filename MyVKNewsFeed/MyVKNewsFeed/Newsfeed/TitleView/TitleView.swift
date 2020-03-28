//
//  TitleView.swift
//  MyVKNewsFeed
//
//  Created by Eric Grant on 24.03.2020.
//  Copyright © 2020 Eric Grant. All rights reserved.
//

import Foundation
import UIKit

// 230.
protocol TitleViewViewModel {
    var photoUrlString: String? { get }
}
// 230.

// 207.
class TitleView: UIView {
    
    // 210.
    private var myTextField = InsertableTextField()
    // 210.
    
    // 208.
    private var myAvatarView: WebImageView = {
        let imageView = WebImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .orange
        imageView.clipsToBounds = true
        return imageView
    }()
    // 208.
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 211.
        translatesAutoresizingMaskIntoConstraints = false // позволяет растягиваться view
        addSubview(myTextField)
        addSubview(myAvatarView)
        // 211.
        // 218.
        makeConstraints()
        // 218.
    }
    
    // 231.
    func set(userViewModel: TitleViewViewModel) {
        myAvatarView.set(imageURL: userViewModel.photoUrlString)
    }
    // 231.
    
    // 212.
    private func makeConstraints() {
        // myAvatarView constraints
        myAvatarView.anchor(top: topAnchor,
                            leading: nil,
                            bottom: nil,
                            trailing: trailingAnchor,
                            padding: UIEdgeInsets(top: 4, left: 777, bottom: 777, right: 4))
        myAvatarView.heightAnchor.constraint(equalTo: myTextField.heightAnchor, multiplier: 1).isActive = true
        myAvatarView.widthAnchor.constraint(equalTo: myTextField.heightAnchor, multiplier: 1).isActive = true
        
        // myTextField constraints
        myTextField.anchor(top: topAnchor,
                           leading: leadingAnchor,
                           bottom: bottomAnchor,
                           trailing: myAvatarView.leadingAnchor,
                           padding: UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 12))
        
    }
    // 212.
    
    // 213. подстраивание View под размеры NavigationBar
    override var intrinsicContentSize: CGSize {
        return UIView.layoutFittingExpandedSize
    }
    // 213.
    
    // 214. Закругление аватара
    override func layoutSubviews() {
        super.layoutSubviews()
        
        myAvatarView.layer.masksToBounds = true
        myAvatarView.layer.cornerRadius = myAvatarView.frame.width / 2
    }
    // 214.
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// 207.
