//
//  TimerButton.swift
//  Learn IOS
//
//  Created by Kevin Le on 2021/9/7.
//  Copyright © 2021 Kevin Le. All rights reserved.
//

import UIKit

class TimerButton: LeButton {
    
    private var startTime: Date?
    private var endTime: Date?
    private let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
    
    
    private var size: CGSize = CGSize(width: 0.0, height: 0.0) {
        didSet {
            if oldValue.width != size.width || oldValue.height != size.height {
                updateLayout()
            }
        }
    }
    
    private var icon: UIImageView!
    private var title: UILabel!
    private var time: UILabel!
    
    private var iconLC: NSLayoutConstraint!
    private var iconTC: NSLayoutConstraint!
    private var titleRC: NSLayoutConstraint!
    private var timeBC: NSLayoutConstraint!
    
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
    
    public func setTime(startTime: Date?, endTime: Date?) {
        self.startTime = startTime
        self.endTime = endTime
        
        guard let startTime = startTime, let endTime = endTime else {
            time.text = "未設定"
            return
        }
        
        time.text = "\(timeFormatter.string(from: startTime))- \(timeFormatter.string(from: endTime))"
    }
}

//MARK: Init
extension TimerButton {
    private func initComponents() {
        initIcon()
        initTitle()
        initTime()
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
    
    private func initTime() {
        time = UILabel()
        self.addSubview(time)
        time.text = "未設定"
        time.textColor = UIColor(hexString: "#585858")
        time.textAlignment = .center
        
        time.translatesAutoresizingMaskIntoConstraints = false
        timeBC = time.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        componentsConstraints.append(timeBC)
        componentsConstraints.append(time.leadingAnchor.constraint(equalTo: icon.leadingAnchor))
        componentsConstraints.append(time.trailingAnchor.constraint(equalTo: title.trailingAnchor))
        componentsConstraints.append(time.topAnchor.constraint(equalTo: icon.bottomAnchor))
    }
}

//MARK: Update
extension TimerButton {
    private func updateLayout() {
        iconLC.constant = self.layer.cornerRadius
        iconTC.constant = self.layer.cornerRadius
        titleRC.constant = self.layer.cornerRadius * -1
        timeBC.constant = self.layer.cornerRadius * -1
    }
}
