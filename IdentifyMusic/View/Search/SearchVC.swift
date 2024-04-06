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
    let player = MPMusicPlayerController.systemMusicPlayer
    
    @IBOutlet weak var pulsyBtn: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       
        setupView()
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupPulsy()
    }
    
    @IBAction func searchClicked(_ sender: UIButton) {
    }
    // MARK:- Private Methods
    private func setupView() {
        tabBarController?.selectedIndex = 0
        self.view.backgroundColor = UIColor(hex: "141414", alpha: 1)
        setupSearchBar()
        setupSettingBtn()
//        setupPulsy()
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
    
    @objc func addButtonTapped() {
        
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





