//
//  PremiumVC.swift
//  IdentifyMusic
//
//  Created by Khaled Abo hassob on 30/3/2024.
//

import UIKit

class PremiumVC: UIViewController {
    @IBOutlet weak var cntView: UIView!
    @IBOutlet weak var headerImgView: UIImageView!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var tickedImgView: UIImageView!
    @IBOutlet weak var noAdsLabel: UILabel!
    @IBOutlet weak var securedImgView: UIImageView!
    @IBOutlet weak var securedLabel: UILabel!
    @IBOutlet weak var subscribeBtn: UIButton!
    
    weak var delegate: BlurVCDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        
        let tapToDismiss = UITapGestureRecognizer(target: self, action: #selector(tapToDismiss(_:)))
        self.view.addGestureRecognizer(tapToDismiss)
        hidePlayer()
        
    }
    
    @IBAction func dismissView(_ sender: UIButton) {
        
        self.dismiss(animated: false)
    }
    
    
    private func setupView() {
        
        Public.setupContainerView(view: cntView, backGround: UIColor(hex: "272727", alpha: 1))
        Public.setupButton(button: subscribeBtn, imgString: "Frame 27")
        Public.setupLabel(label: headerLabel,  text: "What’s included:",  size: 20,    color: .white)
        Public.setupLabel(label: priceLabel,   text: "$3.50/per month",   size: 36,    color: .white)
        Public.setupLabel(label: noAdsLabel,   text: "No advertising",    size: 18,    color: .white)
        Public.setupLabel(label: securedLabel, text: "Secure payment",    size: 14,    color: UIColor(hex: "FFFFFF",alpha: 0.40))
        
        Public.setupImgView(imgView: headerImgView,  imgString: "Frame 16")
        Public.setupImgView(imgView: tickedImgView,  imgString: "gg_check-o-1")
        Public.setupImgView(imgView: securedImgView, imgString: "Group")
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

}
