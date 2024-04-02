//
//  NotAvailableVC.swift
//  IdentifyMusic
//
//  Created by Khaled Abo hassob on 30/3/2024.
//

import UIKit

class NotAvailableVC: UIViewController {

    @IBOutlet weak var cntView: UIView!
    @IBOutlet weak var notAvlbleImgView: UIImageView!
    @IBOutlet weak var notAvlbleLabel: UILabel!
    @IBOutlet weak var dismissBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
       
    }
    
    private func setupView() {
        
        Public.setupContainerView(view: cntView, backGround: UIColor(hex: "FFFFFF", alpha: 0.04))
        Public.setupImgView(imgView: notAvlbleImgView, imgString: "Box Important")
        Public.setupLabel(label: notAvlbleLabel, text: "Sorry, this song is not on YouTube.", size: 16, color: .white)
        Public.setupButton(button: dismissBtn, imgString: "Close")
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
