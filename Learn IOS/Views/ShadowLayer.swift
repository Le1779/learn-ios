//
//  ShadowLayer.swift
//  Learn IOS
//
//  Created by Kevin Le on 2020/3/27.
//  Copyright © 2020 Kevin Le. All rights reserved.
//

import UIKit

class ShadowLayer: UIView {

    public init(frame: CGRect,
                bounds: CGRect,
                cornerRadius: CGFloat = 0.0,
                shadowRadius: CGFloat = 1,
                shadowOpacity: Float = 0.7,
                shadowOffset: CGSize = CGSize(width: 2.0, height: 2.0),
                shadowColor: UIColor = .lightGray){
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowRadius = shadowRadius
        self.layer.masksToBounds = true
        self.clipsToBounds = false
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public func setFrame(frame: CGRect) {
        self.frame = frame
    }
    
    public func setBounds(bounds: CGRect) {
        self.bounds = bounds
    }
    
    public func setCornerRadius(cornerRadius: CGFloat) {
        self.layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
    }
    
    public func setShadowColor(shadowColor: UIColor) {
        self.layer.shadowColor = shadowColor.cgColor
    }
    
    public func setShadowRadius(shadowRadius: CGFloat) {
        self.layer.shadowRadius = shadowRadius
    }
    
}
