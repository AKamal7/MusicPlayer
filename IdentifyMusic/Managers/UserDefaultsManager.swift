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
    
    var isFirstTime: Bool? {
        set {
            UserDefaults.standard.set(newValue, forKey: "firstTime")
        }
        get {
            guard UserDefaults.standard.object(forKey: "firstTime") != nil else {
                return nil
            }
            return UserDefaults.standard.bool(forKey: "firstTime")
        }
    }
    
    var premiumUser: Bool? {
        set {
            UserDefaults.standard.set(newValue, forKey: "premiumUser")
        }
        get {
            guard UserDefaults.standard.object(forKey: "premiumUser") != nil else {
                return nil
            }
            return UserDefaults.standard.bool(forKey: "premiumUser")
        }
    }
    
    var youtubeEnabled: Bool? {
        set {
            UserDefaults.standard.set(newValue, forKey: "youtubeEnabled")
        }
        get {
            guard UserDefaults.standard.object(forKey: "youtubeEnabled") != nil else {
                return nil
            }
            return UserDefaults.standard.bool(forKey: "youtubeEnabled")
        }
    }
    
    var appleMusicPremium: Bool? {
        set {
            UserDefaults.standard.set(newValue, forKey: "appleMusicPremium")
        }
        get {
            guard UserDefaults.standard.object(forKey: "appleMusicPremium") != nil else {
                return nil
            }
            return UserDefaults.standard.bool(forKey: "appleMusicPremium")
        }
    }
}
