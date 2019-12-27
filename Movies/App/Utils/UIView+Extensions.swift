//
//  UIView+Extensions.swift
//  Movies
//
//  Created by Osmely Fernandez on 12/27/19.
//  Copyright © 2019 Osmely Fernandez. All rights reserved.
//

import UIKit

@IBDesignable extension UIView {
    @IBInspectable var cornerRadius:CGFloat {
        set {
            self.layer.cornerRadius = newValue
        }
        get {
            return self.layer.cornerRadius
        }
    }
    
    @IBInspectable var dropShadowVisibles:Bool {
        set{ if newValue { dropShadow() } }
        get { return false }
    }
    
    func dropShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.shadowRadius = 2
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }

}
