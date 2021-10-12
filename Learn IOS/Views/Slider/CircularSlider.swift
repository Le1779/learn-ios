//
//  CircularSlider.swift
//  Learn IOS
//
//  Created by Kevin Le on 2021/8/14.
//  Copyright © 2021 Kevin Le. All rights reserved.
//

import UIKit

class CircularSlider: UIControl {
    
    public weak var delegate: CircularSliderDelegate?
    public var angle: Int
    public var beginAngle: Int
    public var clockwise: Bool = false
    public override var isEnabled: Bool {
        didSet{
            if thumbView != nil {
                thumbView.isHidden = !isEnabled
            }
        }
    }
    
    private var trackPath: TrackPath?
    private var trackLayer: TrackLayer! {
        didSet {
            if trackLayer != nil {
                trackLayer.removeFromSuperlayer()
            
            }
            
            self.layer.addSublayer(self.trackLayer)
        }
    }
    
    public var thumbWidth: CGFloat = 20
    public var thumbView: ThumbView! {
        didSet {
            self.addSubview(self.thumbView)
            if let path = trackPath {
                thumbView.center = path.getPointFromAngle(beginAngle)
            }
            
            thumbView.isHidden = !isEnabled
        }
    }
    public var thumbImage: UIImage? {
        didSet {
            if thumbView != nil {
                thumbView.image = thumbImage
            }
        }
    }
    
    private var _value: Float = 0
    public var value: Float {
        get {
            return self._value
        }
        set {
            let value = round(100*newValue)/100
            if value >= 0 && value <= 1 {
                self._value = value
                updateThumbViewPosition()
            }
        }
    }
    
    public convenience init() {
        self.init(angle: 0, beginAngle: 0)
    }
    
    public init(angle: Int, beginAngle: Int){
        self.angle = angle
        self.beginAngle = beginAngle
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSublayers(of _: CALayer) {
        if trackLayer == nil {
            trackPath = TrackPath(bounds: bounds, padding: 5, angle: angle, beginAngle: beginAngle, clockwise: clockwise)
            if let path = trackPath?.path {
                trackLayer = TrackLayer(bounds: bounds, maskPath: path, pathWidth: 5)
            }
        }
        
        if thumbView == nil {
            thumbView = ThumbView(width: thumbWidth)
            updateThumbViewPosition()
        }
        
        if thumbImage != nil {
            thumbView.image = thumbImage
        }
    }
    
    open override func hitTest(_ point: CGPoint, with _: UIEvent?) -> UIView? {
        if !(thumbView.frame.contains(point)) {
            return nil
        }
        return self
    }
    
    open override func continueTracking(_ touch: UITouch, with _: UIEvent?) -> Bool {
        guard let path = trackPath else {
            return true
        }
        
        let currentAngle = path.getAngleFromPoint(touch.location(in: self))
        let originAngle = path.getOriginAngle(currentAngle)
        let rate = Float(originAngle)/Float(angle)
        self.value = rate
        delegate?.onChanged(value, slider: self)
        return true
    }
    
    private func updateThumbViewPosition() {
        guard let path = trackPath else {
            return
        }
        
        guard let thumb = thumbView else {
            return
        }
        
        var currentAngle = Float(angle)*value
        if clockwise {
            currentAngle = Float(beginAngle) - currentAngle
        } else {
            currentAngle = Float(beginAngle) + currentAngle
        }
        
        thumb.center = path.getPointFromAngle(Int(currentAngle))
    }
}

protocol CircularSliderDelegate: NSObjectProtocol {
    func onChanged(_ value: Float, slider: CircularSlider)
}
