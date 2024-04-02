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
    
    @IBOutlet weak var titleBarItem: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    @IBAction func popScreenBtn(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
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
        
        let attributes = [NSAttributedString.Key.font: UIFont(name: "Heebo-Regular", size: 20)!, NSAttributedString.Key.foregroundColor: UIColor.white]
        titleBarItem.setTitleTextAttributes(attributes, for: .disabled)
        
        
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
