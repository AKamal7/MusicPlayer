//
//  HistoryTableCell.swift
//  IdentifyMusic
//
//  Created by ahmedkamal on 03/04/2024.
//

import UIKit
import SDWebImage
import Cider
import MediaPlayer
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
        containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24).isActive = true
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24).isActive = true
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24).isActive = true
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24).isActive = true
        setupLabel(label: artistNameLabel, text: "The Strokes", size: 12, fontName: "Heebo-Regular", color: UIColor(hex: "FFFFFF", alpha: 0.56))
        setupLabel(label: dateLabel, text: "Found 1 hour ago", size: 12, fontName: "Heebo-Regular", color: UIColor(hex: "FFFFFF", alpha: 0.24))
        setupLabel(label: songNameLabel, text: "The New Abnormal", size: 14, fontName: "Heebo-Regular", color: UIColor(hex: "FFFFFF", alpha: 1))
        setupImgView()
        setupButton()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        containerView.backgroundColor = UIColor(hex: "1f1f1f")
        containerView.layer.cornerRadius = 12.0

        let maskPath = UIBezierPath(roundedRect: containerView.bounds,
                                    byRoundingCorners: [.topLeft, .bottomLeft],
                                    cornerRadii: CGSize(width: 40.0, height: 0.0))

        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        containerView.layer.mask = maskLayer

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
    
    func setupYoutube(model: Video) {
        self.songNameLabel.text = model.title
        let imgUrl = URL(string: model.thumbnailUrl)
        cellImgView.sd_setImage(with: imgUrl)
        self.dateLabel.isHidden = true
        self.artistNameLabel.text = model.channelTitle
        
    }
    
    func setupCell(model: Cider.Track) {
        if let attributes = model.attributes {
            let imgString = attributes.artwork.url.replacingOccurrences(of: "{w}", with: "\(attributes.artwork.width)")
            let imgStringEnhanced = imgString.replacingOccurrences(of: "{h}", with: "\(attributes.artwork.height)")
            let imgUrl = URL(string: imgStringEnhanced)
            cellImgView.sd_setImage(with: imgUrl)
        }
        
        
        
    }
    
    
    
    
    
    
    
   
    
}
