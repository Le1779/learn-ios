//
//  LearnTextFieldViewController.swift
//  Learn IOS
//
//  Created by Kevin Le on 2020/3/11.
//  Copyright © 2020 Kevin Le. All rights reserved.
//

import UIKit

class LearnTextFieldViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func click(_ sender: Any) {
        let text: String = textField.text!
        self.label.text = String(text)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
