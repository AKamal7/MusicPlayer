//
//  TrendsCollectionCell.swift
//  IdentifyMusic
//
//  Created by Khaled Abo hassob on 18/3/2024.
//

import UIKit

class TrendsCollectionCell: UICollectionViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var trendsLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        containerView.backgroundColor = UIColor(hex: "1f1f1f")
        Public.setupLabel(label: trendsLabel, text: "Trends", size: 14, color: .white)
    }

}
