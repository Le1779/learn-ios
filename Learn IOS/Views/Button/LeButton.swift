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
            update()
        }
    }
    
    private var originalBackgroundColor: UIColor?
    private var activeBackgroundColor: UIColor?
    private var shadowLayer: ShadowLayer?
    private var shadowColor: UIColor?
    private var shadowBlur: CGFloat?
    private var isDrawnShadow = false
    
    open override func draw(_ rect: CGRect) {
        super.draw(rect)
        if !isDrawnShadow && shadowLayer != nil {
            self.superview?.insertSubview(shadowLayer!, belowSubview: self)
            isDrawnShadow = true
        }
    }
    
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
        update()
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
        shadowColor = color
        shadowBlur = blur
        shadowLayer = ShadowLayer(shadowRadius: blur, shadowOpacity: 1, shadowOffset: CGSize(width: 0, height: 4) ,shadowColor: color)
    }
}

//MARK: Update
extension LeButton {
    private func update() {
        if cornerType == .round {
            let edge = frame.size.width/4
            imageEdgeInsets = UIEdgeInsets(top: edge, left: edge, bottom: edge, right: edge)
            layer.cornerRadius = frame.size.width * 0.5
        }
        
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
