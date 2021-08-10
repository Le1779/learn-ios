//
//  OnOffButton.swift
//  Learn IOS
//  帶有指示燈的開關按鈕
//  Created by Kevin Le on 2021/8/10.
//  Copyright © 2021 Kevin Le. All rights reserved.
//

import UIKit

class OnOffButton: LeButton {
    
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
    
    private var indicatorLight = IndicatorLight()
    private var statusLabel = UILabel()
    
    private var indicatorLightTC: NSLayoutConstraint!
    private var statusLabelBC: NSLayoutConstraint!
    private var componentsConstraints = [NSLayoutConstraint]()
    
    public override init(frame: CGRect){
        super.init(frame: frame)
        initComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        size = CGSize(width: frame.width, height: frame.height)
    }
}

//MARK: Init
extension OnOffButton {
    private func initComponents() {
        initIndicatorLight()
        initStatusLabel()
        NSLayoutConstraint.activate(componentsConstraints)
    }
    
    private func initIndicatorLight() {
        addSubview(indicatorLight)
        indicatorLight.color = UIColor(hexString: "#4CAF50").cgColor
        indicatorLight.offColor = UIColor(hexString: "#E8E8E8").cgColor
        
        indicatorLight.translatesAutoresizingMaskIntoConstraints = false
        indicatorLightTC = indicatorLight.topAnchor.constraint(equalTo: topAnchor)
        componentsConstraints.append(indicatorLightTC)
        componentsConstraints.append(indicatorLight.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4))
        componentsConstraints.append(indicatorLight.heightAnchor.constraint(equalToConstant: 4))
        componentsConstraints.append(indicatorLight.centerXAnchor.constraint(equalTo: centerXAnchor))
        
    }
    
    private func initStatusLabel() {
        addSubview(statusLabel)
        statusLabel.textColor = UIColor(hexString: "#787878")
        statusLabel.textAlignment = .center
        statusLabel.font = .boldSystemFont(ofSize: statusLabel.font.pointSize)
        
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        statusLabelBC = statusLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        componentsConstraints.append(statusLabelBC)
        componentsConstraints.append(statusLabel.centerXAnchor.constraint(equalTo: centerXAnchor))
        componentsConstraints.append(statusLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5))
        
        componentsConstraints.append(statusLabel.topAnchor.constraint(equalTo: indicatorLight.bottomAnchor))
        
    }
}

//MARK: Update
extension OnOffButton {
    /**
     更新子元件的約束，狀態文字垂直置中於指示燈與底部，最少都給予10個邊距
     */
    private func updateLayout() {
        let radius = layer.cornerRadius < 10 ? 10 : layer.cornerRadius
        indicatorLightTC.constant = radius
        statusLabelBC.constant = -1 * radius/2
        updateStatus()
    }
    
    /**
     更新指示燈與文字，且文字會自動響應寬度
     */
    private func updateStatus() {
        indicatorLight.isOn = isOn
        
        statusLabel.text = isOn ? "ON  " : "OFF"
        statusLabel.setFontSizeToFill()
    }
}
