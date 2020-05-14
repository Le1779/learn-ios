//
//  MoonViewController.swift
//  Learn IOS
//
//  Created by Kevin Le on 2020/5/14.
//  Copyright © 2020 Kevin Le. All rights reserved.
//

import UIKit

class MoonViewController: UIViewController {

    let starrySkyView: StarrySkyView = StarrySkyView()

    override func viewDidLoad() {
        super.viewDidLoad()

        let screenWidth = self.view.frame.width
        let screenHeight = self.view.frame.height
        print("viewDidLoad height: \(screenHeight), width: \(screenWidth)")
        
        starrySkyView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        
        self.view.addSubview(starrySkyView)
        
        let moonView = MoonView(frame: CGRect(x: screenWidth/2.2, y: screenHeight/20, width: screenWidth/2, height: screenWidth/2))
        self.view.addSubview(moonView)
    }
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        starrySkyView.drawStars()
    }

}
