//
//  TintableBarButtonItem.swift
//  IdentifyMusic
//
//  Created by Khaled Abo hassob on 20/3/2024.
//

import Foundation
import UIKit

class TintableBarButtonItem: UIBarButtonItem {

    private(set) var button: UIButton!

    override var tintColor: UIColor? {
        get { return button.tintColor }
        set { button.tintColor = newValue }
    }

    convenience init(button: UIButton) {
        self.init(customView: button)
        self.button = button
        button.imageView?.contentMode = .scaleAspectFit
        button.frame = CGRect(x: 0, y: 0, width: 34, height: 30)
    }

}
