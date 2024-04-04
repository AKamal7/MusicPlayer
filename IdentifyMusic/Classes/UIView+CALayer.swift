//
//  UIView+CALayer.swift
//  IdentifyMusic
//
//  Created by Khaled Abo hassob on 3/4/2024.
//

import Foundation
import UIKit

class GlowBall: UIView {
    private lazy var pulse: CAGradientLayer = {
        let l = CAGradientLayer()
        l.type = .radial
        l.colors = [ UIColor.red.cgColor,
            UIColor.yellow.cgColor,
            UIColor.green.cgColor,
            UIColor.blue.cgColor]
        l.locations = [ 0, 0.3, 0.7, 1 ]
        l.startPoint = CGPoint(x: 0.5, y: 0.5)
        l.endPoint = CGPoint(x: 1, y: 1)
        layer.addSublayer(l)
        return l
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        pulse.frame = bounds
        pulse.cornerRadius = bounds.width / 2.0
    }

}
