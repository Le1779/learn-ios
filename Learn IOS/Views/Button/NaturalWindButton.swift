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
    
    private var size: CGSize = CGSize(width: 0.0, height: 0.0) {
        didSet {
            if oldValue.width != size.width || oldValue.height != size.height {
                updateLayout()
            }
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        size = CGSize(width: frame.width, height: frame.height)
    }
}

//MARK: Update
extension NaturalWindButton {
    private func updateLayout() {
        self.setShadow(color: UIColor(hexString: "#00000020"), blur: 5)
    }
    
    private func updateStatus() {
        self.tintColor = isOn ? UIColor(hexString: "#4CAF50") : UIColor(hexString: "#C8C8C8")
    }
}
