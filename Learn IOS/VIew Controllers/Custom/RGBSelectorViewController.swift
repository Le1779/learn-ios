//
//  RGBSelecterViewController.swift
//  Learn IOS
//
//  Created by Kevin Le on 2020/3/29.
//  Copyright © 2020 Kevin Le. All rights reserved.
//

import UIKit

class RGBSelectorViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let rgbSelect = RGBSelector()
        print("before add tableview")
        self.addChild(rgbSelect)
        self.view.addSubview(rgbSelect.view)
        rgbSelect.didMove(toParent: self)
        print("after add tableview")
        
        rgbSelect.view.frame = CGRect(x: 0, y: 100, width: self.view.frame.width, height: 150)
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
