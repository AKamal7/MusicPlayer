//
//  File.swift
//  IdentifyMusic
//
//  Created by Khaled Abo hassob on 18/3/2024.
//

import Foundation
import UIKit

final class SelfSizedTableView: UITableView {
    override var contentSize:CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
}
