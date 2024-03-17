//
//  AppDelegate.swift
//  IdentifyMusic
//
//  Created by ahmedkamal on 08/03/2024.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    var window:UIWindow?
     
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.makeKeyAndVisible()
        let tabbar = MainTabBar.create()
        window?.rootViewController = tabbar
        
        
        
        return true
    }
    
}
