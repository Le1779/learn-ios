//
//  CustomButtonViewController.swift
//  Learn IOS
//
//  Created by Kevin Le on 2020/3/25.
//  Copyright © 2020 Kevin Le. All rights reserved.
//

import UIKit

class CustomButtonViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let buttonFrame = CGRect(x: 50, y: 50, width: 100, height: 50)
        let customButton = CustomButton.Builder(frame: buttonFrame)
            .setBackgroundColor(color: .gray)
            .setText(text: "Click me!")
            .setTextColor(color: .white)
            .setCornerRadius(radius: 12.0)
            .setWithShadow(withShadow: true)
            .build()
        
        self.view.addSubview(customButton)
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
