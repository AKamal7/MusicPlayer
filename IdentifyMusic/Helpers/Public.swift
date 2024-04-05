//
//  Public.swift
//  IdentifyMusic
//
//  Created by Khaled Abo hassob on 25/3/2024.
//

import Foundation
import UIKit
class Public {
    
    static func setupContainerView(view: UIView, backGround: UIColor ) {
        view.backgroundColor = backGround
    }
    
    static func setupLabel(label: UILabel, text: String, size: CGFloat, color: UIColor) {
        label.text = text
        label.font = UIFont(name: "Heebo-Regular", size: size)
        label.textColor = color
    }
    
    static func setupImgView(imgView: UIImageView, imgString: String) {
        imgView.image = UIImage(named: imgString)
    }
    
    static func setupButton(button: UIButton, imgString: String) {
        button.setImage(UIImage(named: imgString), for: .normal)
    }
    
    static func setupLabelWithMedium(label: UILabel, text: String, size: CGFloat, color: UIColor) {
        label.text = text
        label.font = UIFont(name: "Heebo-Medium", size: size)
        label.textColor = color
    }
    
}
