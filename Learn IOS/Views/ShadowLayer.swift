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
                shadowRadius: CGFloat = 1){
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        self.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        self.layer.shadowOpacity = 0.7
        self.layer.shadowRadius = shadowRadius
        self.layer.masksToBounds = true
        self.clipsToBounds = false
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
