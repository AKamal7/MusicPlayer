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
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    @IBAction func backBtnClicked(_ sender: UIButton) {
        self.dismiss(animated: false)
    }
    
    
    func setupView() {
        
        Public.setupLabelWithMedium(label: titleLabel, text: "Settings", size: 20, color: .white)
        Public.setupButton(button: contactBtn, imgString: "contactBtn")
        Public.setupButton(button: backButton, imgString: "backButton")
        Public.setupLabel(label: contactLabel, text: "Contact", size: 18, color: .white)
    }

   
}
