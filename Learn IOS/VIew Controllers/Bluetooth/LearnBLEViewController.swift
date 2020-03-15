//
//  LearnBLEViewController.swift
//  Learn IOS
//
//  Created by Kevin Le on 2020/3/14.
//  Copyright © 2020 Kevin Le. All rights reserved.
//

import UIKit

class LearnBLEViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addBottomSheetView()
    }
    
    func addBottomSheetView() {
        let bottomSheet = ScanBleBottomSheetViewController()
        
        self.addChild(bottomSheet)
        self.view.addSubview(bottomSheet.view)
        bottomSheet.didMove(toParent: self)
        
        let height = view.frame.height
        let width  = view.frame.width
        bottomSheet.view.frame = CGRect(x: 0, y: view.frame.maxY, width: width, height: height)
    }

}
