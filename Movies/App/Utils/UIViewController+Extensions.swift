//
//  UIViewController+Extensions.swift
//  Movies
//
//  Created by Osmely Fernandez on 12/27/19.
//  Copyright © 2019 Osmely Fernandez. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    static func instantiateFromNib() -> Self {
        func instantiateFromNib<T: UIViewController>(_ viewType: T.Type) -> T {
            return T.init(nibName: String(describing: T.self), bundle: nil)
        }
        return instantiateFromNib(self)
    }
    
    static func topViewController() -> UIViewController {
        let w = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        var vc = (w?.rootViewController)!
        while vc.presentedViewController != nil {
            vc = vc.presentedViewController!
        }
        return vc
    }
}
