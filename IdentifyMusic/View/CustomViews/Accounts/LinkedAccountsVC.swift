//
//  LinkedAccounts.swift
//  IdentifyMusic
//
//  Created by Khaled Abo hassob on 30/3/2024.
//

import UIKit

protocol BlurVCDelegate: class {
    func removeBlurView()
}

class LinkedAccountsVC: UIViewController {
    
    @IBOutlet weak var cntView: UIView!
    @IBOutlet weak var headerLabel: UILabel!
    
    weak var delegate: BlurVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Public.setupContainerView(view: cntView, backGround: UIColor(hex: "272727", alpha: 1))
        Public.setupLabel(label: headerLabel, text: "You don't have any linked accounts yet.", size: 20, color: .white)
//        setBlurView()
        
        let tapToDismiss = UITapGestureRecognizer(target: self, action: #selector(tapToDismiss(_:)))
        self.view.addGestureRecognizer(tapToDismiss)
        hidePlayer()
//        tabBarController?.tabBar.isHidden = true

    }
 
    
    private func hidePlayer() {
        let hide = false
        NotificationCenter.default.post(name: Notification.Name(rawValue: "hidePlayer"), object: hide)
    }
    
    private func showPlayer() {
        let show = true
        NotificationCenter.default.post(name: Notification.Name(rawValue: "showPlayer"), object: show)
    }
    
    @objc func tapToDismiss(_ recognizer: UITapGestureRecognizer) {
        delegate?.removeBlurView()
        showPlayer()
        self.dismiss(animated: true, completion: nil)
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
        view.insertSubview(blurView, belowSubview: self.view)
    }
    
    
    
}
