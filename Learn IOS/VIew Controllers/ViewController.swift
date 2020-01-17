//
//  ViewController.swift
//  Learn IOS
//
//  Created by Kevin Le on 2020/1/16.
//  Copyright © 2020 Kevin Le. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var testLabel: UILabel!
    @IBOutlet weak var testButton: UIButton!
    var clickCount = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.testLabel.text = String(clickCount)
    }

    @IBAction func click(_ sender: Any) {
        clickCount += 1
        self.testLabel.text = String(clickCount)
    }
    
}

