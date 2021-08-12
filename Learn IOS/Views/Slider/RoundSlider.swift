//
//  RoundSlider.swift
//  Learn IOS
//
//  Created by Kevin Le on 2021/8/11.
//  Copyright © 2021 Kevin Le. All rights reserved.
//

import UIKit

class RoundSlider: UIControl {
    
    public var color: UIColor = .blue {
        didSet {
            self.backgroundColor = color
        }
    }
    
    private var _value: Float = 0
    open var value: Float {
        get {
            return self._value
        }
        set {
            var value = newValue
            self._value = value
            print("update value")
            //self.sendActions(for: .valueChanged)
            //self.layout(degree)
        }
    }
    
    public var beginAngle: CGFloat = 0 {
        didSet {
            if trackLayer != nil {
                trackLayer.beginAngle = beginAngle
            }
        }
    }
    public var endAngle: CGFloat = 359 {
        didSet {
            if trackLayer != nil {
                trackLayer.endAngle = endAngle
            }
        }
    }
    
    private var trackLayer: TrackLayer! {
        didSet {
            self.layer.addSublayer(self.trackLayer)
        }
    }
    
    private var size: CGSize = CGSize(width: 0.0, height: 0.0) {
        didSet {
            if oldValue.width != size.width || oldValue.height != size.height {
                updateLayout()
            }
        }
    }
    
    private var componentsConstraints = [NSLayoutConstraint]()
    
    public override init(frame: CGRect){
        super.init(frame: frame)
        initComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        size = CGSize(width: frame.width, height: frame.height)
    }
    
    override func layoutSublayers(of _: CALayer) {
        if trackLayer == nil {
            trackLayer = TrackLayer(bounds: bounds, beginAngle: beginAngle, endAngle: endAngle)
        }
    }
    
    open override func continueTracking(_ touch: UITouch, with _: UIEvent?) -> Bool {
        //print("continueTracking")
        return true
    }
}

//MARK: Init
extension RoundSlider {
    private func initComponents() {
        self.backgroundColor = color
        NSLayoutConstraint.activate(componentsConstraints)
    }
}

//MARK: Update
extension RoundSlider {
    private func updateLayout() {}
}

//MARK: Touch
extension RoundSlider {
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.backgroundColor = color.lighter()
    }
    
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        self.backgroundColor = color
    }
}
