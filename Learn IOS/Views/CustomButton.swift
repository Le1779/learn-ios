//
//  LoadingButton.swift
//  Learn IOS
//  學習怎麼製作客製化元件
//  Created by Kevin Le on 2020/3/26.
//  Copyright © 2020 Kevin Le. All rights reserved.
//

import UIKit

class CustomButton: UIButton {
    
    private var originalBackgroundColor: UIColor = .black
    private var activeBackgroundColor: UIColor = .black
    private var withShadow: Bool = false
    private var shadowLayer: ShadowLayer?
    private var isAddedShadow: Bool = false
    
    open override func draw(_ rect: CGRect) {
        super.draw(rect)
        if isAddedShadow || !withShadow {
            return
        }
        
        isAddedShadow = true
        
        guard let shadowLayer = shadowLayer else {
            return
        }
        
        self.superview?.insertSubview(shadowLayer, belowSubview: self)
    }
    
    public class Builder {
        
        var button: CustomButton
        
        public init(frame: CGRect) {
            button = CustomButton(frame: frame)
            button.backgroundColor = .black
            button.setTitleColor(.black, for: .normal)
            self.button.layer.borderWidth = 0
            self.button.contentEdgeInsets = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        }
        
        public func setBackgroundColor(color: UIColor) -> Builder {
            self.button.backgroundColor = color
            self.button.originalBackgroundColor = color
            self.button.activeBackgroundColor = color.getColorTint()
            return self
        }
        
        public func setText(text: String) -> Builder {
            self.button.setTitle(text, for: .normal)
            self.button.titleLabel?.adjustsFontSizeToFitWidth = true
            return self
        }
        
        public func setTextColor(color: UIColor) -> Builder {
            self.button.setTitleColor(color, for: .normal)
            return self
        }
        
        public func setCornerRadius(radius: CGFloat) -> Builder {
            self.button.layer.cornerRadius = radius
            self.button.clipsToBounds = true
            return self
        }
        
        public func setBorderWidth(width: CGFloat) -> Builder {
            self.button.layer.borderWidth = width
            return self
        }
        
        public func setBorderColor(color: CGColor) -> Builder {
            self.button.layer.borderColor = color
            return self
        }
        
        public func setWithShadow(withShadow: Bool) -> Builder {
            self.button.withShadow = withShadow
            if withShadow {
                self.button.shadowLayer = ShadowLayer(frame: self.button.frame, bounds: self.button.bounds, cornerRadius: self.button.layer.cornerRadius)
            }
            
            return self
        }
        
        public func build() -> CustomButton {
            return button
        }
    }
    
}

// MARK: Touch
extension CustomButton {
    
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.backgroundColor = self.activeBackgroundColor
        if shadowLayer != nil {
            shadowLayer?.layer.shadowColor = UIColor.clear.cgColor
        }
    }
    
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        self.backgroundColor = self.originalBackgroundColor
        if shadowLayer != nil {
            shadowLayer?.layer.shadowColor = UIColor.lightGray.cgColor
        }
    }
    
    open override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        self.backgroundColor = self.originalBackgroundColor
    }
    
    open override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        self.backgroundColor = self.activeBackgroundColor
    }
    
}

// MARK: - UIColor
extension UIColor {
    /**
     Convert RGB value to CMYK value.
     
     - Parameter red: The red value of RGB.
     - Parameter green: The green value of RGB.
     - Parameter blue: The blue value of RGB.
     
     Returns a 4-tuple that represents the CMYK value converted from input RGB.
     */
    public func RGBtoCMYK(
        red: CGFloat,
        green: CGFloat,
        blue: CGFloat
    ) -> (
        cyan: CGFloat,
        magenta: CGFloat,
        yellow: CGFloat,
        key: CGFloat
    ) {
        // Base case
        if red == 0, green == 0, blue == 0 {
            return (0, 0, 0, 1)
        }
        var cyan = 1 - red
        var magenta = 1 - green
        var yellow = 1 - blue
        let minCMY = min(cyan, magenta, yellow)
        cyan = (cyan - minCMY) / (1 - minCMY)
        magenta = (magenta - minCMY) / (1 - minCMY)
        yellow = (yellow - minCMY) / (1 - minCMY)
        return (cyan, magenta, yellow, minCMY)
    }
    /**
     Convert CMYK value to RGB value.
     
     - Parameter cyan: The cyan value of CMYK.
     - Parameter magenta: The magenta value of CMYK.
     - Parameter yellow: The yellow value of CMYK.
     - Parameter key: The key/black value of CMYK.
     
     Returns a 3-tuple that represents the RGB value converted from input CMYK.
     */
    public func CMYKtoRGB(
        cyan: CGFloat,
        magenta: CGFloat,
        yellow: CGFloat,
        key: CGFloat
    ) -> (
        red: CGFloat,
        green: CGFloat,
        blue: CGFloat
    ) {
        let red = (1 - cyan) * (1 - key)
        let green = (1 - magenta) * (1 - key)
        let blue = (1 - yellow) * (1 - key)
        return (red, green, blue)
    }
    /**
     Get the tint color of the current color.
     */
    public func getColorTint() -> UIColor {
        let ciColor = CIColor(color: self)
        let originCMYK = RGBtoCMYK(red: ciColor.red, green: ciColor.green, blue: ciColor.blue)
        let kVal = originCMYK.key > 0.3 ? originCMYK.key - 0.2 : originCMYK.key + 0.2
        let tintRGB = CMYKtoRGB(cyan: originCMYK.cyan, magenta: originCMYK.magenta, yellow: originCMYK.yellow, key: kVal)
        return UIColor(red: tintRGB.red, green: tintRGB.green, blue: tintRGB.blue, alpha: 1.0)
    }
}
