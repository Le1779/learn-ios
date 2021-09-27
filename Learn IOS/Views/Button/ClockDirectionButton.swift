//
//  ClockDirectionButton.swift
//  Learn IOS
//
//  Created by Kevin Le on 2021/9/27.
//  Copyright © 2021 Kevin Le. All rights reserved.
//

import UIKit

class ClockDirectionButton: LeButton {
    
    var clockwise: Bool = true {
        didSet {
            self.setImage(withName: clockwise ? "Clockwise" : "CounterClockwise", tintColor: UIColor(hexString: "#585858"))
            self.updateLayout()
        }
    }
    
    public override init(frame: CGRect){
        super.init(frame: frame)
        self.cornerType = .round
        self.setImage(withName: "Clockwise", tintColor: UIColor(hexString: "#585858"))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateLayout() {
        super.updateLayout()
        self.setShadow(color: UIColor(hexString: "#00000020"), blur: 5)
    }
}
