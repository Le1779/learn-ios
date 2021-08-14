//
//  Angle.swift
//  Learn IOS
//
//  Created by Kevin Le on 2021/8/14.
//  Copyright © 2021 Kevin Le. All rights reserved.
//

import UIKit

class Angle {
    var value: Int
    var radians: CGFloat = 0
    var quadrant: Int = 1
    
    init(_ value: Int) {
        self.value = value
        if value > 360 {
            self.value = value % 360
        }
        
        self.radians = getRadians(self.value)
        self.quadrant = getQuadrant(self.value)
    }
    
    private func getRadians(_ angle: Int) -> CGFloat {
        return CGFloat(angle * -1) * .pi / 180
    }
    
    private func getQuadrant(_ angle: Int) -> Int {
        return Int(angle/90) + 1
    }
}
