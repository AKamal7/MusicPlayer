//
//  LinkedAccountVC.swift
//  IdentifyMusic
//
//  Created by Khaled Abo hassob on 25/3/2024.
//

import UIKit

class PListOptionsVC: UIViewController {
    
    @IBOutlet weak var titleLablel: UILabel!
    @IBOutlet weak var editNameBtn: UIButton!
    @IBOutlet weak var editPListBtn: UIButton!
    @IBOutlet weak var deletePListBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        titleLablel.text = "Options for (song name)"
        setupLabels(buttton: editNameBtn  , title: "Change playlist name")
        setupLabels(buttton: editPListBtn, title: "Edit playlist")
        setupLabels(buttton: deletePListBtn, title: "Delete playlist")
        
    }
    
    
    // MARK :- Private Methods
    private func setupLabels(buttton: UIButton, title: String) {
        buttton.setTitle(title, for: .normal)
        buttton.setTitleColor(UIColor(hex: "FFFFFF", alpha: 1), for: .normal)
        buttton.titleLabel?.font = UIFont(name: "Heebo-Regular", size: 18)
    }
    

}
