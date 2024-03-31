//
//  LinkedAccounts.swift
//  IdentifyMusic
//
//  Created by Khaled Abo hassob on 30/3/2024.
//

import UIKit

class LinkedAccountsVC: UIViewController {

    @IBOutlet weak var cntView: UIView!
    @IBOutlet weak var headerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Public.setupContainerView(view: cntView, backGround: UIColor(hex: "FFFFFF", alpha: 0.04))
        Public.setupLabel(label: headerLabel, text: "You don't have any linked accounts yet.", size: 20, color: .white)
        
    }
    

    

}
