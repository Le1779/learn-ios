//
//  TimePickerAlertController.swift
//  Learn IOS
//
//  Created by Kevin Le on 2021/9/7.
//  Copyright © 2021 Kevin Le. All rights reserved.
//

import UIKit

class TimePickerAlertController: UIAlertController {
    
    var delegate: TimePickerDelegate?
    var startTime: Date? {
        didSet {
            if let picker = startTimePicker {
                picker.date = startTime ?? Date()
            }
        }
    }
    var endTime: Date? {
        didSet {
            if let picker = endTimePicker {
                picker.date = endTime ?? Date()
            }
        }
    }
    
    let container = UIViewController()
    let startTitleLabel = UILabel()
    let endTitleLabel = UILabel()
    var startTimePicker: UIDatePicker!
    var endTimePicker: UIDatePicker!
    var constraints = [NSLayoutConstraint]()
    
    override var preferredStyle: UIAlertController.Style {
        return .actionSheet
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.setValue(container, forKey: "contentViewController")
        
        self.addAction(UIAlertAction(title: "確認", style: .default, handler: { _ in
            self.delegate?.onChanged(start: self.startTimePicker.date, end: self.endTimePicker.date)
        }))
        
        self.addAction(UIAlertAction(title: "清除", style: .destructive, handler: { _ in
            self.delegate?.onClean()
        }))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateViews()
    }
}

//MARK: Initial Views
extension TimePickerAlertController {
    private func initViews() {
        initStartTitleLabel()
        initEndTitleLabel()
        initStartTimePicker()
        initEndTimePicker()
        NSLayoutConstraint.activate(constraints)
    }
    
    private func initStartTitleLabel() {
        container.view.addSubview(startTitleLabel)
        startTitleLabel.text = "開始時間"
        startTitleLabel.textColor = UIColor(hexString: "#585858")
        startTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(startTitleLabel.topAnchor.constraint(equalTo: container.view.topAnchor, constant: 24))
        constraints.append(startTitleLabel.leadingAnchor.constraint(equalTo: container.view.leadingAnchor, constant: 24))
        constraints.append(startTitleLabel.widthAnchor.constraint(equalTo: container.view.widthAnchor, multiplier: 0.5))
    }
    
    private func initEndTitleLabel() {
        container.view.addSubview(endTitleLabel)
        endTitleLabel.text = "結束時間"
        endTitleLabel.textColor = UIColor(hexString: "#585858")
        endTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(endTitleLabel.topAnchor.constraint(equalTo: container.view.topAnchor, constant: 24))
        constraints.append(endTitleLabel.leadingAnchor.constraint(equalTo: startTitleLabel.trailingAnchor, constant: 24))
        constraints.append(endTitleLabel.widthAnchor.constraint(equalTo: container.view.widthAnchor, multiplier: 0.5))
    }
    
    private func initStartTimePicker() {
        startTimePicker = {
            let picker = UIDatePicker()
            picker.date = startTime ?? Date()
            picker.timeZone = NSTimeZone.local
            picker.datePickerMode = .time
            if #available(iOS 13.4, *) {
                picker.preferredDatePickerStyle = .wheels
            }
            container.view.addSubview(picker)
            
            picker.translatesAutoresizingMaskIntoConstraints = false
            picker.widthAnchor.constraint(equalTo: container.view.widthAnchor, multiplier: 0.5).isActive = true
            picker.heightAnchor.constraint(equalToConstant: 300).isActive = true
            picker.topAnchor.constraint(equalTo: startTitleLabel.topAnchor).isActive = true
            picker.leadingAnchor.constraint(equalTo: container.view.leadingAnchor).isActive = true
            return picker
        }()
    }
    
    private func initEndTimePicker() {
        endTimePicker = {
            let picker = UIDatePicker()
            picker.date = endTime ?? Date()
            picker.timeZone = NSTimeZone.local
            picker.datePickerMode = .time
            if #available(iOS 13.4, *) {
                picker.preferredDatePickerStyle = .wheels
            }
            container.view.addSubview(picker)
            
            picker.translatesAutoresizingMaskIntoConstraints = false
            picker.widthAnchor.constraint(equalTo: container.view.widthAnchor, multiplier: 0.5).isActive = true
            picker.heightAnchor.constraint(equalToConstant: 300).isActive = true
            picker.topAnchor.constraint(equalTo: endTitleLabel.topAnchor).isActive = true
            picker.trailingAnchor.constraint(equalTo: container.view.trailingAnchor).isActive = true
            return picker
        }()
    }
}

//MARK: Update Views
extension TimePickerAlertController {
    private func updateViews() {
        container.preferredContentSize = CGSize(width: self.view.frame.size.width, height: 300)
    }
}

protocol TimePickerDelegate {
    func onChanged(start: Date, end: Date)
    func onClean()
}
