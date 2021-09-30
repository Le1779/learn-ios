//
//  UVCButton.swift
//  Learn IOS
//  文字與邊緣有漸層效果的按鈕
//  https://stackoverflow.com/questions/36836367/how-can-i-do-programmatically-gradient-border-color-uibutton-with-swift
//  Created by Kevin Le on 2021/8/11.
//  Copyright © 2021 Kevin Le. All rights reserved.
//

import UIKit

class UVCButton: LeButton {
    
    var isOn: Bool = true {
        didSet {
            updateBorderLayer()
        }
    }
    
    var lineWidthRatio = 0.08 {
        didSet {
            borderMaskLayer.lineWidth = frame.size.width * lineWidthRatio
        }
    }
    
    override var isEnabled: Bool {
        didSet {
            updateBorderLayer()
            updateFontColor()
        }
    }
    
    private var label = UILabel()
    private var borderLayer: CAGradientLayer!
    private var borderMaskLayer = CAShapeLayer()
    
    private var componentsConstraints = [NSLayoutConstraint]()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     更新字體大小與字體顏色 & 邊框的大小
     */
    override func updateLayout() {
        super.updateLayout()
        label.setFontSizeToFill()
        updateBorderLayer()
        updateFontColor()
        
        borderLayer.frame = bounds
        borderMaskLayer.lineWidth = frame.size.width * lineWidthRatio
        borderMaskLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
    }
}

//MARK: Init
extension UVCButton {
    private func initComponents() {
        initLabel()
        initBorderLayer()
        NSLayoutConstraint.activate(componentsConstraints)
    }
    
    /**
     中間的漸層UVC Label
     */
    private func initLabel() {
        addSubview(label)
        
        label.text = "UVC"
        label.textColor = UIColor(hexString: "#787878")
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: label.font.pointSize)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        componentsConstraints.append(label.centerXAnchor.constraint(equalTo: centerXAnchor))
        componentsConstraints.append(label.centerYAnchor.constraint(equalTo: centerYAnchor))
        componentsConstraints.append(label.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6))
    }
    
    /**
     邊框的漸層
     */
    private func initBorderLayer() {
        borderLayer = getGradientLayer(bounds: .zero)
        layer.addSublayer(borderLayer)
        
        borderMaskLayer.strokeColor = UIColor.black.cgColor
        borderMaskLayer.fillColor = UIColor.clear.cgColor
        borderLayer.mask = borderMaskLayer
    }
}

//MARK: Update
extension UVCButton {
    private func updateBorderLayer() {
        borderLayer.opacity = isOn && isEnabled ? 1 : 0
    }
    
    private func updateFontColor() {
        if isEnabled {
            let gradient = getGradientLayer(bounds: label.bounds)
            label.textColor = gradientColor(bounds: label.bounds, gradientLayer: gradient)
        } else {
            label.textColor = UIColor(hexString: "#C8C8C8")
        }
    }
}

//MARK: Gradient
extension UVCButton {
    /**
     產生漸層的顏色
     */
    func gradientColor(bounds: CGRect, gradientLayer :CAGradientLayer) -> UIColor? {
        if bounds.size.width == 0 || bounds.size.height == 0 {
            return nil
        }
        
        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return UIColor(patternImage: image!)
    }
    
    /**
     取得GradientLayer
     */
    func getGradientLayer(bounds : CGRect) -> CAGradientLayer{
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = [UIColor(hexString: "#A066FF8C").cgColor,
                           UIColor(hexString: "#75ABFB8C").cgColor]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        return gradient
    }
}
