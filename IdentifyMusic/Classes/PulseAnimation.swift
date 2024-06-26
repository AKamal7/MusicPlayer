import Foundation
import UIKit


class PulsatingButton: UIButton {
let pulseLayer: CAShapeLayer = {
    let shape = CAShapeLayer()
    shape.strokeColor = UIColor(hex: "BC66FF", alpha: 0.3).cgColor
    shape.lineWidth = 10
    shape.fillColor = UIColor(hex: "BC66FF", alpha: 0.01).cgColor
    shape.lineCap = .round
    return shape
}()

override init(frame: CGRect) {
    super.init(frame: frame)
    setupShapes()
}

required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupShapes()
}

fileprivate func setupShapes() {
    setNeedsLayout()
    layoutIfNeeded()
    
    let backgroundLayer = CAShapeLayer()
    
    let circularPath = UIBezierPath(arcCenter: self.center, radius: bounds.size.height/2, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
    
    pulseLayer.frame = bounds
    pulseLayer.path = circularPath.cgPath
    pulseLayer.position = self.center
    self.layer.addSublayer(pulseLayer)
    
    backgroundLayer.path = circularPath.cgPath
    backgroundLayer.lineWidth = 1
    backgroundLayer.fillColor = UIColor(hex: "FFFFFF", alpha: 0).cgColor
    backgroundLayer.lineCap = .round
    self.layer.addSublayer(backgroundLayer)
}

func pulse() {
    let animation = CABasicAnimation(keyPath: "transform.scale")
    animation.toValue = 1.2
    animation.duration = 1
    animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
    animation.autoreverses = true
    animation.repeatCount = .infinity
    pulseLayer.add(animation, forKey: "pulsing")
}
}
