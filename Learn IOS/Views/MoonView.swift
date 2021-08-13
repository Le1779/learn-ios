//
//  MoonView.swift
//  Learn IOS
//
//  Created by Kevin Le on 2020/5/14.
//  Copyright © 2020 Kevin Le. All rights reserved.
//

import UIKit

class MoonView: UIView {
    
    var viewWidth: CGFloat?
    var moonLightMargin: CGFloat?
    let moonLightCount: CGFloat = 2
    
    public override init(frame: CGRect){
        super.init(frame: frame)
        viewWidth = self.frame.width
        moonLightMargin = viewWidth!/8
        drawMoonLight()
        drawMoon()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func drawMoon() {
        let totalMargin = moonLightCount * moonLightMargin!
        let width = viewWidth! - totalMargin
        let cornerRadius = width/2
        let position = viewWidth!/2
        let moon = UIView()
        moon.frame = CGRect(x: 0, y: 0, width: width, height: width)
        moon.center = CGPoint(x: position, y: position)
        moon.backgroundColor = .white
        moon.layer.cornerRadius = cornerRadius
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            CGColor(srgbRed: 252/255, green: 248/255, blue: 222/255, alpha: 1),
            CGColor(srgbRed: 1, green: 1, blue: 1, alpha: 1)
        ]
        gradientLayer.frame = moon.bounds
        gradientLayer.cornerRadius = cornerRadius
        moon.layer.insertSublayer(gradientLayer, at: 0)
        self.addSubview(moon)
    }
    
    func drawMoonLight() {
        
        let centerPosition = viewWidth!/2
        for index in 0..<Int(moonLightCount) {
            let width = viewWidth! - moonLightMargin!*CGFloat(index)
            let cornerRadius = width/2
            let moonLight = UIView()
            moonLight.frame = CGRect(x: 0, y: 0, width: width, height: width)
            moonLight.center = CGPoint(x: centerPosition, y: centerPosition)
            moonLight.backgroundColor = .white
            moonLight.alpha = 0.2
            moonLight.layer.cornerRadius = cornerRadius
            
            let shadowLayer = ShadowView(frame: moonLight.frame,
                                      bounds: moonLight.bounds,
                                      cornerRadius: cornerRadius,
                                      shadowRadius: 10,
                                      shadowOpacity: 0.5,
                                      shadowOffset: CGSize(width: 0.0, height: 0.0),
                                      shadowColor: .white
            )
            
            self.addSubview(shadowLayer)
            self.addSubview(moonLight)
        }
    }
}
