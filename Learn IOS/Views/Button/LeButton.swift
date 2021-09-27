//
//  LeButton.swift
//  Learn IOS
//
//  Created by Kevin Le on 2021/8/10.
//  Copyright © 2021 Kevin Le. All rights reserved.
//

import UIKit

class LeButton: UIButton {
    
    public enum CornerType {
        case normal
        case round
    }
    
    public var cornerType: CornerType = .normal {
        didSet {
            updateLayout()
        }
    }
    
    public var setImageSizeWithWidth = true {
        didSet {
            updateLayout()
        }
    }
    
    private var size: CGSize = CGSize(width: 0.0, height: 0.0) {
        didSet {
            if oldValue.width != size.width || oldValue.height != size.height {
                updateLayout()
            }
        }
    }
    
    private var originalBackgroundColor: UIColor?
    private var activeBackgroundColor: UIColor?
    private var shadowLayer: ShadowView?
    private var shadowColor: UIColor?
    private var shadowBlur: CGFloat?
    
    public override init(frame: CGRect){
        super.init(frame: frame)
        setBackgroundColor(.systemBackground)
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        size = CGSize(width: frame.width, height: frame.height)
    }
    
    func setTitle(_ text: String, tintColor: UIColor = .black) {
        super.setTitle(text, for: .normal)
        super.setTitleColor(tintColor, for: .normal)
    }
    
    func setImage(withName: String, tintColor: UIColor = .black) {
        super.setImage(UIImage(named: withName)?.withRenderingMode(.alwaysTemplate), for: .normal)
        super.tintColor = tintColor
    }
    
    func setBackgroundColor(_ color: UIColor) {
        backgroundColor = color
        originalBackgroundColor = color
        activeBackgroundColor = color.darker(10)
    }
    
    func setShadow(color: UIColor, blur: CGFloat) {
        self.shadowColor = color
        self.shadowBlur = blur
        if let shadowLayer = shadowLayer {
            shadowLayer.removeFromSuperview()
        }
        
        shadowLayer = ShadowView(shadowRadius: blur, shadowOpacity: 1, shadowOffset: CGSize(width: 0, height: 4) ,shadowColor: color)
        self.superview?.insertSubview(shadowLayer!, belowSubview: self)
        updateShadowLayer()
    }
    
    func updateLayout() {
        if self.size.width != 0 && self.size.height != 0 {
            let imageSize = (setImageSizeWithWidth ? frame.size.width : frame.size.height)/2
            let image = self.imageView?.image?.resizeImage(imageSize).withRenderingMode(.alwaysTemplate)
            super.setImage(image, for: .normal)
        }
        
        if cornerType == .round {
            layer.cornerRadius = frame.size.height * 0.5
        }
        
        updateShadowLayer()
    }
}

//MARK: Update
extension LeButton {
    private func updateShadowLayer() {
        if let shadow = shadowLayer {
            shadow.setFrame(frame: frame)
            shadow.setBounds(bounds: bounds)
            shadow.setCornerRadius(cornerRadius: layer.cornerRadius)
        }
    }
}

//MARK: Touch Event
extension LeButton {
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.backgroundColor = self.activeBackgroundColor
        shadowLayer?.setShadowRadius(shadowRadius: (shadowBlur ?? 1)/2)
    }
    
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        self.backgroundColor = self.originalBackgroundColor
        shadowLayer?.setShadowRadius(shadowRadius: shadowBlur)
    }
    
    open override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        self.backgroundColor = self.originalBackgroundColor
        shadowLayer?.setShadowRadius(shadowRadius: shadowBlur)
    }
    
    open override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        self.backgroundColor = self.activeBackgroundColor
        shadowLayer?.setShadowRadius(shadowRadius: (shadowBlur ?? 1)/2)
    }
}
