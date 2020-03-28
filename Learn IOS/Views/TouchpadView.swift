//
//  TouchpadView.swift
//  Learn IOS
//
//  Created by Kevin Le on 2020/3/28.
//  Copyright © 2020 Kevin Le. All rights reserved.
//

import UIKit

class TouchpadView: UIView {

    public override init(frame: CGRect){
        super.init(frame: frame)
        let blurEffect = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = frame
        self.addSubview(blurView)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func draw(_ rect: CGRect) {
        
    }
    
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
            print("touchesMoved x:\(touchLocation.x), y:\(touchLocation.y)")
        }
    }
    
}
