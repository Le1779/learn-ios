//
//  Scale.swift
//  Learn IOS
//
//  Created by Kevin Le on 2021/8/15.
//  Copyright © 2021 Kevin Le. All rights reserved.
//

import UIKit

class Scale: UIView {
    public enum ScaleType {
        case circular
        case line
    }
    
    var units: CGFloat = 0.1
    var hintInterval: Int = 5
    var scaleType: ScaleType = .line
    var scaleColor: UIColor = .black
    var scaleWidth: CGFloat = 1
    var scaleHeight: CGFloat = 10
    var scaleDeviation: CGFloat = 0.4
    
    var beginAngle: Int = 0
    var angle: Int = 360
    
    var scaleLayer: CAShapeLayer! {
        didSet {
            self.layer.addSublayer(self.scaleLayer)
        }
    }
    
    public init() {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSublayers(of _: CALayer) {
        if scaleLayer == nil {
            scaleLayer = CAShapeLayer()
            scaleLayer.lineWidth = scaleWidth
            scaleLayer.strokeColor = scaleColor.cgColor
            scaleLayer.fillColor = UIColor.clear.cgColor
            scaleLayer.lineCap = .round
            if scaleType == .line {
                drawLineScale()
            } else {
                drawCircularScale()
            }
        }
    }
    
    /**
     繪製線的版本
     */
    private func drawLineScale() {
        let scaleWidth = bounds.width*units
        let path = UIBezierPath()
        for index in 0..<Int(1/units) + 1 {
            let isInterval = index % hintInterval == 0
            let x = CGFloat(index) * scaleWidth
            path.move(to: CGPoint(x: x, y: bounds.height))
            path.addLine(to: CGPoint(x: x, y: isInterval ? 0 : bounds.height*scaleDeviation))
        }
        
        scaleLayer.path = path.cgPath
    }
    
    /**
     繪製圓的版本
     */
    private func drawCircularScale() {
        let height = bounds.height
        let width = bounds.width
        let centerPoint = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius = width < height ? width/2 : height/2
        
        let scaleAngle = CGFloat(angle)*units
        let path = UIBezierPath()
        for index in 0..<Int(1/units) + 1 {
            let isInterval = index % hintInterval == 0
            let angle = beginAngle - index * Int(scaleAngle)
            let pointA = getPoint(angle: angle, radius: radius - scaleHeight, centerPoint: centerPoint)
            path.move(to: pointA)
            
            let radius = isInterval ? radius : radius - scaleHeight*scaleDeviation
            let pointB = getPoint(angle: angle, radius: radius, centerPoint: centerPoint)
            path.addLine(to: pointB)
        }
        
        scaleLayer.path = path.cgPath
    }
    
    private func getPoint(angle: Int, radius: CGFloat, centerPoint: CGPoint) -> CGPoint {
        let x = radius * cos(Angle(angle).radians)
        let y = radius * sin(Angle(angle).radians)

        return CGPoint(x: centerPoint.x + x, y: centerPoint.y + y)
    }
}
