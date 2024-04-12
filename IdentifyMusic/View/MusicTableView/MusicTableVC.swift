//
//  MusicTableVC.swift
//  IdentifyMusic
//
//  Created by Khaled Abo hassob on 7/4/2024.
//

import UIKit

class MusicTableVC: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var titleText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        
    }
    
    //MARK:- private methods
    
    private func setupView() {
        
        view.backgroundColor = UIColor(hex: "141414")
        titleLabel.text = titleText
        
        setupTable()
        setupNavBar()
    }
    
    private func setupNavBar() {
        navigationController?.navigationBar.barTintColor = UIColor(hex: "141414")
        
        navigationController?.navigationBar.tintColor = .white
        
        navigationController?.navigationBar.backIndicatorImage = UIImage(named: "backButton")
        
    }

}
