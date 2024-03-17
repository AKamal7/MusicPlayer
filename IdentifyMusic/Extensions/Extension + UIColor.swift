//
//  Extension + UIColor.swift
//  IdentifyMusic
//
//  Created by Khaled Abo hassob on 14/3/2024.
//

import UIKit

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexValue = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()

        if hexValue.hasPrefix("#") {
            hexValue.remove(at: hexValue.startIndex)
        }

        var rgbValue: UInt64 = 0
        Scanner(string: hexValue).scanHexInt64(&rgbValue)

        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

struct Colors {
    static let mainBackground = UIColor(hex: "00000")
    static let searchBarColor = UIColor(hex: "2B2B2B")
    static let gradientButton1 = UIColor(hex: "BC66FF")
    static let gradientButton2 = UIColor(hex: "DEB5FF")
    static let createPlistView = UIColor(hex: "BC66FF", alpha: 0.04)
    
    //
}
