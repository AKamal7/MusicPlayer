//
//  ViewController.swift
//  IdentifyMusic
//
//  Created by ahmedkamal on 08/03/2024.
//

import UIKit
import MediaPlayer

class SearchVC: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var settingBtn: UIButton!
    let player = MPMusicPlayerController.systemMusicPlayer
    
    @IBOutlet weak var pulsyBtn: PulsatingButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pulsyBtn.pulse()
        pulsyBtn.borderColor = UIColor(hex: "BC66FF", alpha: 1)
        setupView()
        //        var playerQueue = PlayerQueue()
        //        if let song = player.nowPlayingItem {
        //            let id = song.playbackStoreID
        //           }
    }
    
    @IBAction func searchClicked(_ sender: UIButton) {
    }
    // MARK:- Private Methods
    private func setupView() {
        tabBarController?.selectedIndex = 0
        setupSearchBar()
        setupSettingBtn()
    }
    private func setupSettingBtn() {
        
        settingBtn.borderWidth = 1
        settingBtn.borderColor = UIColor(hex: "2b2b2b", alpha: 1)
        settingBtn.layer.cornerRadius = 12
        settingBtn.clipsToBounds = true
        
        
    }
    
    
    @objc func addButtonTapped() {
        
    }
    @IBAction func settingsBtnClicked(_ sender: UIButton) {
        
        
    }
    @IBAction func getPremiumTapped(_ sender: UIButton) {
        
        let premiumVC = UIStoryboard(name: "PremiumVC", bundle: nil).instantiateViewController(withIdentifier: "PremiumVC") as! PremiumVC
        premiumVC.modalPresentationStyle = .overFullScreen
        self.present(premiumVC,animated: false) {
            
        }
        
        
    }
    
    
    
    
}





