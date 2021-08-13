//
//  RoundSlider.swift
//  Learn IOS
//
//  Created by Kevin Le on 2021/8/11.
//  Copyright © 2021 Kevin Le. All rights reserved.
//

import UIKit

class RoundSlider: UIControl {
    
    public var color: UIColor = .clear {
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
        }
    }
    
    public var beginAngle: CGFloat = 0
    public var endAngle: CGFloat = 359 
    
    public var thumbWidth: CGFloat = 20
    public var thumbView: ThumbView! {
        didSet {
            self.addSubview(self.thumbView)
            if let path = inactiveTrackPath {
                thumbView.center = path.getPointFromAngle(beginAngle)
            }
        }
    }
    
    private var inactiveTrackPath: TrackPath?
    
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
            let angleRange = TrackPath.AngleRange(begin: beginAngle, end: endAngle)
            inactiveTrackPath = TrackPath(bounds: bounds, width: 5, angleRange: angleRange)
            if let path = inactiveTrackPath?.path {
                trackLayer = TrackLayer(bounds: bounds, maskPath: path, pathWidth: 5)
            }
        }
        
        if thumbView == nil {
            thumbView = ThumbView(width: thumbWidth)
        }
    }
    
    open override func hitTest(_ point: CGPoint, with _: UIEvent?) -> UIView? {
        if !(thumbView.frame.contains(point)) {
            return nil
        }
        return self
    }
    
    open override func continueTracking(_ touch: UITouch, with _: UIEvent?) -> Bool {
        guard let path = inactiveTrackPath else {
            return true
        }
        
        let angle = path.getAngleFromPoint(touch.location(in: self))
        if path.isInAngleRange(angle) {
            thumbView.center = path.getPointFromAngle(angle)
        } else {
            
        }
        
        
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
