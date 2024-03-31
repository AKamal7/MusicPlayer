//
//  UiView+Gradient.swift
//  IdentifyMusic
//
//  Created by ahmedkamal on 23/03/2024.
//

import Foundation
import UIKit

extension UIView {
    func setGradientBackground(colorOne: UIColor, colorTwo: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        gradientLayer.locations = [0.0, 3.0]
        layer.insertSublayer(gradientLayer, at: 0)
    }
}

      



