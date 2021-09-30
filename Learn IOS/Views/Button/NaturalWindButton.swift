//
//  NaturalWindButton.swift
//  Learn IOS
//
//  Created by Kevin Le on 2021/9/23.
//  Copyright © 2021 Kevin Le. All rights reserved.
//

import UIKit

class NaturalWindButton: LeButton {
    
    var isOn: Bool = true {
        didSet {
            updateStatus()
        }
    }
    
    override var isEnabled: Bool {
        didSet {
            updateStatus()
        }
    }
    
    public override init(frame: CGRect){
        super.init(frame: frame)
        self.cornerType = .round
        self.setImage(withName: "Leaf", tintColor: UIColor(hexString: "#4CAF50"))
        
        updateStatus()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateLayout() {
        super.updateLayout()
        self.setShadow(color: UIColor(hexString: "#00000020"), blur: 5)
    }
}

//MARK: Update
extension NaturalWindButton {
    private func updateStatus() {
        self.tintColor = isOn && isEnabled ? UIColor(hexString: "#4CAF50") : UIColor(hexString: "#C8C8C8")
    }
}
