//
//  ViewController.swift
//  IdentifyMusic
//
//  Created by ahmedkamal on 08/03/2024.
//

import UIKit
import MediaPlayer
import Cider
import CupertinoJWT
import SwiftJWT
import StoreKit

struct DeveloperTokenClaims: Claims {
    let iss: String
    let iat: Date
    let exp: Date
}

class SearchVC: UIViewController {
   
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var settingBtn: UIButton!
    
    @IBOutlet weak var searchBtnOutlet: UIButton!
    @IBOutlet weak var adView: UIView!
    
    @IBOutlet weak var songImgView: UIImageView!
    
    
    @IBOutlet weak var instructionsView: UIView!
    
    @IBOutlet weak var pulsyContainerView: UIView!
    
    @IBOutlet weak var closeRecognitionBtn: UIButton!
    
    @IBOutlet weak var hummingResponseLbl: UILabel!
    @IBOutlet weak var assistLabel: UIView!
    
    //RedScreen
    @IBOutlet weak var backBtnOutlet: UIButton!
    @IBOutlet weak var backLbl: UILabel!
    @IBOutlet weak var noSongAlertLbl: UIView!
    @IBOutlet weak var tapLbl: UILabel!
    
    //    let player = MPMusicPlayerController.systemMusicPlayer
    
    @IBOutlet weak var pulsyBtn: UIButton!
    
    var isPaused = true
    var timer = Timer()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        closeRecognitionBtn.isHidden = true
        hummingResponseLbl.isHidden = true
        assistLabel.isHidden = true
        
        backBtnOutlet.isHidden = true
        backLbl.isHidden = true
        noSongAlertLbl.isHidden = true
        tapLbl.isHidden = true
        
        setupView()
        
        
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
            print(token, "tokeeen")
            let cider = CiderClient(storefront: .unitedStates, developerToken: token)
            cider.search(term: "Michael Jackson", types: [.songs]) { results, error in
                print(error?.localizedDescription, "Errror")
//                print(results, "resultsss")
                if let songs = results?.songs?.data {
                    for song in songs {
                        print(song.attributes?.name)
                    }
                }
              
                //            }
            }
        } catch {
            print(error)
        }
        
        
//        SKCloudServiceController.requestAuthorization { (status) in
//               if status == .authorized {
//                   print(AppleMusicAPI().fetchStorefrontID())
//               }
//           }
        
    }
    
    func generateDeveloperToken(teamId: String, keyId: String, privateKey: String) throws -> String {
        guard let privateKeyData = privateKey.data(using: .utf8) else {
            throw NSError(domain: "PrivateKeyConversionError", code: 0, userInfo: nil)
        }
        
        let signer = JWTSigner.es256(privateKey: privateKeyData)
        
        let now = Date()
        let oneHourFromNow = now.addingTimeInterval(60 * 60)
        
        let claims = DeveloperTokenClaims(iss: teamId, iat: now, exp: oneHourFromNow)
        
        var jwt = JWT(claims: claims)
        let jwtData = try jwt.sign(using: signer)
        return jwtData
    }
    
    func setBlurView() {
        // Init a UIVisualEffectView which going to do the blur for us
        let blurView = UIVisualEffectView()
        // Make its frame equal the main view frame so that every pixel is under blurred
        blurView.frame = view.frame
        // Choose the style of the blur effect to regular.
        // You can choose dark, light, or extraLight if you wants
        blurView.effect = UIBlurEffect(style: .regular)
        // Now add the blur view to the main view
        //           view.addSubview(blurView)
        view.addSubview(blurView)

    }

    @objc func update() {
       noSongView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        setupPulsy()
    }
    
    
    @IBAction func pulsyBtnPressed(_ sender: UIButton) {
        hearingView()
        
    }
    
    @IBAction func searchBtnPressed(_ sender: UIButton) {
        let vc = UIStoryboard(name: "SearchResultsVC", bundle: nil).instantiateViewController(withIdentifier: "SearchResultsVC") as! SearchResultsVC
        self.navigationController?.pushViewController(vc, animated: false)
        print("ahaahah")
    }
    
    @IBAction func searchClicked(_ sender: UIButton) {
        
    }
    
    @IBAction func backBtnPressed(_ sender: UIButton) {
      
        backToOriginal()
    }
    
    private func hearingView() {
        
    
        timer = Timer.scheduledTimer(timeInterval: 6, target: self, selector: #selector(self.update), userInfo: nil, repeats: false)
    
      
        pulsyBtn.setImage(UIImage(named: "Component 1"), for: .normal)
        songImgView.isHidden = false
      
        self.view.backgroundColor = UIColor(hex: "1E1029", alpha: 1)
        adView.isHidden = true
        searchBar.isHidden = true
        searchBtnOutlet.isHidden = true
        settingBtn.isHidden = true
        instructionsView.isHidden = true
        closeRecognitionBtn.isHidden = false
        hummingResponseLbl.isHidden = false
        assistLabel.isHidden = false
        tabBarController?.tabBar.isHidden = true
        hidePlayer()
        backLbl.isHidden = true
        backBtnOutlet.isHidden = true
        noSongAlertLbl.isHidden = true
        tapLbl.isHidden = true
        pulsyBtn.isEnabled = false
        pulsyAnimation()
    }
    
    private func noSongView() {
        self.view.backgroundColor = UIColor(hex: "2C1010", alpha: 1)
        pulsyBtn.setImage(UIImage(named: "Frame 10"), for: .normal)
        backBtnOutlet.isHidden = false
        backLbl.isHidden = false
        noSongAlertLbl.isHidden = false
        tapLbl.isHidden = false
        songImgView.isHidden = true
        closeRecognitionBtn.isHidden = true
        hummingResponseLbl.isHidden = true
        assistLabel.isHidden = true
        pulsyBtn.layer.removeAllAnimations()
        pulsyBtn.isEnabled = true
    }
    
    private func backToOriginal() {
        self.view.backgroundColor = UIColor(hex: "141414", alpha: 1)

        closeRecognitionBtn.isHidden = true
        hummingResponseLbl.isHidden = true
        assistLabel.isHidden = true
        backBtnOutlet.isHidden = true
        backLbl.isHidden = true
        noSongAlertLbl.isHidden = true
        tapLbl.isHidden = true
        adView.isHidden = false
        searchBar.isHidden = false
        searchBtnOutlet.isHidden = false
        settingBtn.isHidden = false
        instructionsView.isHidden = false
        tabBarController?.tabBar.isHidden = false
        showPlayer()
        pulsyBtn.setImage(UIImage(named: "Component 1"), for: .normal)
        pulsyBtn.isEnabled = true
        songImgView.isHidden = false
        pulsyAnimation()
        
    }
    private func pulsyAnimation() {
        
        let pulse1 = CASpringAnimation(keyPath: "transform.scale")
        pulse1.duration = 1
        pulse1.fromValue = 1.0
        pulse1.toValue = 1.12
        pulse1.autoreverses = true
        pulse1.repeatCount = 1
        pulse1.initialVelocity = 0.5
        pulse1.damping = 0.8
        
        let animation = CAKeyframeAnimation(keyPath: "transform.scale")
        
         animation.values = [1.0, 1.2, 1.0]
        animation.keyTimes = [0, 0.5, 1]
         animation.duration = 1.0
         animation.repeatCount = Float.infinity
      
        pulsyBtn.layer.add(animation, forKey: "pulse")
    }
    
    // MARK:- Private Methods
    private func setupView() {
        tabBarController?.selectedIndex = 0
        self.view.backgroundColor = UIColor(hex: "141414", alpha: 1)
        setupSearchBar()
        setupSettingBtn()
//        setupPulsy()
    }
    
    private func hidePlayer() {
        let hide = false
        NotificationCenter.default.post(name: Notification.Name(rawValue: "hidePlayer"), object: hide)
    }
    
    private func showPlayer() {
        let show = true
        NotificationCenter.default.post(name: Notification.Name(rawValue: "showPlayer"), object: show)
    }
    
    private func setupSettingBtn() {
        
        settingBtn.borderWidth = 1
        settingBtn.borderColor = UIColor(hex: "2b2b2b", alpha: 1)
        settingBtn.layer.cornerRadius = 12
        settingBtn.clipsToBounds = true
        
        
    }
    private func setupPulsy() {
        
        pulsyBtn.setImage(UIImage(named: "Component 1"), for: .normal)
        pulsyBtn.isUserInteractionEnabled = true
        pulsyBtn.isEnabled = true
        
        pulsyAnimation()
    }
    
    @objc func addButtonTapped() {
        
    }
    
    @IBAction func closeRecogntionBtnPressed(_ sender: UIButton) {
        self.view.backgroundColor = UIColor(hex: "141414", alpha: 1)
        adView.isHidden = false
        searchBar.isHidden = false
        searchBtnOutlet.isHidden = false
        settingBtn.isHidden = false
        instructionsView.isHidden = false
        closeRecognitionBtn.isHidden = true
        hummingResponseLbl.isHidden = true
        assistLabel.isHidden = true
        tabBarController?.tabBar.isHidden = false
        showPlayer()

        
    }
    
    @IBAction func settingsBtnClicked(_ sender: UIButton) {
       
        let settings = UIStoryboard(name: "SettingsVC", bundle: nil).instantiateViewController(withIdentifier: "SettingsVC") as! SettingsVC
        settings.modalPresentationStyle = .fullScreen
        self.present(settings,animated: false,completion: nil)
    }
    
    @IBAction func getPremiumTapped(_ sender: UIButton) {
        
        let premiumVC = UIStoryboard(name: "PremiumVC", bundle: nil).instantiateViewController(withIdentifier: "PremiumVC") as! PremiumVC
        premiumVC.modalPresentationStyle = .custom
        self.present(premiumVC, animated: false, completion: nil)
         
        self.setBlurView()
        premiumVC.delegate = self

     
        
    }
    
    
    
    
}




extension SearchVC: BlurVCDelegate {
    
    func removeBlurView() {
         for subview in view.subviews {
             if subview.isKind(of: UIVisualEffectView.self) {
                 subview.removeFromSuperview()
             }
         }
     }
    
    
}
