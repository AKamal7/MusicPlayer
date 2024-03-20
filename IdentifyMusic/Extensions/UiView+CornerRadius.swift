//
//  UiView+CornerRadius.swift
//  IdentifyMusic
//
//  Created by ahmedkamal on 20/03/2024.
//


import Foundation


import UIKit

extension UIView {

    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }

    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    @IBInspectable
    var borderColor: UIColor? {
        get {
            let color = UIColor(cgColor: layer.borderColor!)
            return color
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }

    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOffset = CGSize(width: 0, height: 2)
            layer.shadowOpacity = 0.4
            layer.shadowRadius = newValue
        }
    }
}



extension UIView {
    func showActivityIndicator() {
        let activityIndicator = setupActivityIndicator()
        activityIndicator.startAnimating()
        addSubview(activityIndicator)
    }

    func hideActivityIndicator() {
        if let activityIndicator = viewWithTag(100) {
            activityIndicator.removeFromSuperview()
        }
    }
    
    func setupActivityIndicator() -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 22, height: 22))
        activityIndicator.backgroundColor = .clear
        activityIndicator.layer.cornerRadius = 11
//        activityIndicator.center = self.center
        activityIndicator.hidesWhenStopped = true
        if #available(iOS 13.0, *) {
            activityIndicator.style = .large
        } else {
            activityIndicator.style = .large
            // Fallback on earlier versions
        }
        activityIndicator.color = .systemGray
        activityIndicator.tag = 100
        activityIndicator.translatesAutoresizingMaskIntoConstraints = true
        activityIndicator.center = CGPoint(x: self.frame.size.width  / 2, y: self.frame.size.height / 2)
        return activityIndicator
    }
}

extension UIView {
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
