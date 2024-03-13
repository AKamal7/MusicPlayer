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
        mainTabBar.viewControllers = [searchNavigation, favoriteNavigation, appointmentsNavigation]
        return mainTabBar
    }
}

// MARK:- Private Methods
extension MainTabBar {
    private func setupTabBar() {
        self.tabBar.backgroundColor = UIColor.gray
        self.tabBar.tintColor = UIColor(named: "mainColor")
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
        let playlistVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PlayListVC") as! PlayListVC
        playlistVC.tabBarItem = UITabBarItem(title: "Playlist", image: UIImage(named: "playlist"), tag: 3)
        let playlistNavigation = UINavigationController()
        playlistNavigation.viewControllers = [playlistVC]
        return playlistNavigation
    }
}
