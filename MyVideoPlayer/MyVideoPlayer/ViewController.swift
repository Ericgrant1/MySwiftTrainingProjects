//
//  ViewController.swift
//  MyVideoPlayer
//
//  Created by Eric on 05.01.2020.
//  Copyright © 2020 Eric Grant. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var videoView: UIView!
    
    // 1.
    var videoPlayer: AVPlayer!
    var videoPlayerLayer: AVPlayerLayer!
    // 1.
    // 5.
    var isVideoPlaying = false
    // 5.
    
    @IBOutlet weak var timeVideoSlider: UISlider!
    @IBOutlet weak var fullDurationLabel: UILabel!
    @IBOutlet weak var currentDurationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 2. //
        let urlVideo = URL(string: "https://videolamborghini-meride-tv.akamaized.net/video/folder1/K44Msh0w_lamborghini/4k/index.m3u8")!
        videoPlayer = AVPlayer(url: urlVideo)
        
        // 8.
        videoPlayer.currentItem?.addObserver(self, forKeyPath: "duration", options: [.new, .initial], context: nil)
        // 8.
        
        // 9.
        addTimeVideoObservsr()
        // 9.
        
        videoPlayerLayer = AVPlayerLayer(player: videoPlayer)
        videoPlayerLayer.videoGravity = .resize
        
        videoView.layer.addSublayer(videoPlayerLayer)
        // 2. //
    }
//    // 4.
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        videoPlayer.play()
//    // 4.
//    }
    // 3.
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        videoPlayerLayer.frame = videoView.bounds
    // 3.
    }
    
    // 9.
    func addTimeVideoObservsr() {
        let interval = 0.5
        let timeInterval = CMTime(seconds: interval, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        let mainQueue = DispatchQueue.main
        _ = videoPlayer.addPeriodicTimeObserver(forInterval: timeInterval, queue: mainQueue, using: { [weak self] time in
            guard let currentItem = self?.videoPlayer.currentItem else { return }
            self?.timeVideoSlider.maximumValue = Float(currentItem.duration.seconds)
            self?.timeVideoSlider.minimumValue = 0
            self?.timeVideoSlider.value = Float(currentItem.currentTime().seconds)
            self?.currentDurationLabel.text = self?.getVideoDurationString(from: currentItem.currentTime())
        })
    }
    // 9.
    
    @IBAction func playButton(_ sender: UIButton) {
        // 5.
        if isVideoPlaying {
            videoPlayer.pause()
            sender.setTitle("Play", for: .normal)
        } else {
            videoPlayer.play()
            sender.setTitle("Pause", for: .normal)
        }
        
        isVideoPlaying = !isVideoPlaying
        // 5.
    }
    
    @IBAction func forwardButton(_ sender: UIButton) {
        // 6.
        guard let videoDuration = videoPlayer.currentItem?.duration else { return }
        let currentTime = CMTimeGetSeconds(videoPlayer.currentTime())
        let secondsTime = 5.0
        let newTime = currentTime + secondsTime
        
        if newTime < (CMTimeGetSeconds(videoDuration) - secondsTime) {
            let timeDuration: CMTime = CMTimeMake(value: (Int64(newTime * 1000)), timescale: 1000)
            videoPlayer.seek(to: timeDuration)
        }
        // 6.
    }

    @IBAction func backwardButton(_ sender: UIButton) {
        // 7.
        let currentTime = CMTimeGetSeconds(videoPlayer.currentTime())
        let secondsTime = 5.0
        var newTime = currentTime + secondsTime
        
        if newTime < 0 {
            newTime = 0
        }
        let timeDuration: CMTime = CMTimeMake(value: (Int64(newTime * 1000)), timescale: 1000)
        videoPlayer.seek(to: timeDuration)
        // 7.
    }
    
    @IBAction func sliderDurationChanged(_ sender: UISlider) {
        
        // 10.
        videoPlayer.seek(to: CMTimeMake(value: Int64(sender.value * 1000), timescale: 1000))
        // 10.
    }
    // 8.
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "duration", let duration = videoPlayer.currentItem?.duration.seconds, duration > 0.0 {
            self.fullDurationLabel.text = getVideoDurationString(from: videoPlayer.currentItem!.duration)
        }
    }
    
    func getVideoDurationString(from time: CMTime) -> String {
        let totalDuration = CMTimeGetSeconds(time)
        let durationInHours = Int(totalDuration / 3600)
        let durationInMinutes = Int(totalDuration / 60) % 60
        let durationInSeconds = Int(totalDuration.truncatingRemainder(dividingBy: 60))
        if durationInHours > 0 {
            return String(format: "%i:%02i:%02i", arguments: [durationInHours, durationInMinutes, durationInSeconds])
        } else {
            return String(format: "%02i:%02i", arguments: [durationInMinutes, durationInSeconds])
        }
    }
    // 8.
}

