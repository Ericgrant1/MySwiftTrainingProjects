//
//  SecondViewController.swift
//  MyTabbedMusicPlayer
//
//  Created by Eric on 10.01.2020.
//  Copyright © 2020 Eric Grant. All rights reserved.
//

import UIKit
import AVFoundation

class SecondViewController: UIViewController {

    @IBOutlet weak var trackLabel: UILabel!
    @IBOutlet weak var pictureImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 11.
        trackLabel.text = tracks[currentTrack]
        // 11.
        
    }
    
    // 11.
    @IBAction func prevAction(_ sender: Any) {
        
        
        if currentTrack != 0 && trackStuffed == true {
            playCurrent(currentOne: tracks[currentTrack - 1])
            currentTrack -= 1
            trackLabel.text = tracks[currentTrack]
        } else {
            
        }
    }
    // 11.
    
    // 6.
    @IBAction func playAction(_ sender: Any) {
        
        if trackStuffed == true && trackPlayer.isPlaying == false {
            trackPlayer.play()
        }
    }
    
    @IBAction func pauseAction(_ sender: Any) {
        
        if trackStuffed == true && trackPlayer.isPlaying {
            trackPlayer.pause()
    
        }
    }
    // 6.
    
    // 10.
    @IBAction func nextAction(_ sender: Any) {
        
        if currentTrack < tracks.count - 1 && trackStuffed == true {
            playCurrent(currentOne: tracks[currentTrack + 1])
            currentTrack += 1
            trackLabel.text = tracks[currentTrack]
        } else {
        }
        
    }
    // 10.
    
    // 7.
    @IBAction func sliderAction(_ sender: UISlider) {
        
        if trackStuffed == true {
            trackPlayer.volume = sender.value
        }
        
    }
    // 7.
    
    // 9.
    func playCurrent(currentOne: String) {
        
        do {
            let songPath = Bundle.main.path(forResource: currentOne, ofType: ".mp3")
            try trackPlayer = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: songPath!) as URL)
            trackPlayer.play()
        } catch {
            print("Error")
            
        }
    }
    // 9.
    
}

