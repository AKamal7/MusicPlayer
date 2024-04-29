//
//  UserDefaultManager.swift
//  IdentifyMusic
//
//  Created by ahmedkamal on 29/04/2024.
//

import Foundation


class UserDefaultsManager {
    
    // MARK:- Singleton
    private static let sharedInstance = UserDefaultsManager()
    
    class func shared() -> UserDefaultsManager {
        return UserDefaultsManager.sharedInstance
    }
    
    // MARK:- Properties
    var token: String? {
        set {
            UserDefaults.standard.set(newValue, forKey: "developerToken")
        }
        get {
            guard UserDefaults.standard.object(forKey: "developerToken") != nil else {
                return nil
            }
            return UserDefaults.standard.string(forKey: "developerToken")!
        }
    }
}
