//
//  TrackPath.swift
//  Learn IOS
//
//  Created by Kevin Le on 2021/8/13.
//  Copyright © 2021 Kevin Le. All rights reserved.
//

import UIKit

class TrackPath {
    struct AngleRange {
        var begin: CGFloat
        var end: CGFloat
    }
    
    public var path: CGPath?
    
    private var bounds: CGRect
    private var padding: CGFloat
    private var angleRange: AngleRange
    
    private var radius: CGFloat = 0
    private var centerPoint: CGPoint = CGPoint(x: 0, y: 0)
    
    public init(bounds: CGRect, width: CGFloat, angleRange: AngleRange) {
        self.bounds = bounds
        self.padding = width
        self.angleRange = angleRange
        generate()
    }
    
    public func getPointFromAngle(_ angle: CGFloat) -> CGPoint {
        let x = radius * cos(toRadians(angle))
        let y = radius * sin(toRadians(angle))

        return CGPoint(x: centerPoint.x + x, y: centerPoint.y + y)
    }
    
    public func getAngleFromPoint(_ point: CGPoint) -> CGFloat {
        let originPoint = CGPoint(x: point.x - centerPoint.x, y: point.y - centerPoint.y)
        let bearingRadians = atan2(Double(originPoint.y), Double(originPoint.x))
        var bearingDegrees = (bearingRadians * -1) * (180.0 / .pi)
        bearingDegrees = (bearingDegrees > 0.0 ? bearingDegrees : (360.0 + bearingDegrees))
        return CGFloat(bearingDegrees)
    }
    
    public func isInAngleRange(_ angle: CGFloat) -> Bool {
        let direction = getDirection(bounds: bounds)
        if direction == "HR" {
            return angle >= angleRange.begin && angle <= 360 || angle <= angleRange.end && angle >= 0
        } else {
            return angle >= angleRange.begin && angle <= angleRange.end
        }
    }
    
    private func generate() {
        let pathBound = bounds.insetBy(dx: padding, dy: padding)
        let height = pathBound.height
        let width = pathBound.width
        let beginRadians = toRadians(angleRange.begin)
        let endRadians = toRadians(angleRange.end)
        
        let direction = getDirection(bounds: pathBound)
        
        if isSameDirection(direction) {
            radius = width > height ? width/2 : height/2
        } else {
            radius = width/2
        }
        
        centerPoint = getCenterPoint(bounds: pathBound, direction: direction, padding: padding)
        let path = UIBezierPath(arcCenter: centerPoint, radius: radius, startAngle: beginRadians, endAngle: endRadians, clockwise: false)
        self.path = path.cgPath
    }
    
    private func toRadians(_ degrees: CGFloat) -> CGFloat {
        return (degrees * -1) * .pi / 180
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
    
    private func getDirection(bounds: CGRect) -> String{
        let height = bounds.height
        let width = bounds.width
        let beginQuadrant = getQuadrant(angleRange.begin)
        let endQuadrant = getQuadrant(angleRange.end)
        
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
