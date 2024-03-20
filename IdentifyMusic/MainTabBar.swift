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
        return mainTabBar
    }
}

// MARK:- Private Methods
extension MainTabBar {
    
    private func setupTabBar() {
        self.tabBar.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        self.tabBar.unselectedItemTintColor = .white.withAlphaComponent(0.4)
        self.tabBar.tintColor = UIColor(named: "mainColor")
//        self.tabBar.inputViewController?.edgesForExtendedLayout = .bottom
//        self.tabBar.inputViewController?.edgesForExtendedLayout = .top

        let blurEffect = UIBlurEffect(style: .light)

             // Create a visual effect view with the blur effect
             let visualEffectView = UIVisualEffectView(effect: blurEffect)

             // Set the frame of the visual effect view to cover the area below the tab bar
             let tabBarFrame = tabBar.frame
        visualEffectView.frame = self.view.bounds

             // Add the visual effect view below the tab bar
        
        tabBar.addSubview(visualEffectView)
    }
    
    private func createServiceSearchVC() -> UINavigationController {
        let searchVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SearchVC") as! SearchVC
        searchVC.tabBarItem = UITabBarItem(title: "Search", image: UIImage(named: "search"), tag: 1)
        let searchNavigation = UINavigationController()
        searchNavigation.viewControllers = [searchVC]
        return searchNavigation
    }
    
    private func createHistoryVC() -> UINavigationController {
        let historyVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HistoryVC") as! HistoryVC
        historyVC.tabBarItem = UITabBarItem(title: "History", image: UIImage(named: "history"), tag: 2)
        let favoriteNavigation = UINavigationController()
        favoriteNavigation.viewControllers = [historyVC]
        return favoriteNavigation
    }
    
    private func createPlaylistVC() -> UINavigationController {
        let playlistVC = UIStoryboard(name: "PlaylistVC", bundle: nil).instantiateViewController(withIdentifier: "PlaylistVC") as! PlaylistVC
        playlistVC.tabBarItem = UITabBarItem(title: "Playlist", image: UIImage(named: "playlist"), tag: 3)
        let playlistNavigation = UINavigationController()
        playlistNavigation.viewControllers = [playlistVC]
        return playlistNavigation
    }
}
