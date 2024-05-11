//
//  SettingsVC.swift
//  IdentifyMusic
//
//  Created by ahmedkamal on 05/04/2024.
//

import UIKit

class SettingsVC: UIViewController {

    @IBOutlet weak var contactBtn: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contactLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var appleMusicSwitch: UISwitch!
    @IBOutlet weak var youtubeSwitch: UISwitch!
    @IBOutlet weak var premiumSwitch: UISwitch!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupIntialValues()
    }
    
    @IBAction func backBtnClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func premiumSwitchChanged(_ sender: UISwitch) {
        if sender.isOn {
            UserDefaultsManager.shared().premiumUser = true
        } else {
            UserDefaultsManager.shared().premiumUser = false
        }
    }
    
    @IBAction func appleMusicSwitchChanged(_ sender: UISwitch) {
        print(sender.isOn, "isOnnnn", sender.tag)
        if sender.tag == 0 {
            if sender.isOn {
                appleMusicSwitch.isOn = true
                youtubeSwitch.isOn = false
                UserDefaultsManager.shared().appleMusicPremium = true
                UserDefaultsManager.shared().youtubeEnabled = false
            } else {
                appleMusicSwitch.isOn = false
                youtubeSwitch.isOn = true
                UserDefaultsManager.shared().appleMusicPremium = false
                UserDefaultsManager.shared().youtubeEnabled = true
            }
        } else {
            if sender.isOn {
                appleMusicSwitch.isOn = false
                youtubeSwitch.isOn = true
                UserDefaultsManager.shared().youtubeEnabled = true
                UserDefaultsManager.shared().appleMusicPremium = false
            } else {
                appleMusicSwitch.isOn = true
                youtubeSwitch.isOn = false
                UserDefaultsManager.shared().youtubeEnabled = false
                UserDefaultsManager.shared().appleMusicPremium = true
            }
        }
        print(UserDefaultsManager.shared().youtubeEnabled, "youtube", UserDefaultsManager.shared().appleMusicPremium, "appleMusic")
        
    }
    
    func setupView() {
        Public.setupLabelWithMedium(label: titleLabel, text: "Settings", size: 20, color: .white)
        Public.setupButton(button: contactBtn, imgString: "contactBtn")
        Public.setupButton(button: backButton, imgString: "backButton")
        Public.setupLabel(label: contactLabel, text: "Contact", size: 18, color: .white)
    }
    
    func setupIntialValues() {
        appleMusicSwitch.isOn = UserDefaultsManager.shared().appleMusicPremium ?? false
        youtubeSwitch.isOn = UserDefaultsManager.shared().youtubeEnabled ?? false
    }

   
}
