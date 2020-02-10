//
//  ViewController.swift
//  MyProgressBarWithCALayer
//
//  Created by Eric Grant on 10.02.2020.
//  Copyright © 2020 Eric Grant. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var progressBar: ProgressBar!
    
    // 15.
    var timeCounter: CGFloat = 0
    // 15.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 16.
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { (timer) in
            self.timeCounter += 1
            
            DispatchQueue.main.async {
                self.progressBar.progress = min(0.03 * self.timeCounter, 1)
                
                if self.progressBar.progress == 1 {
                    timer.invalidate()
                }
            }
        }
        // 16.
        
    }


}

