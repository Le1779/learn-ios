//
//  NightLightPowerButton.swift
//  Learn IOS
//
//  Created by Kevin Le on 2021/9/30.
//  Copyright © 2021 Kevin Le. All rights reserved.
//

import UIKit

class NightLightPowerButton: LeButton {
    
    var isOn: Bool = true {
        didSet {
            updateStatus()
        }
    }
    
    var lightnessView = UIView()
    var lightnessViewBC: NSLayoutConstraint!
    var lightnessViewRC: NSLayoutConstraint!
    
    public override init(frame: CGRect){
        super.init(frame: frame)
        setupLightnessView()
        self.cornerType = .round
        self.setImage(withName: "NightLight", tintColor: UIColor(hexString: "#585858"))
        
        updateStatus()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     設定陰影、設定光暈的大小＆位置
     */
    override func updateLayout() {
        super.updateLayout()
        self.setShadow(color: UIColor(hexString: "#00000020"), blur: 5)
        lightnessViewBC.constant = self.frame.width * -0.2
        lightnessViewRC.constant = self.frame.width * -0.2
        
        lightnessView.layer.shadowPath = UIBezierPath(roundedRect: lightnessView.bounds, cornerRadius: lightnessView.layer.cornerRadius).cgPath
        lightnessView.layer.shadowRadius = lightnessView.frame.size.width*0.5
    }
}

//MARK: Setup Subview
extension NightLightPowerButton {
    /**
     將光暈放在畫面上
     */
    private func setupLightnessView() {
        lightnessView.layer.shadowOpacity = 1
        lightnessView.layer.shadowColor = UIColor(hexString: "#F4BF71").cgColor
        lightnessView.isUserInteractionEnabled = false
        self.addSubview(lightnessView)
        
        lightnessView.translatesAutoresizingMaskIntoConstraints = false
        lightnessViewBC = lightnessView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        lightnessViewRC = lightnessView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        lightnessViewBC.isActive = true
        lightnessViewRC.isActive = true
        lightnessView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3).isActive = true
        lightnessView.heightAnchor.constraint(equalTo: lightnessView.widthAnchor).isActive = true
    }
}

//MARK: Update
extension NightLightPowerButton {
    private func updateStatus() {
        UIView.animate(withDuration: 0.25) {
            self.lightnessView.layer.shadowOpacity = self.isOn ? 1 : 0
            self.tintColor = self.isOn ? UIColor(hexString: "#585858") : UIColor(hexString: "#C8C8C8")
        }
    }
}
