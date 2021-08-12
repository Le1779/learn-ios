//
//  TrackLayer.swift
//  Learn IOS
//
//  Created by Kevin Le on 2021/8/11.
//  Copyright © 2021 Kevin Le. All rights reserved.
//

import UIKit

internal class TrackLayer: CAShapeLayer {
    public var beginAngle: CGFloat = 0
    public var endAngle: CGFloat = 0
    public var trackWidth: CGFloat = 5
    internal var centerPoint: CGPoint {
        return CGPoint(x: self.bounds.midX, y: self.bounds.midY)
    }
    
    internal init(bounds: CGRect, beginAngle: CGFloat, endAngle: CGFloat) {
        super.init()
        //print("f: \(bounds), b: \(beginAngle), e: \(endAngle)")
        self.bounds = bounds
        self.beginAngle = beginAngle
        self.endAngle = endAngle
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
        let maskBound = bounds
        let maskLayer = CAShapeLayer()
        maskLayer.frame = maskBound
        maskLayer.lineWidth = trackWidth
        maskLayer.strokeColor = UIColor.black.cgColor
        maskLayer.fillColor = UIColor.clear.cgColor
        maskLayer.lineCap = .round
        maskLayer.path = getPath(bounds: maskBound, beginAngle: beginAngle, endAngle: endAngle)

        mask = maskLayer
    }
    
    private func toRadians(_ degrees: CGFloat) -> CGFloat {
        return (degrees * -1) * .pi / 180
    }
    
    private func getPath(bounds: CGRect, beginAngle: CGFloat, endAngle: CGFloat) -> CGPath {
        let padding = trackWidth
        let pathBound = bounds.insetBy(dx: padding, dy: padding)
        let height = pathBound.height
        let width = pathBound.width
        let beginRadians = toRadians(beginAngle)
        let endRadians = toRadians(endAngle)
        
        let direction = getDirection(bounds: pathBound, beginAngle: beginAngle, endAngle: endAngle)
        print(direction)
        var radius: CGFloat = 0
        
        if isSameDirection(direction) {
            radius = width > height ? width/2 : height/2
        } else {
            radius = width/2
        }
        
        let center = getCenterPoint(bounds: pathBound, direction: direction, padding: padding)
        print("Center: \(center)")
        let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: beginRadians, endAngle: endRadians, clockwise: false)
        return path.cgPath
    }
    
    private func getCenterPoint(bounds: CGRect, direction: String, padding: CGFloat) -> CGPoint {
        if direction == "HL" {
            return CGPoint(x: bounds.maxX + padding, y: bounds.midY)
        } else if direction == "HR" {
            return CGPoint(x: bounds.minX - padding, y: bounds.midY)
        } else if direction == "VT" {
            return CGPoint(x: bounds.midX, y: bounds.maxY + padding)
        } else if direction == "VB" {
            return CGPoint(x: bounds.midX, y: bounds.minY - padding)
        }
        
        return CGPoint(x: bounds.midX, y: bounds.midY)
    }
    
    private func isSameDirection(_ direction: String) -> Bool {
        return direction == "HL" || direction == "HR" || direction == "VT" || direction == "VB"
    }
    
    private func getDirection(bounds: CGRect, beginAngle: CGFloat, endAngle: CGFloat) -> String{
        let height = bounds.height
        let width = bounds.width
        let beginQuadrant = getQuadrant(beginAngle)
        let endQuadrant = getQuadrant(endAngle)
        
        if height > width {
            if beginQuadrant == 2 && endQuadrant == 3 {
                return "HL"
            } else if beginQuadrant == 4 && endQuadrant == 1 {
                return "HR"
            } else {
                return "HC"
            }
        } else {
            if beginQuadrant == 1 && endQuadrant == 2 {
                return "VT"
            } else if beginQuadrant == 3 && endQuadrant == 4 {
                return "VB"
            } else {
                print("bq: \(beginQuadrant), eq: \(endQuadrant)")
                return "VC"
            }
        }
    }
    
    private func getQuadrant(_ angle: CGFloat) -> Int {
        var a = Int(angle)
        if a >= 360 {
            a = a % 360
        }
        
        return Int(a/90) + 1
    }
}
