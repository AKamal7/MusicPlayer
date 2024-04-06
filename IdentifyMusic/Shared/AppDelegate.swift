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
        
        
        let lunchScreen = UIStoryboard(name: "LunchScreenLoadVC", bundle: nil).instantiateViewController(withIdentifier: "LunchScreenLoadVC") as! LunchScreenLoadVC
        window?.rootViewController = lunchScreen
        
//        UIApplication.shared.statusBarView?.tintColor = UIColor(hex: "141414", alpha: 1)
        
        return true
    }
    
}

extension UIApplication {
    var statusBarView: UIView? {
        if responds(to: Selector(("statusBarManager"))) {
            return value(forKey: "statusBarManager") as? UIView
        }
        return nil
    }
}


