//
//  TouchpadViewController.swift
//  Learn IOS
//
//  Created by Kevin Le on 2020/3/28.
//  Copyright © 2020 Kevin Le. All rights reserved.
//

import UIKit

class TouchpadViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screenWidth = self.view.frame.width
        let screenHeight = self.view.frame.height
        print("viewDidLoad height: \(screenHeight), width: \(screenWidth)")
        let viewWidth = screenWidth < screenHeight ? screenWidth/2 : screenHeight/2
        
        let touchpadFrame = CGRect(x: 0, y: 0, width: viewWidth, height: viewWidth)
        let touchpadView = TouchpadView(frame: touchpadFrame);
        self.view.addSubview(touchpadView)
        touchpadView.center = self.view.center
        touchpadView.center.y -= viewWidth/2
    }

    @IBAction func clickBackButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
