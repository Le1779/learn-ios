//
//  TimerButton.swift
//  Learn IOS
//
//  Created by Kevin Le on 2021/9/7.
//  Copyright © 2021 Kevin Le. All rights reserved.
//

import UIKit

class TimerButton: LeButton {
    private var size: CGSize = CGSize(width: 0.0, height: 0.0) {
        didSet {
            if oldValue.width != size.width || oldValue.height != size.height {
                updateLayout()
            }
        }
    }
    
    var icon: UIImageView!
    var title: UILabel!
    
    var iconLC: NSLayoutConstraint!
    var iconTC: NSLayoutConstraint!
    var titleRC: NSLayoutConstraint!
    
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
extension TimerButton {
    private func initComponents() {
        initIcon()
        initTitle()
        NSLayoutConstraint.activate(componentsConstraints)
    }
    
    private func initIcon() {
        icon = UIImageView()
        self.addSubview(icon)
        icon.image = UIImage(named: "Timer")?.withRenderingMode(.alwaysTemplate)
        icon.tintColor = UIColor(hexString: "#585858")
        
        icon.translatesAutoresizingMaskIntoConstraints = false
        iconLC = icon.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        iconTC = icon.topAnchor.constraint(equalTo: self.topAnchor)
        componentsConstraints.append(iconLC)
        componentsConstraints.append(iconTC)
        componentsConstraints.append(icon.widthAnchor.constraint(equalToConstant: 24))
        componentsConstraints.append(icon.heightAnchor.constraint(equalTo: icon.widthAnchor))
    }
    
    private func initTitle() {
        title = UILabel()
        self.addSubview(title)
        title.text = "定時"
        title.textColor = UIColor(hexString: "#585858")
        
        title.translatesAutoresizingMaskIntoConstraints = false
        titleRC = title.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        componentsConstraints.append(titleRC)
        componentsConstraints.append(title.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 8))
        componentsConstraints.append(title.centerYAnchor.constraint(equalTo: icon.centerYAnchor))
    }
}

//MARK: Update
extension TimerButton {
    private func updateLayout() {
        iconLC.constant = self.layer.cornerRadius
        iconTC.constant = self.layer.cornerRadius
        titleRC.constant = self.layer.cornerRadius * -1
    }
}
