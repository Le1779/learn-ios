//
//  ThumbView.swift
//  Learn IOS
//
//  Created by Kevin Le on 2021/8/13.
//  Copyright © 2021 Kevin Le. All rights reserved.
//

import UIKit

class ThumbView: UIView {
    
    private var width: CGFloat
    private var shadowLayer: ShadowView?
    private var shadowColor: UIColor?
    private var shadowBlur: CGFloat?
    private var isDrawnShadow = true
    
    public init(width: CGFloat){
        self.width = width
        super.init(frame: CGRect(x: 0, y: 0, width: width, height: width))
        backgroundColor = .darkGray
        layer.cornerRadius = width/2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
