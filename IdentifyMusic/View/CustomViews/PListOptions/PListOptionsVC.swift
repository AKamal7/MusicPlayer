//
//  LinkedAccountVC.swift
//  IdentifyMusic
//
//  Created by Khaled Abo hassob on 25/3/2024.
//

import UIKit

class PListOptionsVC: UIViewController {
    
    @IBOutlet weak var cntView: UIView!
    @IBOutlet weak var titleLablel: UILabel!
    @IBOutlet weak var editNameBtn: UIButton!
    @IBOutlet weak var editPListBtn: UIButton!
    @IBOutlet weak var deletePListBtn: UIButton!
    
    @IBOutlet weak var popButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Public.setupContainerView(view: cntView, backGround: UIColor(hex: "272727", alpha: 1))
        titleLablel.text = "Options for (song name)"
        setupLabels(buttton: editNameBtn  , title: "Change playlist name")
        setupLabels(buttton: editPListBtn, title: "Edit playlist")
        setupLabels(buttton: deletePListBtn, title: "Delete playlist")
        setupPopBtn()
        
        
    }
    
    
    // MARK :- Private Methods
    private func setupLabels(buttton: UIButton, title: String) {
        buttton.setTitle(title, for: .normal)
        buttton.setTitleColor(UIColor(hex: "FFFFFF", alpha: 1), for: .normal)
        buttton.titleLabel?.font = UIFont(name: "Heebo-Regular", size: 18)
    }
    @IBAction func popBtnClicked(_ sender: UIButton) {
        
        self.dismiss(animated: false)
    }
    
    private func setupPopBtn() {
        
        let blur = UIVisualEffectView(effect: UIBlurEffect(style:
                                                            UIBlurEffect.Style.regular))
        blur.alpha = 0.6
        blur.frame = popButton.bounds
        blur.isUserInteractionEnabled = false //This allows touches to forward to the button.
        popButton.insertSubview(blur, at: 0)
    }
}
