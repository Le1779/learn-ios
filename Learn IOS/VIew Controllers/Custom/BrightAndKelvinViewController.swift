//
//  BrightAndKelvinViewController.swift
//  Learn IOS
//  控制亮度與色溫元件
//  Created by Kevin Le on 2020/3/29.
//  Copyright © 2020 Kevin Le. All rights reserved.
//

import UIKit

class BrightAndKelvinViewController: UIViewController {

    @IBOutlet weak var touchLocationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screenWidth = self.view.frame.width
        let screenHeight = self.view.frame.height
        print("viewDidLoad height: \(screenHeight), width: \(screenWidth)")
        let viewWidth = screenWidth < screenHeight ? screenWidth/1.5 : screenHeight/1.5
        
        let touchpadFrame = CGRect(x: 0, y: 0, width: viewWidth, height: viewWidth)
        let touchpadView = BrightAndKelvinTouchpadView(frame: touchpadFrame);
        self.view.addSubview(touchpadView)
        touchpadView.center = self.view.center
        touchpadView.center.y -= viewWidth/2.5
        touchpadView.addBrightAndKelvinListener(listener: self)
    }

    @IBAction func clickBackButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension BrightAndKelvinViewController: BrightAndKelvinListener {
    
    func change(bright: CGFloat, kelvin: CGFloat) {
        let b = String(format: "%.2f", bright)
        let k = String(format: "%.2f", kelvin)
        touchLocationLabel.text = "bright:\(b)  kelvin:\(k)"
    }
    
}
