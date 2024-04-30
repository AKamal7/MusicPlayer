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
import StoreKit

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
        recognizeSong()
        print("111...")
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
    
    func recognizeSong() {
        let apiUrlString = "https://api.audd.io/"
        let apiKey = "5239c12f53949b82c14d2fd822102c01" // Replace with your Audd.io API key

        guard let apiUrl = URL(string: apiUrlString) else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: apiUrl)
        request.httpMethod = "POST"
        print(apiUrl, "API URLLL")
        // Set the required parameters
        let parameters: [String: Any] = [
            "api_token": apiKey,
            // Add either "url" or "file" parameter based on the recognition method you're using
            // Example using URL:
            "url": "https://commondatastorage.googleapis.com/codeskulptor-demos/pyman_assets/ateapill.ogg",
            // Example using file:
            // "file": fileData
            "return": "apple_music"
        ]

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: [])
            request.httpBody = jsonData
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")

            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    print("Error: \(error)")
                } else if let data = data {
                    // Parse the response JSON
                    if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        // Handle the recognition response
                        self.handleRecognitionResponse(json)
                        print(data,"RecognitionDAtaa")
                    }
                }
            }

            task.resume()
        } catch {
            print("Error creating JSON data: \(error)")
        }
    }
    
    func handleRecognitionResponse(_ response: [String: Any]) {
        // Process the recognition response here
        // You can extract the recognized song information from the response dictionary
        // For example, you can access the "title", "artist", or "album" fields

        if let title = response["title"] as? String {
            print("Title: \(title)")
        }

        if let artist = response["artist"] as? String {
            print("Artist: \(artist)")
        }

        if let album = response["album"] as? String {
            print("Album: \(album)")
        }
        
        print(response, "Response")

        // Continue with further processing or UI updates based on the recognition results
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
