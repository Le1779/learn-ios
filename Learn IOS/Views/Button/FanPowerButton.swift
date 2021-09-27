//
//  FanPowerButton.swift
//  Learn IOS
//
//  Created by Kevin Le on 2021/9/23.
//  Copyright © 2021 Kevin Le. All rights reserved.
//

import UIKit

class FanPowerButton: LeButton {
    
    var isOn: Bool = true {
        didSet {
            updateStatus()
        }
    }
    
    var clockwise: Bool = true {
        didSet {
            rotate()
        }
    }
    
    var speedRate: Float = 0 {
        didSet {
            if oldValue != speedRate {
                rotate()
            }
        }
    }
    
    private var size: CGSize = CGSize(width: 0.0, height: 0.0) {
        didSet {
            if oldValue.width != size.width || oldValue.height != size.height {
                updateLayout()
            }
        }
    }
    
    private var rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
    
    public override init(frame: CGRect){
        super.init(frame: frame)
        self.cornerType = .round
        self.setImage(withName: "Fan", tintColor: UIColor(hexString: "#585858"))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        size = CGSize(width: frame.width, height: frame.height)
    }
}

//MARK: Update
extension FanPowerButton {
    private func updateLayout() {
        self.setShadow(color: UIColor(hexString: "#00000020"), blur: 5)
        updateStatus()
        rotate()
    }
    
    private func updateStatus() {
        self.tintColor = isOn ? UIColor(hexString: "#585858") : UIColor(hexString: "#C8C8C8")
        
        if isOn {
            rotate()
        } else {
            imageView?.layer.removeAnimation(forKey: "rotate")
        }
    }
    
    func rotate() {
        imageView?.layer.removeAnimation(forKey: "rotate")
        
        if !isOn {
            return
        }
        
        rotateAnimation.repeatCount = .infinity
        rotateAnimation.fromValue = clockwise ? 0 : Double.pi*2
        rotateAnimation.toValue = clockwise ? Double.pi*2 : 0
        
        let speed = 1.25 - 0.75 * speedRate
        rotateAnimation.duration = CFTimeInterval(speed)
        imageView?.layer.add(rotateAnimation, forKey: "rotate")
    }
}
