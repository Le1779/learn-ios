//
//  TimerViewController.swift
//  Learn IOS
//
//  Created by Kevin Le on 2021/9/6.
//  Copyright © 2021 Kevin Le. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController {
    
    let backButton = LeButton()
    let showAlertButton = LeButton()
    var timer: Timer!
    var timerButton: TimerButton!
    var timePicker: UIAlertController!
    private var constraints = [NSLayoutConstraint]()
    
    var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    func makeDatePickerAlert() -> UIAlertController {
        let container = UIViewController()
        container.preferredContentSize = CGSize(width: self.view.frame.size.width,height: 300)
        
        let startTimeTitle = UILabel()
        container.view.addSubview(startTimeTitle)
        startTimeTitle.text = "Start time"
        
        startTimeTitle.translatesAutoresizingMaskIntoConstraints = false
        startTimeTitle.topAnchor.constraint(equalTo: container.view.topAnchor, constant: 24).isActive = true
        startTimeTitle.leadingAnchor.constraint(equalTo: container.view.leadingAnchor, constant: 24).isActive = true
        startTimeTitle.widthAnchor.constraint(equalTo: container.view.widthAnchor, multiplier: 0.5)
        
        let startTimePicker: UIDatePicker = {
            let picker = UIDatePicker()
            picker.timeZone = NSTimeZone.local
            picker.datePickerMode = .time
            if #available(iOS 13.4, *) {
                picker.preferredDatePickerStyle = .wheels
            }
            container.view.addSubview(picker)
            picker.translatesAutoresizingMaskIntoConstraints = false
            picker.widthAnchor.constraint(equalTo: container.view.widthAnchor, multiplier: 0.5).isActive = true
            picker.heightAnchor.constraint(equalToConstant: 300).isActive = true
            picker.topAnchor.constraint(equalTo: startTimeTitle.topAnchor).isActive = true
            picker.leadingAnchor.constraint(equalTo: container.view.leadingAnchor).isActive = true
            return picker
        }()
        
        let endTimePicker: UIDatePicker = {
            let picker = UIDatePicker()
            picker.timeZone = NSTimeZone.local
            picker.datePickerMode = .time
            if #available(iOS 13.4, *) {
                picker.preferredDatePickerStyle = .wheels
            }
            container.view.addSubview(picker)
            picker.translatesAutoresizingMaskIntoConstraints = false
            picker.widthAnchor.constraint(equalTo: container.view.widthAnchor, multiplier: 0.5).isActive = true
            picker.heightAnchor.constraint(equalToConstant: 300).isActive = true
            picker.topAnchor.constraint(equalTo: container.view.topAnchor).isActive = true
            picker.trailingAnchor.constraint(equalTo: container.view.trailingAnchor).isActive = true
            return picker
        }()
        
        
        let selectAction = UIAlertAction(title: "Ok", style: .default, handler: { _ in
            //self.formateAndShowPickedDate()
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: { _ in
            //self.pickerTextField.text = ""
        })
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.setValue(container, forKey: "contentViewController")
        alert.addAction(selectAction)
        alert.addAction(cancelAction)
        return alert
    }
}

//MARK: Initial Views
extension TimerViewController {
    private func initViews() {
        initBackButton()
        initTimerButton()
        initShowAlertButton()
        initDatePicker()
        NSLayoutConstraint.activate(constraints)
        
        initTimePicker()
    }
    
    private func initTimePicker() {
        let selectAction = UIAlertAction(title: "Ok", style: .default, handler: { _ in
            //self.formateAndShowPickedDate()
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: { _ in
            //self.pickerTextField.text = ""
        })
        
        timePicker = TimePickerAlertController()
        timePicker.addAction(selectAction)
        timePicker.addAction(cancelAction)
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
        
        timerButton.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(timerButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.4))
        constraints.append(timerButton.heightAnchor.constraint(equalTo: timerButton.widthAnchor, multiplier: 0.7))
        constraints.append(timerButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor))
        constraints.append(timerButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor))
    }
    
    private func initDatePicker() {
        datePicker = UIDatePicker()
        self.view.addSubview(datePicker)
        datePicker.datePickerMode = .time
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(datePicker.widthAnchor.constraint(equalTo: self.view.widthAnchor))
        constraints.append(datePicker.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.3))
        constraints.append(datePicker.leadingAnchor.constraint(equalTo: self.view.leadingAnchor))
        constraints.append(datePicker.topAnchor.constraint(equalTo: timerButton.bottomAnchor, constant: 12))
    }
}

//MARK: Update Views
extension TimerViewController {
    private func updateViews() {}
}
