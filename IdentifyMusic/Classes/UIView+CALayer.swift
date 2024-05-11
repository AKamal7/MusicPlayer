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


class CircularSoundWaveView: UIView {
    private let shapeLayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        // Configure the circular shape layer
        shapeLayer.lineWidth = 2.0
        shapeLayer.strokeColor = UIColor.blue.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        layer.addSublayer(shapeLayer)
    }
    
    func updateSoundWave(intensity: Float) {
        // Calculate the radius based on the intensity
        let maxRadius = min(bounds.width, bounds.height) / 2.0
        let radius = maxRadius * CGFloat(intensity)
        
        // Create a circular path
        let path = UIBezierPath(arcCenter: CGPoint(x: bounds.midX, y: bounds.midY),
                                radius: radius,
                                startAngle: 0,
                                endAngle: CGFloat.pi * 2,
                                clockwise: true)
        
        // Apply the path to the shape layer
        shapeLayer.path = path.cgPath
    }
}

