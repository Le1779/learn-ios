//
//  TrackLayer.swift
//  Learn IOS
//
//  Created by Kevin Le on 2021/8/11.
//  Copyright © 2021 Kevin Le. All rights reserved.
//

import UIKit

internal class TrackLayer: CAShapeLayer {
    
    private var maskPath: CGPath
    private var pathWidth: CGFloat
    internal var centerPoint: CGPoint {
        return CGPoint(x: self.bounds.midX, y: self.bounds.midY)
    }
    
    internal init(bounds: CGRect, maskPath: CGPath, pathWidth: CGFloat) {
        self.maskPath = maskPath
        self.pathWidth = pathWidth
        super.init()
        self.bounds = bounds
        masksToBounds = true
        position = centerPoint
        backgroundColor = UIColor(hexString: "#E8E8E8").cgColor
        mask()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func draw(in context: CGContext) {
        super.draw(in: context)
        print("draw")
    }
    
    private func mask() {
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.lineWidth = pathWidth
        maskLayer.strokeColor = UIColor.black.cgColor
        maskLayer.fillColor = UIColor.clear.cgColor
        maskLayer.lineCap = .round
        maskLayer.path = maskPath
        
        mask = maskLayer
    }
}
