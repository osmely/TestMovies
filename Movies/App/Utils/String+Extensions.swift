//
//  String+Extensions.swift
//  Movies
//
//  Created by Osmely Fernandez on 12/27/19.
//  Copyright © 2019 Osmely Fernandez. All rights reserved.
//

import Foundation
import UIKit

extension NSMutableAttributedString {
    @discardableResult func boldLine(_ text: String?, size:CGFloat = 22) -> NSMutableAttributedString {
        guard let text = text else {return self}
        let attrs: [NSAttributedString.Key: Any] = [.font: UIFont.boldSystemFont(ofSize: size)]
        let boldString = NSMutableAttributedString(string:"\(text)\n", attributes: attrs)
        append(boldString)
        return self
    }

    @discardableResult func normalLine(_ text: String?, size:CGFloat = 21) -> NSMutableAttributedString {
        guard let text = text else {return self}
        let attrs: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: size)]
        let normal = NSMutableAttributedString(string:"\(text)\n", attributes: attrs)
        append(normal)
        return self
    }
}
