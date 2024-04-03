//
//  UILabel+Gradient.swift
//  IdentifyMusic
//
//  Created by ahmedkamal on 03/04/2024.
//

import Foundation
import UIKit

func gradientColor(bounds: CGRect, gradientLayer :CAGradientLayer) -> UIColor? {

      UIGraphicsBeginImageContext(gradientLayer.bounds.size)
      gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
      let image = UIGraphicsGetImageFromCurrentImageContext()
      UIGraphicsEndImageContext()
      return UIColor(patternImage: image!)
}

func getGradientLayer(bounds : CGRect) -> CAGradientLayer{
    let gradient = CAGradientLayer()
    gradient.frame = bounds
    // gradient colors in order which they will visually appear
//    gradient.colors = [UIColor.red.cgColor,UIColor.blue.cgColor, UIColor.green.cgColor]
    let firstColor = UIColor(hex: "BC66FF", alpha: 1).cgColor
    let secondColor = UIColor(hex: "DEB5FF", alpha: 1).cgColor
    gradient.colors = [firstColor, secondColor]
    // Gradient from left to right
    gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
    gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
    return gradient
}


//let button = UIButton(frame: textView.bounds)
//button.setTitle("Hello World", for: .normal)
//button.titleLabel?.font =  UIFont.boldSystemFont(ofSize:80)
//button.setTitleColor(gradientColor(bounds: textView.bounds, gradientLayer: gradient), for: .normal)

