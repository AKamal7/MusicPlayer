//
//  PListOptionsVC.swift
//  IdentifyMusic
//
//  Created by Khaled Abo hassob on 25/3/2024.
//

import UIKit

class SongOptionsVC: UIViewController {

    @IBOutlet weak var contView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var addToPListBtn: UIButton!
    @IBOutlet weak var addToFavBtn: UIButton!
    @IBOutlet weak var buyOnAmazon: UIButton!
    @IBOutlet weak var openOnMusicBtn: UIButton!
    @IBOutlet weak var openYTubeBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = "Options for (Song Name)"
        Public.setupContainerView(view: contView, backGround: UIColor(hex: "FFFFFF", alpha: 0.04))
        setupLabels(buttton: shareBtn, title: "Share")
        setupLabels(buttton: addToPListBtn, title: "Add to playlist")
        setupLabels(buttton: addToFavBtn, title: "Add to favorits")
        setupLabels(buttton: buyOnAmazon, title: "Buy on amazon")
        setupLabels(buttton: openOnMusicBtn, title: "Open on Apple music")
        setupLabels(buttton: openYTubeBtn, title: "Open on Youtube")
    }
    
    // MARK :- IBActions
    @IBAction func shareCliked(_ sender: UIButton) {
        print("share")
    }
    @IBAction func addToPlistClicked(_ sender: UIButton) {
        print("addPlist")
    }
    @IBAction func addToFavClicked(_ sender: UIButton) {
        print("addFav")
    }
    @IBAction func amazonClicked(_ sender: UIButton) {
        print("amazon")
    }
    @IBAction func appleMusicClicked(_ sender: UIButton) {
        print("apple")
    }
    @IBAction func youtubeClicked(_ sender: UIButton) {
        print("utube")
    }
    
    
    
    
    
    // MARK :- Private Methods
    private func setupLabels(buttton: UIButton, title: String) {
        buttton.setTitle(title, for: .normal)
        buttton.setTitleColor(UIColor(hex: "FFFFFF", alpha: 1), for: .normal)
        buttton.titleLabel?.font = UIFont(name: "Heebo-Regular", size: 18)
    }
}
