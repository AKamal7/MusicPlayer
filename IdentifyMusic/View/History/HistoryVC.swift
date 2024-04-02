//
//  HistoryVC.swift
//  IdentifyMusic
//
//  Created by ahmedkamal on 09/03/2024.
//

import UIKit

class HistoryVC: UIViewController {

    @IBOutlet weak var tableView: SelfSizedTableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.selectedIndex = 1
        
        view.backgroundColor = UIColor(hex: "141414", alpha: 1)
        setupTable()
        
    }
    

  

}
