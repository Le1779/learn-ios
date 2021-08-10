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
    
    open override func draw(_ rect: CGRect) {
        super.draw(rect)
    }
    
    public override init(frame: CGRect){
        super.init(frame: frame)
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        update()
    }
    
    func setImage(withName: String) {
        super.setImage(UIImage(named: withName)?.withRenderingMode(.alwaysTemplate), for: .normal)
    }
    
    func setBackgroundColor(_ color: UIColor) {
        backgroundColor = color
        originalBackgroundColor = color
        activeBackgroundColor = color.darker()
    }
}

//MARK: Update
extension LeButton {
    private func update() {
        let edge = frame.size.width/4
        imageEdgeInsets = UIEdgeInsets(top: edge, left: edge, bottom: edge, right: edge)
        
        if cornerType == .round {
            layer.cornerRadius = frame.size.width * 0.5
        }
    }
}

//MARK: Touch Event
extension LeButton {
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.backgroundColor = self.activeBackgroundColor
    }
    
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        self.backgroundColor = self.originalBackgroundColor
    }
}
