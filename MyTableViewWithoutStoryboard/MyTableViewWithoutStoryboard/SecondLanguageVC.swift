//
//  SecondLanguageVC.swift
//  MyTableViewWithoutStoryboard
//
//  Created by Eric Grant on 29.02.2020.
//  Copyright © 2020 Eric Grant. All rights reserved.
//

import UIKit

class SecondLanguageVC: UIViewController {

    // 34.
    var titleLabel: UILabel!
    // 34.
    
    // 36.
    init(title: String?) {
      super.init(nibName: nil, bundle: nil)
      self.title = title
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
      super.init(nibName: nil, bundle: nil)
    }
    // 36.
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 33.
        view.backgroundColor = .darkGray
        // 33.
        
        // 35.
        titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.backgroundColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 25)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        // 35.
        
    }

}
