//
//  GradientView.swift
//  MyVKNewsFeed
//
//  Created by Eric Grant on 28.03.2020.
//  Copyright © 2020 Eric Grant. All rights reserved.
//

import Foundation
import UIKit

// 277.
class GradientView: UIView {
    
    // 284.
    @IBInspectable private var startColor: UIColor? {
        // 287.
        didSet {
            setupGradientColors()
        }
        // 287.
    } // = .red
    @IBInspectable private var endColor: UIColor? {
        // 288.
        didSet {
            setupGradientColors()
        }
        // 288.
    }// = .yellow
    // 284.
    
    // 280.
    private let gradientLayer = CAGradientLayer()
    // 280.
    
    // 278.
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    // 278.
    
    // 279.
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        //backgroundColor = .blue
        // fatalError("init(coder:) has not been implemented")
        // 283.
        setupGradient()
        // 283.
    }
    // 279.
    
    // 282.
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds // растягиваем по всей границе
    }
    // 282.
    
    // 281.
    private func setupGradient() {
        self.layer.addSublayer(gradientLayer)
        // 286.
        setupGradientColors()
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        // 286.
    }
    // 281.
    
    // 285.
    private func setupGradientColors() {
        if let startColor = startColor, let endColor = endColor {
            gradientLayer.colors = [startColor.cgColor, endColor.cgColor] // [UIColor.red.cgColor, UIColor.blue.cgColor]
        }
    }
    // 285.
}
// 277.
