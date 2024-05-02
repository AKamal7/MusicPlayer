//
//  PlistTableCell.swift
//  IdentifyMusic
//
//  Created by Khaled Abo hassob on 17/3/2024.
//

import UIKit
import Cider

protocol plistTabelCellProtocol: AnyObject {
    
    func presentView()
    
}

class PlistTableCell: UITableViewCell {
    
    weak var delegate: plistTabelCellProtocol?
   
    @IBOutlet weak var PlistNameLbl: UILabel!
    @IBOutlet weak var cellImgView: UIImageView!
    
    @IBOutlet weak var moreActionsBtn: UIButton!
    @IBOutlet weak var artistsNamesLbl: UILabel!
    @IBOutlet weak var hoursOfPlayingLbl: UILabel!
    @IBOutlet weak var containerView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupView()
                
    }

    private func setupView() {
        setupLabel(label: artistsNamesLbl, text: "Artist Name", size: 12, fontName: "Heebo-Regular", color: UIColor(hex: "FFFFFF", alpha: 0.24))
        setupLabel(label: hoursOfPlayingLbl, text: "Hours of playing", size: 12, fontName: "Heebo-Regular", color: UIColor(hex: "FFFFFF", alpha: 0.24))
        setupLabel(label: PlistNameLbl, text: "Plist Name", size: 20, fontName: "Heebo-Regular", color: UIColor(hex: "FFFFFF", alpha: 1))
        

        
        setupButton()
        
    }
    @IBAction func actionClicked(_ sender: UIButton) {
        
        
        delegate?.presentView()
        
        print("action yalla")
    }
    
    private func setupButton() {
        moreActionsBtn.setImage(UIImage(named: "moreActions"), for: .normal)
        moreActionsBtn.setTitle("", for: .normal)
    }
   
    private func setupLabel(label: UILabel,text: String, size: CGFloat, fontName: String, color: UIColor) {
        label.text = text
        label.font = UIFont(name: fontName, size: size)
        label.textColor = color
    }
    
    
    func setupImage(model: Playlist) {
       
        let imgString = model.attributes.artwork?.url.replacingOccurrences(of: "{w}", with: "\(model.attributes.artwork?.width ?? 80)")
        let imgStringEnhanced = imgString?.replacingOccurrences(of: "{h}", with: "\(model.attributes.artwork?.height ?? 80)") ?? ""
            let imgUrl = URL(string: imgStringEnhanced)
            cellImgView.sd_setImage(with: imgUrl)
            cellImgView.cornerRadius = 40
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
