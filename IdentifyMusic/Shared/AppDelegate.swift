//
//  AppDelegate.swift
//  IdentifyMusic
//
//  Created by ahmedkamal on 08/03/2024.
//

import UIKit
import CupertinoJWT
import StoreKit
import AVFoundation
import MediaPlayer
import Cider

var isPlaying: Bool = false
var isAuthorized = false
var player: AVPlayer!
var musicPlayer: MPMusicPlayerController!
var nowPlayingTrack: Cider.Track?


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    var window:UIWindow?
     
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if UserDefaultsManager.shared().isFirstTime == nil || UserDefaultsManager.shared().isFirstTime == false {
            UserDefaultsManager.shared().isFirstTime = true
            UserDefaultsManager.shared().appleMusicPremium = true
            UserDefaultsManager.shared().youtubeEnabled = false
            print(UserDefaultsManager.shared().isFirstTime, "firstTimeee")
        }
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.makeKeyAndVisible()
        getDeveloperToken()
        appleMusicCheckIfDeviceCanPlayback()
        appleMusicRequestPermission()
        appleMusicFetchStorefrontRegion()

        
        let lunchScreen = UIStoryboard(name: "LunchScreenLoadVC", bundle: nil).instantiateViewController(withIdentifier: "LunchScreenLoadVC") as! LunchScreenLoadVC
        window?.rootViewController = lunchScreen
        
//        UIApplication.shared.statusBarView?.tintColor = UIColor(hex: "141414", alpha: 1)
        
        return true
    }
    
    func getDeveloperToken() {
        let p8 = """
            -----BEGIN PRIVATE KEY-----
            MIGTAgEAMBMGByqGSM49AgEGCCqGSM49AwEHBHkwdwIBAQQg1rLpjJ1IxyLHl1dl
            oo3IKO9x1Wv/4msdMXXll5nhhIigCgYIKoZIzj0DAQehRANCAATkIJJnP6Tfabtd
            MXlkfJqAVeKGfQ0pAe3FIbxjdYgHfEBp4q+oCGklkBcHnYZO1XfzwW82xntW6bkU
            0wWARvaV
            -----END PRIVATE KEY-----
            """

        let jwt = JWT(keyID: "SQ9L7MVJ9R", teamID: "ZHXVY6M87Z", issueDate: Date(), expireDuration: 60 * 60)

        do {
            let token = try jwt.sign(with: p8)
            UserDefaultsManager.shared().token = token
            print(UserDefaultsManager.shared().token, "tokeeen")
            SKCloudServiceController().requestUserToken(forDeveloperToken: token) { userToken, error in
                if userToken != nil {
                    isAuthorized = true
                } else {
                    isAuthorized = false
                }
                print("Flagtoken2",userToken)
            }

        } catch {
            print(error)
        }
    }
    
    func appleMusicCheckIfDeviceCanPlayback() {
        let serviceController = SKCloudServiceController()
        serviceController.requestCapabilities { (capability:SKCloudServiceCapability, err: Error?) in
                
            switch capability {
                
            case []:
        
                print("The user doesn't have an Apple Music subscription available. Now would be a good time to prompt them to buy one?")
                
            case SKCloudServiceCapability.musicCatalogPlayback:
                
                print("The user has an Apple Music subscription and can playback music!")
                
            case SKCloudServiceCapability.addToCloudMusicLibrary:
                
                print("The user has an Apple Music subscription, can playback music AND can add to the Cloud Music Library")
                
            default: break
                
            }
            
        }
        
    }
    
    func appleMusicRequestPermission() {
        
        SKCloudServiceController.requestAuthorization { (status:SKCloudServiceAuthorizationStatus) in
            
            switch status {
                
            case .authorized:
                
                print("All good - the user tapped 'OK', so you're clear to move forward and start playing.")
                
            case .denied:
                
                print("The user tapped 'Don't allow'. Read on about that below...")
                
            case .notDetermined:
                
                print("The user hasn't decided or it's not clear whether they've confirmed or denied.")
                
            case .restricted:
                
                print("User may be restricted; for example, if the device is in Education mode, it limits external Apple Music usage. This is similar behaviour to Denied.")
                
            @unknown default:
                print("Error....")
            }
            
        }
        
    }
    
    func appleMusicFetchStorefrontRegion() {
        
        let serviceController = SKCloudServiceController()
        serviceController.requestStorefrontIdentifier { (storefrontId:String?, err: Error?) in
            
            guard err == nil else {
                
                print("An error occured. Handle it here.")
                return
                
            }
            
            guard let storefrontId = storefrontId, storefrontId.count >= 6 else {
                
                print("Handle the error - the callback didn't contain a valid storefrontID.")
                return
                
            }
            
            let endIndex = storefrontId.index(storefrontId.startIndex, offsetBy: 5)
            let indexRange = storefrontId.startIndex...endIndex
            let trimmedId = String(storefrontId[indexRange])

//            let indexRange = Range(storefrontId.startIndex...storefrontId.startIndex.advancedBy(5))
//            let trimmedId = storefrontId.substringWithRange(indexRange)
//
            print("Success! The user's storefront ID is: \(trimmedId)")
            
        }
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


