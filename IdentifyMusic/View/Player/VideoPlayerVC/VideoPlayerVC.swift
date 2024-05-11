//
//  VideoPlayerVC.swift
//  IdentifyMusic
//
//  Created by ahmedkamal on 04/05/2024.
//

import UIKit
import youtube_ios_player_helper

class VideoPlayerVC: UIViewController {

//    var playerView: YTPlayerView!

    @IBOutlet weak var playerView: YTPlayerView!
    
    var videoID: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        playerView = YTPlayerView(frame: CGRect(x: 0, y: 0, width: 320, height: 180))
        playerView.delegate = self
        view.addSubview(playerView)
        playerView.load(withVideoId: videoID ?? "")

    }
    

 
}

extension VideoPlayerVC: YTPlayerViewDelegate {
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        playerView.playVideo()
    }
}
