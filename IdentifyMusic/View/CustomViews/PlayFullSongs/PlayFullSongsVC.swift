//
//  PlayFullSongsVC.swift
//  IdentifyMusic
//
//  Created by Khaled Abo hassob on 26/3/2024.
//

import UIKit

class PlayFullSongsVC: UIViewController {
    
    
    @IBOutlet weak var screenTitleLabel: UILabel!
    @IBOutlet weak var screenSubTitleLabel: UILabel!
    @IBOutlet weak var previewTitleLable: UILabel!
    @IBOutlet weak var youtubeLabel: UILabel!
    @IBOutlet weak var appleMusicLabel: UILabel!
    @IBOutlet weak var previewCheckBtn: UIButton!
    @IBOutlet weak var selectBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
    }
    private func setupView() {
        Public.setupLabel(label: screenTitleLabel, text: "Play the full song", size: 32, color: .white)
        Public.setupLabel(label: screenSubTitleLabel, text: "Select your experience on hearing. Change it anytime from Settings.", size: 16, color: .white)
        screenSubTitleLabel.numberOfLines = 2
        Public.setupLabel(label: previewTitleLable, text: "Listen to 30 sec preview", size: 18, color: .white)
        Public.setupLabel(label: appleMusicLabel, text: "Apple Music", size: 18, color: .white)
        Public.setupLabel(label: youtubeLabel, text: "Youtube Music", size: 18, color: .white)
        Public.setupButton(button: selectBtn, imgString: "Frame 26")
        
        
    }
    @IBAction func previewCheckBtn(_ sender: UIButton) {
//        if self.previewCheckBtn.imageView?.image == UIImage(named: "gg_check-o")
//        {previewCheckBtn.setImage(UIImage(named:"gg_check-o-1"), for: .normal)}
//        else
//        {previewCheckBtn.setImage(UIImage(named: "gg_check-o"), for: .normal)}
    }
    @IBAction func appleMusicCheckBtn(_ sender: UIButton) {
    }
    @IBAction func youtubeCheckBtn(_ sender: UIButton) {
    }
    @IBAction func selectBtn(_ sender: UIButton) {
    }
    
    

}
