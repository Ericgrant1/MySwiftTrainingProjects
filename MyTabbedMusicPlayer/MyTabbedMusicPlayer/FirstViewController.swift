//
//  FirstViewController.swift
//  MyTabbedMusicPlayer
//
//  Created by Eric on 10.01.2020.
//  Copyright © 2020 Eric Grant. All rights reserved.
//

import UIKit
import AVFoundation

// 3.
var tracks: [String] = []
// 3.
// 5.
var trackPlayer = AVAudioPlayer()
// 5.
// 8.
var currentTrack = 0
// 8.
// 12.
var trackStuffed = false
// 12.

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // 4.
    @IBOutlet weak var tracksTableView: UITableView!
    // 4.

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 2.
        gettingTrackName()
        // 2.
    }
    
    // 3.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = tracks[indexPath.row]
        
        return cell
    }
    // 3.
    
    // 5.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        do {
            let songPath = Bundle.main.path(forResource: tracks[indexPath.row], ofType: ".mp3")
            try trackPlayer = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: songPath!) as URL)
            trackPlayer.play()
            // 8.
            currentTrack = indexPath.row
            // 8.
            // 12.
            trackStuffed = true
            // 12.
        } catch {
            print("Error")
        }
    }
    // 5.
    
    
    // 1.
    func gettingTrackName() {
        
        let musicURL = URL(fileURLWithPath: Bundle.main.resourcePath!)
        
        do {
            let trackPath = try FileManager.default.contentsOfDirectory(at: musicURL, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
            for track in trackPath {
                var myTrack = track.absoluteString
                
                if myTrack.contains(".mp3") {
                    let detectString = myTrack.components(separatedBy: "/")
                    myTrack = detectString[detectString.count - 1]
                    myTrack = myTrack.replacingOccurrences(of: "%20", with: " ")
                    myTrack = myTrack.replacingOccurrences(of: "%5", with: " ")
                    myTrack = myTrack.replacingOccurrences(of: ".mp3", with: "")
                    // 3.
                    tracks.append(myTrack)
                    // 3.
                }
            }
            // 4.
            tracksTableView.reloadData()
            // 4.
        } catch {
            
        }
    }
    // 1.
}

