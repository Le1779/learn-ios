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
        
        let smRgbSelect = RGBSelector()
        self.addChild(smRgbSelect)
        self.view.addSubview(smRgbSelect.view)
        smRgbSelect.didMove(toParent: self)
        smRgbSelect.view.frame = CGRect(x: 0, y: 100, width: self.view.frame.width, height: 100)
        
        
        let mdRgbSelect = RGBSelector()
        self.addChild(mdRgbSelect)
        self.view.addSubview(mdRgbSelect.view)
        mdRgbSelect.didMove(toParent: self)
        mdRgbSelect.view.frame = CGRect(x: 0, y: 200, width: self.view.frame.width, height: 120)

        let rgbSelect = RGBSelector()
        self.addChild(rgbSelect)
        self.view.addSubview(rgbSelect.view)
        rgbSelect.didMove(toParent: self)
        rgbSelect.view.frame = CGRect(x: 0, y: 300, width: self.view.frame.width, height: 150)
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
