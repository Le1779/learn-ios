//
//  LightPowerButton.swift
//  Learn IOS
//
//  Created by Kevin Le on 2021/9/29.
//  Copyright © 2021 Kevin Le. All rights reserved.
//

import UIKit

class LightPowerButton: LeButton {
    
    var isOn: Bool = true {
        didSet {
            updateStatus()
        }
    }
    
    var lightnessView = UIView()
    var lightnessViewTC: NSLayoutConstraint!
    
    public override init(frame: CGRect){
        super.init(frame: frame)
        setupLightnessView()
        self.cornerType = .round
        self.setImage(withName: "Lightbulb", tintColor: UIColor(hexString: "#585858"))
        
        
        updateStatus()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateLayout() {
        super.updateLayout()
        self.setShadow(color: UIColor(hexString: "#00000020"), blur: 5)
        lightnessViewTC.constant = self.frame.width * 0.3
        
        lightnessView.layer.shadowPath = UIBezierPath(roundedRect: lightnessView.bounds, cornerRadius: lightnessView.layer.cornerRadius).cgPath
        lightnessView.layer.shadowRadius = lightnessView.frame.size.width*0.5
    }
    
    private func setupLightnessView() {
        lightnessView.layer.shadowOpacity = 1
        lightnessView.layer.shadowColor = UIColor(hexString: "#F4BF71").cgColor
        lightnessView.isUserInteractionEnabled = false
        self.addSubview(lightnessView)
        
        lightnessView.translatesAutoresizingMaskIntoConstraints = false
        lightnessViewTC = lightnessView.topAnchor.constraint(equalTo: self.topAnchor)
        lightnessViewTC.isActive = true
        lightnessView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3).isActive = true
        lightnessView.heightAnchor.constraint(equalTo: lightnessView.widthAnchor).isActive = true
        lightnessView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
}

//MARK: Update
extension LightPowerButton {
    private func updateStatus() {
        UIView.animate(withDuration: 0.25) {
            self.lightnessView.layer.shadowOpacity = self.isOn ? 1 : 0
            self.tintColor = self.isOn ? UIColor(hexString: "#585858") : UIColor(hexString: "#C8C8C8")
        }
    }
}
