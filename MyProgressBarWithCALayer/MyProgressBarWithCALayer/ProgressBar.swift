//
//  ProgressBar.swift
//  MyProgressBarWithCALayer
//
//  Created by Eric Grant on 10.02.2020.
//  Copyright © 2020 Eric Grant. All rights reserved.
//

import UIKit

class ProgressBar: UIView {

    // 19.
    @IBInspectable public var bacgroundCircleColor: UIColor = UIColor.lightGray
    @IBInspectable public var startGradientColor: UIColor = UIColor.red
    @IBInspectable public var endGradientColor: UIColor = UIColor.yellow
    @IBInspectable public var textColor: UIColor = UIColor.white
    // 19.
    
    // 1.
    private var backgroundLayer: CAShapeLayer!
    private var foregroundLayer: CAShapeLayer!
    private var textLayer: CATextLayer!
    // 1.
    // 17.
    private var gradientLayer: CAGradientLayer!
    // 17.
    
    // 13.
    public var progress: CGFloat = 0 {
        didSet {
            didProgressUpdated()
        }
    }
    // 13.
    
    override func draw(_ rect: CGRect) {
        // 20.
        guard layer.sublayers == nil else {
            return 
        }
        // 20.
        
        // 2.
        let width = rect.width
        let height = rect.height
        
        let lineWidth = 0.1 * min(width, height)
        
//        let center = CGPoint(x: width / 2, y: width / 2)
//        let radius = (min(width, height) - lineWidth) / 2
//
//        // 5. Удаляем
//        let startAngle = -CGFloat.pi / 2
//        let endAngle = startAngle + 2 * CGFloat.pi
//        // 5.
//
//        let circularPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true) // 5.1 - заменилили startAngle: 0; endAngle: CGFloat.pi;
        // 2.
        
        // 3. Удаляем
        // 9.
        backgroundLayer = createCircularLayer(rect: rect, strokeColor: UIColor.lightGray.cgColor, fillColor: UIColor.clear.cgColor, lineWidth: lineWidth) // замена CAShapeLayer()
        // 9.
        
//        backgroundLayer.path = circularPath.cgPath
//
//        backgroundLayer.strokeColor = UIColor.lightGray.cgColor
//        backgroundLayer.fillColor = UIColor.clear.cgColor
//        backgroundLayer.lineWidth = lineWidth
//        backgroundLayer.lineCap = .round
        // 3.
        
        // 6. Удаляем
        // 10.
        foregroundLayer = createCircularLayer(rect: rect, strokeColor: UIColor.red.cgColor, fillColor: UIColor.clear.cgColor, lineWidth: lineWidth) // замена CAShapeLayer()
        // 10.
        
//        foregroundLayer.path = circularPath.cgPath
//
//        foregroundLayer.strokeColor = UIColor.red.cgColor
//        foregroundLayer.fillColor = UIColor.clear.cgColor
//        foregroundLayer.lineWidth = lineWidth
//        foregroundLayer.lineCap = .round
        // 6.
        
        // 7. Удаляем
//        foregroundLayer.strokeEnd = 0.3
        // 7.
        
        // 18.
        gradientLayer = CAGradientLayer()
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        
        gradientLayer.colors = [startGradientColor.cgColor, endGradientColor.cgColor] // 19.1 заменили [UIColor.red.cgColor, UIColor.orange.cgColor]
        gradientLayer.frame = rect
        gradientLayer.mask = foregroundLayer
        // 18.
        
        // 12.
        textLayer = createTextLayer(rect: rect, textColor: textColor.cgColor) // 19.2 заменили textColor: UIColor.white.cgColor
        // 12.
        
        // 4.
        layer.addSublayer(backgroundLayer)
        layer.addSublayer(gradientLayer) // 18.1 заменили foregroundLayer // 6.1
        layer.addSublayer(textLayer) // 12.1
        // 4.
    }
    // 8.
    private func createCircularLayer(rect: CGRect,
                                     strokeColor: CGColor,
                                     fillColor: CGColor,
                                     lineWidth: CGFloat) -> CAShapeLayer {
        
        let width = rect.width
        let height = rect.height
        
        let center = CGPoint(x: width / 2, y: width / 2)
        let radius = (min(width, height) - lineWidth) / 2
        
        let startAngle = -CGFloat.pi / 2
        let endAngle = startAngle + 2 * CGFloat.pi
        
        let circularPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        let shapeLayer = CAShapeLayer()
        
        shapeLayer.path = circularPath.cgPath
        
        shapeLayer.strokeColor = strokeColor
        shapeLayer.fillColor = fillColor
        shapeLayer.lineWidth = lineWidth
        shapeLayer.lineCap = .round
        
        return shapeLayer
        
    }
    // 8.

    // 11.
    private func createTextLayer(rect: CGRect, textColor: CGColor) -> CATextLayer {
        
        let width = rect.width
        let height = rect.height
        
        let fontSize = min(width, height) / 4
        let offset = min(width, height) * 0.1
        
        let layer = CATextLayer()
        layer.string = "\(Int(progress * 100))" // заменили "100"
        layer.backgroundColor = UIColor.clear.cgColor
        layer.foregroundColor = textColor
        layer.fontSize = fontSize
        layer.frame = CGRect(x: 0, y: (height - fontSize - offset) / 2, width: width, height: fontSize * offset)
        layer.alignmentMode = .center
        
        return layer
    }
    // 11.
    
    // 14.
    private func didProgressUpdated() {
        textLayer?.string = "\(Int(progress * 100)) %"
        foregroundLayer?.strokeEnd = progress
    }
    // 14.
}
