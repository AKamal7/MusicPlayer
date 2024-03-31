//
//  SettingsVC.swift
//  IdentifyMusic
//
//  Created by ahmedkamal on 22/03/2024.
//

import UIKit

class SettingsVC: UIViewController {
    
    
    @IBOutlet weak var navTitleOutlet: UIBarButtonItem!
    @IBOutlet weak var contactBtnOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
                let attributes = [NSAttributedString.Key.font: UIFont(name: "Heebo-Regular", size: 20)!, NSAttributedString.Key.foregroundColor: UIColor.white]
        navTitleOutlet.setTitleTextAttributes(attributes, for: .disabled)
                
    }
    
    @IBAction func contactBtnPressed(_ sender: UIButton) {
        
    }
    
    @IBAction func navBackBtnAction(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    
    
    
}
