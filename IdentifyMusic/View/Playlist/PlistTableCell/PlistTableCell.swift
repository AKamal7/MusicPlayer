//
//  PlistTableCell.swift
//  IdentifyMusic
//
//  Created by Khaled Abo hassob on 17/3/2024.
//

import UIKit

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
        

        setupImgView()
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
    private func setupImgView() {
        cellImgView.image = UIImage(named: "musicIcon")
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
