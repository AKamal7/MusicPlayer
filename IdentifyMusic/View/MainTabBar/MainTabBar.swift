//
//  MainTabBarVC.swift
//  IdentifyMusic
//
//  Created by ahmedkamal on 09/03/2024.
//

import UIKit
import Cider
class MainTabBar: UITabBarController {
    
    var isHearing: Bool = false
    let containerView = UIView()
    
    // UI
    var songImage  : UIImageView!
    var songName   : UILabel!
    var songArtist : UILabel!
    var favButton  : UIButton!
    var playButton : UIButton!
    
    // MARK:- LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        NotificationCenter.default.addObserver(self, selector: #selector(playerVisibilityHidden(notif:)), name: Notification.Name(rawValue: "hidePlayer"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(playerVisibilityShown(notif:)), name: Notification.Name(rawValue: "showPlayer"), object: nil)
        if isPlaying == false {
            hidePlayer(hide: true)
        }
        setupObserver()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupPlayerData()
        print("viewillappear")
    }
    
    // MARK:- Public Methods
    class func create() -> MainTabBar {
        let mainTabBar = MainTabBar()
        let searchNavigation = UINavigationController(rootViewController: mainTabBar.createServiceSearchVC())
        let favoriteNavigation = UINavigationController(rootViewController: mainTabBar.createHistoryVC())
        let appointmentsNavigation = UINavigationController(rootViewController: mainTabBar.createPlaylistVC())
        mainTabBar.viewControllers = [favoriteNavigation, searchNavigation, appointmentsNavigation]
        mainTabBar.selectedIndex = 1
        
        mainTabBar.tabBar.items!.first?.titlePositionAdjustment = UIOffset(horizontal: 30, vertical: 0.0);
        mainTabBar.tabBar.items!.last?.titlePositionAdjustment = UIOffset(horizontal: -30, vertical: 0.0);
        
        return mainTabBar
    }
    
    deinit {
         clearObserver()
     }
     
     func setupObserver() {
         NotificationCenter.default.addObserver(self,
                                                selector: #selector(handleNotification(_:)),
                                                name: NSNotification.Name("UpdatePlayer"),
                                                object: nil)
         
        
     }
     
     func clearObserver() {
         NotificationCenter.default.removeObserver(self)
     }
     
     @objc func handleNotification(_ sender: Notification) {
         if isPlaying {
             setupPlayerData()
             showPlayer(show: true)
//             playButton.setImage(UIImage(named:"pause"), for: .normal)
         } else {
//             playButton.setImage(UIImage(named:"play"), for: .normal)
         }
         print("Khaled")
     }
        
    @objc func playerVisibilityHidden(notif: Notification) {
        let show = notif.object as? Bool ?? false
        self.hidePlayer(hide: show)
    }
    
    @objc func playerVisibilityShown(notif: Notification) {
        let show = notif.object as? Bool ?? true
        self.showPlayer(show: show)
    }
}

// MARK:- Private Methods
extension MainTabBar {
    
    private func setupTabBar() {
        
        
        let blurEffect = UIBlurEffect(style: .systemMaterialDark)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        visualEffectView.effect = blurEffect
          // Set the frame of the visual effect view to cover the entire screen
        visualEffectView.frame = tabBar.bounds
          
          // Insert the visual effect view below the tab bar
        tabBar.insertSubview(visualEffectView, at: 0)
        self.tabBar.isTranslucent = true
        self.tabBar.backgroundColor = .clear
        self.tabBar.barStyle = .black
        self.tabBar.backgroundImage = UIImage()
        self.tabBar.unselectedItemTintColor = .white.withAlphaComponent(0.4)
        self.tabBar.tintColor = UIColor(named: "mainColor")
        
        // Bn3ml el container bta3na ya st el kol
        containerView.backgroundColor = UIColor(hex: "1E1E1E", alpha: 1)
        view.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        containerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: tabBar.topAnchor).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 72).isActive = true
        
        // n7dr b2a kol el m2ader bta3tna
        songImage  = UIImageView()
        songName   = UILabel()
        songArtist = UILabel()
        favButton  = UIButton()
        playButton = UIButton()
        // n7ot el m2ader ya 7bibte x el 7ala
        containerView.addSubview(songImage)
        containerView.addSubview(songName)
        containerView.addSubview(songArtist)
        containerView.addSubview(playButton)
        containerView.addSubview(favButton)
        
       
        
        // El 7rkat w el tkat
        songImage.image = UIImage(named: "Component 1")
        Public.setupLabel(label: songName, text: "Killer", size: 14, color: .white)
        Public.setupLabel(label: songArtist, text: "Eminem", size: 12, color: UIColor(hex: "FFFFFF", alpha: 0.56))
        Public.setupButton(button: playButton, imgString: "playButton")
        Public.setupButton(button: favButton, imgString: "heartIt")
        
        
        // Targets
        playButton.addTarget(self, action:#selector(MainTabBar.playTarget(_sender:)), for: .touchUpInside)
        // N7ot ml7 3shan el t3m
        songImage.translatesAutoresizingMaskIntoConstraints = false
        songName.translatesAutoresizingMaskIntoConstraints = false
        songArtist.translatesAutoresizingMaskIntoConstraints = false
        playButton.translatesAutoresizingMaskIntoConstraints = false
        favButton.translatesAutoresizingMaskIntoConstraints = false
        
        // Negi b2a l decore
        NSLayoutConstraint.activate([
            
            songImage.widthAnchor.constraint(equalToConstant: 48),
            songImage.heightAnchor.constraint(equalToConstant: 48),
            songImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            songImage.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
            songName.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 14.5),
            songName.leadingAnchor.constraint(equalTo: songImage.trailingAnchor, constant: 12),
            songName.widthAnchor.constraint(equalToConstant: 200),
            songName.heightAnchor.constraint(equalToConstant: 18),
            
            
            songArtist.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -14.5),
            songArtist.leadingAnchor.constraint(equalTo: songImage.trailingAnchor, constant: 12),
            songArtist.widthAnchor.constraint(equalToConstant: 200),
            songArtist.heightAnchor.constraint(equalToConstant: 18),
            
            playButton.widthAnchor.constraint(equalToConstant: 45),
            playButton.heightAnchor.constraint(equalToConstant: 45),
            playButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            playButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
            favButton.widthAnchor.constraint(equalToConstant: 45),
            favButton.heightAnchor.constraint(equalToConstant: 45),
            favButton.trailingAnchor.constraint(equalTo: playButton.leadingAnchor, constant: -12),
            favButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
        ])
        
        
    }
    @objc public func playTarget(_sender: UIButton) {
        
        if isPlaying {
            musicPlayer.pause()
            playButton.setImage(UIImage(named: "play"), for: .normal)
        } else if isPlaying == true {
            musicPlayer.play()
            playButton.setImage(UIImage(named: "pause"), for: .normal)
        } else {
            return
        }

        }
    
    func setupPlayerData() {
        
        songName.text = nowPlayingTrack?.attributes?.name
        songArtist.text = nowPlayingTrack?.attributes?.artistName
        
        
        if isPlaying {
            showPlayer(show: true)
            playButton.setImage(UIImage(named: "pause"), for: .normal)
        } else {
            playButton.setImage(UIImage(named: "play"), for: .normal)
        }
    }
    
    
    
    
    
    
    
    func hidePlayer(hide: Bool) {
        self.containerView.isHidden = true
    }
    
    func showPlayer(show: Bool) {
        self.containerView.isHidden = false
    }
    
    private func createServiceSearchVC() -> UIViewController {
        let searchVC = UIStoryboard(name: "SearchVC", bundle: nil).instantiateViewController(withIdentifier: "SearchVC") as! SearchVC
        searchVC.tabBarItem = UITabBarItem(title: "Search", image: UIImage(named: "search"), tag: 1)

        
        return searchVC
    }
    
    private func createHistoryVC() -> UIViewController {
        let historyVC = UIStoryboard(name: "HistoryVC", bundle: nil).instantiateViewController(withIdentifier: "HistoryVC") as! HistoryVC
        historyVC.tabBarItem = UITabBarItem(title: "History", image: UIImage(named: "history"), tag: 2)
        
        return historyVC
    }
    
    private func createPlaylistVC() -> UIViewController {
        let playlistVC = UIStoryboard(name: "PlaylistVC", bundle: nil).instantiateViewController(withIdentifier: "PlaylistVC") as! PlaylistVC
        playlistVC.tabBarItem = UITabBarItem(title: "Playlist", image: UIImage(named: "playlist"), tag: 2)
        
        
        return playlistVC
    }
}
