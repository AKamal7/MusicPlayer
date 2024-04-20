//
//  HistoryTableCell.swift
//  IdentifyMusic
//
//  Created by ahmedkamal on 03/04/2024.
//

import UIKit

class HistoryTableCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var cellImgView: UIImageView!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var songNameLabel: UILabel!
    
    @IBOutlet weak var artistNameLabel: UILabel!
    
    @IBOutlet weak var moreActionBtnOutlet: UIButton!
    
    
    private var cornerRadii: UIRectCorner = .allCorners

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()

    }
    
    private func setupView() {
        selectionStyle = .none
        setupLabel(label: artistNameLabel, text: "The Strokes", size: 12, fontName: "Heebo-Regular", color: UIColor(hex: "FFFFFF", alpha: 0.56))
        setupLabel(label: dateLabel, text: "Found 1 hour ago", size: 12, fontName: "Heebo-Regular", color: UIColor(hex: "FFFFFF", alpha: 0.24))
        setupLabel(label: songNameLabel, text: "The New Abnormal", size: 14, fontName: "Heebo-Regular", color: UIColor(hex: "FFFFFF", alpha: 1))
        setupImgView()
        setupButton()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        containerView.backgroundColor = UIColor(hex: "1f1f1f")
        //        containerView.roundCorners(corners: [.bottomLeft, .topLeft], radius: 40)
        //        containerView.layer.cornerRadius = 12
        //        containerView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        //
        //        containerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
    }

 
    
    private func setupButton() {
        moreActionBtnOutlet.setImage(UIImage(named: "moreActions"), for: .normal)
        moreActionBtnOutlet.setTitle("", for: .normal)
    }
    
    private func setupLabel(label: UILabel,text: String, size: CGFloat, fontName: String, color: UIColor) {
        label.text = text
        label.font = UIFont(name: fontName, size: size)
        label.textColor = color
    }
    
    private func setupImgView() {
        cellImgView.image = UIImage(named: "musicIcon")
        cellImgView.cornerRadius = cellImgView.frame.size.height / 2
    }
    
   
    
}
