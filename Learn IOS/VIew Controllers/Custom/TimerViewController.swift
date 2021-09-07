//
//  TimerViewController.swift
//  Learn IOS
//
//  Created by Kevin Le on 2021/9/6.
//  Copyright © 2021 Kevin Le. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController {
    
    private var startTime: Date?
    private var endTime: Date?
    
    let backButton = LeButton()
    let showAlertButton = LeButton()
    var timer: Timer!
    var timerButton: TimerButton!
    var timePicker: TimePickerAlertController!
    private var constraints = [NSLayoutConstraint]()
    private let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startTime = timeFormatter.date(from: "09:30")
        endTime = timeFormatter.date(from: "17:45")
        initViews()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateViews()
    }
    
    @objc func onBackButtonClick(_ sender:UIButton) {
        UIImpactFeedbackGenerator().impactOccurred()
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func onShowAlertButtonClick(_ sender:UIButton) {
        UIImpactFeedbackGenerator().impactOccurred()
        present(timePicker, animated: true)
    }
}

//MARK: Initial Views
extension TimerViewController {
    private func initViews() {
        initBackButton()
        initTimerButton()
        initShowAlertButton()
        NSLayoutConstraint.activate(constraints)
        
        initTimePicker()
    }
    
    private func initTimePicker() {
        timePicker = TimePickerAlertController()
        timePicker.delegate = self
        timePicker.startTime = startTime
        timePicker.endTime = endTime
    }
    
    private func initBackButton() {
        view.addSubview(backButton)
        backButton.cornerType = .round
        backButton.setImage(withName: "ArrowBack", tintColor: UIColor(hexString: "#585858"))
        backButton.setBackgroundColor(UIColor(hexString: "#C8C8C840"))
        backButton.addTarget(self, action: #selector(onBackButtonClick), for: .touchUpInside)
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 48))
        constraints.append(backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36))
        constraints.append(backButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.12))
        constraints.append(backButton.heightAnchor.constraint(equalTo: backButton.widthAnchor))
    }
    
    private func initShowAlertButton() {
        view.addSubview(showAlertButton)
        showAlertButton.cornerType = .round
        showAlertButton.setBackgroundColor(UIColor(hexString: "#585858"))
        showAlertButton.setTitle("Show Alert", for: .normal)
        showAlertButton.setTitleColor(UIColor(hexString: "#E8E8E8"), for: .normal)
        showAlertButton.addTarget(self, action: #selector(onShowAlertButtonClick), for: .touchUpInside)
        
        showAlertButton.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(showAlertButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor))
        constraints.append(showAlertButton.centerYAnchor.constraint(equalTo: backButton.centerYAnchor))
        constraints.append(showAlertButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.3))
        constraints.append(showAlertButton.heightAnchor.constraint(equalToConstant: 48))
    }
    
    private func initTimerButton() {
        timerButton = TimerButton()
        self.view.addSubview(timerButton)
        timerButton.layer.cornerRadius = 28
        timerButton.setShadow(color: UIColor(hexString: "#00000020"), blur: 5)
        timerButton.addTarget(self, action: #selector(onShowAlertButtonClick), for: .touchUpInside)
        timerButton.setTime(startTime: startTime, endTime: endTime)
        
        timerButton.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(timerButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.4))
        constraints.append(timerButton.heightAnchor.constraint(equalTo: timerButton.widthAnchor, multiplier: 0.7))
        constraints.append(timerButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor))
        constraints.append(timerButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor))
    }
}

//MARK: Update Views
extension TimerViewController {
    private func updateViews() {}
}

extension TimerViewController: TimePickerDelegate {
    func onChanged(start: Date, end: Date) {
        self.startTime = start
        self.endTime = end
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        print("Start: \(formatter.string(from: start)), End: \(formatter.string(from: end))")
        timerButton.setTime(startTime: start, endTime: end)
    }
    
    func onClean() {
        print("Clean")
        timerButton.setTime(startTime: nil, endTime: nil)
    }
}
