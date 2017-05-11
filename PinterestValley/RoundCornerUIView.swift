//
//  RoundCornerUIView.swift
//  PinterestValley
//
//  Created by Emmanuel on 11/05/2017.
//  Copyright © 2017 Emmanuel. All rights reserved.
//

import UIKit

@IBDesignable

class RoundCornerUIView: UIView {
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
}
