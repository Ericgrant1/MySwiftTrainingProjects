//
//  CustomViewCell.swift
//  MyTableViewWithoutStoryboard
//
//  Created by Eric Grant on 24.02.2020.
//  Copyright © 2020 Eric Grant. All rights reserved.
//

import UIKit

class CustomViewCell: UITableViewCell {

    // 13.
    let customCellView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.setCellShadow()
        return view
    }()
    // 13.
    
    // 17.
    let configureImageView: UIImageView = {
        let configIV = UIImageView()
        configIV.contentMode = .scaleAspectFit
        // configIV.backgroundColor = .orange
        return configIV
    }()
    // 17.
    
    // 18.
    let configureTitleLabel: UILabel = {
        let configTL = UILabel()
        configTL.text = "someText"
        configTL.textColor = .darkGray
        configTL.font = UIFont.boldSystemFont(ofSize: 20)
        return configTL
    }()
    // 18.
    
// 12.
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setCustomViewCell() // 14.1
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
// 12.
    
    // 28.
    func set(configure: DataInfo) {
        configureImageView.image = configure.image
        configureTitleLabel.text = configure.title
    }
    // 28.
    
    // 14.
    func setCustomViewCell() {
        
        // 19.
        backgroundColor = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1.0)
        // 19.
        
        addSubview(customCellView)
        
        // 20.
        customCellView.addSubview(configureImageView)
        customCellView.addSubview(configureTitleLabel)
        // 20.
        
        customCellView.setAnchor(top: topAnchor, paddingTop: 4,
                                 bottom: bottomAnchor, paddingBottom: 4,
                                 left: leftAnchor, paddingLeft: 8,
                                 right: rightAnchor, paddingRight: 8,
                                 height: 0, width: 0)
        
        // 21.
        configureImageView.setAnchor(top: nil, paddingTop: 0,
                                     bottom: nil, paddingBottom: 0,
                                     left: customCellView.leftAnchor, paddingLeft: 8,
                                     right: nil, paddingRight: 0,
                                     height: 80, width: 80)
        configureImageView.centerYAnchor.constraint(equalTo: customCellView.centerYAnchor).isActive = true
        // 21.
        
        // 22.
        configureTitleLabel.setAnchor(top: nil, paddingTop: 0,
                                      bottom: nil, paddingBottom: 0,
                                      left: configureImageView.rightAnchor,
                                      paddingLeft: 20, right: rightAnchor,
                                      paddingRight: 20, height: 80, width: 0)
        configureTitleLabel.centerYAnchor.constraint(equalTo: configureImageView.centerYAnchor).isActive = true
        // 22.
    }
    // 14.
}

