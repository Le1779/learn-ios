//
//  LearnDatePickerViewController.swift
//  Learn IOS
//  學習怎麼操作DatePicker & 製作Alert版本的DatePicker(有隱藏bug)
//  Created by Kevin Le on 2020/3/23.
//  Copyright © 2020 Kevin Le. All rights reserved.
//

import UIKit

class LearnDatePickerViewController: UIViewController {
    
    @IBOutlet weak var showDateSwitch: UISwitch!
    @IBOutlet weak var pickerTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func datePickerChange(_ sender: Any) {
        formateAndShowPickedDate()
    }
    
    @IBAction func showDateSwitchChange(_ sender: Any) {
        datePicker.datePickerMode = showDateSwitch.isOn ?  .dateAndTime : .time
    }
    
    @IBAction func showAlert(_ sender: Any) {
        present(makeDatePickerAlert(), animated: true)
    }
    
    func formateAndShowPickedDate(){
        let formatter = DateFormatter()
        formatter.dateFormat = showDateSwitch.isOn ? "YYYY MM dd EE HH:mm" : "HH:mm"
        pickerTextField.text = formatter.string(from: datePicker.date)
    }
    
    func makeDatePickerAlert() -> UIAlertController {
        let pickerContainer = UIViewController()
        pickerContainer.preferredContentSize = CGSize(width: self.view.frame.size.width,height: 300)
        
        let datePicker: UIDatePicker = UIDatePicker()
        datePicker.timeZone = NSTimeZone.local
        datePicker.frame = CGRect(x: 0, y: 0, width:self.view.frame.size.width, height: 300)
        datePicker.datePickerMode = showDateSwitch.isOn ?  .dateAndTime : .time
        pickerContainer.view.addSubview(datePicker)
        
        let selectAction = UIAlertAction(title: "Ok", style: .default, handler: { _ in
            self.formateAndShowPickedDate()
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: { _ in
            self.pickerTextField.text = ""
        })
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.setValue(pickerContainer, forKey: "contentViewController")
        alert.addAction(selectAction)
        alert.addAction(cancelAction)
        return alert
    }

}
