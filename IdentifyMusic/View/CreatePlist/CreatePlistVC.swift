//
//  CreatePlistVC.swift
//  IdentifyMusic
//
//  Created by Khaled Abo hassob on 19/3/2024.
//

import UIKit

class CreatePlistVC: UIViewController {

    @IBOutlet weak var createPlayistTxtField: UITextField!
    @IBOutlet weak var createPlaylistBtn: UIButton!
    @IBOutlet weak var createPlaylistLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    private func setupView() {
        view.backgroundColor = UIColor(hex: "141414")
        setupNavBar()
        setupLabel()
        setupTextField()
        setupButton()
    }
    private func setupNavBar() {
        
        let navC = self.navigationController
        let navB = navC?.navigationBar
        navB?.backgroundColor = UIColor(hex: "141414", alpha: 1)
        
        
        navC?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navC?.navigationBar.shadowImage = UIImage()
        
        //SettingUp title
        let title = UILabel()
        title.text      = "Create new playlist"
        title.textColor = .white
        title.font = UIFont(name: "Heebo-Regular", size: 20)
        
        //Setting up Spacer
        let spacer      = UIView()
        let constraint  = spacer.widthAnchor.constraint(greaterThanOrEqualToConstant: CGFloat.greatestFiniteMagnitude)
        constraint.isActive = true
        constraint.priority = .defaultLow
        
        //Creating stackView
        let stack                = UIStackView(arrangedSubviews: [title, spacer])
        stack.axis               = .horizontal
        navigationItem.titleView = stack
        
        //Setup back button
        let backBtnImage = UIImage(named: "backButton")
        navB?.backIndicatorImage = backBtnImage
        navB?.backIndicatorTransitionMaskImage = backBtnImage
        
        
    }
    private func setupLabel() {
        createPlaylistLabel.text = "Your playlist name"
        createPlaylistLabel.font = UIFont(name: "Heebo-Regular", size: 14)
        createPlaylistLabel.textColor = UIColor(hex: "FFFFFF")
    }
    private func setupTextField() {
        createPlayistTxtField.placeholder = "Playlist 1"
        createPlayistTxtField.textColor = UIColor(hex: "FFFFFF")
        createPlayistTxtField.layer.borderWidth = 1
        createPlayistTxtField.layer.borderColor = UIColor(hex: "2b2b2b").cgColor
        createPlayistTxtField.layer.cornerRadius = 12
        createPlayistTxtField.clipsToBounds = true
        createPlayistTxtField.backgroundColor = UIColor(hex: "141414")
    }
    private func setupButton() {
        createPlaylistBtn.layer.cornerRadius = 12
        createPlaylistBtn.setTitle("", for: .normal)
        createPlaylistBtn.setImage(UIImage(named: "createButton"), for: .normal)
//        createPlaylistBtn.clipsToBounds = true
    }
}
