//
//  ParticlesView.swift
//  MyWeatherApp
//
//  Created by Eric on 26.12.2019.
//  Copyright © 2019 Eric Grant. All rights reserved.
//

import UIKit
import SpriteKit

class ParticlesView: SKView {
    override func didMoveToSuperview() {
        
        let scene = SKScene(size: self.frame.size)
        scene.backgroundColor = UIColor.clear
        self.presentScene(scene)
        
        // Делаем прозрвчным фон PaticlesView
        self.allowsTransparency = true
        self.backgroundColor = UIColor.clear
        
        // Размещаем частицы на сцене
        if let particles = SKEmitterNode(fileNamed: "ParticeScene.sks") {
            particles.position = CGPoint(x: self.frame.size.width / 2,
                                         y: self.frame.size.height)
            // Пределы размещения
            particles.particlePositionRange = CGVector(dx: self.bounds.size.width, dy: 0)
            
            // Добовляем частицы на сцену
            scene.addChild(particles)
        }
    }
}
