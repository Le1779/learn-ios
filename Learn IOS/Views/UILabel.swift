//
//  UILabel.swift
//  Learn IOS
//
//  Created by Kevin Le on 2021/8/11.
//  Copyright © 2021 Kevin Le. All rights reserved.
//

import UIKit

extension UILabel {
    
    /**
     讓字體大小響應9成寬度
     */
    func setFontSizeToFill() {
        layoutIfNeeded()
        let boundsSize  = self.bounds.size
        guard boundsSize.height > 0 && boundsSize.width > 0 && self.text != nil else {
            return
        }
        
        let fontPoints = self.font.pointSize
        let fontSize   = self.text!.size(withAttributes: [NSAttributedString.Key.font: self.font.withSize(fontPoints)])
        let scale = (boundsSize.width * 0.9) / fontSize.width
        self.font = self.font.withSize(fontPoints * scale)
    }
}
