//
//  TrendsCollectionVC.swift
//  IdentifyMusic
//
//  Created by Khaled Abo hassob on 7/4/2024.
//

import UIKit

class TrendsCollectionVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupView()
        
        
    }
    
    private func setupView() {
        
        view.backgroundColor = UIColor(hex: "141414")
        
        
        setupCollectionView()
        setupNavBar()
    }
    
    private func setupNavBar() {
        navigationController?.navigationBar.barTintColor = UIColor(hex: "141414")
        
        navigationController?.navigationBar.tintColor = .white
        
        navigationController?.navigationBar.backIndicatorImage = UIImage(named: "backButton")
        
    }


    

}
