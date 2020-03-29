//
//  TouchpadView.swift
//  Learn IOS
//
//  Created by Kevin Le on 2020/3/28.
//  Copyright © 2020 Kevin Le. All rights reserved.
//

import UIKit

class TouchpadView: UIView {
    
    private var touchpadListeners = [TouchpadListener]()
    private var isDrawShadow: Bool = false

    public override init(frame: CGRect){
        super.init(frame: frame)
        blurBackground()
        setCorner()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public func addTouchpadListener(listener: TouchpadListener) {
        if let index = touchpadListeners.firstIndex(where: {$0 === listener}) {
            touchpadListeners.remove(at: index)
        }
        
        touchpadListeners.append(listener)
    }
    
    override func draw(_ rect: CGRect) {
        if !isDrawShadow {
            isDrawShadow = true
            let shadowLayer = ShadowLayer(frame: self.frame, bounds: self.bounds, cornerRadius: self.layer.cornerRadius)
            self.superview?.insertSubview(shadowLayer, belowSubview: self)
        }
    }
    
    private func notifyLocationChange(location: CGPoint) {
        for listener in touchpadListeners {
            listener.locationChange(location: location)
        }
    }
    
    private func blurBackground() {
        let blurEffect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = frame
        self.addSubview(blurView)
    }
    
    private func setCorner() {
        self.layer.cornerRadius = self.frame.width/20
        self.clipsToBounds = true
    }
    
}

protocol TouchpadListener: NSObjectProtocol {
    
    func locationChange(location: CGPoint)
}

// MARK: Touch
extension TouchpadView {
    
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if let touch = touches.first {
            let touchLocation = touch.location(in: self)
            print("touchesBegan x:\(touchLocation.x), y:\(touchLocation.y)")
        }
        
    }
    
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        if let touch = touches.first {
            let touchLocation = touch.location(in: self)
            print("touchesEnded x:\(touchLocation.x), y:\(touchLocation.y)")
        }
    }
    
    open override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        if let touch = touches.first {
            let touchLocation = touch.location(in: self)
            print("touchesCancelled x:\(touchLocation.x), y:\(touchLocation.y)")
        }
    }
    
    open override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        if let touch = touches.first {
            let touchLocation = touch.location(in: self)
            notifyLocationChange(location: touchLocation)
        }
    }
    
}
