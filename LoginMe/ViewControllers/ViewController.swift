//
//  ViewController.swift
//  LoginMe
//
//  Created by Chitralekha Yellewar on 11/09/20.
//  Copyright © 2020 Chitralekha Yellewar. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player: AVPlayer?
    var playerLayer: AVPlayerLayer?
    
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpElements()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupVideo()
    }

    func setUpElements() {
        Utilities.styleFilledButton(signupButton)
        Utilities.styleHollowButton(loginButton)
    }
    
    func setupVideo() {
        
        guard let videoPath = Bundle.main.path(forResource: "bridge", ofType: "mp4") else {
            return
        }
        //create a video url
        let videoUrl = URL(fileURLWithPath: videoPath)
        
        // Create the video player item
        let item = AVPlayerItem(url: videoUrl)
        
        // Create the player
        player = AVPlayer(playerItem: item)
        
        // Create the layer
        playerLayer = AVPlayerLayer(player: player)
        
        // Adjust the size and frame
        playerLayer?.frame = CGRect(x: -self.view.frame.size.width*1.5, y: 0, width: self.view.frame.size.width*4, height: self.view.frame.size.height)
        
        view.layer.insertSublayer(playerLayer!, at: 0)
        
        // Add it to the view and play it
        player?.playImmediately(atRate: 1)
        
    }

}

