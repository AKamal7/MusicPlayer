//
//  MainTabBarVC.swift
//  IdentifyMusic
//
//  Created by ahmedkamal on 09/03/2024.
//

import UIKit

class MainTabBar: UITabBarController {

    // MARK:- LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    // MARK:- Public Methods
    class func create() -> MainTabBar {
        let mainTabBar = MainTabBar()
        let searchNavigation = mainTabBar.createServiceSearchVC()
        let favoriteNavigation = mainTabBar.createHistoryVC()
        let appointmentsNavigation = mainTabBar.createPlaylistVC()
        mainTabBar.viewControllers = [favoriteNavigation, searchNavigation, appointmentsNavigation]
        mainTabBar.selectedIndex = 1
        mainTabBar.tabBar.items!.first?.titlePositionAdjustment = UIOffset(horizontal: 30, vertical: 0.0);
        mainTabBar.tabBar.items!.last?.titlePositionAdjustment = UIOffset(horizontal: -30, vertical: 0.0);
        
        return mainTabBar
    }
}

// MARK:- Private Methods
extension MainTabBar {
    
    private func setupTabBar() {
        self.tabBar.isTranslucent = true
        self.tabBar.backgroundColor = .clear
        self.tabBar.backgroundImage = UIImage()
        self.tabBar.unselectedItemTintColor = .white.withAlphaComponent(0.4)
        self.tabBar.tintColor = UIColor(named: "mainColor")
        
        let blurEffect = UIBlurEffect(style: .light)
          let visualEffectView = UIVisualEffectView(effect: blurEffect)
          
          // Set the frame of the visual effect view to cover the entire screen
        visualEffectView.frame = tabBar.bounds
          
          // Insert the visual effect view below the tab bar
          view.insertSubview(visualEffectView, belowSubview: tabBar)
        
    }
    
    private func createServiceSearchVC() -> UINavigationController {
        let searchVC = UIStoryboard(name: "SearchVC", bundle: nil).instantiateViewController(withIdentifier: "SearchVC") as! SearchVC
        searchVC.tabBarItem = UITabBarItem(title: "Search", image: UIImage(named: "search"), tag: 1)
        let searchNavigation = UINavigationController()
        searchNavigation.viewControllers = [searchVC]
        return searchNavigation
    }
    
    private func createHistoryVC() -> UINavigationController {
        let historyVC = UIStoryboard(name: "HistoryVC", bundle: nil).instantiateViewController(withIdentifier: "HistoryVC") as! HistoryVC
        historyVC.tabBarItem = UITabBarItem(title: "History", image: UIImage(named: "history"), tag: 2)
        let favoriteNavigation = UINavigationController()
        favoriteNavigation.viewControllers = [historyVC]
        return favoriteNavigation
    }
    
    private func createPlaylistVC() -> UINavigationController {
        let playlistVC = UIStoryboard(name: "PlaylistVC", bundle: nil).instantiateViewController(withIdentifier: "PlaylistVC") as! PlaylistVC
        playlistVC.tabBarItem = UITabBarItem(title: "Playlist", image: UIImage(named: "playlist"), tag: 2)
        let plistNav = UINavigationController()
        plistNav.viewControllers = [playlistVC]
        
        
        return plistNav
    }
}
