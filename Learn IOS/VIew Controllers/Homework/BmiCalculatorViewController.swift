//
//  BmiCalculatorViewController.swift
//  Learn IOS
//
//  Created by Kevin Le on 2020/3/12.
//  Copyright © 2020 Kevin Le. All rights reserved.
//

import UIKit

class BmiCalculatorViewController: UIViewController {

    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var heightErrorLabel: UILabel!
    @IBOutlet weak var weightErrorLabel: UILabel!
    @IBOutlet weak var calculateButton: UIButton!
    @IBOutlet weak var resultTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func calculate(_ sender: Any) {
        let height: Double? = Double(heightTextField.text!)
        let weight: Double? = Double(weightTextField.text!)
        
        if !checkHeight(h: height) {
            return;
        }
        
        if !checkWeight(w: weight) {
            return;
        }
        
        resultTextView.text = getCalculateResultText(h: height!, w: weight!)
    }
    
    // MARK: - 輸入驗證
    func checkHeight(h: Double?) -> Bool {
        heightErrorLabel.text = ""
        
        if h == nil {
            heightErrorLabel.text = "請輸入數字"
            return false
        }
        
        if h! < 80 && h! > 210{
            heightErrorLabel.text = "請輸入正確的範圍"
            return false
        }
        
        return true
    }
    
    func checkWeight(w: Double?) -> Bool {
        weightErrorLabel.text = ""
        
        if w == nil {
            weightErrorLabel.text = "請輸入數字"
            return false
        }
        
        if w! < 30 && w! > 300{
            weightErrorLabel.text = "請輸入正確的範圍"
            return false
        }
        
        return true
    }
    
    // MARK: - 計算
    func getCalculateResultText(h: Double, w: Double) -> String {
        let bmi: Double = w / (h * h / 10000)
        
        var remark: String = ""
        
        if bmi < 18.5 {
            remark = "體重過輕"
        } else if bmi < 24 {
            remark = "體重正常"
        } else if bmi < 27 {
            remark = "體重過重"
        } else if bmi < 30 {
            remark = "輕度肥胖"
        } else if bmi < 35 {
            remark = "中度肥胖"
        } else {
            remark = "重度肥胖"
        }
        
        return "你的ＢＭＩ值為：\(String(format:"%.1f",bmi)), \(remark)"
    }
    
}
