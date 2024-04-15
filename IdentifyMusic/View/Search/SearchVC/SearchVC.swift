//
//  ViewController.swift
//  IdentifyMusic
//
//  Created by ahmedkamal on 08/03/2024.
//

import UIKit
import MediaPlayer

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
        premiumVC.modalPresentationStyle = .overFullScreen
        self.present(premiumVC,animated: false) {
            
        }
        
        
    }
    
    
    
    
}




