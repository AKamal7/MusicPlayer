//
//  Player+Youtube.swift
//  IdentifyMusic
//
//  Created by ahmedkamal on 11/05/2024.
//

import Foundation
import youtube_ios_player_helper

extension PlayerVC: YTPlayerViewDelegate {
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        playerView.playVideo()
//        sliderView.maximumValue = 1.0

    }
    
}
