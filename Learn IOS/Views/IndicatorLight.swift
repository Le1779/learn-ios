//
//  LndicatorLight.swift
//  Learn IOS
//  指示燈
//  Created by Kevin Le on 2020/10/29.
//

import UIKit

class IndicatorLight: UIView {
    
    public var color: CGColor = defaultLightColor {
        didSet {
            updateLightColor()
            updateState()
        }
    }
    
    public var offColor: CGColor? {
        didSet {
            updateLightColor()
            updateState()
        }
    }
    
    public var cornerRadius: CGFloat = defaultCornerRadius {
        didSet { updateLightLayer() }
    }
    
    public var isOn: Bool = true {
        didSet {
            updateLightColor()
            updateState()
        }
    }
    
    private var size: CGSize = CGSize(width: 0.0, height: 0.0) {
        didSet {
            if oldValue.width != size.width || oldValue.height != size.height {
                updateLightLayer()
            }
        }
    }
    
    public static let defaultLightColor: CGColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
    private static let defaultShadowOffset: CGSize = .init(width: 0, height: 0)
    private static let defaultShadowRadius: CGFloat = 5
    private static let defaultCornerRadius: CGFloat = 10
    private var lightLayer = CAShapeLayer()
    
    public override init(frame: CGRect){
        super.init(frame: frame)
        initLightLayer()
        updateLightColor()
        updateState()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        size = CGSize(width: frame.width, height: frame.height)
    }
}

//MARK: Init
extension IndicatorLight {
    private func initLightLayer() {
        layer.addSublayer(lightLayer)
        lightLayer.backgroundColor = UIColor.clear.cgColor
        lightLayer.shadowOffset = IndicatorLight.defaultShadowOffset
        lightLayer.shadowRadius = IndicatorLight.defaultShadowRadius
    }
}

//MARK: Update
extension IndicatorLight {
    private func updateLightLayer() {
        lightLayer.frame = bounds
        lightLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
    }
    
    private func updateLightColor() {
        lightLayer.fillColor = isOn ? color : offColor
        lightLayer.shadowColor = color
    }
    
    private func updateState() {
        if offColor == nil {
            lightLayer.opacity = isOn ? 1 : 0
        }
        
        lightLayer.shadowOpacity = isOn ? 1 : 0
    }
}
