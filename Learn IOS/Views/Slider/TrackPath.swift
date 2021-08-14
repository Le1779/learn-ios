//
//  TrackPath2.swift
//  Learn IOS
//
//  Created by Kevin Le on 2021/8/13.
//  Copyright © 2021 Kevin Le. All rights reserved.
//

import UIKit

class TrackPath {
    
    class AngleRange {
        var begin: Angle
        var end: Angle
        
        init(begin: Int, end: Int) {
            self.begin = Angle(begin)
            self.end = Angle(end)
        }
    }
    
    public var path: CGPath?
    
    private var bounds: CGRect
    private var padding: CGFloat
    private var clockwise: Bool
    private var radius: CGFloat = 0
    private var angleRange: AngleRange!
    private var centerPoint: CGPoint = CGPoint(x: 0, y: 0)
    
    public init(bounds: CGRect, padding: CGFloat, angle: Int, beginAngle: Int, clockwise: Bool) {
        self.bounds = bounds.insetBy(dx: padding, dy: padding)
        self.padding = padding
        self.clockwise = clockwise
        generateAngleRange(angle: angle, beginAngle: beginAngle)
        generateRadius()
        generateCenterPoint()
        
        let path = UIBezierPath(arcCenter: centerPoint, radius: radius, startAngle: self.angleRange.begin.radians, endAngle: self.angleRange.end.radians, clockwise: clockwise)
        self.path = path.cgPath
    }
    
    /**
     透過角度取得圓周上得點
     */
    public func getPointFromAngle(_ angle: Int) -> CGPoint {
        let x = radius * cos(Angle(angle).radians)
        let y = radius * sin(Angle(angle).radians)

        return CGPoint(x: centerPoint.x + x, y: centerPoint.y + y)
    }
    
    /**
     取得某個點與圓心的夾角
     */
    public func getAngleFromPoint(_ point: CGPoint) -> Int {
        let originPoint = CGPoint(x: point.x - centerPoint.x, y: point.y - centerPoint.y)
        let bearingRadians = atan2(Double(originPoint.y), Double(originPoint.x))
        var bearingDegrees = (bearingRadians * -1) * (180.0 / .pi)
        bearingDegrees = (bearingDegrees > 0.0 ? bearingDegrees : (360.0 + bearingDegrees))
        return Int(bearingDegrees)
    }
    
    /**
     取得從原點開始算的角度
     */
    public func getOriginAngle(_ angle: Int) -> Int {
        if clockwise {
            if angle > self.angleRange.begin.value {
                return 360 - angle + self.angleRange.begin.value
            }
            
            return self.angleRange.begin.value - angle
        } else {
            if angle < self.angleRange.begin.value && angle <= self.angleRange.end.value {
                return angle + 360 - self.angleRange.begin.value
            }
            
            return angle - self.angleRange.begin.value
        }
    }
    
    /**
     建立起始角度與結束角度
     */
    private func generateAngleRange(angle: Int, beginAngle: Int) {
        var endAngle = 0
        if clockwise {
            endAngle = beginAngle - angle
            if endAngle < 0 {
                endAngle = endAngle + 360
            }
        } else {
            endAngle = beginAngle + angle
        }
        
        angleRange = AngleRange(begin: beginAngle, end: endAngle)
    }
    
    /**
     建立半徑
     */
    private func generateRadius() {
        let height = bounds.height
        let width = bounds.width
        radius = width > height ? width/2 : height/2
    }
    
    /**
     建立圓心
     */
    private func generateCenterPoint() {
        let direction = getDirection()
        if direction == "L" {
            self.centerPoint = CGPoint(x: bounds.maxX + padding, y: bounds.midY)
        } else if direction == "R" {
            self.centerPoint = CGPoint(x: bounds.minX - padding, y: bounds.midY)
        } else if direction == "T" {
            self.centerPoint = CGPoint(x: bounds.midX, y: bounds.maxY + padding)
        } else if direction == "B" {
            self.centerPoint = CGPoint(x: bounds.midX, y: bounds.minY - padding)
        } else {
            self.centerPoint = CGPoint(x: bounds.midX, y: bounds.midY)
        }
    }
    
    private func getDirection() -> String{
        if bounds.height == bounds.width || (angleRange.begin.value <= angleRange.end.value && clockwise) {
            return "C"
        }
        
        let beginQuadrant = angleRange.begin.quadrant
        let endQuadrant = angleRange.end.quadrant
        
        if beginQuadrant == 2 && endQuadrant == 3 || beginQuadrant == 3 && endQuadrant == 2 {
            return "L"
        } else if beginQuadrant == 4 && endQuadrant == 1 || beginQuadrant == 1 && endQuadrant == 4 {
            return "R"
        } else if beginQuadrant == 1 && endQuadrant == 2 || beginQuadrant == 2 && endQuadrant == 1 {
            return "T"
        } else if beginQuadrant == 3 && endQuadrant == 4 || beginQuadrant == 4 && endQuadrant == 3 {
            return "B"
        } else {
            return "C"
        }
    }
}
